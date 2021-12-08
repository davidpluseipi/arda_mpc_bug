#include "ne_ds.h"
#include "plant_836bb176_1_ds_sys_struct.h"
#include "plant_836bb176_1_ds_dxy_p.h"
#include "plant_836bb176_1_ds.h"
#include "plant_836bb176_1_ds_externals.h"
#include "plant_836bb176_1_ds_external_struct.h"
#include "ssc_ml_fun.h"
int32_T plant_836bb176_1_ds_dxy_p ( const NeDynamicSystem * LC , const
NeDynamicSystemInput * t1 , NeDsMethodOutput * t2 ) { static int32_T
_cg_const_1 [ 123 ] = { 0 , 0 , 1 , 4 , 4 , 5 , 6 , 7 , 8 , 11 , 14 , 14 , 14
, 14 , 14 , 14 , 17 , 17 , 17 , 17 , 17 , 17 , 17 , 17 , 17 , 17 , 17 , 17 ,
17 , 17 , 17 , 17 , 17 , 17 , 17 , 17 , 17 , 17 , 17 , 17 , 17 , 17 , 17 , 17
, 18 , 19 , 20 , 21 , 22 , 23 , 24 , 25 , 25 , 25 , 25 , 25 , 25 , 25 , 26 ,
26 , 26 , 26 , 26 , 26 , 26 , 26 , 29 , 29 , 29 , 29 , 29 , 29 , 29 , 29 , 29
, 29 , 29 , 29 , 29 , 29 , 29 , 29 , 29 , 29 , 29 , 29 , 32 , 35 , 38 , 38 ,
38 , 38 , 38 , 38 , 38 , 38 , 38 , 38 , 38 , 38 , 38 , 38 , 38 , 38 , 38 , 38
, 38 , 38 , 38 , 38 , 38 , 41 , 42 , 42 , 45 , 48 , 51 , 51 , 51 , 51 , 51 ,
51 , 51 } ; PmSparsityPattern out ; int32_T b ; ( void ) t1 ; ( void ) LC ;
out = t2 -> mDXY_P ; out . mNumCol = 122ULL ; out . mNumRow = 11ULL ; for ( b
= 0 ; b < 123 ; b ++ ) { out . mJc [ b ] = _cg_const_1 [ b ] ; } out . mIr [
0 ] = 2 ; out . mIr [ 1 ] = 8 ; out . mIr [ 2 ] = 9 ; out . mIr [ 3 ] = 10 ;
out . mIr [ 4 ] = 1 ; out . mIr [ 5 ] = 1 ; out . mIr [ 6 ] = 0 ; out . mIr [
7 ] = 0 ; out . mIr [ 8 ] = 4 ; out . mIr [ 9 ] = 5 ; out . mIr [ 10 ] = 6 ;
out . mIr [ 11 ] = 4 ; out . mIr [ 12 ] = 5 ; out . mIr [ 13 ] = 6 ; out .
mIr [ 14 ] = 8 ; out . mIr [ 15 ] = 9 ; out . mIr [ 16 ] = 10 ; out . mIr [
17 ] = 1 ; out . mIr [ 18 ] = 1 ; out . mIr [ 19 ] = 1 ; out . mIr [ 20 ] = 1
; out . mIr [ 21 ] = 0 ; out . mIr [ 22 ] = 0 ; out . mIr [ 23 ] = 0 ; out .
mIr [ 24 ] = 0 ; out . mIr [ 25 ] = 3 ; out . mIr [ 26 ] = 4 ; out . mIr [ 27
] = 5 ; out . mIr [ 28 ] = 6 ; out . mIr [ 29 ] = 4 ; out . mIr [ 30 ] = 5 ;
out . mIr [ 31 ] = 6 ; out . mIr [ 32 ] = 4 ; out . mIr [ 33 ] = 5 ; out .
mIr [ 34 ] = 6 ; out . mIr [ 35 ] = 4 ; out . mIr [ 36 ] = 5 ; out . mIr [ 37
] = 6 ; out . mIr [ 38 ] = 8 ; out . mIr [ 39 ] = 9 ; out . mIr [ 40 ] = 10 ;
out . mIr [ 41 ] = 7 ; out . mIr [ 42 ] = 8 ; out . mIr [ 43 ] = 9 ; out .
mIr [ 44 ] = 10 ; out . mIr [ 45 ] = 8 ; out . mIr [ 46 ] = 9 ; out . mIr [
47 ] = 10 ; out . mIr [ 48 ] = 8 ; out . mIr [ 49 ] = 9 ; out . mIr [ 50 ] =
10 ; ( void ) LC ; ( void ) t2 ; return 0 ; }
