#
#    PARALLEL    INTEL
##################################################################

#EXTENTION OF THE BINARY
EXT=

#COMPILER NAMES
CC=mpicc
FC=mpifort
FL=mpifort

#PREPOCESSING COMMANDES :
OPT_PRE = -cpp 

#OPTIONS COMPILE
#DEBUG
#OPTF =  -C -g -warn  -DEBUG -check -assume byterecl -check all -gen_interfaces -traceback   $(OPT_PRE) -assume byterecl  
#OPTC =  -C -g -Wall $(OPT_PRE)
#OPTL =  -C -g -warn  -DEBUG -check -assume byterecl -check all -gen_interfaces -traceback   $(OPT_PRE) -assume byterecl 
#OPTIMIZED
OPTF =  -O3  $(OPT_PRE)    
OPTC =  -O3  $(OPT_PRE)    
OPTL =  -O3   

OPTFF = ${OPTF}

#Library variables
AR= ar
ARFUNCT= cruv
AREXTRA= xo
RANLIB= ranlib

#ROOT DIR OF MUMPS/METIS
LADIR  = /tmp/Software/math_2024

#ROOT DIR OF TOOL BOX
LTOOLS_BOX = /tmp/Software/TOOLBOX_OPTIMIZATION

#MKL LIBRARIES
MKL_DIR= /opt/intel/oneapi/mkl/

LMKL= -L $(MKL_DIR) -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -lm -qopenmp -lpthread -lmkl_blas95_lp64 -lmkl_lapack95_lp64 -lmkl_blacs_intelmpi_lp64 -lmkl_scalapack_lp64

#MUMPS LIB AND INC
LMUMPS = -L$(LADIR)/mumps/lib -lcmumps -lmumps_common
IMUMPS = -I$(LADIR)/mumps/include

#PORD LIB (INSIDE MUMPS)
LPORDDIR = $(LADIR)/mumps/PORD/lib
LPORD    = -L$(LPORDDIR) -lpord

#METIS LIB
LMETISDIR = $(LADIR)/metis_out
LMETIS    = -L$(LMETISDIR)/lib -lmetis

#PARMETIS LIB
LPARMETISDIR = $(LADIR)/parmetis_out
LPARMETIS    = -L$(LPARMETISDIR)/lib -lparmetis


#TOOL BOX LIB AND INC
LOPTIM = -L $(LTOOLS_BOX)/lib -lSEISCOPE_OPTIM
IOPTIM  = -I $(LTOOLS_BOX)/COMMON/include

#WE GATHER EVERYTHINGS
LIBPAR = $(LMUMPS) $(LPORD) $(LOPTIM)  $(LMETIS) $(LMKL) 
INCPAR = $(IMUMPS) $(IPORD) $(IOPTIM) -I../include  

INC = $(INCPAR)
LIB = $(LIBPAR)
