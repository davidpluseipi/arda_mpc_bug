#include "ne_ds.h"
#include "plant_836bb176_1_ds_sys_struct.h"
#include "plant_836bb176_1_ds_dxy.h"
#include "plant_836bb176_1_ds.h"
#include "plant_836bb176_1_ds_externals.h"
#include "plant_836bb176_1_ds_external_struct.h"
#include "ssc_ml_fun.h"
int32_T plant_836bb176_1_ds_dxy ( const NeDynamicSystem * LC , const
NeDynamicSystemInput * t139 , NeDsMethodOutput * t140 ) { PmRealVector out ;
real_T t100 ; real_T t121 ; real_T t122 ; real_T t123 ; real_T t124 ; real_T
t125 ; real_T t126 ; real_T t137 ; real_T t79 ; real_T t82 ; real_T t88 ;
real_T t94 ; real_T t97 ; ( void ) t139 ; ( void ) LC ; out = t140 -> mDXY ;
t121 = - 1.0E-5 ; t97 = - t121 ; t122 = - 0.0 ; t82 = - t122 ; t123 = - 0.0 ;
t94 = - t123 ; t124 = - 0.0 ; t88 = - t124 ; t125 = - 0.0 ; t126 = - 0.0 ;
t79 = - t126 ; t100 = - t121 ; t121 = - t122 ; t122 = - t123 ; t123 = - t126
; t126 = - t124 ; t137 = t121 * 99999.999999999985 ; t121 = t79 *
99999.999999999985 ; t79 = t82 * 99999.999999999985 ; t82 = t123 *
99999.999999999985 ; t123 = t88 * 99999.999999999985 ; t124 = t94 *
99999.999999999985 ; t94 = t97 * 99999.999999999985 ; out . mX [ 0 ] = 1.0 ;
out . mX [ 1 ] = t137 ; out . mX [ 2 ] = 1.0 ; out . mX [ 3 ] = 0.0 ; out .
mX [ 4 ] = 1.0 ; out . mX [ 5 ] = 0.0 ; out . mX [ 6 ] = 1.0 ; out . mX [ 7 ]
= 0.0 ; out . mX [ 8 ] = t121 ; out . mX [ 9 ] = 0.0 ; out . mX [ 10 ] = 0.0
; out . mX [ 11 ] = t79 ; out . mX [ 12 ] = 1.0 ; out . mX [ 13 ] = 0.0 ; out
. mX [ 14 ] = t82 ; out . mX [ 15 ] = 0.0 ; out . mX [ 16 ] = 0.0 ; out . mX
[ 17 ] = 0.0 ; out . mX [ 18 ] = 0.0 ; out . mX [ 19 ] = 0.0 ; out . mX [ 20
] = 0.0 ; out . mX [ 21 ] = 0.0 ; out . mX [ 22 ] = 0.0 ; out . mX [ 23 ] =
0.0 ; out . mX [ 24 ] = 0.0 ; out . mX [ 25 ] = 1.0 ; out . mX [ 26 ] = t123
; out . mX [ 27 ] = 0.0 ; out . mX [ 28 ] = 0.0 ; out . mX [ 29 ] = - t125 *
99999.999999999985 ; out . mX [ 30 ] = 0.0 ; out . mX [ 31 ] = 0.0 ; out . mX
[ 32 ] = t124 ; out . mX [ 33 ] = 0.0 ; out . mX [ 34 ] = 1.0 ; out . mX [ 35
] = t94 ; out . mX [ 36 ] = 0.0 ; out . mX [ 37 ] = 0.0 ; out . mX [ 38 ] =
t100 * 99999.999999999985 ; out . mX [ 39 ] = 0.0 ; out . mX [ 40 ] = 0.0 ;
out . mX [ 41 ] = 1.0E-6 ; out . mX [ 42 ] = - t125 * 99999.999999999985 ;
out . mX [ 43 ] = 0.0 ; out . mX [ 44 ] = 0.0 ; out . mX [ 45 ] = t122 *
99999.999999999985 ; out . mX [ 46 ] = 0.0 ; out . mX [ 47 ] = 1.0 ; out . mX
[ 48 ] = t126 * 99999.999999999985 ; out . mX [ 49 ] = 0.0 ; out . mX [ 50 ]
= 0.0 ; ( void ) LC ; ( void ) t140 ; return 0 ; }
