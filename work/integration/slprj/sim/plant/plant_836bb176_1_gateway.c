#ifdef MATLAB_MEX_FILE
#include "tmwtypes.h"
#else
#include "rtwtypes.h"
#endif
#include "nesl_rtw.h"
#include "plant_836bb176_1.h"
#include "plant_836bb176_1_gateway.h"
void plant_836bb176_1_gateway ( void ) { NeModelParameters modelparams = { (
NeSolverType ) 0 , 0.001 , 0 , 0 , 0.1 , 0 , 0 , 0 , 0 , ( SscLoggingSetting
) 0 , 560795604 , 1 , } ; NeSolverParameters solverparams = { 0 , 0 , 1 , 0 ,
0 , 0.001 , 1e-06 , 1e-09 , 0 , 0 , 100 , 0 , 1 , 1 , 1e-09 , 1 , (
NeLocalSolverChoice ) 0 , 0.1 , 1 , 3 , 2 , 0 , 2 , ( NeLinearAlgebraChoice )
0 , ( NeEquationFormulationChoice ) 0 , 1024 , 1 , 0.001 , (
NePartitionStorageMethod ) 0 , 1024 , ( NePartitionMethod ) 0 , } ; const
NeOutputParameters * outputparameters = NULL ; NeDae * dae ; size_t
numOutputs = 0 ; int rtpDaes [ 1 ] = { 0 } ; int * rtwLogDaes = NULL ; {
static const NeOutputParameters outputparameters_init [ ] = { { 0 , 0 , } , }
; outputparameters = outputparameters_init ; numOutputs = sizeof (
outputparameters_init ) / sizeof ( outputparameters_init [ 0 ] ) ; }
plant_836bb176_1_dae ( & dae , & modelparams , & solverparams ) ;
nesl_register_simulator_group ( "plant/Solver Configuration_1" , 1 , & dae ,
& solverparams , & modelparams , numOutputs , outputparameters , 1 , rtpDaes
, 0 , rtwLogDaes ) ; }
