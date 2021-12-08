#include "ne_ds.h"
#include "plant_836bb176_1_ds_sys_struct.h"
#include "plant_836bb176_1_ds_m_p.h"
#include "plant_836bb176_1_ds.h"
#include "plant_836bb176_1_ds_externals.h"
#include "plant_836bb176_1_ds_external_struct.h"
#include "ssc_ml_fun.h"
int32_T plant_836bb176_1_ds_m_p ( const NeDynamicSystem * LC , const
NeDynamicSystemInput * t1 , NeDsMethodOutput * t2 ) { static int32_T
_cg_const_1 [ 123 ] = { 0 , 1 , 2 , 4 , 5 , 7 , 8 , 10 , 11 , 12 , 14 , 15 ,
16 , 17 , 18 , 19 , 20 , 21 , 22 , 23 , 24 , 25 , 26 , 27 , 27 , 27 , 27 , 27
, 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 ,
27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27
, 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 ,
27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27
, 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 ,
27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27 , 27
, 27 , 27 } ; PmSparsityPattern out ; int32_T b ; ( void ) t1 ; ( void ) LC ;
out = t2 -> mM_P ; out . mNumCol = 122ULL ; out . mNumRow = 122ULL ; for ( b
= 0 ; b < 123 ; b ++ ) { out . mJc [ b ] = _cg_const_1 [ b ] ; } out . mIr [
0 ] = 19 ; out . mIr [ 1 ] = 22 ; out . mIr [ 2 ] = 14 ; out . mIr [ 3 ] = 15
; out . mIr [ 4 ] = 20 ; out . mIr [ 5 ] = 10 ; out . mIr [ 6 ] = 11 ; out .
mIr [ 7 ] = 12 ; out . mIr [ 8 ] = 6 ; out . mIr [ 9 ] = 7 ; out . mIr [ 10 ]
= 8 ; out . mIr [ 11 ] = 4 ; out . mIr [ 12 ] = 2 ; out . mIr [ 13 ] = 3 ;
out . mIr [ 14 ] = 2 ; out . mIr [ 15 ] = 10 ; out . mIr [ 16 ] = 6 ; out .
mIr [ 17 ] = 0 ; out . mIr [ 18 ] = 1 ; out . mIr [ 19 ] = 16 ; out . mIr [
20 ] = 14 ; out . mIr [ 21 ] = 18 ; out . mIr [ 22 ] = 21 ; out . mIr [ 23 ]
= 5 ; out . mIr [ 24 ] = 9 ; out . mIr [ 25 ] = 13 ; out . mIr [ 26 ] = 17 ;
( void ) LC ; ( void ) t2 ; return 0 ; }
