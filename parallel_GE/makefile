##
# @file      makefile
# @author    Mitch Richling <http://www.mitchr.me/>
# @Copyright Copyright 1999 by Mitch Richling.  All rights reserved.
# @brief     Build the MPI example programs.@EOL
# @Keywords  MPI examples
# @Std       GenericMake

# Depending upon which MPI implementation is used, the following may
# need to be adjusted.
MPICC  = mpicc

# Uncomment to build all when make file changes
#SPECDEP=makefile

TARGETS = parallel_GE_alessandro makemat

all : $(TARGETS)
	@echo Make Complete

parallel_GE_alessandro : parallel_GE_alessandro.c $(SPECDEP)
	$(MPICC) -lm parallel_GE_alessandro.c -o parallel_GE_alessandro

makemat : makemat.c $(SPECDEP)
	$(MPICC) -lm makemat.c -o makemat
