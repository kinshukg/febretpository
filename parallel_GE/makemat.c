#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <sys/time.h>
#include <mpi.h>

///////////////////////////////////////////////////////////////////////////////////////////////////
int sign(int n)
{
	return n >= 0 ? 1 : -1;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
int main(int argc, char** argv)
{
	if(argc < 3)
	{
		printf("usage: makemat <size> <id>\n");
		return 0;
	}

	// Read arguments
	int N = atoi(argv[1]);
	int ID = atoi(argv[2]);
	
	char filename[256];
	sprintf(filename, "matrix_%d_%d.txt", N, ID);
	FILE* out = fopen(filename, "w");
	
	// use the id number as the random seed
	srand (ID + 1);
	
	float p = (float)rand() / RAND_MAX;
	
	int j, k;
	for(j = 0; j < N; j++)
	{
		for(k = 0; k < N + 1; k++)
		{
			int m = rand() % 131070 - 65535;
			float m_abs = abs(m);
			while(m_abs > 10) m_abs /= 10;
			float m_f = sign(m) * m_abs;
			float e;
			if(p < 0.3) e = rand() % 6 - 3;
			else if(p < 0.6) e = rand() % 6 - 1;
			else e = rand() % 6 + 2;
			
			double elem = m_f * pow(2, e);
			
			fprintf(out, "%11.4e", elem);
			if((k + 1) % 16 == 0 || k == N) fprintf(out, "\n");
			else fprintf(out, " ");
		}
	}
	
	fclose(out);
	
	return 0;
}
