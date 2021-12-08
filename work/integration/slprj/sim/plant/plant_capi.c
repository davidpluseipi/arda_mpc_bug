#include <stddef.h>
#include "rtw_capi.h"
#ifdef HOST_CAPI_BUILD
#include "plant_capi_host.h"
#define sizeof(s) ((size_t)(0xFFFF))
#undef rt_offsetof
#define rt_offsetof(s,el) ((uint16_T)(0xFFFF))
#define TARGET_CONST
#define TARGET_STRING(s) (s)
#else
#include "builtin_typeid_types.h"
#include "plant.h"
#include "plant_capi.h"
#include "plant_private.h"
#ifdef LIGHT_WEIGHT_CAPI
#define TARGET_CONST
#define TARGET_STRING(s)               ((NULL))
#else
#define TARGET_CONST                   const
#define TARGET_STRING(s)               (s)
#endif
#endif
static rtwCAPI_Signals rtBlockSignals [ ] = { { 0 , 0 , ( NULL ) , ( NULL ) ,
0 , 0 , 0 , 0 , 0 } } ; static rtwCAPI_States rtBlockStates [ ] = { { 0 , 0 ,
TARGET_STRING ( "plant/fan/Transfer Fcn" ) , TARGET_STRING ( "" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 , 1 , - 1 , 0 } , { 1 , 1 ,
TARGET_STRING ( "plant/steam_injector/Transfer Fcn" ) , TARGET_STRING ( "" )
, TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 , 1 , - 1 , 0 } , { 2 , - 1 ,
TARGET_STRING ( "plant/Solver\nConfiguration/EVAL_KEY/INPUT_1_1_1" ) ,
TARGET_STRING ( "Discrete" ) , "" , 0 , 0 , 1 , 0 , 1 , 0 , - 1 , 0 } , { 3 ,
- 1 , TARGET_STRING ( "plant/Solver\nConfiguration/EVAL_KEY/INPUT_2_1_1" ) ,
TARGET_STRING ( "Discrete" ) , "" , 0 , 0 , 1 , 0 , 1 , 0 , - 1 , 0 } , { 4 ,
- 1 , TARGET_STRING ( "plant/Solver\nConfiguration/EVAL_KEY/INPUT_3_1_1" ) ,
TARGET_STRING ( "Discrete" ) , "" , 0 , 0 , 1 , 0 , 1 , 0 , - 1 , 0 } , { 5 ,
- 1 , TARGET_STRING ( "plant/Solver\nConfiguration/EVAL_KEY/INPUT_4_1_1" ) ,
TARGET_STRING ( "Discrete" ) , "" , 0 , 0 , 1 , 0 , 0 , 0 , - 1 , 0 } , { 6 ,
- 1 , TARGET_STRING ( "plant/Solver\nConfiguration/EVAL_KEY/INPUT_5_1_1" ) ,
TARGET_STRING ( "Discrete" ) , "" , 0 , 0 , 1 , 0 , 0 , 0 , - 1 , 0 } , { 7 ,
- 1 , TARGET_STRING ( "plant/Solver\nConfiguration/EVAL_KEY/INPUT_6_1_1" ) ,
TARGET_STRING ( "Discrete" ) , "" , 0 , 0 , 1 , 0 , 1 , 0 , - 1 , 0 } , { 8 ,
- 1 , TARGET_STRING ( "plant/Solver\nConfiguration/EVAL_KEY/INPUT_7_1_1" ) ,
TARGET_STRING ( "Discrete" ) , "" , 0 , 0 , 1 , 0 , 0 , 0 , - 1 , 0 } , { 9 ,
- 1 , TARGET_STRING ( "plant/Solver\nConfiguration/EVAL_KEY/STATE_1" ) ,
TARGET_STRING ( "Discrete" ) , "" , 0 , 0 , 2 , 0 , 1 , 0 , - 1 , 0 } , { 0 ,
- 1 , ( NULL ) , ( NULL ) , ( NULL ) , 0 , 0 , 0 , 0 , 0 , 0 , - 1 , 0 } } ;
static int_T rt_LoggedStateIdxList [ ] = { 0 , 1 , 2 , 0 , 1 , 3 , 4 , 5 , 6
, 7 } ;
#ifndef HOST_CAPI_BUILD
static void plant_InitializeDataAddr ( void * dataAddr [ ] , khriw1lc2c *
localDW , nwe3ifp0pp * localX ) { dataAddr [ 0 ] = ( void * ) ( & localX ->
osra1al44t ) ; dataAddr [ 1 ] = ( void * ) ( & localX -> juq2ph1trj ) ;
dataAddr [ 2 ] = ( void * ) ( & localDW -> f5pqyxxsbw [ 0 ] ) ; dataAddr [ 3
] = ( void * ) ( & localDW -> jybrzbbm2b [ 0 ] ) ; dataAddr [ 4 ] = ( void *
) ( & localDW -> m4ierv1qm3 [ 0 ] ) ; dataAddr [ 5 ] = ( void * ) ( & localDW
-> mc1vxvx1ag [ 0 ] ) ; dataAddr [ 6 ] = ( void * ) ( & localDW -> byuf4wycfu
[ 0 ] ) ; dataAddr [ 7 ] = ( void * ) ( & localDW -> i2uttr1ys2 [ 0 ] ) ;
dataAddr [ 8 ] = ( void * ) ( & localDW -> ay4g10nafy [ 0 ] ) ; dataAddr [ 9
] = ( void * ) ( & localDW -> diy4avfcef [ 0 ] ) ; }
#endif
#ifndef HOST_CAPI_BUILD
static void plant_InitializeVarDimsAddr ( int32_T * vardimsAddr [ ] ) {
vardimsAddr [ 0 ] = ( NULL ) ; }
#endif
#ifndef HOST_CAPI_BUILD
static void plant_InitializeLoggingFunctions ( RTWLoggingFcnPtr loggingPtrs [
] ) { loggingPtrs [ 0 ] = ( NULL ) ; loggingPtrs [ 1 ] = ( NULL ) ;
loggingPtrs [ 2 ] = ( NULL ) ; loggingPtrs [ 3 ] = ( NULL ) ; loggingPtrs [ 4
] = ( NULL ) ; loggingPtrs [ 5 ] = ( NULL ) ; loggingPtrs [ 6 ] = ( NULL ) ;
loggingPtrs [ 7 ] = ( NULL ) ; loggingPtrs [ 8 ] = ( NULL ) ; loggingPtrs [ 9
] = ( NULL ) ; }
#endif
static TARGET_CONST rtwCAPI_DataTypeMap rtDataTypeMap [ ] = { { "double" ,
"real_T" , 0 , 0 , sizeof ( real_T ) , ( uint8_T ) SS_DOUBLE , 0 , 0 , 0 } }
;
#ifdef HOST_CAPI_BUILD
#undef sizeof
#endif
static TARGET_CONST rtwCAPI_ElementMap rtElementMap [ ] = { { ( NULL ) , 0 ,
0 , 0 , 0 } , } ; static rtwCAPI_DimensionMap rtDimensionMap [ ] = { {
rtwCAPI_SCALAR , 0 , 2 , 0 } , { rtwCAPI_VECTOR , 2 , 2 , 0 } , {
rtwCAPI_VECTOR , 4 , 2 , 0 } } ; static uint_T rtDimensionArray [ ] = { 1 , 1
, 2 , 1 , 122 , 1 } ; static const real_T rtcapiStoredFloats [ ] = { 0.0 ,
0.1 } ; static rtwCAPI_FixPtMap rtFixPtMap [ ] = { { ( NULL ) , ( NULL ) ,
rtwCAPI_FIX_RESERVED , 0 , 0 , ( boolean_T ) 0 } , } ; static
rtwCAPI_SampleTimeMap rtSampleTimeMap [ ] = { { ( const void * ) &
rtcapiStoredFloats [ 0 ] , ( const void * ) & rtcapiStoredFloats [ 0 ] , (
int8_T ) 0 , ( uint8_T ) 0 } , { ( const void * ) & rtcapiStoredFloats [ 1 ]
, ( const void * ) & rtcapiStoredFloats [ 0 ] , ( int8_T ) 1 , ( uint8_T ) 0
} } ; static int_T rtContextSystems [ 3 ] ; static rtwCAPI_LoggingMetaInfo
loggingMetaInfo [ ] = { { 0 , 0 , "" , 0 } } ; static
rtwCAPI_ModelMapLoggingStaticInfo mmiStaticInfoLogging = { 3 ,
rtContextSystems , loggingMetaInfo , 0 , ( NULL ) , { 0 , ( NULL ) , ( NULL )
} , 0 , ( NULL ) } ; static rtwCAPI_ModelMappingStaticInfo mmiStatic = { {
rtBlockSignals , 0 , ( NULL ) , 0 , ( NULL ) , 0 } , { ( NULL ) , 0 , ( NULL
) , 0 } , { rtBlockStates , 10 } , { rtDataTypeMap , rtDimensionMap ,
rtFixPtMap , rtElementMap , rtSampleTimeMap , rtDimensionArray } , "float" ,
{ 3596072871U , 1266355155U , 3742914901U , 1455645845U } , &
mmiStaticInfoLogging , 0 , ( boolean_T ) 0 , rt_LoggedStateIdxList } ; const
rtwCAPI_ModelMappingStaticInfo * plant_GetCAPIStaticMap ( void ) { return &
mmiStatic ; }
#ifndef HOST_CAPI_BUILD
static void plant_InitializeSystemRan ( oqqfjfnavm * const kyw2aoe1o0 ,
sysRanDType * systemRan [ ] , khriw1lc2c * localDW , int_T systemTid [ ] ,
void * rootSysRanPtr , int rootTid ) { UNUSED_PARAMETER ( kyw2aoe1o0 ) ;
UNUSED_PARAMETER ( localDW ) ; systemRan [ 0 ] = ( sysRanDType * )
rootSysRanPtr ; systemRan [ 1 ] = ( NULL ) ; systemRan [ 2 ] = ( NULL ) ;
systemTid [ 1 ] = kyw2aoe1o0 -> Timing . mdlref_GlobalTID [ 0 ] ; systemTid [
2 ] = kyw2aoe1o0 -> Timing . mdlref_GlobalTID [ 0 ] ; systemTid [ 0 ] =
rootTid ; rtContextSystems [ 0 ] = 0 ; rtContextSystems [ 1 ] = 0 ;
rtContextSystems [ 2 ] = 0 ; }
#endif
#ifndef HOST_CAPI_BUILD
void plant_InitializeDataMapInfo ( oqqfjfnavm * const kyw2aoe1o0 , khriw1lc2c
* localDW , nwe3ifp0pp * localX , void * sysRanPtr , int contextTid ) {
rtwCAPI_SetVersion ( kyw2aoe1o0 -> DataMapInfo . mmi , 1 ) ;
rtwCAPI_SetStaticMap ( kyw2aoe1o0 -> DataMapInfo . mmi , & mmiStatic ) ;
rtwCAPI_SetLoggingStaticMap ( kyw2aoe1o0 -> DataMapInfo . mmi , &
mmiStaticInfoLogging ) ; plant_InitializeDataAddr ( kyw2aoe1o0 -> DataMapInfo
. dataAddress , localDW , localX ) ; rtwCAPI_SetDataAddressMap ( kyw2aoe1o0
-> DataMapInfo . mmi , kyw2aoe1o0 -> DataMapInfo . dataAddress ) ;
plant_InitializeVarDimsAddr ( kyw2aoe1o0 -> DataMapInfo . vardimsAddress ) ;
rtwCAPI_SetVarDimsAddressMap ( kyw2aoe1o0 -> DataMapInfo . mmi , kyw2aoe1o0
-> DataMapInfo . vardimsAddress ) ; rtwCAPI_SetPath ( kyw2aoe1o0 ->
DataMapInfo . mmi , ( NULL ) ) ; rtwCAPI_SetFullPath ( kyw2aoe1o0 ->
DataMapInfo . mmi , ( NULL ) ) ; plant_InitializeLoggingFunctions (
kyw2aoe1o0 -> DataMapInfo . loggingPtrs ) ; rtwCAPI_SetLoggingPtrs (
kyw2aoe1o0 -> DataMapInfo . mmi , kyw2aoe1o0 -> DataMapInfo . loggingPtrs ) ;
rtwCAPI_SetInstanceLoggingInfo ( kyw2aoe1o0 -> DataMapInfo . mmi , &
kyw2aoe1o0 -> DataMapInfo . mmiLogInstanceInfo ) ; rtwCAPI_SetChildMMIArray (
kyw2aoe1o0 -> DataMapInfo . mmi , ( NULL ) ) ; rtwCAPI_SetChildMMIArrayLen (
kyw2aoe1o0 -> DataMapInfo . mmi , 0 ) ; plant_InitializeSystemRan (
kyw2aoe1o0 , kyw2aoe1o0 -> DataMapInfo . systemRan , localDW , kyw2aoe1o0 ->
DataMapInfo . systemTid , sysRanPtr , contextTid ) ; rtwCAPI_SetSystemRan (
kyw2aoe1o0 -> DataMapInfo . mmi , kyw2aoe1o0 -> DataMapInfo . systemRan ) ;
rtwCAPI_SetSystemTid ( kyw2aoe1o0 -> DataMapInfo . mmi , kyw2aoe1o0 ->
DataMapInfo . systemTid ) ; rtwCAPI_SetGlobalTIDMap ( kyw2aoe1o0 ->
DataMapInfo . mmi , & kyw2aoe1o0 -> Timing . mdlref_GlobalTID [ 0 ] ) ; }
#else
#ifdef __cplusplus
extern "C" {
#endif
void plant_host_InitializeDataMapInfo ( plant_host_DataMapInfo_T * dataMap ,
const char * path ) { rtwCAPI_SetVersion ( dataMap -> mmi , 1 ) ;
rtwCAPI_SetStaticMap ( dataMap -> mmi , & mmiStatic ) ;
rtwCAPI_SetDataAddressMap ( dataMap -> mmi , ( NULL ) ) ;
rtwCAPI_SetVarDimsAddressMap ( dataMap -> mmi , ( NULL ) ) ; rtwCAPI_SetPath
( dataMap -> mmi , path ) ; rtwCAPI_SetFullPath ( dataMap -> mmi , ( NULL ) )
; rtwCAPI_SetChildMMIArray ( dataMap -> mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( dataMap -> mmi , 0 ) ; }
#ifdef __cplusplus
}
#endif
#endif
