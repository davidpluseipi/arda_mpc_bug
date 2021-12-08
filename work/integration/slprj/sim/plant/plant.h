#ifndef RTW_HEADER_plant_h_
#define RTW_HEADER_plant_h_
#include <stddef.h>
#include <string.h>
#include "rtw_modelmap_simtarget.h"
#ifndef plant_COMMON_INCLUDES_
#define plant_COMMON_INCLUDES_
#include <stdio.h>
#include "rtwtypes.h"
#include "slsv_diagnostic_codegen_c_api.h"
#include "sl_AsyncioQueue/AsyncioQueueCAPI.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "nesl_rtw_rtp.h"
#include "plant_836bb176_1_gateway.h"
#include "nesl_rtw.h"
#endif
#include "plant_types.h"
#include "multiword_types.h"
#include "model_reference_types.h"
#include "rtGetInf.h"
#include "rt_nonfinite.h"
typedef struct { real_T nej3fn0a0e [ 4 ] ; real_T pbhhlvkgxv [ 4 ] ; real_T
agn2ggwjbr [ 4 ] ; real_T pum1gml0fg ; real_T oyche00ljt ; real_T fpgrkyomeh
; real_T bkoe3onl4o [ 4 ] ; real_T pwiaux3gpz ; real_T huw2jglag1 ; real_T
jzn21mzell ; real_T b1fwtui0xy [ 4 ] ; real_T hohy0ccoij [ 4 ] ; real_T
dfescxqrvg ; real_T kukprqjt0a ; real_T lw3wils3lh ; real_T ddbvd0dqvk [ 4 ]
; real_T l121g2av3m ; real_T gwaclz3bjw [ 197 ] ; real_T dbmtiwskob ; real_T
kmxexgsb2w ; real_T pthz20a004 ; real_T bwsq2w4yue ; real_T mxtsxnl344 ; }
gs4ynfho4y ; typedef struct { real_T jybrzbbm2b [ 2 ] ; real_T m4ierv1qm3 [ 2
] ; real_T f5pqyxxsbw [ 2 ] ; real_T mc1vxvx1ag [ 2 ] ; real_T byuf4wycfu [ 2
] ; real_T i2uttr1ys2 [ 2 ] ; real_T ay4g10nafy [ 2 ] ; real_T diy4avfcef [
122 ] ; real_T li0zy2ybda ; real_T o4xfeqygo1 ; real_T bmmnk2hkqr ; real_T
ddxucremmb ; real_T cc0p4yapio ; real_T hetafjr45k ; real_T pjlofbmgkc ;
real_T dcm3vfsh3n ; real_T ha3flsheab ; real_T pgqakzzjtp ; real_T cpxu0nhavi
; real_T ewdokzvqyf ; real_T jgxniudunk ; real_T ncxcfwfguz ; real_T
a0sj41yc22 ; real_T kvptsc2r0b ; real_T askvnz0tsd ; real_T khrsxvxe2v ;
real_T oem3mqqlzr ; real_T jlenuaifba ; real_T gpiwz4w1hd ; real_T hamkb3snwi
; real_T nfnzt1rl1w ; real_T ecaz0wysbo ; real_T k3ixguozrc ; struct { real_T
modelTStart ; real_T TUbufferArea [ 204800 ] ; } bdxcmvfrpb ; struct { real_T
modelTStart ; real_T TUbufferArea [ 2048000 ] ; } axkanaqtvp ; struct {
real_T modelTStart ; real_T TUbufferArea [ 204800 ] ; } ligjvnb3hq ; struct {
void * TUbufferPtrs [ 2 ] ; } heanzsqqzv ; void * ck5clrltfz ; void *
jw04ifknil ; void * d1krrjylmb ; void * oiosdkzqje ; void * ngvulm2fvq ; void
* hlhfuuju2v ; void * mbaq2wwli1 ; void * p4i4r5dbtk ; void * ln2l0ra4by ;
void * ank21lvkry ; void * hmmewkbpq3 ; struct { void * TUbufferPtrs [ 2 ] ;
} g3uljnoxwm ; struct { void * TUbufferPtrs [ 2 ] ; } k551hcuwml ; struct {
int_T Tail ; int_T Head ; int_T Last ; int_T CircularBufSize ; } ndsoprptcn ;
int_T iie5kx1kjr [ 75 ] ; int_T cyqvnriqjr ; struct { int_T Tail ; int_T Head
; int_T Last ; int_T CircularBufSize ; } gq1n1qgyyy ; struct { int_T Tail ;
int_T Head ; int_T Last ; int_T CircularBufSize ; } ggfepuoe3d ; boolean_T
heva2ukg0u ; boolean_T azdqrfhhnj ; boolean_T otb0bsqikx ; } khriw1lc2c ;
typedef struct { real_T osra1al44t ; real_T juq2ph1trj ; } nwe3ifp0pp ;
typedef struct { real_T osra1al44t ; real_T juq2ph1trj ; } ecygsd2j42 ;
typedef struct { boolean_T osra1al44t ; boolean_T juq2ph1trj ; } imwyid11cc ;
struct j1gcqcp03uo_ { real_T P_7 ; real_T P_8 ; real_T P_9 ; real_T P_10 ;
real_T P_11 ; real_T P_12 ; real_T P_13 ; real_T P_14 ; real_T P_15 ; real_T
P_16 ; real_T P_17 ; real_T P_18 ; real_T P_19 ; real_T P_20 ; real_T P_21 ;
real_T P_22 ; real_T P_23 ; real_T P_24 ; real_T P_25 ; real_T P_26 ; real_T
P_27 ; real_T P_28 ; real_T P_29 ; real_T P_30 ; real_T P_31 ; real_T P_32 ;
real_T P_33 ; real_T P_34 ; real_T P_35 ; real_T P_36 ; real_T P_37 ; uint8_T
P_38 ; uint8_T P_39 ; uint8_T P_40 ; } ; struct ay3wm3e024 { struct
SimStruct_tag * _mdlRefSfcnS ; const rtTimingBridge * timingBridge ; struct {
rtwCAPI_ModelMappingInfo mmi ; rtwCAPI_ModelMapLoggingInstanceInfo
mmiLogInstanceInfo ; void * dataAddress [ 10 ] ; int32_T * vardimsAddress [
10 ] ; RTWLoggingFcnPtr loggingPtrs [ 10 ] ; sysRanDType * systemRan [ 3 ] ;
int_T systemTid [ 3 ] ; } DataMapInfo ; struct { int_T mdlref_GlobalTID [ 3 ]
; } Timing ; } ; typedef struct { gs4ynfho4y rtb ; khriw1lc2c rtdw ;
oqqfjfnavm rtm ; } irprwpldwbj ; extern real_T rtP_T_env ; extern real_T
rtP_T_init ; extern real_T rtP_T_steam ; extern real_T rtP_p_env ; extern
real_T rtP_p_init ; extern real_T rtP_phi_env ; extern real_T rtP_phi_init ;
extern void k1yuutjvkp ( SimStruct * _mdlRefSfcnS , int_T mdlref_TID0 , int_T
mdlref_TID1 , int_T mdlref_TID2 , oqqfjfnavm * const kyw2aoe1o0 , gs4ynfho4y
* localB , khriw1lc2c * localDW , nwe3ifp0pp * localX , void * sysRanPtr ,
int contextTid , rtwCAPI_ModelMappingInfo * rt_ParentMMI , const char_T *
rt_ChildPath , int_T rt_ChildMMIIdx , int_T rt_CSTATEIdx ) ; extern void
mr_plant_MdlInfoRegFcn ( SimStruct * mdlRefSfcnS , char_T * modelName , int_T
* retVal ) ; extern mxArray * mr_plant_GetDWork ( const irprwpldwbj *
mdlrefDW ) ; extern void mr_plant_SetDWork ( irprwpldwbj * mdlrefDW , const
mxArray * ssDW ) ; extern void mr_plant_RegisterSimStateChecksum ( SimStruct
* S ) ; extern mxArray * mr_plant_GetSimStateDisallowedBlocks ( ) ; extern
const rtwCAPI_ModelMappingStaticInfo * plant_GetCAPIStaticMap ( void ) ;
extern void otef51nrsc ( khriw1lc2c * localDW , nwe3ifp0pp * localX ) ;
extern void hzsbmy4fnm ( khriw1lc2c * localDW , nwe3ifp0pp * localX ) ;
extern void clc5gd4b5i ( oqqfjfnavm * const kyw2aoe1o0 , khriw1lc2c * localDW
) ; extern void oum4ych01w ( oqqfjfnavm * const kyw2aoe1o0 , const real_T *
cemkstch3m , const real_T * cqvger3asl , const real_T * dgovykv54s ,
gs4ynfho4y * localB , nwe3ifp0pp * localX , ecygsd2j42 * localXdot ) ; extern
void hwyjztgp4d ( oqqfjfnavm * const kyw2aoe1o0 , const real_T * cemkstch3m ,
const real_T * cqvger3asl , const real_T * dgovykv54s , gs4ynfho4y * localB ,
khriw1lc2c * localDW ) ; extern void hwyjztgp4dTID2 ( void ) ; extern void
plant ( oqqfjfnavm * const kyw2aoe1o0 , real_T * dtfibjp3f2 , real_T *
nsdvtzjsad , real_T * kc5pzokhav , gs4ynfho4y * localB , khriw1lc2c * localDW
, nwe3ifp0pp * localX ) ; extern void plantTID2 ( void ) ; extern void
mbc2hav4mz ( khriw1lc2c * localDW , oqqfjfnavm * const kyw2aoe1o0 ) ;
#endif
