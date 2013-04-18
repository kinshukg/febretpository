#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <sys/time.h>
#include <mpi.h>

///////////////////////////////////////////////////////////////////////////////////////////////////
// Global variables
#define MAX_P 64 // Maximum number of processors
#define MAX_N 2048 // Maximum matrix row / column size. Used for static array allocations.
// All these values are set at startup and are constants in the program.
int P = 0; // Total number of processors
int PID = 0; // rank of this processor
int N = 0; // Matrix size (matrix is NxN)
int R = 1; // Block cyclic factor (between 1 and N/P)
int RPP = 1; // Number of rows-per-process (equal to N/P)
int DISTRIBUTE_READ = 0; // When set to 1, each node reads data.
int OUTPUT_UX = 0; // When set to 1, outputs UX on a separate file
int PIVOT = 1; // When set to 0, disables pivoting.

///////////////////////////////////////////////////////////////////////////////////////////////////
// Returns a high precision timer value in milliseconds
double mstime()
{
	struct timeval tp1;
	gettimeofday(&tp1, NULL);
    double time = (tp1.tv_sec * 1000000.0) + tp1.tv_usec;
	return time / 1000.0;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// Utility: compute log2
int ilog2(int number)
{
	float v=log(number)/log(2.0);;
	return (int)v;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// Returns the processor ID of the processor owning the specified row.
int getRowPID(int r)
{
	// total chunks 
	int tc = R * P;
	// rows per chunk
	int rc = N / tc;
	// find chunk containing row r
	int c = r / rc;
	// return node containing chunk c
	return c % P;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// Returns the local row index (0 based) of the specified row
int getLocalRowID(int r)
{
	// total chunks 
	int tc = R * P;
	// rows per chunk
	int rc = N / tc;
	// find chunk containing row r
	int c = r / rc;
	// row index in chunk
	int rcid = r % rc;
	// local chunk index
	//int lcid = c - (c % P) * R;
	int lcid = c / P;
	// Return local row id.
	
	//printf("R%d P%d N%d, rc=%d tc=%d c=%d rcid=%d lcid=%d\n", R, P, N, rc, tc, c, rcid, lcid);
	
	return lcid * rc + rcid;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
double* getLocalRow(int j, double* localRows)
{
	if(getRowPID(j) == PID)
	{
		int lr = getLocalRowID(j);
		return &localRows[lr * (N + 1)];
	}
	return NULL;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// Loads matrix data. on exit, augM will contain the augmented matrix rows associated to this node.
void createCyclicMatrix(double* inm, double* outm)
{
	//printf("CREATE CYCLIC\n");
	
	int r;
	// Iterate rows
	for(r = 0; r < N; r++)
	{
		// node owning row r
		int n = getRowPID(r);
		// local row index for row r
		int lr = getLocalRowID(r);
		
		int outrowindex = n * RPP + lr;
		
		//printf("ROW %d TO N%d ID%d \n", r, n, lr);
	
		// Copy row to correct position.
		memcpy(&outm[outrowindex * (N + 1)], &inm[r * (N + 1)], (N + 1) * sizeof(double));
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// Loads matrix data. on exit, augM will contain the augmented matrix rows associated to this node.
void loadMatrix(const char* inputFile, double* localRows, float* ddtime)
{
	// Record data distribution time on head node
	double ddstartTime = 0;
	if(PID == 0) ddstartTime = mstime();
	
	// Non-distributed read: root node reads data and scatters it to all nodes.
	if(DISTRIBUTE_READ == 0)
	{
		double* augM = malloc(N * (N + 1) * sizeof(double));
		double* cyclicM = malloc(N * (N + 1) * sizeof(double));
		//printf("HERE\n");
		if(PID == 0)
		{
			int nelems = 0;
			// Load the file in the array.
			FILE* in = fopen(inputFile, "rb");
			if(in != NULL)
			{
				while(!feof(in))
				{
					char intString[20];
					fgets(intString, 13, in);
					augM[nelems] = atof(intString);
					nelems++;
					//printf("read %d\n", nelems - 1);
				}
				fclose(in);
				
				printf("File read: nelems = %d\n", nelems - 1);
			}
			else
			{
				printf("FATAL: Could not open file %s\n", inputFile);
			}
			// Reorganize the matrix rows depending on block-cyclic factor R.
			createCyclicMatrix(augM, cyclicM);
		}
		int scatterSize = RPP * (N + 1);
		MPI_Scatter(cyclicM, scatterSize, MPI_DOUBLE, localRows, scatterSize, MPI_DOUBLE, 0, MPI_COMM_WORLD);
		//free(augM);
		//free(cyclicM);
	}
	else
	{
		int nelems = 0;
		// Load the file in the array.
		FILE* in = fopen(inputFile, "rb");
		if(in != NULL)
		{
			// Loop through row indices. If the row is assigned to this processor, read it.
			int i;
			for(i = 0; i < N; i++)
			{
				if(getRowPID(i) == PID)
				{
					// The row belongs to this processor. Compute the row offset.
					int rowSize = 12 * (N + 1);
					int offset = rowSize * i;
					fseek(in, offset, SEEK_SET);
					
					// Now read the row.
					int j;
					for(j = 0; j < N + 1; j++)
					{
						if(feof(in))
						{
							printf("FATAL: unexpected end of file in %s\n", inputFile);
							exit(-1);
						}
						char intString[20];
						fgets(intString, 13, in);
						localRows[nelems] = atof(intString);
						nelems++;
					}
				}
			}
			fclose(in);
			
			printf("File read: nelems = %d\n", nelems - 1);
		}
		else
		{
			printf("FATAL: Could not open file %s\n", inputFile);
		}
	}
	
	*ddtime = mstime() - ddstartTime;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void pivot(double* localRows, double* pivotRow, int j, int jpid, int* localRowIds, float* pvtime)
{
	// Record time on head node
	double pvstartTime = 0;
	if(PID == 0) pvstartTime = mstime();

	// Compute local absolute maximum of jth column, for pivot finding.
	int i;
	double maxjelem = 0;
	int maxji = -1;
	for(i = 0; i < RPP; i++)
	{
		double* rowi = &localRows[i * (N + 1)];
		double aej = abs(rowi[j]);
		//printf("NODE %d row%d[%d] = %f\n", PID, i, j, aej);
		if(aej >= maxjelem && localRowIds[i] >= j) 
		{
			maxjelem = aej;
			maxji = i;
			//printf("NODE %d maxji = %d\n", PID, maxji);
		}
	}
	
	// Gather local maximums and rows on first node.
	double gm = 0;
	int gmpid = -1;
	double localMaximums[MAX_P];
	int localMaxRows[MAX_P];
	MPI_Gather(&maxjelem, 1, MPI_DOUBLE, localMaximums, 1, MPI_DOUBLE, 0, MPI_COMM_WORLD);
	MPI_Gather(&maxji, 1, MPI_INT, localMaxRows, 1, MPI_INT, 0, MPI_COMM_WORLD);
				
	if(PID == 0)
	{
		// Find global maximum
		for(i = 0; i < P; i++)
		{
			if(localMaximums[i] > gm && localMaxRows[i] != -1)
			{
				//printf("GLOBAL (%d)%f > (%d)%f\n", i, localMaximums[i], gmpid, gm);
				gm = localMaximums[i];
				gmpid = i;
			}
		}
	}
	
	// Broadcast the global colum maximum and column owner node to all nodes.
	MPI_Bcast(&gm, 1, MPI_DOUBLE, 0, MPI_COMM_WORLD);
	MPI_Bcast(&gmpid, 1, MPI_INT, 0, MPI_COMM_WORLD);
	
	// Exchange rows.
	// Special case: pivot and maximum row are on the same node
	if(gmpid == jpid && jpid == PID)
	{
		// If the maximum row is already the current pivot, there is nothing we need to do.
		if(j != localRowIds[maxji])
		{
			double tmp[MAX_N];
			memcpy(tmp, &localRows[maxji * (N + 1)], (N + 1) * sizeof(double));
			memcpy(&localRows[maxji * (N + 1)], pivotRow, (N + 1) * sizeof(double));
			memcpy(pivotRow, tmp, (N + 1) * sizeof(double));
		}
	}
	else
	{
		MPI_Status status;
		// Normal case: send / receive rows.
		if(gmpid == PID)
		{
			double tmp[MAX_N];
			MPI_Send(&localRows[maxji * (N + 1)], N + 1, MPI_DOUBLE, jpid, 0, MPI_COMM_WORLD);
			MPI_Recv(tmp, N + 1, MPI_DOUBLE, jpid, 0, MPI_COMM_WORLD, &status);
			memcpy(&localRows[maxji * (N + 1)], tmp, (N + 1) * sizeof(double));
			//printf("NODE %d SENT MAX ROW %d TO %d\n", PID, maxji, jpid);
		}
		else if(jpid == PID)
		{
			double tmp[MAX_N];
			MPI_Recv(tmp, N + 1, MPI_DOUBLE, gmpid, 0, MPI_COMM_WORLD, &status);
			MPI_Send(pivotRow, N + 1, MPI_DOUBLE, gmpid, 0, MPI_COMM_WORLD);
			memcpy(pivotRow, tmp, (N + 1) * sizeof(double));
			//printf("NODE %d RECVD MAX ROW FOR PIVOT %d FROm %d\n", PID, j, gmpid);
		}
	}
	
	// NOTE: pivot time accumulates, since we run this function for each row.
	if(PID == 0) *pvtime += (mstime() - pvstartTime); 
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void forwardEliminationStep(double* localRows, float* pvtime)
{
	// Fill up this array with the ids of local rows. Will be used in the FE computation to quickly
	// check if indices of local rows are bigger than pivot row.
	int localRowIds[MAX_N];
	int i = 0;
	int j;
	for(j = 0; j < N; j++)
	{
		if(getRowPID(j) == PID) 
		{
			localRowIds[i] = j;	
			i++;
		}
	}
	if(i != RPP) printf("local row number %d != RPP %d!!\n", i, RPP); // This should never happen.
	
	for(j = 0; j < N; j++)
	{
		double rowj[MAX_N];
		double* rowPtr = getLocalRow(j, localRows);
		
		int rowSource = getRowPID(j);
		
		// Pivot
		pivot(localRows, rowPtr, j, rowSource, localRowIds, pvtime);
		
		if(rowPtr != NULL)
		{
			memcpy(rowj, rowPtr, (N + 1) * sizeof(double));
		}
		
		// Broadcast the row.
		MPI_Bcast(rowj, N + 1, MPI_DOUBLE, rowSource, MPI_COMM_WORLD);
		
		// Compute new coefficients for rows after j
		int i;
		for(i = 0; i < RPP; i++)
		{
			double* rowi = &localRows[i * (N + 1)];
			double mult = -(rowi[j]/rowj[j]);
			//printf("NODE %d LOCAL ROW %d FIRST VAL %11.4e\n", PID, i, rowi[0]);
			
			if(localRowIds[i] > j)
			{
				int k;
				for(k = 0; k < N + 1; k++)
				{
					if(k == j) rowi[k] = 0;
					else rowi[k] = mult * rowj[k] + rowi[k];
					//double v = mult * rowj[k] + rowi[k];
					
					// Kind of hack but useful for visually debugging output matrix.
					//if(rowi[k] < 0.00000000000001) rowi[k] = 0;
				}
			}
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
backSubstitutionStep(double* localRows, double* localSolution)
{
	MPI_Status status;
	int j;
	
	// This array is used to check wether we already sent a solution to a specific node,
	// to avoid redundant communication.
	char sendMask[MAX_N][MAX_P];
	char recvMask[MAX_N];
	
	memset(sendMask, 0, MAX_N * MAX_P);
	memset(recvMask, 0, MAX_N);
	
	// Stores values of x needed to compute local solutions.
	double x[MAX_N];
	memset(x, 0, MAX_N * sizeof(double));
	
	for(j = N - 1; j >= 0; j--)
	{
		// Is row j local?
		double* row = getLocalRow(j, localRows);
		if(row)
		{
			// Step 1: Receive all the values of x needed to solve this row
			int i;
			double sum = 0;
			for(i = N - 1; i > j; i--)
			{
				// If the row that computed x[i] is not local, do an MPI receive.
				// If the row is local, x[j] is already stored in the x array.
				int rpid = getRowPID(i);
				if(rpid != PID && !recvMask[i])	
				{
					//printf("N%d RECV X[%d] from N%d\n", PID, i, rpid);
					int err = MPI_Recv(&x[i], 1, MPI_DOUBLE, rpid, i, MPI_COMM_WORLD, &status);
					if(err != MPI_SUCCESS) printf("MPI_Recv ERROR on NODE %d\n", PID);
					
					// Mark x[i] as received
					recvMask[i] = 1;
					//else printf("N%d RECV X[%d] = %f from N%d\n", PID, i, x[i], rpid);
				}
				sum += x[i] * row[i];
			}
			// Step 2: compute solution for x[j];
			x[j] = 1.0 / row[j] * (row[N] - sum);
			//printf("X[%d] = %f\n", j + 1, x[j]);
			
			// Step 3: propagate x[j] to all rows before me
			for(i = j - 1; i >= 0; i--)
			{
				// If row i is local, we do not need to do an MPI send. The value of x will be 
				// read from the local solution array.
				int rpid = getRowPID(i);
				if(rpid != PID && !sendMask[j][rpid]) 
				{
					//printf("N%d SEND X[%d] to N%d\n", PID, j, rpid);
					MPI_Send(&x[j], 1, MPI_DOUBLE, rpid, j, MPI_COMM_WORLD);
					
					// Mark x[j] as already sent to node rpid
					sendMask[j][rpid] = 1;
				}
			}			
		}
	}
	
	// Copy data to local solution array.
	memcpy(localSolution, x, MAX_N * sizeof(double));
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void solve(double* localRows, double* localSolution, float* fetime, float* bstime, float* pvtime)
{
	// Record time on head node
	double festartTime = 0;
	if(PID == 0) festartTime = mstime();
	
	*pvtime = 0;
	
	forwardEliminationStep(localRows, pvtime);
	
	// Record forward elimination total time on head node.
	*fetime = mstime() - festartTime;
	
	// Record time on head node
	double bsstartTime = 0;
	if(PID == 0) bsstartTime = mstime();
	
	backSubstitutionStep(localRows, localSolution);
	
	// Record back substitution time
	*bstime = mstime() - bsstartTime;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void gatherSolution(double* localSolution, double* globalSolution)
{
	MPI_Status status;
	int j;
	for(j = 0; j < N; j++)
	{
		if(getRowPID(j) == PID && PID != 0) 
		{
			MPI_Send(&localSolution[j], 1, MPI_DOUBLE, 0, j, MPI_COMM_WORLD);
		}
	}
	
	// Gather data on root node.
	if(PID == 0)
	{
		for(j = 0; j < N; j++)
		{
			if(getRowPID(j) == 0)
			{
				globalSolution[j] = localSolution[j];
			}
			else
			{
				MPI_Recv(&globalSolution[j], 1, MPI_DOUBLE, getRowPID(j), j, MPI_COMM_WORLD, &status);
			}
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void gatherU(double* localRows, double* U)
{
	MPI_Status status;
	int j;
	for(j = 0; j < N; j++)
	{
		double* row = getLocalRow(j, localRows);
		if(row != NULL && PID != 0) 
		{
			MPI_Send(row, N + 1, MPI_DOUBLE, 0, j, MPI_COMM_WORLD);
		}
	}
	
	// Gather data on root node.
	if(PID == 0)
	{
		for(j = 0; j < N; j++)
		{
			if(getRowPID(j) == 0)
			{
				memcpy(&U[j * (N + 1)], &localRows[getLocalRowID(j) * (N + 1)], (N + 1) * sizeof(double));
			}
			else
			{
				MPI_Recv(&U[j * (N + 1)], N + 1, MPI_DOUBLE, getRowPID(j), j, MPI_COMM_WORLD, &status);
			}
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void computeChecksums(double* U, double* X, double* cu1, double* cu2, double* cx1, double* cx2)
{
	*cu1 = 0;
	*cu2 = 0;
	*cx1 = 0;
	*cx2 = 0;
	int j, k;
	for(j = 0; j < N; j++)
	{
		*cx1 += X[j];
		*cx2 += j%2 ? -X[j] : X[j];
		for(k = 0; k < N; k++)
		{
			double u = U[j * (N + 1) + k];
			*cu1 += u;
			*cu2 += k%2 ? -u : u;
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void outputSolution(FILE* out, double* X)
{
	int j;
	for(j = 0; j < N; j++)
	{
		//fprintf(out, "\nROW %d\n", j);
		fprintf(out, "%11.4e", X[j]);
		if((j + 1) % 16 == 0) fprintf(out, "\n");
		else fprintf(out, " ");
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void outputMatrix(FILE* out, double* U)
{
	int j;
	for(j = 0; j < N; j++)
	{
		fprintf(out, "\nROW %d\n", j);
		int i;
		double* row = &U[j * (N + 1)];
		for(i = 0; i < N + 1; i++)
		{
			fprintf(out, "%11.4e", row[i]);
			if((i + 1) % 16 == 0) fprintf(out, "\n");
			else fprintf(out, " ");
		}
		fprintf(out, "\n");
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void outputResults(const char* inputFile, double* localRows, double* localSolution, float ddtime, float bstime, float fetime, float pvtime)
{
	// Gather X and U on root node.
	double X[MAX_N];
	double* U = malloc(N * (N + 1) * sizeof(double));
	
	gatherSolution(localSolution, X);
	gatherU(localRows, U);
	
	double cx1, cx2, cu1, cu2;
	
	if(PID == 0)
	{
		computeChecksums(U, X, &cu1, &cu2, &cx1, &cx2);
		
		//float time = mstime() - startTime;
		float sequentialTimeDDBSFEPV = 0;
		float sequentialTimeDD = 0;
		float sequentialTimeBS = 0;
		float sequentialTimeFE = 0;
		float sequentialTimeFENOPV = 0;
		float sequentialTimePV = 0;
		char filename[32];
		
		if(P > 1)
		{
			// Read linear time from saved file (if we are not running in sequential mode)
			sprintf(filename, "op_P_%d_N_%d_R_%d_%d.txt", 1, N, R, DISTRIBUTE_READ);
			FILE* in = fopen(filename, "r");
			
			char line[512];
			// skip first three lines (headers)
			fgets(line, 512, in);
			fgets(line, 512, in);
			fgets(line, 512, in);
			
			fscanf(in, "Sequential Time w/DD+BS     : %f(ms)\n", &sequentialTimeDDBSFEPV);
			fscanf(in, "Sequential Time DD only     : %f(ms)\n", &sequentialTimeDD);
			fscanf(in, "Sequential Time BS only     : %f(ms)\n", &sequentialTimeBS);
			fscanf(in, "Sequential Time PV only     : %f(ms)\n", &sequentialTimePV);
			fscanf(in, "Sequential Time w/oDD+BS    : %f(ms)\n", &sequentialTimeFE);
			fscanf(in, "Sequential Time w/oDD+BS+PV : %f(ms)\n", &sequentialTimeFENOPV);
			fclose(in);
		}
		
		// Write output
		sprintf(filename, "op_P_%d_N_%d_R_%d_%d.txt", P, N, R, DISTRIBUTE_READ);
		FILE* out = fopen(filename, "a");
		
		fprintf(out, "P = %d, distributed_read = %d, N = %d, R = %d, input = %s\n", P, DISTRIBUTE_READ, N, R, inputFile);
		fprintf(out, "Checksum1(X) = %11.4e,    Checksum2(X) = %11.4e,    Checksum1(U) = %11.4e,    Checksum2(U) = %11.4e\n", cx1, cx2, cu1, cu2);
		fprintf(out, "-------------------------------------------------------------------------------------------------------------\n");
		
		if(P == 1)
		{
			// Print times
			fprintf(out, "Sequential Time w/DD+BS     : %.3f(ms)\n", ddtime + fetime + bstime);
			fprintf(out, "Sequential Time DD only     : %.3f(ms)\n", ddtime);
			fprintf(out, "Sequential Time BS only     : %.3f(ms)\n", bstime);
			fprintf(out, "Sequential Time PV only     : %.3f(ms)\n", pvtime);
			fprintf(out, "Sequential Time w/oDD+BS    : %.3f(ms)\n", fetime);
			fprintf(out, "Sequential Time w/oDD+BS+PV : %.3f(ms)\n", fetime - pvtime);
		}
		else
		{
			fprintf(out, "Sequential Time w/DD+BS     : %.3f(ms)\n", sequentialTimeDDBSFEPV);
			fprintf(out, "Sequential Time DD only     : %.3f(ms)\n", sequentialTimeDD);
			fprintf(out, "Sequential Time BS only     : %.3f(ms)\n", sequentialTimeBS);
			fprintf(out, "Sequential Time PV only     : %.3f(ms)\n", sequentialTimePV);
			fprintf(out, "Sequential Time w/oDD+BS    : %.3f(ms)\n", sequentialTimeFE);
			fprintf(out, "Sequential Time w/oDD+BS+PV : %.3f(ms)\n\n", sequentialTimeFENOPV);
		}
		
		// Print Speedups
		if(P > 1)
		{
			fprintf(out, "Parallel Time w/DD+BS  : %.3f(ms)\n", ddtime + fetime + bstime);
			fprintf(out, "Speedup       w/DD+BS  : %.3f\n\n", sequentialTimeDDBSFEPV / (ddtime + fetime + bstime));
			
			fprintf(out, "Parallel Time DD only     : %.3f(ms)\n", ddtime);
			fprintf(out, "Speedup       DD only     : %.3f\n\n", sequentialTimeDD / ddtime);
			
			fprintf(out, "Parallel Time BS only     : %.3f(ms)\n", bstime);
			fprintf(out, "Speedup       BS only     : %.3f\n\n", sequentialTimeBS / bstime);
			
			fprintf(out, "Parallel Time PV only     : %.3f(ms)\n", pvtime);
			fprintf(out, "Speedup       PV only     : %.3f\n\n", sequentialTimePV / pvtime);
			
			fprintf(out, "Parallel Time w/oDD+BS    : %.3f(ms)\n", fetime);
			fprintf(out, "Speedup       w/oDD+BS    : %.3f\n", sequentialTimeFE / fetime);
			
			fprintf(out, "Parallel Time w/oDD+BS+PV    : %.3f(ms)\n", fetime - pvtime);
			fprintf(out, "Speedup       w/oDD+BS+PV    : %.3f\n", (sequentialTimeFE -  sequentialTimePV) / (fetime - pvtime));
		}
		fprintf(out, "-------------------------------------------------------------------------------------------------------------\n\n");
		fclose(out);
		
		// Write aggregated results
		// In a csv file with columns
		// INPUT NAME, N, P, R, DISTRIBUTE_READ, TIME, SPEEDUP
		out = fopen("aggregatedResults.csv", "a");
		fprintf(out, "%s, %d, %d, %d, %d, %f, %f, %f, %f, %f, %f, ", inputFile, N, P, R, DISTRIBUTE_READ, 
			(ddtime + fetime + bstime), ddtime, bstime, pvtime, fetime, (fetime - pvtime));
		if(P > 1)
		{		
			fprintf(out, "%f, ", sequentialTimeDDBSFEPV / (ddtime + fetime + bstime));
			fprintf(out, "%f, ", sequentialTimeDD / ddtime);
			fprintf(out, "%f, ", sequentialTimeBS / bstime);
			fprintf(out, "%f, ", sequentialTimePV / pvtime);
			fprintf(out, "%f, ", sequentialTimeFE / fetime);
			fprintf(out, "%f\n", (sequentialTimeFE -  sequentialTimePV) / (fetime - pvtime));
		}
		else 
		{
			fprintf(out, "1.0, 1.0, 1.0, 1.0\n");
		}
		fclose(out);
	}
	
	if(OUTPUT_UX)
	{
		if(PID == 0)
		{
			// Write the solution vector and U matrix.
			char filename[32];
			sprintf(filename, "op_P_%d_N_%d_R_%d_%d_UX.txt", P, N, R, DISTRIBUTE_READ);
			FILE* out = fopen(filename, "w");
			fprintf(out, "P = %d, distributed_read = %d, N = %d, R = %d, input = %s\n", P, DISTRIBUTE_READ, N, R, inputFile);
			fprintf(out, "Checksum1(X) = %11.4e,    Checksum2(X) = %11.4e,    Checksum1(U) = %11.4e,    Checksum2(U) = %11.4e\n", cx1, cx2, cu1, cu2);
			fprintf(out, "---------------------------------------------------------------------------------------------------\n");
			fprintf(out, "Solution Vector:\n");
			outputSolution(out, X);
			fprintf(out, "---------------------------------------------------------------------------------------------------\n");
			fprintf(out, "U Matrix:\n");
			outputMatrix(out, U);
			fclose(out);
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
int main(int argc, char** argv)
{
	if(argc < 6)
	{
		printf("usage: sum <distr. mode = 0/1> <block cyclic factor = R [1, n/P]> <N: matrix is NxN> <input file name> <output ux = 0/1>\n");
		return 0;
	}

	// Read arguments
	DISTRIBUTE_READ = atoi(argv[1]);
	R = atoi(argv[2]);
	N = atoi(argv[3]);
	OUTPUT_UX = atoi(argv[5]);
	char* inputFile = argv[4];
	
	// Initialize MPI
	MPI_Init(&argc, &argv);
	MPI_Comm_size(MPI_COMM_WORLD, &P);
	MPI_Comm_rank(MPI_COMM_WORLD, &PID);
	
	RPP = N / P;
	
	if(R < 1 || R > N / P)
	{
		printf("ERROR: R (%d) must be between 1 and N/P (%d)\n", R, N/P);
		return -1;
	}
	
	// Broadcast matrix size and block cyclic factor
	MPI_Bcast(&N, 1, MPI_INT, 0, MPI_COMM_WORLD);
	MPI_Bcast(&R, 1, MPI_INT, 0, MPI_COMM_WORLD);
	
	// This array stores the rows of the augmented matrix associated to this processor.
	double* localRows = malloc(RPP * (N + 1) * sizeof(double));

	double x[MAX_N];
	memset(x, 0, MAX_N * sizeof(double));
	
	// These variables will store times for data loading (and distribution)
	// Forward elimination and back substitution.
	float ddtime;
	float fetime;
	float bstime;
	float pvtime;

	// Load the matrix data 
	loadMatrix(inputFile, localRows, &ddtime);
	
	// Solve the system
	solve(localRows, x, &fetime, &bstime, &pvtime);

	// Output solution and statistics
	outputResults(inputFile, localRows, x, ddtime, bstime, fetime, pvtime);
	
	// Free memory
	//free(localRowIds);
	//free(localRows);
	
	// Finalize MPI
	MPI_Finalize();
	return 0;
}
