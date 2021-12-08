#include "ne_ds.h"
#include "plant_836bb176_1_ds_sys_struct.h"
#include "plant_836bb176_1_ds_dxm_p.h"
#include "plant_836bb176_1_ds.h"
#include "plant_836bb176_1_ds_externals.h"
#include "plant_836bb176_1_ds_external_struct.h"
#include "ssc_ml_fun.h"
int32_T plant_836bb176_1_ds_dxm_p ( const NeDynamicSystem * LC , const
NeDynamicSystemInput * t1 , NeDsMethodOutput * t2 ) { static int32_T
_cg_const_1 [ 123 ] = { 0 , 0 , 0 , 4 , 4 , 8 , 12 , 16 , 20 , 24 , 28 , 32 ,
36 , 40 , 40 , 40 , 44 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48
, 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 ,
48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48
, 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 ,
48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48
, 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 ,
48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48 , 48
, 48 , 48 } ; PmSparsityPattern out ; int32_T b ; ( void ) t1 ; ( void ) LC ;
out = t2 -> mDXM_P ; out . mNumCol = 122ULL ; out . mNumRow = 27ULL ; for ( b
= 0 ; b < 123 ; b ++ ) { out . mJc [ b ] = _cg_const_1 [ b ] ; } out . mIr [
0 ] = 2 ; out . mIr [ 1 ] = 3 ; out . mIr [ 2 ] = 19 ; out . mIr [ 3 ] = 20 ;
out . mIr [ 4 ] = 5 ; out . mIr [ 5 ] = 6 ; out . mIr [ 6 ] = 7 ; out . mIr [
7 ] = 15 ; out . mIr [ 8 ] = 5 ; out . mIr [ 9 ] = 6 ; out . mIr [ 10 ] = 7 ;
out . mIr [ 11 ] = 15 ; out . mIr [ 12 ] = 8 ; out . mIr [ 13 ] = 9 ; out .
mIr [ 14 ] = 10 ; out . mIr [ 15 ] = 16 ; out . mIr [ 16 ] = 8 ; out . mIr [
17 ] = 9 ; out . mIr [ 18 ] = 10 ; out . mIr [ 19 ] = 16 ; out . mIr [ 20 ] =
11 ; out . mIr [ 21 ] = 12 ; out . mIr [ 22 ] = 13 ; out . mIr [ 23 ] = 14 ;
out . mIr [ 24 ] = 11 ; out . mIr [ 25 ] = 12 ; out . mIr [ 26 ] = 13 ; out .
mIr [ 27 ] = 14 ; out . mIr [ 28 ] = 11 ; out . mIr [ 29 ] = 12 ; out . mIr [
30 ] = 13 ; out . mIr [ 31 ] = 14 ; out . mIr [ 32 ] = 5 ; out . mIr [ 33 ] =
6 ; out . mIr [ 34 ] = 7 ; out . mIr [ 35 ] = 15 ; out . mIr [ 36 ] = 8 ; out
. mIr [ 37 ] = 9 ; out . mIr [ 38 ] = 10 ; out . mIr [ 39 ] = 16 ; out . mIr
[ 40 ] = 2 ; out . mIr [ 41 ] = 3 ; out . mIr [ 42 ] = 19 ; out . mIr [ 43 ]
= 20 ; out . mIr [ 44 ] = 2 ; out . mIr [ 45 ] = 3 ; out . mIr [ 46 ] = 19 ;
out . mIr [ 47 ] = 20 ; ( void ) LC ; ( void ) t2 ; return 0 ; }
