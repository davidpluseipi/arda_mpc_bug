#include "plant_capi.h"
#include "plant.h"
#include "plant_private.h"
#include "rt_TDelayInterpolate.h"
static RegMdlInfo rtMdlInfo_plant [ 43 ] = { { "irprwpldwbj" ,
MDL_INFO_NAME_MDLREF_DWORK , 0 , - 1 , ( void * ) "plant" } , { "dantqf54nj"
, MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * ) "plant" } , {
"nci4jq3zl4" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"plant" } , { "jiemay0mhr" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , (
void * ) "plant" } , { "mhckh0zejo" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 ,
- 1 , ( void * ) "plant" } , { "imwyid11cc" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * ) "plant" } , {
"ecygsd2j42" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"plant" } , { "nwe3ifp0pp" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , (
void * ) "plant" } , { "o3xgc1peb0" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 ,
- 1 , ( void * ) "plant" } , { "ipcar4aujz" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * ) "plant" } , {
"m4m1udxt01" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"plant" } , { "j1bfijgnfg" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , (
void * ) "plant" } , { "khriw1lc2c" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 ,
- 1 , ( void * ) "plant" } , { "gs4ynfho4y" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * ) "plant" } , {
"k3sp34iqm3" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"plant" } , { "mbc2hav4mz" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , (
void * ) "plant" } , { "eldcewjbmo" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 ,
- 1 , ( void * ) "plant" } , { "kaeb0eavom" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * ) "plant" } , {
"oum4ych01w" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"plant" } , { "hwyjztgp4d" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , (
void * ) "plant" } , { "hzsbmy4fnm" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 ,
- 1 , ( void * ) "plant" } , { "otef51nrsc" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * ) "plant" } , {
"k1yuutjvkp" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * )
"plant" } , { "clc5gd4b5i" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , (
void * ) "plant" } , { "ikzjs414xk" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 ,
- 1 , ( void * ) "plant" } , { "plant" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0
, 0 , ( NULL ) } , { "djn4fhgkjc" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , -
1 , ( void * ) "plant" } , { "ay3wm3e024" , MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT
, 0 , - 1 , ( void * ) "plant" } , { "oqqfjfnavm" ,
MDL_INFO_ID_GLOBAL_RTW_CONSTRUCT , 0 , - 1 , ( void * ) "plant" } , {
"mr_plant_GetSimStateDisallowedBlocks" , MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1
, ( void * ) "plant" } , { "mr_plant_extractBitFieldFromCellArrayWithOffset"
, MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 , ( void * ) "plant" } , {
"mr_plant_cacheBitFieldToCellArrayWithOffset" , MDL_INFO_ID_MODEL_FCN_NAME ,
0 , - 1 , ( void * ) "plant" } , {
"mr_plant_restoreDataFromMxArrayWithOffset" , MDL_INFO_ID_MODEL_FCN_NAME , 0
, - 1 , ( void * ) "plant" } , { "mr_plant_cacheDataToMxArrayWithOffset" ,
MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 , ( void * ) "plant" } , {
"mr_plant_extractBitFieldFromMxArray" , MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1
, ( void * ) "plant" } , { "mr_plant_cacheBitFieldToMxArray" ,
MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 , ( void * ) "plant" } , {
"mr_plant_restoreDataFromMxArray" , MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 , (
void * ) "plant" } , { "mr_plant_cacheDataAsMxArray" ,
MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 , ( void * ) "plant" } , {
"mr_plant_RegisterSimStateChecksum" , MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 ,
( void * ) "plant" } , { "mr_plant_SetDWork" , MDL_INFO_ID_MODEL_FCN_NAME , 0
, - 1 , ( void * ) "plant" } , { "mr_plant_GetDWork" ,
MDL_INFO_ID_MODEL_FCN_NAME , 0 , - 1 , ( void * ) "plant" } , { "plant.h" ,
MDL_INFO_MODEL_FILENAME , 0 , - 1 , ( NULL ) } , { "plant.c" ,
MDL_INFO_MODEL_FILENAME , 0 , - 1 , ( void * ) "plant" } } ; j1gcqcp03uo
j1gcqcp03u = { - 1.0 , 1.0 , 1.0 , 0.0 , - 1.0 , 1.0 , 0.001 , 1.0 , 0.0 ,
0.001 , 1.0 , 0.0 , 9.54929658551372 , 0.0 , 0.0 , 0.0 , 0.0 , 0.0 , 1.0 ,
0.0 , 0.0 , 0.0 , 0.0 , 0.101325 , 0.0 , 0.0 , 0.0 , 0.0 , 0.0 , 0.0 , 0.0 ,
0U , 0U , 0U } ; void otef51nrsc ( khriw1lc2c * localDW , nwe3ifp0pp * localX
) { localX -> osra1al44t = 0.0 ; localDW -> li0zy2ybda = ( rtInf ) ; localDW
-> bmmnk2hkqr = ( rtInf ) ; localDW -> cc0p4yapio = ( rtInf ) ; localDW ->
pjlofbmgkc = ( rtInf ) ; localDW -> ha3flsheab = ( rtInf ) ; localDW ->
cpxu0nhavi = ( rtInf ) ; localDW -> jgxniudunk = ( rtInf ) ; localDW ->
a0sj41yc22 = ( rtInf ) ; localX -> juq2ph1trj = 0.0 ; localDW -> askvnz0tsd =
( rtInf ) ; localDW -> oem3mqqlzr = ( rtInf ) ; localDW -> gpiwz4w1hd = (
rtInf ) ; localDW -> nfnzt1rl1w = ( rtInf ) ; } void hzsbmy4fnm ( khriw1lc2c
* localDW , nwe3ifp0pp * localX ) { localX -> osra1al44t = 0.0 ; localDW ->
li0zy2ybda = ( rtInf ) ; localDW -> bmmnk2hkqr = ( rtInf ) ; localDW ->
cc0p4yapio = ( rtInf ) ; localDW -> pjlofbmgkc = ( rtInf ) ; localDW ->
ha3flsheab = ( rtInf ) ; localDW -> cpxu0nhavi = ( rtInf ) ; localDW ->
jgxniudunk = ( rtInf ) ; localDW -> a0sj41yc22 = ( rtInf ) ; localX ->
juq2ph1trj = 0.0 ; localDW -> askvnz0tsd = ( rtInf ) ; localDW -> oem3mqqlzr
= ( rtInf ) ; localDW -> gpiwz4w1hd = ( rtInf ) ; localDW -> nfnzt1rl1w = (
rtInf ) ; } void clc5gd4b5i ( oqqfjfnavm * const kyw2aoe1o0 , khriw1lc2c *
localDW ) { NeModelParameters modelParameters ; NeModelParameters
modelParameters_p ; NeslRtpManager * manager ; NeslRtpManager * manager_p ;
NeslSimulationData * tmp_e ; NeslSimulator * tmp_p ; NeuDiagnosticManager *
diagnosticManager ; NeuDiagnosticTree * diagnosticTree ; NeuDiagnosticTree *
diagnosticTree_p ; char * msg ; char * msg_p ; real_T tmp_i ; int32_T tmp_m ;
boolean_T tmp ; boolean_T val ; { real_T * pBuffer = & localDW -> bdxcmvfrpb
. TUbufferArea [ 0 ] ; char ptrKey [ 1024 ] ; localDW -> ndsoprptcn . Tail =
0 ; localDW -> ndsoprptcn . Head = 0 ; localDW -> ndsoprptcn . Last = 0 ;
localDW -> ndsoprptcn . CircularBufSize = 102400 ; pBuffer [ 0 ] = j1gcqcp03u
. P_10 ; pBuffer [ 102400 ] = rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; localDW ->
heanzsqqzv . TUbufferPtrs [ 0 ] = ( void * ) & pBuffer [ 0 ] ; sprintf (
ptrKey , "plant/heater/Transport\nDelay1_TUbuffer%d" , 0 ) ;
slsaSaveRawMemoryForSimTargetOP ( kyw2aoe1o0 -> _mdlRefSfcnS , ptrKey , (
void * * ) ( & localDW -> heanzsqqzv . TUbufferPtrs [ 0 ] ) , 2 * 102400 *
sizeof ( real_T ) , ( NULL ) , ( NULL ) ) ; } manager_p =
nesl_lease_rtp_manager ( "plant/Solver Configuration_1" , 0 ) ; manager =
manager_p ; tmp = pointer_is_null ( manager_p ) ; if ( tmp ) {
plant_836bb176_1_gateway ( ) ; manager = nesl_lease_rtp_manager (
"plant/Solver Configuration_1" , 0 ) ; } localDW -> ck5clrltfz = ( void * )
manager ; localDW -> heva2ukg0u = true ; tmp_p = nesl_lease_simulator (
"plant/Solver Configuration_1" , 0 , 0 ) ; localDW -> jw04ifknil = ( void * )
tmp_p ; tmp = pointer_is_null ( localDW -> jw04ifknil ) ; if ( tmp ) {
plant_836bb176_1_gateway ( ) ; tmp_p = nesl_lease_simulator (
"plant/Solver Configuration_1" , 0 , 0 ) ; localDW -> jw04ifknil = ( void * )
tmp_p ; } slsaSaveRawMemoryForSimTargetOP ( kyw2aoe1o0 -> _mdlRefSfcnS ,
"plant/Solver Configuration_100" , ( void * * ) ( & localDW -> jw04ifknil ) ,
0U * sizeof ( real_T ) , nesl_save_simdata , nesl_restore_simdata ) ; tmp_e =
nesl_create_simulation_data ( ) ; localDW -> d1krrjylmb = ( void * ) tmp_e ;
diagnosticManager = rtw_create_diagnostics ( ) ; localDW -> oiosdkzqje = (
void * ) diagnosticManager ; modelParameters . mSolverType =
NE_SOLVER_TYPE_DAE ; modelParameters . mSolverTolerance = 0.001 ;
modelParameters . mVariableStepSolver = false ; modelParameters .
mIsUsingODEN = false ; modelParameters . mFixedStepSize = 0.1 ;
modelParameters . mStartTime = 0.0 ; modelParameters . mLoadInitialState =
false ; modelParameters . mUseSimState = false ; modelParameters .
mLinTrimCompile = false ; modelParameters . mLoggingMode = SSC_LOGGING_NONE ;
modelParameters . mRTWModifiedTimeStamp = 5.60795604E+8 ; modelParameters .
mZcDisabled = true ; tmp_i = 0.001 ; modelParameters . mSolverTolerance =
tmp_i ; tmp_i = 0.1 ; modelParameters . mFixedStepSize = tmp_i ; tmp = false
; modelParameters . mVariableStepSolver = tmp ; tmp = false ; modelParameters
. mIsUsingODEN = tmp ; val = false ; tmp = slIsRapidAcceleratorSimulating ( )
; if ( tmp ) { tmp = ssGetGlobalInitialStatesAvailable ( kyw2aoe1o0 ->
_mdlRefSfcnS ) ; val = ( tmp && rtmIsFirstInitCond ( kyw2aoe1o0 ) ) ; }
modelParameters . mLoadInitialState = val ; modelParameters . mZcDisabled =
true ; diagnosticManager = ( NeuDiagnosticManager * ) localDW -> oiosdkzqje ;
diagnosticTree = neu_diagnostic_manager_get_initial_tree ( diagnosticManager
) ; tmp_m = nesl_initialize_simulator ( ( NeslSimulator * ) localDW ->
jw04ifknil , & modelParameters , diagnosticManager ) ; if ( tmp_m != 0 ) {
tmp = error_buffer_is_empty ( ssGetErrorStatus ( kyw2aoe1o0 -> _mdlRefSfcnS )
) ; if ( tmp ) { msg = rtw_diagnostics_msg ( diagnosticTree ) ;
ssSetErrorStatus ( kyw2aoe1o0 -> _mdlRefSfcnS , msg ) ; } } tmp_p =
nesl_lease_simulator ( "plant/Solver Configuration_1" , 1 , 0 ) ; localDW ->
mbaq2wwli1 = ( void * ) tmp_p ; tmp = pointer_is_null ( localDW -> mbaq2wwli1
) ; if ( tmp ) { plant_836bb176_1_gateway ( ) ; tmp_p = nesl_lease_simulator
( "plant/Solver Configuration_1" , 1 , 0 ) ; localDW -> mbaq2wwli1 = ( void *
) tmp_p ; } slsaSaveRawMemoryForSimTargetOP ( kyw2aoe1o0 -> _mdlRefSfcnS ,
"plant/Solver Configuration_110" , ( void * * ) ( & localDW -> mbaq2wwli1 ) ,
0U * sizeof ( real_T ) , nesl_save_simdata , nesl_restore_simdata ) ; tmp_e =
nesl_create_simulation_data ( ) ; localDW -> p4i4r5dbtk = ( void * ) tmp_e ;
diagnosticManager = rtw_create_diagnostics ( ) ; localDW -> ln2l0ra4by = (
void * ) diagnosticManager ; modelParameters_p . mSolverType =
NE_SOLVER_TYPE_DAE ; modelParameters_p . mSolverTolerance = 0.001 ;
modelParameters_p . mVariableStepSolver = false ; modelParameters_p .
mIsUsingODEN = false ; modelParameters_p . mFixedStepSize = 0.1 ;
modelParameters_p . mStartTime = 0.0 ; modelParameters_p . mLoadInitialState
= false ; modelParameters_p . mUseSimState = false ; modelParameters_p .
mLinTrimCompile = false ; modelParameters_p . mLoggingMode = SSC_LOGGING_NONE
; modelParameters_p . mRTWModifiedTimeStamp = 5.60795604E+8 ;
modelParameters_p . mZcDisabled = true ; tmp_i = 0.001 ; modelParameters_p .
mSolverTolerance = tmp_i ; tmp_i = 0.1 ; modelParameters_p . mFixedStepSize =
tmp_i ; tmp = false ; modelParameters_p . mVariableStepSolver = tmp ; tmp =
false ; modelParameters_p . mIsUsingODEN = tmp ; val = false ; tmp =
slIsRapidAcceleratorSimulating ( ) ; if ( tmp ) { tmp =
ssGetGlobalInitialStatesAvailable ( kyw2aoe1o0 -> _mdlRefSfcnS ) ; val = (
tmp && rtmIsFirstInitCond ( kyw2aoe1o0 ) ) ; } modelParameters_p .
mLoadInitialState = val ; modelParameters_p . mZcDisabled = true ;
diagnosticManager = ( NeuDiagnosticManager * ) localDW -> ln2l0ra4by ;
diagnosticTree_p = neu_diagnostic_manager_get_initial_tree (
diagnosticManager ) ; tmp_m = nesl_initialize_simulator ( ( NeslSimulator * )
localDW -> mbaq2wwli1 , & modelParameters_p , diagnosticManager ) ; if (
tmp_m != 0 ) { tmp = error_buffer_is_empty ( ssGetErrorStatus ( kyw2aoe1o0 ->
_mdlRefSfcnS ) ) ; if ( tmp ) { msg_p = rtw_diagnostics_msg (
diagnosticTree_p ) ; ssSetErrorStatus ( kyw2aoe1o0 -> _mdlRefSfcnS , msg_p )
; } } { real_T * pBuffer = & localDW -> axkanaqtvp . TUbufferArea [ 0 ] ;
char ptrKey [ 1024 ] ; localDW -> gq1n1qgyyy . Tail = 0 ; localDW ->
gq1n1qgyyy . Head = 0 ; localDW -> gq1n1qgyyy . Last = 0 ; localDW ->
gq1n1qgyyy . CircularBufSize = 1024000 ; pBuffer [ 0 ] = j1gcqcp03u . P_15 ;
pBuffer [ 1024000 ] = rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; localDW ->
g3uljnoxwm . TUbufferPtrs [ 0 ] = ( void * ) & pBuffer [ 0 ] ; sprintf (
ptrKey , "plant/steam_injector/Transport\nDelay_TUbuffer%d" , 0 ) ;
slsaSaveRawMemoryForSimTargetOP ( kyw2aoe1o0 -> _mdlRefSfcnS , ptrKey , (
void * * ) ( & localDW -> g3uljnoxwm . TUbufferPtrs [ 0 ] ) , 2 * 1024000 *
sizeof ( real_T ) , ( NULL ) , ( NULL ) ) ; } { real_T * pBuffer = & localDW
-> ligjvnb3hq . TUbufferArea [ 0 ] ; char ptrKey [ 1024 ] ; localDW ->
ggfepuoe3d . Tail = 0 ; localDW -> ggfepuoe3d . Head = 0 ; localDW ->
ggfepuoe3d . Last = 0 ; localDW -> ggfepuoe3d . CircularBufSize = 102400 ;
pBuffer [ 0 ] = j1gcqcp03u . P_18 ; pBuffer [ 102400 ] = rtmGetTaskTime (
kyw2aoe1o0 , 0 ) ; localDW -> k551hcuwml . TUbufferPtrs [ 0 ] = ( void * ) &
pBuffer [ 0 ] ; sprintf ( ptrKey , "plant/fan/Transport\nDelay_TUbuffer%d" ,
0 ) ; slsaSaveRawMemoryForSimTargetOP ( kyw2aoe1o0 -> _mdlRefSfcnS , ptrKey ,
( void * * ) ( & localDW -> k551hcuwml . TUbufferPtrs [ 0 ] ) , 2 * 102400 *
sizeof ( real_T ) , ( NULL ) , ( NULL ) ) ; } } void plant ( oqqfjfnavm *
const kyw2aoe1o0 , real_T * dtfibjp3f2 , real_T * nsdvtzjsad , real_T *
kc5pzokhav , gs4ynfho4y * localB , khriw1lc2c * localDW , nwe3ifp0pp * localX
) { NeParameterBundle expl_temp ; NeslSimulationData * simulationData ;
NeuDiagnosticManager * diag ; NeuDiagnosticTree * diagTree ;
NeuDiagnosticTree * diagnosticTree ; NeuDiagnosticTree * diagnosticTree_p ;
char * msg ; char * msg_e ; char * msg_p ; real_T tmp_i [ 225 ] ; real_T tmp
[ 32 ] ; real_T tmp_p [ 28 ] ; real_T p1xjbgvbxw [ 11 ] ; real_T ioisohncle ;
real_T lastTime ; real_T time ; real_T time_p ; real_T * lastU ; int_T tmp_m
[ 9 ] ; int_T tmp_e [ 8 ] ; int_T iy ; boolean_T ok ; if ( rtmIsMajorTimeStep
( kyw2aoe1o0 ) ) { localB -> nej3fn0a0e [ 0 ] = rtP_p_env ; localB ->
nej3fn0a0e [ 1 ] = 0.0 ; localB -> nej3fn0a0e [ 2 ] = 0.0 ; localDW ->
jybrzbbm2b [ 0 ] = ! ( localB -> nej3fn0a0e [ 0 ] == localDW -> jybrzbbm2b [
1 ] ) ; localDW -> jybrzbbm2b [ 1 ] = localB -> nej3fn0a0e [ 0 ] ; localB ->
nej3fn0a0e [ 0 ] = localDW -> jybrzbbm2b [ 1 ] ; localB -> nej3fn0a0e [ 3 ] =
localDW -> jybrzbbm2b [ 0 ] ; localB -> pbhhlvkgxv [ 0 ] = rtP_phi_env ;
localB -> pbhhlvkgxv [ 1 ] = 0.0 ; localB -> pbhhlvkgxv [ 2 ] = 0.0 ; localDW
-> m4ierv1qm3 [ 0 ] = ! ( localB -> pbhhlvkgxv [ 0 ] == localDW -> m4ierv1qm3
[ 1 ] ) ; localDW -> m4ierv1qm3 [ 1 ] = localB -> pbhhlvkgxv [ 0 ] ; localB
-> pbhhlvkgxv [ 0 ] = localDW -> m4ierv1qm3 [ 1 ] ; localB -> pbhhlvkgxv [ 3
] = localDW -> m4ierv1qm3 [ 0 ] ; localB -> agn2ggwjbr [ 0 ] = rtP_T_env ;
localB -> agn2ggwjbr [ 1 ] = 0.0 ; localB -> agn2ggwjbr [ 2 ] = 0.0 ; localDW
-> f5pqyxxsbw [ 0 ] = ! ( localB -> agn2ggwjbr [ 0 ] == localDW -> f5pqyxxsbw
[ 1 ] ) ; localDW -> f5pqyxxsbw [ 1 ] = localB -> agn2ggwjbr [ 0 ] ; localB
-> agn2ggwjbr [ 0 ] = localDW -> f5pqyxxsbw [ 1 ] ; localB -> agn2ggwjbr [ 3
] = localDW -> f5pqyxxsbw [ 0 ] ; } localB -> pum1gml0fg = 0.0 ; localB ->
pum1gml0fg += j1gcqcp03u . P_8 * localX -> osra1al44t ; ioisohncle =
rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; if ( ( localDW -> li0zy2ybda >=
ioisohncle ) && ( localDW -> bmmnk2hkqr >= ioisohncle ) ) { localB ->
oyche00ljt = 0.0 ; } else { lastTime = localDW -> li0zy2ybda ; lastU = &
localDW -> o4xfeqygo1 ; if ( localDW -> li0zy2ybda < localDW -> bmmnk2hkqr )
{ if ( localDW -> bmmnk2hkqr < ioisohncle ) { lastTime = localDW ->
bmmnk2hkqr ; lastU = & localDW -> ddxucremmb ; } } else if ( localDW ->
li0zy2ybda >= ioisohncle ) { lastTime = localDW -> bmmnk2hkqr ; lastU = &
localDW -> ddxucremmb ; } localB -> oyche00ljt = ( localB -> pum1gml0fg - *
lastU ) / ( ioisohncle - lastTime ) ; } if ( ( localDW -> cc0p4yapio >=
ioisohncle ) && ( localDW -> pjlofbmgkc >= ioisohncle ) ) { localB ->
fpgrkyomeh = 0.0 ; } else { lastTime = localDW -> cc0p4yapio ; lastU = &
localDW -> hetafjr45k ; if ( localDW -> cc0p4yapio < localDW -> pjlofbmgkc )
{ if ( localDW -> pjlofbmgkc < ioisohncle ) { lastTime = localDW ->
pjlofbmgkc ; lastU = & localDW -> dcm3vfsh3n ; } } else if ( localDW ->
cc0p4yapio >= ioisohncle ) { lastTime = localDW -> pjlofbmgkc ; lastU = &
localDW -> dcm3vfsh3n ; } localB -> fpgrkyomeh = ( localB -> oyche00ljt - *
lastU ) / ( ioisohncle - lastTime ) ; } localB -> bkoe3onl4o [ 0 ] = localB
-> pum1gml0fg ; localB -> bkoe3onl4o [ 1 ] = localB -> oyche00ljt ; localB ->
bkoe3onl4o [ 2 ] = localB -> fpgrkyomeh ; localB -> bkoe3onl4o [ 3 ] = 0.0 ;
{ real_T * * uBuffer = ( real_T * * ) & localDW -> heanzsqqzv . TUbufferPtrs
[ 0 ] ; real_T simTime = rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; real_T
tMinusDelay = simTime - j1gcqcp03u . P_9 ; localB -> pwiaux3gpz =
rt_TDelayInterpolate ( tMinusDelay , 0.0 , * uBuffer , localDW -> ndsoprptcn
. CircularBufSize , & localDW -> ndsoprptcn . Last , localDW -> ndsoprptcn .
Tail , localDW -> ndsoprptcn . Head , j1gcqcp03u . P_10 , 0 , ( boolean_T ) (
rtmIsMinorTimeStep ( kyw2aoe1o0 ) && ( rtmGetTimeOfLastOutput ( kyw2aoe1o0 )
== rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ) ) ) ; } if ( ( localDW -> ha3flsheab
>= ioisohncle ) && ( localDW -> cpxu0nhavi >= ioisohncle ) ) { localB ->
huw2jglag1 = 0.0 ; } else { lastTime = localDW -> ha3flsheab ; lastU = &
localDW -> pgqakzzjtp ; if ( localDW -> ha3flsheab < localDW -> cpxu0nhavi )
{ if ( localDW -> cpxu0nhavi < ioisohncle ) { lastTime = localDW ->
cpxu0nhavi ; lastU = & localDW -> ewdokzvqyf ; } } else if ( localDW ->
ha3flsheab >= ioisohncle ) { lastTime = localDW -> cpxu0nhavi ; lastU = &
localDW -> ewdokzvqyf ; } localB -> huw2jglag1 = ( localB -> pwiaux3gpz - *
lastU ) / ( ioisohncle - lastTime ) ; } if ( ( localDW -> jgxniudunk >=
ioisohncle ) && ( localDW -> a0sj41yc22 >= ioisohncle ) ) { localB ->
jzn21mzell = 0.0 ; } else { lastTime = localDW -> jgxniudunk ; lastU = &
localDW -> ncxcfwfguz ; if ( localDW -> jgxniudunk < localDW -> a0sj41yc22 )
{ if ( localDW -> a0sj41yc22 < ioisohncle ) { lastTime = localDW ->
a0sj41yc22 ; lastU = & localDW -> kvptsc2r0b ; } } else if ( localDW ->
jgxniudunk >= ioisohncle ) { lastTime = localDW -> a0sj41yc22 ; lastU = &
localDW -> kvptsc2r0b ; } localB -> jzn21mzell = ( localB -> huw2jglag1 - *
lastU ) / ( ioisohncle - lastTime ) ; } localB -> b1fwtui0xy [ 0 ] = localB
-> pwiaux3gpz ; localB -> b1fwtui0xy [ 1 ] = localB -> huw2jglag1 ; localB ->
b1fwtui0xy [ 2 ] = localB -> jzn21mzell ; localB -> b1fwtui0xy [ 3 ] = 0.0 ;
if ( rtmIsMajorTimeStep ( kyw2aoe1o0 ) ) { localB -> hohy0ccoij [ 0 ] =
rtP_T_steam ; localB -> hohy0ccoij [ 1 ] = 0.0 ; localB -> hohy0ccoij [ 2 ] =
0.0 ; localDW -> i2uttr1ys2 [ 0 ] = ! ( localB -> hohy0ccoij [ 0 ] == localDW
-> i2uttr1ys2 [ 1 ] ) ; localDW -> i2uttr1ys2 [ 1 ] = localB -> hohy0ccoij [
0 ] ; localB -> hohy0ccoij [ 0 ] = localDW -> i2uttr1ys2 [ 1 ] ; localB ->
hohy0ccoij [ 3 ] = localDW -> i2uttr1ys2 [ 0 ] ; } localB -> dfescxqrvg = 0.0
; localB -> dfescxqrvg += j1gcqcp03u . P_12 * localX -> juq2ph1trj ; if ( (
localDW -> askvnz0tsd >= ioisohncle ) && ( localDW -> oem3mqqlzr >=
ioisohncle ) ) { localB -> kukprqjt0a = 0.0 ; } else { lastTime = localDW ->
askvnz0tsd ; lastU = & localDW -> khrsxvxe2v ; if ( localDW -> askvnz0tsd <
localDW -> oem3mqqlzr ) { if ( localDW -> oem3mqqlzr < ioisohncle ) {
lastTime = localDW -> oem3mqqlzr ; lastU = & localDW -> jlenuaifba ; } } else
if ( localDW -> askvnz0tsd >= ioisohncle ) { lastTime = localDW -> oem3mqqlzr
; lastU = & localDW -> jlenuaifba ; } localB -> kukprqjt0a = ( localB ->
dfescxqrvg - * lastU ) / ( ioisohncle - lastTime ) ; } if ( ( localDW ->
gpiwz4w1hd >= ioisohncle ) && ( localDW -> nfnzt1rl1w >= ioisohncle ) ) {
localB -> lw3wils3lh = 0.0 ; } else { lastTime = localDW -> gpiwz4w1hd ;
lastU = & localDW -> hamkb3snwi ; if ( localDW -> gpiwz4w1hd < localDW ->
nfnzt1rl1w ) { if ( localDW -> nfnzt1rl1w < ioisohncle ) { lastTime = localDW
-> nfnzt1rl1w ; lastU = & localDW -> ecaz0wysbo ; } } else if ( localDW ->
gpiwz4w1hd >= ioisohncle ) { lastTime = localDW -> nfnzt1rl1w ; lastU = &
localDW -> ecaz0wysbo ; } localB -> lw3wils3lh = ( localB -> kukprqjt0a - *
lastU ) / ( ioisohncle - lastTime ) ; } localB -> ddbvd0dqvk [ 0 ] = localB
-> dfescxqrvg ; localB -> ddbvd0dqvk [ 1 ] = localB -> kukprqjt0a ; localB ->
ddbvd0dqvk [ 2 ] = localB -> lw3wils3lh ; localB -> ddbvd0dqvk [ 3 ] = 0.0 ;
if ( rtmIsMajorTimeStep ( kyw2aoe1o0 ) ) { if ( localDW -> heva2ukg0u ) { tmp
[ 0 ] = rtP_T_init ; tmp [ 1 ] = rtP_T_env ; tmp [ 2 ] = rtP_T_init ; tmp [ 3
] = rtP_T_init ; tmp [ 4 ] = j1gcqcp03u . P_31 ; tmp [ 5 ] = rtP_phi_init ;
tmp [ 6 ] = rtP_T_env ; tmp [ 7 ] = rtP_phi_init ; tmp [ 8 ] = rtP_T_init ;
tmp [ 9 ] = rtP_T_init ; tmp [ 10 ] = rtP_p_init ; tmp [ 11 ] = j1gcqcp03u .
P_30 ; tmp [ 12 ] = rtP_p_init ; tmp [ 13 ] = rtP_phi_init ; tmp [ 14 ] =
j1gcqcp03u . P_22 ; tmp [ 15 ] = j1gcqcp03u . P_23 ; tmp [ 16 ] = j1gcqcp03u
. P_24 ; tmp [ 17 ] = j1gcqcp03u . P_26 ; tmp [ 18 ] = j1gcqcp03u . P_27 ;
tmp [ 19 ] = j1gcqcp03u . P_28 ; tmp [ 20 ] = rtP_T_init ; tmp [ 21 ] =
j1gcqcp03u . P_29 ; tmp [ 22 ] = rtP_phi_init ; tmp [ 23 ] = rtP_p_init ; tmp
[ 24 ] = j1gcqcp03u . P_32 ; tmp [ 25 ] = j1gcqcp03u . P_33 ; tmp [ 26 ] =
j1gcqcp03u . P_34 ; tmp [ 27 ] = j1gcqcp03u . P_35 ; tmp [ 28 ] = j1gcqcp03u
. P_36 ; tmp [ 29 ] = rtP_T_init ; tmp [ 30 ] = j1gcqcp03u . P_37 ; tmp [ 31
] = rtP_T_init ; lastU = & tmp [ 0 ] ; diag = rtw_create_diagnostics ( ) ;
diagTree = neu_diagnostic_manager_get_initial_tree ( diag ) ; expl_temp .
mRealParameters . mN = 32 ; expl_temp . mRealParameters . mX = lastU ;
expl_temp . mLogicalParameters . mN = 0 ; expl_temp . mLogicalParameters . mX
= NULL ; expl_temp . mIntegerParameters . mN = 0 ; expl_temp .
mIntegerParameters . mX = NULL ; expl_temp . mIndexParameters . mN = 0 ;
expl_temp . mIndexParameters . mX = NULL ; ok = nesl_rtp_manager_set_rtps ( (
NeslRtpManager * ) localDW -> ck5clrltfz , rtmGetTaskTime ( kyw2aoe1o0 , 0 )
, expl_temp , diag ) ; if ( ! ok ) { ok = error_buffer_is_empty (
ssGetErrorStatus ( kyw2aoe1o0 -> _mdlRefSfcnS ) ) ; if ( ok ) { msg =
rtw_diagnostics_msg ( diagTree ) ; ssSetErrorStatus ( kyw2aoe1o0 ->
_mdlRefSfcnS , msg ) ; } } } localDW -> heva2ukg0u = false ; simulationData =
( NeslSimulationData * ) localDW -> d1krrjylmb ; time = ioisohncle ;
simulationData -> mData -> mTime . mN = 1 ; simulationData -> mData -> mTime
. mX = & time ; simulationData -> mData -> mContStates . mN = 0 ;
simulationData -> mData -> mContStates . mX = NULL ; simulationData -> mData
-> mDiscStates . mN = 122 ; simulationData -> mData -> mDiscStates . mX = &
localDW -> diy4avfcef [ 0 ] ; simulationData -> mData -> mModeVector . mN =
75 ; simulationData -> mData -> mModeVector . mX = & localDW -> iie5kx1kjr [
0 ] ; ok = false ; simulationData -> mData -> mFoundZcEvents = ok ;
simulationData -> mData -> mIsMajorTimeStep = true ; ok =
_ssGetSolverAssertCheck ( kyw2aoe1o0 -> _mdlRefSfcnS ) ; simulationData ->
mData -> mIsSolverAssertCheck = ok ; simulationData -> mData ->
mIsSolverCheckingCIC = false ; simulationData -> mData ->
mIsComputingJacobian = false ; simulationData -> mData -> mIsEvaluatingF0 =
false ; simulationData -> mData -> mIsSolverRequestingReset = false ;
simulationData -> mData -> mIsOkayToUpdateMode = true ; tmp_e [ 0 ] = 0 ;
tmp_p [ 0 ] = localB -> nej3fn0a0e [ 0 ] ; tmp_p [ 1 ] = localB -> nej3fn0a0e
[ 1 ] ; tmp_p [ 2 ] = localB -> nej3fn0a0e [ 2 ] ; tmp_p [ 3 ] = localB ->
nej3fn0a0e [ 3 ] ; tmp_e [ 1 ] = 4 ; tmp_p [ 4 ] = localB -> pbhhlvkgxv [ 0 ]
; tmp_p [ 5 ] = localB -> pbhhlvkgxv [ 1 ] ; tmp_p [ 6 ] = localB ->
pbhhlvkgxv [ 2 ] ; tmp_p [ 7 ] = localB -> pbhhlvkgxv [ 3 ] ; tmp_e [ 2 ] = 8
; tmp_p [ 8 ] = localB -> agn2ggwjbr [ 0 ] ; tmp_p [ 9 ] = localB ->
agn2ggwjbr [ 1 ] ; tmp_p [ 10 ] = localB -> agn2ggwjbr [ 2 ] ; tmp_p [ 11 ] =
localB -> agn2ggwjbr [ 3 ] ; tmp_e [ 3 ] = 12 ; tmp_p [ 12 ] = localB ->
bkoe3onl4o [ 0 ] ; tmp_p [ 13 ] = localB -> bkoe3onl4o [ 1 ] ; tmp_p [ 14 ] =
localB -> bkoe3onl4o [ 2 ] ; tmp_p [ 15 ] = localB -> bkoe3onl4o [ 3 ] ;
tmp_e [ 4 ] = 16 ; tmp_p [ 16 ] = localB -> b1fwtui0xy [ 0 ] ; tmp_p [ 17 ] =
localB -> b1fwtui0xy [ 1 ] ; tmp_p [ 18 ] = localB -> b1fwtui0xy [ 2 ] ;
tmp_p [ 19 ] = localB -> b1fwtui0xy [ 3 ] ; tmp_e [ 5 ] = 20 ; tmp_p [ 20 ] =
localB -> hohy0ccoij [ 0 ] ; tmp_p [ 21 ] = localB -> hohy0ccoij [ 1 ] ;
tmp_p [ 22 ] = localB -> hohy0ccoij [ 2 ] ; tmp_p [ 23 ] = localB ->
hohy0ccoij [ 3 ] ; tmp_e [ 6 ] = 24 ; tmp_p [ 24 ] = localB -> ddbvd0dqvk [ 0
] ; tmp_p [ 25 ] = localB -> ddbvd0dqvk [ 1 ] ; tmp_p [ 26 ] = localB ->
ddbvd0dqvk [ 2 ] ; tmp_p [ 27 ] = localB -> ddbvd0dqvk [ 3 ] ; tmp_e [ 7 ] =
28 ; simulationData -> mData -> mInputValues . mN = 28 ; simulationData ->
mData -> mInputValues . mX = & tmp_p [ 0 ] ; simulationData -> mData ->
mInputOffsets . mN = 8 ; simulationData -> mData -> mInputOffsets . mX = &
tmp_e [ 0 ] ; simulationData -> mData -> mOutputs . mN = 197 ; simulationData
-> mData -> mOutputs . mX = & localB -> gwaclz3bjw [ 0 ] ; simulationData ->
mData -> mSampleHits . mN = 0 ; simulationData -> mData -> mSampleHits . mX =
NULL ; ok = rtmIsMajorTimeStep ( kyw2aoe1o0 ) ; simulationData -> mData ->
mIsFundamentalSampleHit = ok ; simulationData -> mData -> mTolerances . mN =
0 ; simulationData -> mData -> mTolerances . mX = NULL ; simulationData ->
mData -> mCstateHasChanged = false ; diag = ( NeuDiagnosticManager * )
localDW -> oiosdkzqje ; diagnosticTree =
neu_diagnostic_manager_get_initial_tree ( diag ) ; iy = ne_simulator_method (
( NeslSimulator * ) localDW -> jw04ifknil , NESL_SIM_OUTPUTS , simulationData
, diag ) ; if ( iy != 0 ) { ok = error_buffer_is_empty ( ssGetErrorStatus (
kyw2aoe1o0 -> _mdlRefSfcnS ) ) ; if ( ok ) { msg_p = rtw_diagnostics_msg (
diagnosticTree ) ; ssSetErrorStatus ( kyw2aoe1o0 -> _mdlRefSfcnS , msg_p ) ;
} } ssSetBlockStateForSolverChangedAtMajorStep ( kyw2aoe1o0 -> _mdlRefSfcnS )
; simulationData = ( NeslSimulationData * ) localDW -> p4i4r5dbtk ; time_p =
ioisohncle ; simulationData -> mData -> mTime . mN = 1 ; simulationData ->
mData -> mTime . mX = & time_p ; simulationData -> mData -> mContStates . mN
= 0 ; simulationData -> mData -> mContStates . mX = NULL ; simulationData ->
mData -> mDiscStates . mN = 0 ; simulationData -> mData -> mDiscStates . mX =
& localDW -> k3ixguozrc ; simulationData -> mData -> mModeVector . mN = 0 ;
simulationData -> mData -> mModeVector . mX = & localDW -> cyqvnriqjr ; ok =
false ; simulationData -> mData -> mFoundZcEvents = ok ; simulationData ->
mData -> mIsMajorTimeStep = true ; ok = _ssGetSolverAssertCheck ( kyw2aoe1o0
-> _mdlRefSfcnS ) ; simulationData -> mData -> mIsSolverAssertCheck = ok ;
simulationData -> mData -> mIsSolverCheckingCIC = false ; simulationData ->
mData -> mIsComputingJacobian = false ; simulationData -> mData ->
mIsEvaluatingF0 = false ; simulationData -> mData -> mIsSolverRequestingReset
= false ; simulationData -> mData -> mIsOkayToUpdateMode = true ; tmp_m [ 0 ]
= 0 ; tmp_i [ 0 ] = localB -> nej3fn0a0e [ 0 ] ; tmp_i [ 1 ] = localB ->
nej3fn0a0e [ 1 ] ; tmp_i [ 2 ] = localB -> nej3fn0a0e [ 2 ] ; tmp_i [ 3 ] =
localB -> nej3fn0a0e [ 3 ] ; tmp_m [ 1 ] = 4 ; tmp_i [ 4 ] = localB ->
pbhhlvkgxv [ 0 ] ; tmp_i [ 5 ] = localB -> pbhhlvkgxv [ 1 ] ; tmp_i [ 6 ] =
localB -> pbhhlvkgxv [ 2 ] ; tmp_i [ 7 ] = localB -> pbhhlvkgxv [ 3 ] ; tmp_m
[ 2 ] = 8 ; tmp_i [ 8 ] = localB -> agn2ggwjbr [ 0 ] ; tmp_i [ 9 ] = localB
-> agn2ggwjbr [ 1 ] ; tmp_i [ 10 ] = localB -> agn2ggwjbr [ 2 ] ; tmp_i [ 11
] = localB -> agn2ggwjbr [ 3 ] ; tmp_m [ 3 ] = 12 ; tmp_i [ 12 ] = localB ->
bkoe3onl4o [ 0 ] ; tmp_i [ 13 ] = localB -> bkoe3onl4o [ 1 ] ; tmp_i [ 14 ] =
localB -> bkoe3onl4o [ 2 ] ; tmp_i [ 15 ] = localB -> bkoe3onl4o [ 3 ] ;
tmp_m [ 4 ] = 16 ; tmp_i [ 16 ] = localB -> b1fwtui0xy [ 0 ] ; tmp_i [ 17 ] =
localB -> b1fwtui0xy [ 1 ] ; tmp_i [ 18 ] = localB -> b1fwtui0xy [ 2 ] ;
tmp_i [ 19 ] = localB -> b1fwtui0xy [ 3 ] ; tmp_m [ 5 ] = 20 ; tmp_i [ 20 ] =
localB -> hohy0ccoij [ 0 ] ; tmp_i [ 21 ] = localB -> hohy0ccoij [ 1 ] ;
tmp_i [ 22 ] = localB -> hohy0ccoij [ 2 ] ; tmp_i [ 23 ] = localB ->
hohy0ccoij [ 3 ] ; tmp_m [ 6 ] = 24 ; tmp_i [ 24 ] = localB -> ddbvd0dqvk [ 0
] ; tmp_i [ 25 ] = localB -> ddbvd0dqvk [ 1 ] ; tmp_i [ 26 ] = localB ->
ddbvd0dqvk [ 2 ] ; tmp_i [ 27 ] = localB -> ddbvd0dqvk [ 3 ] ; tmp_m [ 7 ] =
28 ; memcpy ( & tmp_i [ 28 ] , & localB -> gwaclz3bjw [ 0 ] , 197U * sizeof (
real_T ) ) ; tmp_m [ 8 ] = 225 ; simulationData -> mData -> mInputValues . mN
= 225 ; simulationData -> mData -> mInputValues . mX = & tmp_i [ 0 ] ;
simulationData -> mData -> mInputOffsets . mN = 9 ; simulationData -> mData
-> mInputOffsets . mX = & tmp_m [ 0 ] ; simulationData -> mData -> mOutputs .
mN = 11 ; simulationData -> mData -> mOutputs . mX = & p1xjbgvbxw [ 0 ] ;
simulationData -> mData -> mSampleHits . mN = 0 ; simulationData -> mData ->
mSampleHits . mX = NULL ; ok = rtmIsMajorTimeStep ( kyw2aoe1o0 ) ;
simulationData -> mData -> mIsFundamentalSampleHit = ok ; simulationData ->
mData -> mTolerances . mN = 0 ; simulationData -> mData -> mTolerances . mX =
NULL ; simulationData -> mData -> mCstateHasChanged = false ; diag = (
NeuDiagnosticManager * ) localDW -> ln2l0ra4by ; diagnosticTree_p =
neu_diagnostic_manager_get_initial_tree ( diag ) ; iy = ne_simulator_method (
( NeslSimulator * ) localDW -> mbaq2wwli1 , NESL_SIM_OUTPUTS , simulationData
, diag ) ; if ( iy != 0 ) { ok = error_buffer_is_empty ( ssGetErrorStatus (
kyw2aoe1o0 -> _mdlRefSfcnS ) ) ; if ( ok ) { msg_e = rtw_diagnostics_msg (
diagnosticTree_p ) ; ssSetErrorStatus ( kyw2aoe1o0 -> _mdlRefSfcnS , msg_e )
; } } ssSetBlockStateForSolverChangedAtMajorStep ( kyw2aoe1o0 -> _mdlRefSfcnS
) ; ioisohncle = j1gcqcp03u . P_13 * p1xjbgvbxw [ 4 ] ; * dtfibjp3f2 =
p1xjbgvbxw [ 5 ] ; * nsdvtzjsad = p1xjbgvbxw [ 6 ] ; * kc5pzokhav =
p1xjbgvbxw [ 7 ] ; } { real_T * * uBuffer = ( real_T * * ) & localDW ->
g3uljnoxwm . TUbufferPtrs [ 0 ] ; real_T simTime = rtmGetTaskTime (
kyw2aoe1o0 , 0 ) ; real_T tMinusDelay = simTime - j1gcqcp03u . P_14 ; localB
-> dbmtiwskob = rt_TDelayInterpolate ( tMinusDelay , 0.0 , * uBuffer ,
localDW -> gq1n1qgyyy . CircularBufSize , & localDW -> gq1n1qgyyy . Last ,
localDW -> gq1n1qgyyy . Tail , localDW -> gq1n1qgyyy . Head , j1gcqcp03u .
P_15 , 0 , ( boolean_T ) ( rtmIsMinorTimeStep ( kyw2aoe1o0 ) && (
rtmGetTimeOfLastOutput ( kyw2aoe1o0 ) == rtmGetTaskTime ( kyw2aoe1o0 , 0 ) )
) ) ; } if ( rtmIsMajorTimeStep ( kyw2aoe1o0 ) ) { ioisohncle = j1gcqcp03u .
P_16 * p1xjbgvbxw [ 8 ] ; } { real_T * * uBuffer = ( real_T * * ) & localDW
-> k551hcuwml . TUbufferPtrs [ 0 ] ; real_T simTime = rtmGetTaskTime (
kyw2aoe1o0 , 0 ) ; real_T tMinusDelay = simTime - j1gcqcp03u . P_17 ; localB
-> kmxexgsb2w = rt_TDelayInterpolate ( tMinusDelay , 0.0 , * uBuffer ,
localDW -> ggfepuoe3d . CircularBufSize , & localDW -> ggfepuoe3d . Last ,
localDW -> ggfepuoe3d . Tail , localDW -> ggfepuoe3d . Head , j1gcqcp03u .
P_18 , 0 , ( boolean_T ) ( rtmIsMinorTimeStep ( kyw2aoe1o0 ) && (
rtmGetTimeOfLastOutput ( kyw2aoe1o0 ) == rtmGetTaskTime ( kyw2aoe1o0 , 0 ) )
) ) ; } if ( rtmIsMajorTimeStep ( kyw2aoe1o0 ) ) { ioisohncle = j1gcqcp03u .
P_19 * p1xjbgvbxw [ 3 ] ; } } void plantTID2 ( void ) { } void hwyjztgp4d (
oqqfjfnavm * const kyw2aoe1o0 , const real_T * cemkstch3m , const real_T *
cqvger3asl , const real_T * dgovykv54s , gs4ynfho4y * localB , khriw1lc2c *
localDW ) { NeslSimulationData * simulationData ; NeuDiagnosticManager *
diagnosticManager ; NeuDiagnosticTree * diagnosticTree ; char * msg ; real_T
tmp_p [ 28 ] ; real_T time ; real_T * lastU ; int32_T tmp_i ; int_T tmp_e [ 8
] ; boolean_T tmp ; if ( j1gcqcp03u . P_38 == 1 ) { localB -> pthz20a004 =
j1gcqcp03u . P_20 ; } else { localB -> pthz20a004 = * cemkstch3m ; } if (
rtmIsMajorTimeStep ( kyw2aoe1o0 ) ) { } if ( j1gcqcp03u . P_39 == 1 ) {
localB -> bwsq2w4yue = j1gcqcp03u . P_21 ; } else { localB -> bwsq2w4yue = *
cqvger3asl ; } if ( rtmIsMajorTimeStep ( kyw2aoe1o0 ) ) { } if ( j1gcqcp03u .
P_40 == 1 ) { localB -> mxtsxnl344 = j1gcqcp03u . P_25 ; } else { localB ->
mxtsxnl344 = * dgovykv54s ; } if ( rtmIsMajorTimeStep ( kyw2aoe1o0 ) ) { } if
( localDW -> li0zy2ybda == ( rtInf ) ) { localDW -> li0zy2ybda =
rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; lastU = & localDW -> o4xfeqygo1 ; } else
if ( localDW -> bmmnk2hkqr == ( rtInf ) ) { localDW -> bmmnk2hkqr =
rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; lastU = & localDW -> ddxucremmb ; } else
if ( localDW -> li0zy2ybda < localDW -> bmmnk2hkqr ) { localDW -> li0zy2ybda
= rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; lastU = & localDW -> o4xfeqygo1 ; }
else { localDW -> bmmnk2hkqr = rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; lastU = &
localDW -> ddxucremmb ; } * lastU = localB -> pum1gml0fg ; if ( localDW ->
cc0p4yapio == ( rtInf ) ) { localDW -> cc0p4yapio = rtmGetTaskTime (
kyw2aoe1o0 , 0 ) ; lastU = & localDW -> hetafjr45k ; } else if ( localDW ->
pjlofbmgkc == ( rtInf ) ) { localDW -> pjlofbmgkc = rtmGetTaskTime (
kyw2aoe1o0 , 0 ) ; lastU = & localDW -> dcm3vfsh3n ; } else if ( localDW ->
cc0p4yapio < localDW -> pjlofbmgkc ) { localDW -> cc0p4yapio = rtmGetTaskTime
( kyw2aoe1o0 , 0 ) ; lastU = & localDW -> hetafjr45k ; } else { localDW ->
pjlofbmgkc = rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; lastU = & localDW ->
dcm3vfsh3n ; } * lastU = localB -> oyche00ljt ; { real_T * * uBuffer = (
real_T * * ) & localDW -> heanzsqqzv . TUbufferPtrs [ 0 ] ; real_T simTime =
rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; localDW -> ndsoprptcn . Head = ( (
localDW -> ndsoprptcn . Head < ( localDW -> ndsoprptcn . CircularBufSize - 1
) ) ? ( localDW -> ndsoprptcn . Head + 1 ) : 0 ) ; if ( localDW -> ndsoprptcn
. Head == localDW -> ndsoprptcn . Tail ) { localDW -> ndsoprptcn . Tail = ( (
localDW -> ndsoprptcn . Tail < ( localDW -> ndsoprptcn . CircularBufSize - 1
) ) ? ( localDW -> ndsoprptcn . Tail + 1 ) : 0 ) ; } ( * uBuffer + localDW ->
ndsoprptcn . CircularBufSize ) [ localDW -> ndsoprptcn . Head ] = simTime ; (
* uBuffer ) [ localDW -> ndsoprptcn . Head ] = localB -> pthz20a004 ; } if (
localDW -> ha3flsheab == ( rtInf ) ) { localDW -> ha3flsheab = rtmGetTaskTime
( kyw2aoe1o0 , 0 ) ; lastU = & localDW -> pgqakzzjtp ; } else if ( localDW ->
cpxu0nhavi == ( rtInf ) ) { localDW -> cpxu0nhavi = rtmGetTaskTime (
kyw2aoe1o0 , 0 ) ; lastU = & localDW -> ewdokzvqyf ; } else if ( localDW ->
ha3flsheab < localDW -> cpxu0nhavi ) { localDW -> ha3flsheab = rtmGetTaskTime
( kyw2aoe1o0 , 0 ) ; lastU = & localDW -> pgqakzzjtp ; } else { localDW ->
cpxu0nhavi = rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; lastU = & localDW ->
ewdokzvqyf ; } * lastU = localB -> pwiaux3gpz ; if ( localDW -> jgxniudunk ==
( rtInf ) ) { localDW -> jgxniudunk = rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ;
lastU = & localDW -> ncxcfwfguz ; } else if ( localDW -> a0sj41yc22 == (
rtInf ) ) { localDW -> a0sj41yc22 = rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; lastU
= & localDW -> kvptsc2r0b ; } else if ( localDW -> jgxniudunk < localDW ->
a0sj41yc22 ) { localDW -> jgxniudunk = rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ;
lastU = & localDW -> ncxcfwfguz ; } else { localDW -> a0sj41yc22 =
rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; lastU = & localDW -> kvptsc2r0b ; } *
lastU = localB -> huw2jglag1 ; if ( localDW -> askvnz0tsd == ( rtInf ) ) {
localDW -> askvnz0tsd = rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; lastU = & localDW
-> khrsxvxe2v ; } else if ( localDW -> oem3mqqlzr == ( rtInf ) ) { localDW ->
oem3mqqlzr = rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; lastU = & localDW ->
jlenuaifba ; } else if ( localDW -> askvnz0tsd < localDW -> oem3mqqlzr ) {
localDW -> askvnz0tsd = rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; lastU = & localDW
-> khrsxvxe2v ; } else { localDW -> oem3mqqlzr = rtmGetTaskTime ( kyw2aoe1o0
, 0 ) ; lastU = & localDW -> jlenuaifba ; } * lastU = localB -> dfescxqrvg ;
if ( localDW -> gpiwz4w1hd == ( rtInf ) ) { localDW -> gpiwz4w1hd =
rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; lastU = & localDW -> hamkb3snwi ; } else
if ( localDW -> nfnzt1rl1w == ( rtInf ) ) { localDW -> nfnzt1rl1w =
rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; lastU = & localDW -> ecaz0wysbo ; } else
if ( localDW -> gpiwz4w1hd < localDW -> nfnzt1rl1w ) { localDW -> gpiwz4w1hd
= rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; lastU = & localDW -> hamkb3snwi ; }
else { localDW -> nfnzt1rl1w = rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ; lastU = &
localDW -> ecaz0wysbo ; } * lastU = localB -> kukprqjt0a ; if (
rtmIsMajorTimeStep ( kyw2aoe1o0 ) ) { simulationData = ( NeslSimulationData *
) localDW -> d1krrjylmb ; time = rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ;
simulationData -> mData -> mTime . mN = 1 ; simulationData -> mData -> mTime
. mX = & time ; simulationData -> mData -> mContStates . mN = 0 ;
simulationData -> mData -> mContStates . mX = NULL ; simulationData -> mData
-> mDiscStates . mN = 122 ; simulationData -> mData -> mDiscStates . mX = &
localDW -> diy4avfcef [ 0 ] ; simulationData -> mData -> mModeVector . mN =
75 ; simulationData -> mData -> mModeVector . mX = & localDW -> iie5kx1kjr [
0 ] ; tmp = false ; simulationData -> mData -> mFoundZcEvents = tmp ;
simulationData -> mData -> mIsMajorTimeStep = true ; tmp =
_ssGetSolverAssertCheck ( kyw2aoe1o0 -> _mdlRefSfcnS ) ; simulationData ->
mData -> mIsSolverAssertCheck = tmp ; simulationData -> mData ->
mIsSolverCheckingCIC = false ; simulationData -> mData ->
mIsComputingJacobian = false ; simulationData -> mData -> mIsEvaluatingF0 =
false ; simulationData -> mData -> mIsSolverRequestingReset = false ;
simulationData -> mData -> mIsOkayToUpdateMode = true ; tmp_e [ 0 ] = 0 ;
tmp_p [ 0 ] = localB -> nej3fn0a0e [ 0 ] ; tmp_p [ 1 ] = localB -> nej3fn0a0e
[ 1 ] ; tmp_p [ 2 ] = localB -> nej3fn0a0e [ 2 ] ; tmp_p [ 3 ] = localB ->
nej3fn0a0e [ 3 ] ; tmp_e [ 1 ] = 4 ; tmp_p [ 4 ] = localB -> pbhhlvkgxv [ 0 ]
; tmp_p [ 5 ] = localB -> pbhhlvkgxv [ 1 ] ; tmp_p [ 6 ] = localB ->
pbhhlvkgxv [ 2 ] ; tmp_p [ 7 ] = localB -> pbhhlvkgxv [ 3 ] ; tmp_e [ 2 ] = 8
; tmp_p [ 8 ] = localB -> agn2ggwjbr [ 0 ] ; tmp_p [ 9 ] = localB ->
agn2ggwjbr [ 1 ] ; tmp_p [ 10 ] = localB -> agn2ggwjbr [ 2 ] ; tmp_p [ 11 ] =
localB -> agn2ggwjbr [ 3 ] ; tmp_e [ 3 ] = 12 ; tmp_p [ 12 ] = localB ->
bkoe3onl4o [ 0 ] ; tmp_p [ 13 ] = localB -> bkoe3onl4o [ 1 ] ; tmp_p [ 14 ] =
localB -> bkoe3onl4o [ 2 ] ; tmp_p [ 15 ] = localB -> bkoe3onl4o [ 3 ] ;
tmp_e [ 4 ] = 16 ; tmp_p [ 16 ] = localB -> b1fwtui0xy [ 0 ] ; tmp_p [ 17 ] =
localB -> b1fwtui0xy [ 1 ] ; tmp_p [ 18 ] = localB -> b1fwtui0xy [ 2 ] ;
tmp_p [ 19 ] = localB -> b1fwtui0xy [ 3 ] ; tmp_e [ 5 ] = 20 ; tmp_p [ 20 ] =
localB -> hohy0ccoij [ 0 ] ; tmp_p [ 21 ] = localB -> hohy0ccoij [ 1 ] ;
tmp_p [ 22 ] = localB -> hohy0ccoij [ 2 ] ; tmp_p [ 23 ] = localB ->
hohy0ccoij [ 3 ] ; tmp_e [ 6 ] = 24 ; tmp_p [ 24 ] = localB -> ddbvd0dqvk [ 0
] ; tmp_p [ 25 ] = localB -> ddbvd0dqvk [ 1 ] ; tmp_p [ 26 ] = localB ->
ddbvd0dqvk [ 2 ] ; tmp_p [ 27 ] = localB -> ddbvd0dqvk [ 3 ] ; tmp_e [ 7 ] =
28 ; simulationData -> mData -> mInputValues . mN = 28 ; simulationData ->
mData -> mInputValues . mX = & tmp_p [ 0 ] ; simulationData -> mData ->
mInputOffsets . mN = 8 ; simulationData -> mData -> mInputOffsets . mX = &
tmp_e [ 0 ] ; diagnosticManager = ( NeuDiagnosticManager * ) localDW ->
oiosdkzqje ; diagnosticTree = neu_diagnostic_manager_get_initial_tree (
diagnosticManager ) ; tmp_i = ne_simulator_method ( ( NeslSimulator * )
localDW -> jw04ifknil , NESL_SIM_UPDATE , simulationData , diagnosticManager
) ; if ( tmp_i != 0 ) { tmp = error_buffer_is_empty ( ssGetErrorStatus (
kyw2aoe1o0 -> _mdlRefSfcnS ) ) ; if ( tmp ) { msg = rtw_diagnostics_msg (
diagnosticTree ) ; ssSetErrorStatus ( kyw2aoe1o0 -> _mdlRefSfcnS , msg ) ; }
} } { real_T * * uBuffer = ( real_T * * ) & localDW -> g3uljnoxwm .
TUbufferPtrs [ 0 ] ; real_T simTime = rtmGetTaskTime ( kyw2aoe1o0 , 0 ) ;
localDW -> gq1n1qgyyy . Head = ( ( localDW -> gq1n1qgyyy . Head < ( localDW
-> gq1n1qgyyy . CircularBufSize - 1 ) ) ? ( localDW -> gq1n1qgyyy . Head + 1
) : 0 ) ; if ( localDW -> gq1n1qgyyy . Head == localDW -> gq1n1qgyyy . Tail )
{ localDW -> gq1n1qgyyy . Tail = ( ( localDW -> gq1n1qgyyy . Tail < ( localDW
-> gq1n1qgyyy . CircularBufSize - 1 ) ) ? ( localDW -> gq1n1qgyyy . Tail + 1
) : 0 ) ; } ( * uBuffer + localDW -> gq1n1qgyyy . CircularBufSize ) [ localDW
-> gq1n1qgyyy . Head ] = simTime ; ( * uBuffer ) [ localDW -> gq1n1qgyyy .
Head ] = localB -> bwsq2w4yue ; } { real_T * * uBuffer = ( real_T * * ) &
localDW -> k551hcuwml . TUbufferPtrs [ 0 ] ; real_T simTime = rtmGetTaskTime
( kyw2aoe1o0 , 0 ) ; localDW -> ggfepuoe3d . Head = ( ( localDW -> ggfepuoe3d
. Head < ( localDW -> ggfepuoe3d . CircularBufSize - 1 ) ) ? ( localDW ->
ggfepuoe3d . Head + 1 ) : 0 ) ; if ( localDW -> ggfepuoe3d . Head == localDW
-> ggfepuoe3d . Tail ) { localDW -> ggfepuoe3d . Tail = ( ( localDW ->
ggfepuoe3d . Tail < ( localDW -> ggfepuoe3d . CircularBufSize - 1 ) ) ? (
localDW -> ggfepuoe3d . Tail + 1 ) : 0 ) ; } ( * uBuffer + localDW ->
ggfepuoe3d . CircularBufSize ) [ localDW -> ggfepuoe3d . Head ] = simTime ; (
* uBuffer ) [ localDW -> ggfepuoe3d . Head ] = localB -> mxtsxnl344 ; } }
void hwyjztgp4dTID2 ( void ) { } void oum4ych01w ( oqqfjfnavm * const
kyw2aoe1o0 , const real_T * cemkstch3m , const real_T * cqvger3asl , const
real_T * dgovykv54s , gs4ynfho4y * localB , nwe3ifp0pp * localX , ecygsd2j42
* localXdot ) { if ( j1gcqcp03u . P_38 == 1 ) { localB -> pthz20a004 =
j1gcqcp03u . P_20 ; } else { localB -> pthz20a004 = * cemkstch3m ; } if (
rtmIsMajorTimeStep ( kyw2aoe1o0 ) ) { } if ( j1gcqcp03u . P_39 == 1 ) {
localB -> bwsq2w4yue = j1gcqcp03u . P_21 ; } else { localB -> bwsq2w4yue = *
cqvger3asl ; } if ( rtmIsMajorTimeStep ( kyw2aoe1o0 ) ) { } if ( j1gcqcp03u .
P_40 == 1 ) { localB -> mxtsxnl344 = j1gcqcp03u . P_25 ; } else { localB ->
mxtsxnl344 = * dgovykv54s ; } if ( rtmIsMajorTimeStep ( kyw2aoe1o0 ) ) { }
localXdot -> osra1al44t = 0.0 ; localXdot -> osra1al44t += j1gcqcp03u . P_7 *
localX -> osra1al44t ; localXdot -> osra1al44t += localB -> kmxexgsb2w ;
localXdot -> juq2ph1trj = 0.0 ; localXdot -> juq2ph1trj += j1gcqcp03u . P_11
* localX -> juq2ph1trj ; localXdot -> juq2ph1trj += localB -> dbmtiwskob ; }
void mbc2hav4mz ( khriw1lc2c * localDW , oqqfjfnavm * const kyw2aoe1o0 ) {
neu_destroy_diagnostic_manager ( ( NeuDiagnosticManager * ) localDW ->
oiosdkzqje ) ; nesl_destroy_simulation_data ( ( NeslSimulationData * )
localDW -> d1krrjylmb ) ; nesl_erase_simulator (
"plant/Solver Configuration_1" ) ; nesl_destroy_registry ( ) ;
neu_destroy_diagnostic_manager ( ( NeuDiagnosticManager * ) localDW ->
ln2l0ra4by ) ; nesl_destroy_simulation_data ( ( NeslSimulationData * )
localDW -> p4i4r5dbtk ) ; nesl_erase_simulator (
"plant/Solver Configuration_1" ) ; nesl_destroy_registry ( ) ; if ( !
slIsRapidAcceleratorSimulating ( ) ) { slmrRunPluginEvent ( kyw2aoe1o0 ->
_mdlRefSfcnS , "plant" , "SIMSTATUS_TERMINATING_MODELREF_ACCEL_EVENT" ) ; } }
void k1yuutjvkp ( SimStruct * _mdlRefSfcnS , int_T mdlref_TID0 , int_T
mdlref_TID1 , int_T mdlref_TID2 , oqqfjfnavm * const kyw2aoe1o0 , gs4ynfho4y
* localB , khriw1lc2c * localDW , nwe3ifp0pp * localX , void * sysRanPtr ,
int contextTid , rtwCAPI_ModelMappingInfo * rt_ParentMMI , const char_T *
rt_ChildPath , int_T rt_ChildMMIIdx , int_T rt_CSTATEIdx ) { rt_InitInfAndNaN
( sizeof ( real_T ) ) ; ( void ) memset ( ( void * ) kyw2aoe1o0 , 0 , sizeof
( oqqfjfnavm ) ) ; kyw2aoe1o0 -> Timing . mdlref_GlobalTID [ 0 ] =
mdlref_TID0 ; kyw2aoe1o0 -> Timing . mdlref_GlobalTID [ 1 ] = mdlref_TID1 ;
kyw2aoe1o0 -> Timing . mdlref_GlobalTID [ 2 ] = mdlref_TID2 ; kyw2aoe1o0 ->
_mdlRefSfcnS = ( _mdlRefSfcnS ) ; if ( ! slIsRapidAcceleratorSimulating ( ) )
{ slmrRunPluginEvent ( kyw2aoe1o0 -> _mdlRefSfcnS , "plant" ,
"START_OF_SIM_MODEL_MODELREF_ACCEL_EVENT" ) ; } { int32_T i ; for ( i = 0 ; i
< 197 ; i ++ ) { localB -> gwaclz3bjw [ i ] = 0.0 ; } localB -> nej3fn0a0e [
0 ] = 0.0 ; localB -> nej3fn0a0e [ 1 ] = 0.0 ; localB -> nej3fn0a0e [ 2 ] =
0.0 ; localB -> nej3fn0a0e [ 3 ] = 0.0 ; localB -> pbhhlvkgxv [ 0 ] = 0.0 ;
localB -> pbhhlvkgxv [ 1 ] = 0.0 ; localB -> pbhhlvkgxv [ 2 ] = 0.0 ; localB
-> pbhhlvkgxv [ 3 ] = 0.0 ; localB -> agn2ggwjbr [ 0 ] = 0.0 ; localB ->
agn2ggwjbr [ 1 ] = 0.0 ; localB -> agn2ggwjbr [ 2 ] = 0.0 ; localB ->
agn2ggwjbr [ 3 ] = 0.0 ; localB -> pum1gml0fg = 0.0 ; localB -> oyche00ljt =
0.0 ; localB -> fpgrkyomeh = 0.0 ; localB -> bkoe3onl4o [ 0 ] = 0.0 ; localB
-> bkoe3onl4o [ 1 ] = 0.0 ; localB -> bkoe3onl4o [ 2 ] = 0.0 ; localB ->
bkoe3onl4o [ 3 ] = 0.0 ; localB -> pwiaux3gpz = 0.0 ; localB -> huw2jglag1 =
0.0 ; localB -> jzn21mzell = 0.0 ; localB -> b1fwtui0xy [ 0 ] = 0.0 ; localB
-> b1fwtui0xy [ 1 ] = 0.0 ; localB -> b1fwtui0xy [ 2 ] = 0.0 ; localB ->
b1fwtui0xy [ 3 ] = 0.0 ; localB -> hohy0ccoij [ 0 ] = 0.0 ; localB ->
hohy0ccoij [ 1 ] = 0.0 ; localB -> hohy0ccoij [ 2 ] = 0.0 ; localB ->
hohy0ccoij [ 3 ] = 0.0 ; localB -> dfescxqrvg = 0.0 ; localB -> kukprqjt0a =
0.0 ; localB -> lw3wils3lh = 0.0 ; localB -> ddbvd0dqvk [ 0 ] = 0.0 ; localB
-> ddbvd0dqvk [ 1 ] = 0.0 ; localB -> ddbvd0dqvk [ 2 ] = 0.0 ; localB ->
ddbvd0dqvk [ 3 ] = 0.0 ; localB -> l121g2av3m = 0.0 ; localB -> dbmtiwskob =
0.0 ; localB -> kmxexgsb2w = 0.0 ; localB -> pthz20a004 = 0.0 ; localB ->
bwsq2w4yue = 0.0 ; localB -> mxtsxnl344 = 0.0 ; } ( void ) memset ( ( void *
) localDW , 0 , sizeof ( khriw1lc2c ) ) ; localDW -> jybrzbbm2b [ 0 ] = 0.0 ;
localDW -> jybrzbbm2b [ 1 ] = 0.0 ; localDW -> m4ierv1qm3 [ 0 ] = 0.0 ;
localDW -> m4ierv1qm3 [ 1 ] = 0.0 ; localDW -> f5pqyxxsbw [ 0 ] = 0.0 ;
localDW -> f5pqyxxsbw [ 1 ] = 0.0 ; localDW -> mc1vxvx1ag [ 0 ] = 0.0 ;
localDW -> mc1vxvx1ag [ 1 ] = 0.0 ; localDW -> byuf4wycfu [ 0 ] = 0.0 ;
localDW -> byuf4wycfu [ 1 ] = 0.0 ; localDW -> i2uttr1ys2 [ 0 ] = 0.0 ;
localDW -> i2uttr1ys2 [ 1 ] = 0.0 ; localDW -> ay4g10nafy [ 0 ] = 0.0 ;
localDW -> ay4g10nafy [ 1 ] = 0.0 ; { int32_T i ; for ( i = 0 ; i < 122 ; i
++ ) { localDW -> diy4avfcef [ i ] = 0.0 ; } } localDW -> li0zy2ybda = 0.0 ;
localDW -> o4xfeqygo1 = 0.0 ; localDW -> bmmnk2hkqr = 0.0 ; localDW ->
ddxucremmb = 0.0 ; localDW -> cc0p4yapio = 0.0 ; localDW -> hetafjr45k = 0.0
; localDW -> pjlofbmgkc = 0.0 ; localDW -> dcm3vfsh3n = 0.0 ; localDW ->
ha3flsheab = 0.0 ; localDW -> pgqakzzjtp = 0.0 ; localDW -> cpxu0nhavi = 0.0
; localDW -> ewdokzvqyf = 0.0 ; localDW -> jgxniudunk = 0.0 ; localDW ->
ncxcfwfguz = 0.0 ; localDW -> a0sj41yc22 = 0.0 ; localDW -> kvptsc2r0b = 0.0
; localDW -> askvnz0tsd = 0.0 ; localDW -> khrsxvxe2v = 0.0 ; localDW ->
oem3mqqlzr = 0.0 ; localDW -> jlenuaifba = 0.0 ; localDW -> gpiwz4w1hd = 0.0
; localDW -> hamkb3snwi = 0.0 ; localDW -> nfnzt1rl1w = 0.0 ; localDW ->
ecaz0wysbo = 0.0 ; localDW -> k3ixguozrc = 0.0 ; localDW -> bdxcmvfrpb .
modelTStart = 0.0 ; { int32_T i ; for ( i = 0 ; i < 204800 ; i ++ ) { localDW
-> bdxcmvfrpb . TUbufferArea [ i ] = 0.0 ; } } localDW -> axkanaqtvp .
modelTStart = 0.0 ; { int32_T i ; for ( i = 0 ; i < 2048000 ; i ++ ) {
localDW -> axkanaqtvp . TUbufferArea [ i ] = 0.0 ; } } localDW -> ligjvnb3hq
. modelTStart = 0.0 ; { int32_T i ; for ( i = 0 ; i < 204800 ; i ++ ) {
localDW -> ligjvnb3hq . TUbufferArea [ i ] = 0.0 ; } }
plant_InitializeDataMapInfo ( kyw2aoe1o0 , localDW , localX , sysRanPtr ,
contextTid ) ; if ( ( rt_ParentMMI != ( NULL ) ) && ( rt_ChildPath != ( NULL
) ) ) { rtwCAPI_SetChildMMI ( * rt_ParentMMI , rt_ChildMMIIdx , & (
kyw2aoe1o0 -> DataMapInfo . mmi ) ) ; rtwCAPI_SetPath ( kyw2aoe1o0 ->
DataMapInfo . mmi , rt_ChildPath ) ; rtwCAPI_MMISetContStateStartIndex (
kyw2aoe1o0 -> DataMapInfo . mmi , rt_CSTATEIdx ) ; } } void
mr_plant_MdlInfoRegFcn ( SimStruct * mdlRefSfcnS , char_T * modelName , int_T
* retVal ) { * retVal = 0 ; { boolean_T regSubmodelsMdlinfo = false ;
ssGetRegSubmodelsMdlinfo ( mdlRefSfcnS , & regSubmodelsMdlinfo ) ; if (
regSubmodelsMdlinfo ) { } } * retVal = 0 ; ssRegModelRefMdlInfo ( mdlRefSfcnS
, modelName , rtMdlInfo_plant , 43 ) ; * retVal = 1 ; } static void
mr_plant_cacheDataAsMxArray ( mxArray * destArray , mwIndex i , int j , const
void * srcData , size_t numBytes ) ; static void mr_plant_cacheDataAsMxArray
( mxArray * destArray , mwIndex i , int j , const void * srcData , size_t
numBytes ) { mxArray * newArray = mxCreateUninitNumericMatrix ( ( size_t ) 1
, numBytes , mxUINT8_CLASS , mxREAL ) ; memcpy ( ( uint8_T * ) mxGetData (
newArray ) , ( const uint8_T * ) srcData , numBytes ) ; mxSetFieldByNumber (
destArray , i , j , newArray ) ; } static void
mr_plant_restoreDataFromMxArray ( void * destData , const mxArray * srcArray
, mwIndex i , int j , size_t numBytes ) ; static void
mr_plant_restoreDataFromMxArray ( void * destData , const mxArray * srcArray
, mwIndex i , int j , size_t numBytes ) { memcpy ( ( uint8_T * ) destData , (
const uint8_T * ) mxGetData ( mxGetFieldByNumber ( srcArray , i , j ) ) ,
numBytes ) ; } static void mr_plant_cacheBitFieldToMxArray ( mxArray *
destArray , mwIndex i , int j , uint_T bitVal ) ; static void
mr_plant_cacheBitFieldToMxArray ( mxArray * destArray , mwIndex i , int j ,
uint_T bitVal ) { mxSetFieldByNumber ( destArray , i , j ,
mxCreateDoubleScalar ( ( double ) bitVal ) ) ; } static uint_T
mr_plant_extractBitFieldFromMxArray ( const mxArray * srcArray , mwIndex i ,
int j , uint_T numBits ) ; static uint_T mr_plant_extractBitFieldFromMxArray
( const mxArray * srcArray , mwIndex i , int j , uint_T numBits ) { const
uint_T varVal = ( uint_T ) mxGetScalar ( mxGetFieldByNumber ( srcArray , i ,
j ) ) ; return varVal & ( ( 1u << numBits ) - 1u ) ; } static void
mr_plant_cacheDataToMxArrayWithOffset ( mxArray * destArray , mwIndex i , int
j , mwIndex offset , const void * srcData , size_t numBytes ) ; static void
mr_plant_cacheDataToMxArrayWithOffset ( mxArray * destArray , mwIndex i , int
j , mwIndex offset , const void * srcData , size_t numBytes ) { uint8_T *
varData = ( uint8_T * ) mxGetData ( mxGetFieldByNumber ( destArray , i , j )
) ; memcpy ( ( uint8_T * ) & varData [ offset * numBytes ] , ( const uint8_T
* ) srcData , numBytes ) ; } static void
mr_plant_restoreDataFromMxArrayWithOffset ( void * destData , const mxArray *
srcArray , mwIndex i , int j , mwIndex offset , size_t numBytes ) ; static
void mr_plant_restoreDataFromMxArrayWithOffset ( void * destData , const
mxArray * srcArray , mwIndex i , int j , mwIndex offset , size_t numBytes ) {
const uint8_T * varData = ( const uint8_T * ) mxGetData ( mxGetFieldByNumber
( srcArray , i , j ) ) ; memcpy ( ( uint8_T * ) destData , ( const uint8_T *
) & varData [ offset * numBytes ] , numBytes ) ; } static void
mr_plant_cacheBitFieldToCellArrayWithOffset ( mxArray * destArray , mwIndex i
, int j , mwIndex offset , uint_T fieldVal ) ; static void
mr_plant_cacheBitFieldToCellArrayWithOffset ( mxArray * destArray , mwIndex i
, int j , mwIndex offset , uint_T fieldVal ) { mxSetCell ( mxGetFieldByNumber
( destArray , i , j ) , offset , mxCreateDoubleScalar ( ( double ) fieldVal )
) ; } static uint_T mr_plant_extractBitFieldFromCellArrayWithOffset ( const
mxArray * srcArray , mwIndex i , int j , mwIndex offset , uint_T numBits ) ;
static uint_T mr_plant_extractBitFieldFromCellArrayWithOffset ( const mxArray
* srcArray , mwIndex i , int j , mwIndex offset , uint_T numBits ) { const
uint_T fieldVal = ( uint_T ) mxGetScalar ( mxGetCell ( mxGetFieldByNumber (
srcArray , i , j ) , offset ) ) ; return fieldVal & ( ( 1u << numBits ) - 1u
) ; } mxArray * mr_plant_GetDWork ( const irprwpldwbj * mdlrefDW ) { static
const char * ssDWFieldNames [ 3 ] = { "rtb" , "rtdw" , "NULL->rtzce" , } ;
mxArray * ssDW = mxCreateStructMatrix ( 1 , 1 , 3 , ssDWFieldNames ) ;
mr_plant_cacheDataAsMxArray ( ssDW , 0 , 0 , ( const void * ) & ( mdlrefDW ->
rtb ) , sizeof ( mdlrefDW -> rtb ) ) ; { static const char *
rtdwDataFieldNames [ 44 ] = { "mdlrefDW->rtdw.jybrzbbm2b" ,
"mdlrefDW->rtdw.m4ierv1qm3" , "mdlrefDW->rtdw.f5pqyxxsbw" ,
"mdlrefDW->rtdw.mc1vxvx1ag" , "mdlrefDW->rtdw.byuf4wycfu" ,
"mdlrefDW->rtdw.i2uttr1ys2" , "mdlrefDW->rtdw.ay4g10nafy" ,
"mdlrefDW->rtdw.diy4avfcef" , "mdlrefDW->rtdw.li0zy2ybda" ,
"mdlrefDW->rtdw.o4xfeqygo1" , "mdlrefDW->rtdw.bmmnk2hkqr" ,
"mdlrefDW->rtdw.ddxucremmb" , "mdlrefDW->rtdw.cc0p4yapio" ,
"mdlrefDW->rtdw.hetafjr45k" , "mdlrefDW->rtdw.pjlofbmgkc" ,
"mdlrefDW->rtdw.dcm3vfsh3n" , "mdlrefDW->rtdw.ha3flsheab" ,
"mdlrefDW->rtdw.pgqakzzjtp" , "mdlrefDW->rtdw.cpxu0nhavi" ,
"mdlrefDW->rtdw.ewdokzvqyf" , "mdlrefDW->rtdw.jgxniudunk" ,
"mdlrefDW->rtdw.ncxcfwfguz" , "mdlrefDW->rtdw.a0sj41yc22" ,
"mdlrefDW->rtdw.kvptsc2r0b" , "mdlrefDW->rtdw.askvnz0tsd" ,
"mdlrefDW->rtdw.khrsxvxe2v" , "mdlrefDW->rtdw.oem3mqqlzr" ,
"mdlrefDW->rtdw.jlenuaifba" , "mdlrefDW->rtdw.gpiwz4w1hd" ,
"mdlrefDW->rtdw.hamkb3snwi" , "mdlrefDW->rtdw.nfnzt1rl1w" ,
"mdlrefDW->rtdw.ecaz0wysbo" , "mdlrefDW->rtdw.k3ixguozrc" ,
"mdlrefDW->rtdw.bdxcmvfrpb" , "mdlrefDW->rtdw.axkanaqtvp" ,
"mdlrefDW->rtdw.ligjvnb3hq" , "mdlrefDW->rtdw.ndsoprptcn" ,
"mdlrefDW->rtdw.iie5kx1kjr" , "mdlrefDW->rtdw.cyqvnriqjr" ,
"mdlrefDW->rtdw.gq1n1qgyyy" , "mdlrefDW->rtdw.ggfepuoe3d" ,
"mdlrefDW->rtdw.heva2ukg0u" , "mdlrefDW->rtdw.azdqrfhhnj" ,
"mdlrefDW->rtdw.otb0bsqikx" , } ; mxArray * rtdwData = mxCreateStructMatrix (
1 , 1 , 44 , rtdwDataFieldNames ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 0 , ( const void * ) & ( mdlrefDW -> rtdw . jybrzbbm2b ) , sizeof (
mdlrefDW -> rtdw . jybrzbbm2b ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 1 , ( const void * ) & ( mdlrefDW -> rtdw . m4ierv1qm3 ) , sizeof (
mdlrefDW -> rtdw . m4ierv1qm3 ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 2 , ( const void * ) & ( mdlrefDW -> rtdw . f5pqyxxsbw ) , sizeof (
mdlrefDW -> rtdw . f5pqyxxsbw ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 3 , ( const void * ) & ( mdlrefDW -> rtdw . mc1vxvx1ag ) , sizeof (
mdlrefDW -> rtdw . mc1vxvx1ag ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 4 , ( const void * ) & ( mdlrefDW -> rtdw . byuf4wycfu ) , sizeof (
mdlrefDW -> rtdw . byuf4wycfu ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 5 , ( const void * ) & ( mdlrefDW -> rtdw . i2uttr1ys2 ) , sizeof (
mdlrefDW -> rtdw . i2uttr1ys2 ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 6 , ( const void * ) & ( mdlrefDW -> rtdw . ay4g10nafy ) , sizeof (
mdlrefDW -> rtdw . ay4g10nafy ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 7 , ( const void * ) & ( mdlrefDW -> rtdw . diy4avfcef ) , sizeof (
mdlrefDW -> rtdw . diy4avfcef ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 8 , ( const void * ) & ( mdlrefDW -> rtdw . li0zy2ybda ) , sizeof (
mdlrefDW -> rtdw . li0zy2ybda ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 9 , ( const void * ) & ( mdlrefDW -> rtdw . o4xfeqygo1 ) , sizeof (
mdlrefDW -> rtdw . o4xfeqygo1 ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 10 , ( const void * ) & ( mdlrefDW -> rtdw . bmmnk2hkqr ) , sizeof (
mdlrefDW -> rtdw . bmmnk2hkqr ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 11 , ( const void * ) & ( mdlrefDW -> rtdw . ddxucremmb ) , sizeof (
mdlrefDW -> rtdw . ddxucremmb ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 12 , ( const void * ) & ( mdlrefDW -> rtdw . cc0p4yapio ) , sizeof (
mdlrefDW -> rtdw . cc0p4yapio ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 13 , ( const void * ) & ( mdlrefDW -> rtdw . hetafjr45k ) , sizeof (
mdlrefDW -> rtdw . hetafjr45k ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 14 , ( const void * ) & ( mdlrefDW -> rtdw . pjlofbmgkc ) , sizeof (
mdlrefDW -> rtdw . pjlofbmgkc ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 15 , ( const void * ) & ( mdlrefDW -> rtdw . dcm3vfsh3n ) , sizeof (
mdlrefDW -> rtdw . dcm3vfsh3n ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 16 , ( const void * ) & ( mdlrefDW -> rtdw . ha3flsheab ) , sizeof (
mdlrefDW -> rtdw . ha3flsheab ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 17 , ( const void * ) & ( mdlrefDW -> rtdw . pgqakzzjtp ) , sizeof (
mdlrefDW -> rtdw . pgqakzzjtp ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 18 , ( const void * ) & ( mdlrefDW -> rtdw . cpxu0nhavi ) , sizeof (
mdlrefDW -> rtdw . cpxu0nhavi ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 19 , ( const void * ) & ( mdlrefDW -> rtdw . ewdokzvqyf ) , sizeof (
mdlrefDW -> rtdw . ewdokzvqyf ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 20 , ( const void * ) & ( mdlrefDW -> rtdw . jgxniudunk ) , sizeof (
mdlrefDW -> rtdw . jgxniudunk ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 21 , ( const void * ) & ( mdlrefDW -> rtdw . ncxcfwfguz ) , sizeof (
mdlrefDW -> rtdw . ncxcfwfguz ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 22 , ( const void * ) & ( mdlrefDW -> rtdw . a0sj41yc22 ) , sizeof (
mdlrefDW -> rtdw . a0sj41yc22 ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 23 , ( const void * ) & ( mdlrefDW -> rtdw . kvptsc2r0b ) , sizeof (
mdlrefDW -> rtdw . kvptsc2r0b ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 24 , ( const void * ) & ( mdlrefDW -> rtdw . askvnz0tsd ) , sizeof (
mdlrefDW -> rtdw . askvnz0tsd ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 25 , ( const void * ) & ( mdlrefDW -> rtdw . khrsxvxe2v ) , sizeof (
mdlrefDW -> rtdw . khrsxvxe2v ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 26 , ( const void * ) & ( mdlrefDW -> rtdw . oem3mqqlzr ) , sizeof (
mdlrefDW -> rtdw . oem3mqqlzr ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 27 , ( const void * ) & ( mdlrefDW -> rtdw . jlenuaifba ) , sizeof (
mdlrefDW -> rtdw . jlenuaifba ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 28 , ( const void * ) & ( mdlrefDW -> rtdw . gpiwz4w1hd ) , sizeof (
mdlrefDW -> rtdw . gpiwz4w1hd ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 29 , ( const void * ) & ( mdlrefDW -> rtdw . hamkb3snwi ) , sizeof (
mdlrefDW -> rtdw . hamkb3snwi ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 30 , ( const void * ) & ( mdlrefDW -> rtdw . nfnzt1rl1w ) , sizeof (
mdlrefDW -> rtdw . nfnzt1rl1w ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 31 , ( const void * ) & ( mdlrefDW -> rtdw . ecaz0wysbo ) , sizeof (
mdlrefDW -> rtdw . ecaz0wysbo ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 32 , ( const void * ) & ( mdlrefDW -> rtdw . k3ixguozrc ) , sizeof (
mdlrefDW -> rtdw . k3ixguozrc ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 33 , ( const void * ) & ( mdlrefDW -> rtdw . bdxcmvfrpb ) , sizeof (
mdlrefDW -> rtdw . bdxcmvfrpb ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 34 , ( const void * ) & ( mdlrefDW -> rtdw . axkanaqtvp ) , sizeof (
mdlrefDW -> rtdw . axkanaqtvp ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 35 , ( const void * ) & ( mdlrefDW -> rtdw . ligjvnb3hq ) , sizeof (
mdlrefDW -> rtdw . ligjvnb3hq ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 36 , ( const void * ) & ( mdlrefDW -> rtdw . ndsoprptcn ) , sizeof (
mdlrefDW -> rtdw . ndsoprptcn ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 37 , ( const void * ) & ( mdlrefDW -> rtdw . iie5kx1kjr ) , sizeof (
mdlrefDW -> rtdw . iie5kx1kjr ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 38 , ( const void * ) & ( mdlrefDW -> rtdw . cyqvnriqjr ) , sizeof (
mdlrefDW -> rtdw . cyqvnriqjr ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 39 , ( const void * ) & ( mdlrefDW -> rtdw . gq1n1qgyyy ) , sizeof (
mdlrefDW -> rtdw . gq1n1qgyyy ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 40 , ( const void * ) & ( mdlrefDW -> rtdw . ggfepuoe3d ) , sizeof (
mdlrefDW -> rtdw . ggfepuoe3d ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 41 , ( const void * ) & ( mdlrefDW -> rtdw . heva2ukg0u ) , sizeof (
mdlrefDW -> rtdw . heva2ukg0u ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 42 , ( const void * ) & ( mdlrefDW -> rtdw . azdqrfhhnj ) , sizeof (
mdlrefDW -> rtdw . azdqrfhhnj ) ) ; mr_plant_cacheDataAsMxArray ( rtdwData ,
0 , 43 , ( const void * ) & ( mdlrefDW -> rtdw . otb0bsqikx ) , sizeof (
mdlrefDW -> rtdw . otb0bsqikx ) ) ; mxSetFieldByNumber ( ssDW , 0 , 1 ,
rtdwData ) ; } ( void ) mdlrefDW ; return ssDW ; } void mr_plant_SetDWork (
irprwpldwbj * mdlrefDW , const mxArray * ssDW ) { ( void ) ssDW ; ( void )
mdlrefDW ; mr_plant_restoreDataFromMxArray ( ( void * ) & ( mdlrefDW -> rtb )
, ssDW , 0 , 0 , sizeof ( mdlrefDW -> rtb ) ) ; { const mxArray * rtdwData =
mxGetFieldByNumber ( ssDW , 0 , 1 ) ; mr_plant_restoreDataFromMxArray ( (
void * ) & ( mdlrefDW -> rtdw . jybrzbbm2b ) , rtdwData , 0 , 0 , sizeof (
mdlrefDW -> rtdw . jybrzbbm2b ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . m4ierv1qm3 ) , rtdwData , 0 , 1 , sizeof (
mdlrefDW -> rtdw . m4ierv1qm3 ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . f5pqyxxsbw ) , rtdwData , 0 , 2 , sizeof (
mdlrefDW -> rtdw . f5pqyxxsbw ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . mc1vxvx1ag ) , rtdwData , 0 , 3 , sizeof (
mdlrefDW -> rtdw . mc1vxvx1ag ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . byuf4wycfu ) , rtdwData , 0 , 4 , sizeof (
mdlrefDW -> rtdw . byuf4wycfu ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . i2uttr1ys2 ) , rtdwData , 0 , 5 , sizeof (
mdlrefDW -> rtdw . i2uttr1ys2 ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . ay4g10nafy ) , rtdwData , 0 , 6 , sizeof (
mdlrefDW -> rtdw . ay4g10nafy ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . diy4avfcef ) , rtdwData , 0 , 7 , sizeof (
mdlrefDW -> rtdw . diy4avfcef ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . li0zy2ybda ) , rtdwData , 0 , 8 , sizeof (
mdlrefDW -> rtdw . li0zy2ybda ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . o4xfeqygo1 ) , rtdwData , 0 , 9 , sizeof (
mdlrefDW -> rtdw . o4xfeqygo1 ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . bmmnk2hkqr ) , rtdwData , 0 , 10 , sizeof (
mdlrefDW -> rtdw . bmmnk2hkqr ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . ddxucremmb ) , rtdwData , 0 , 11 , sizeof (
mdlrefDW -> rtdw . ddxucremmb ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . cc0p4yapio ) , rtdwData , 0 , 12 , sizeof (
mdlrefDW -> rtdw . cc0p4yapio ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . hetafjr45k ) , rtdwData , 0 , 13 , sizeof (
mdlrefDW -> rtdw . hetafjr45k ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . pjlofbmgkc ) , rtdwData , 0 , 14 , sizeof (
mdlrefDW -> rtdw . pjlofbmgkc ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . dcm3vfsh3n ) , rtdwData , 0 , 15 , sizeof (
mdlrefDW -> rtdw . dcm3vfsh3n ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . ha3flsheab ) , rtdwData , 0 , 16 , sizeof (
mdlrefDW -> rtdw . ha3flsheab ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . pgqakzzjtp ) , rtdwData , 0 , 17 , sizeof (
mdlrefDW -> rtdw . pgqakzzjtp ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . cpxu0nhavi ) , rtdwData , 0 , 18 , sizeof (
mdlrefDW -> rtdw . cpxu0nhavi ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . ewdokzvqyf ) , rtdwData , 0 , 19 , sizeof (
mdlrefDW -> rtdw . ewdokzvqyf ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . jgxniudunk ) , rtdwData , 0 , 20 , sizeof (
mdlrefDW -> rtdw . jgxniudunk ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . ncxcfwfguz ) , rtdwData , 0 , 21 , sizeof (
mdlrefDW -> rtdw . ncxcfwfguz ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . a0sj41yc22 ) , rtdwData , 0 , 22 , sizeof (
mdlrefDW -> rtdw . a0sj41yc22 ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . kvptsc2r0b ) , rtdwData , 0 , 23 , sizeof (
mdlrefDW -> rtdw . kvptsc2r0b ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . askvnz0tsd ) , rtdwData , 0 , 24 , sizeof (
mdlrefDW -> rtdw . askvnz0tsd ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . khrsxvxe2v ) , rtdwData , 0 , 25 , sizeof (
mdlrefDW -> rtdw . khrsxvxe2v ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . oem3mqqlzr ) , rtdwData , 0 , 26 , sizeof (
mdlrefDW -> rtdw . oem3mqqlzr ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . jlenuaifba ) , rtdwData , 0 , 27 , sizeof (
mdlrefDW -> rtdw . jlenuaifba ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . gpiwz4w1hd ) , rtdwData , 0 , 28 , sizeof (
mdlrefDW -> rtdw . gpiwz4w1hd ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . hamkb3snwi ) , rtdwData , 0 , 29 , sizeof (
mdlrefDW -> rtdw . hamkb3snwi ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . nfnzt1rl1w ) , rtdwData , 0 , 30 , sizeof (
mdlrefDW -> rtdw . nfnzt1rl1w ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . ecaz0wysbo ) , rtdwData , 0 , 31 , sizeof (
mdlrefDW -> rtdw . ecaz0wysbo ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . k3ixguozrc ) , rtdwData , 0 , 32 , sizeof (
mdlrefDW -> rtdw . k3ixguozrc ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . bdxcmvfrpb ) , rtdwData , 0 , 33 , sizeof (
mdlrefDW -> rtdw . bdxcmvfrpb ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . axkanaqtvp ) , rtdwData , 0 , 34 , sizeof (
mdlrefDW -> rtdw . axkanaqtvp ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . ligjvnb3hq ) , rtdwData , 0 , 35 , sizeof (
mdlrefDW -> rtdw . ligjvnb3hq ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . ndsoprptcn ) , rtdwData , 0 , 36 , sizeof (
mdlrefDW -> rtdw . ndsoprptcn ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . iie5kx1kjr ) , rtdwData , 0 , 37 , sizeof (
mdlrefDW -> rtdw . iie5kx1kjr ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . cyqvnriqjr ) , rtdwData , 0 , 38 , sizeof (
mdlrefDW -> rtdw . cyqvnriqjr ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . gq1n1qgyyy ) , rtdwData , 0 , 39 , sizeof (
mdlrefDW -> rtdw . gq1n1qgyyy ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . ggfepuoe3d ) , rtdwData , 0 , 40 , sizeof (
mdlrefDW -> rtdw . ggfepuoe3d ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . heva2ukg0u ) , rtdwData , 0 , 41 , sizeof (
mdlrefDW -> rtdw . heva2ukg0u ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . azdqrfhhnj ) , rtdwData , 0 , 42 , sizeof (
mdlrefDW -> rtdw . azdqrfhhnj ) ) ; mr_plant_restoreDataFromMxArray ( ( void
* ) & ( mdlrefDW -> rtdw . otb0bsqikx ) , rtdwData , 0 , 43 , sizeof (
mdlrefDW -> rtdw . otb0bsqikx ) ) ; } } void
mr_plant_RegisterSimStateChecksum ( SimStruct * S ) { const uint32_T chksum [
4 ] = { 3911090777U , 2035586667U , 3977113206U , 1123880655U , } ;
slmrModelRefRegisterSimStateChecksum ( S , "plant" , & chksum [ 0 ] ) ; }
mxArray * mr_plant_GetSimStateDisallowedBlocks ( ) { mxArray * data =
mxCreateCellMatrix ( 5 , 3 ) ; mwIndex subs [ 2 ] , offset ; { static const
char * blockType [ 5 ] = { "SimscapeRtp" , "SimscapeExecutionBlock" ,
"SimscapeExecutionBlock" , "SimscapeExecutionBlock" ,
"SimscapeExecutionBlock" , } ; static const char * blockPath [ 5 ] = {
"plant/Solver Configuration/RTP_1" ,
"plant/Solver Configuration/EVAL_KEY/STATE_1" ,
"plant/Solver Configuration/EVAL_KEY/OUTPUT_1_0" ,
"plant/Solver Configuration/EVAL_KEY/OUTPUT_1_0" ,
"plant/Solver Configuration/EVAL_KEY/STATE_1" , } ; static const int reason [
5 ] = { 0 , 0 , 0 , 5 , 5 , } ; for ( subs [ 0 ] = 0 ; subs [ 0 ] < 5 ; ++ (
subs [ 0 ] ) ) { subs [ 1 ] = 0 ; offset = mxCalcSingleSubscript ( data , 2 ,
subs ) ; mxSetCell ( data , offset , mxCreateString ( blockType [ subs [ 0 ]
] ) ) ; subs [ 1 ] = 1 ; offset = mxCalcSingleSubscript ( data , 2 , subs ) ;
mxSetCell ( data , offset , mxCreateString ( blockPath [ subs [ 0 ] ] ) ) ;
subs [ 1 ] = 2 ; offset = mxCalcSingleSubscript ( data , 2 , subs ) ;
mxSetCell ( data , offset , mxCreateDoubleScalar ( ( double ) reason [ subs [
0 ] ] ) ) ; } } return data ; }
#if defined(_MSC_VER)
#pragma warning(disable: 4505) //unreferenced local function has been removed
#endif
