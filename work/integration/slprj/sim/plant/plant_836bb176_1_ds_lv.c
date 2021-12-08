#include "ne_ds.h"
#include "plant_836bb176_1_ds_sys_struct.h"
#include "plant_836bb176_1_ds_lv.h"
#include "plant_836bb176_1_ds.h"
#include "plant_836bb176_1_ds_externals.h"
#include "plant_836bb176_1_ds_external_struct.h"
#include "ssc_ml_fun.h"
int32_T plant_836bb176_1_ds_lv ( const NeDynamicSystem * LC , const
NeDynamicSystemInput * t1 , NeDsMethodOutput * t2 ) { static boolean_T
_cg_const_1 [ 122 ] = { false , false , false , false , false , false , false
, false , false , false , false , false , false , false , false , false ,
false , false , false , false , false , false , false , false , false , true
, false , false , false , false , false , false , false , false , false ,
false , false , false , false , false , false , false , true , false , false
, false , true , false , false , false , true , false , false , false , false
, false , false , false , false , false , false , false , false , false ,
false , false , false , false , false , false , false , false , false , false
, false , false , false , false , false , false , false , false , false ,
false , false , false , false , true , false , false , false , false , false
, false , false , false , false , false , false , false , false , false ,
false , false , false , false , false , false , false , false , true , false
, false , false , false , false , false , false , false , false , false ,
false } ; PmBoolVector out ; int32_T b ; boolean_T t0 [ 122 ] ; ( void ) t1 ;
( void ) LC ; out = t2 -> mLV ; for ( b = 0 ; b < 122 ; b ++ ) { t0 [ b ] =
_cg_const_1 [ b ] ; } for ( b = 0 ; b < 122 ; b ++ ) { out . mX [ b ] = t0 [
b ] ; } ( void ) LC ; ( void ) t2 ; return 0 ; }
