GENERATING MATRICES:
use makemat. example usage:
./makemat 128 0
Will generate matrix_128_0.txt


RUNNING PARALLEL_GE
usage: parallel_GE_alessandro <distr. mode = 0/1> <block cyclic factor = R [1, n/P]> <N: matrix is NxN> <input file name> <output ux = 0/1>

In general, never launch parallel_GE_alessandro but use either the run_single or run_all scripts

run_single is used to queue a single instance.
usage: qsub run_single
Program options are specified as part of the script.

run_all will queue multiple executions with different parameters:
matrix size: 128 256 512 1024 2048
block cyclic factor R: 1 2 8 16 64
number of processors: 1 2 4 8 16
distributed and non distributed read mode.

NOTE: run_all also takes care of generating matrices at startup, using makemat. The current version of the script generated ONE matrix for each N (for testing convenience), 
but the behavior can be changed by adding an additional loop.


OUTPUT FORMAT:
parallel_GE_alessandro outputs 3 files:
1 - the main statistics file: (ex op_P_1_N_128_R_1_1.txt) - contains an execution summary, X and U checksums, and parallel + sequential times and speedups. New results get appended to this file
2 - the UX file (ex op_P_1_N_128_R_1_1_UX.txt) - contains an execution summary, X and U checksums, and a printout of X and U. This file gets regenerated for each run.
3 - the aggregated statistics file: aggregatedResults.csv. This file contains an execution summary, times and speedups of ALL executions, as comma-separated values. Generated to simplify analysis of results.


COLLECTED DATA:
parallel_GE_alessandro collects timing information about data distribution, forward elimination, back substitution AND pivoting.
The results for the forward elimination step are displayed WITH and WITHOUT pivoting, to assess the impact of the pivoting step on the algorithm.