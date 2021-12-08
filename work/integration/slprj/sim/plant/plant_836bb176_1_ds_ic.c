#include "ne_ds.h"
#include "plant_836bb176_1_ds_sys_struct.h"
#include "plant_836bb176_1_ds_ic.h"
#include "plant_836bb176_1_ds.h"
#include "plant_836bb176_1_ds_externals.h"
#include "plant_836bb176_1_ds_external_struct.h"
#include "ssc_ml_fun.h"
int32_T plant_836bb176_1_ds_ic ( const NeDynamicSystem * LC , const
NeDynamicSystemInput * t1 , NeDsMethodOutput * t2 ) { PmRealVector out ;
real_T t0 [ 122 ] ; real_T P_R_idx_0 ; real_T P_R_idx_1 ; real_T P_R_idx_10 ;
real_T P_R_idx_11 ; real_T P_R_idx_12 ; real_T P_R_idx_13 ; real_T P_R_idx_19
; real_T P_R_idx_2 ; real_T P_R_idx_20 ; real_T P_R_idx_22 ; real_T
P_R_idx_23 ; real_T P_R_idx_28 ; real_T P_R_idx_29 ; real_T P_R_idx_3 ;
real_T P_R_idx_31 ; real_T P_R_idx_4 ; real_T P_R_idx_5 ; real_T P_R_idx_6 ;
real_T P_R_idx_7 ; real_T P_R_idx_8 ; real_T P_R_idx_9 ; int32_T b ; ( void )
LC ; P_R_idx_0 = t1 -> mP_R . mX [ 0 ] ; P_R_idx_1 = t1 -> mP_R . mX [ 1 ] ;
P_R_idx_2 = t1 -> mP_R . mX [ 2 ] ; P_R_idx_3 = t1 -> mP_R . mX [ 3 ] ;
P_R_idx_4 = t1 -> mP_R . mX [ 4 ] ; P_R_idx_5 = t1 -> mP_R . mX [ 5 ] ;
P_R_idx_6 = t1 -> mP_R . mX [ 6 ] ; P_R_idx_7 = t1 -> mP_R . mX [ 7 ] ;
P_R_idx_8 = t1 -> mP_R . mX [ 8 ] ; P_R_idx_9 = t1 -> mP_R . mX [ 9 ] ;
P_R_idx_10 = t1 -> mP_R . mX [ 10 ] ; P_R_idx_11 = t1 -> mP_R . mX [ 11 ] ;
P_R_idx_12 = t1 -> mP_R . mX [ 12 ] ; P_R_idx_13 = t1 -> mP_R . mX [ 13 ] ;
P_R_idx_19 = t1 -> mP_R . mX [ 19 ] ; P_R_idx_20 = t1 -> mP_R . mX [ 20 ] ;
P_R_idx_22 = t1 -> mP_R . mX [ 22 ] ; P_R_idx_23 = t1 -> mP_R . mX [ 23 ] ;
P_R_idx_28 = t1 -> mP_R . mX [ 28 ] ; P_R_idx_29 = t1 -> mP_R . mX [ 29 ] ;
P_R_idx_31 = t1 -> mP_R . mX [ 31 ] ; out = t2 -> mIC ; t0 [ 0ULL ] =
P_R_idx_0 ; t0 [ 1ULL ] = P_R_idx_1 ; t0 [ 2ULL ] = P_R_idx_2 ; t0 [ 3ULL ] =
P_R_idx_3 ; t0 [ 4ULL ] = P_R_idx_6 ; t0 [ 5ULL ] = 0.0 ; t0 [ 6ULL ] =
P_R_idx_8 ; t0 [ 7ULL ] = 0.0 ; t0 [ 8ULL ] = 0.0 ; t0 [ 9ULL ] = P_R_idx_9 ;
t0 [ 10ULL ] = P_R_idx_10 * 0.01 ; t0 [ 11ULL ] = P_R_idx_11 * 10.0 ; t0 [
12ULL ] = P_R_idx_12 * 0.01 ; t0 [ 13ULL ] = 0.0 ; t0 [ 14ULL ] = P_R_idx_31
; t0 [ 15ULL ] = 0.0 ; t0 [ 16ULL ] = P_R_idx_23 * 0.01 ; t0 [ 17ULL ] =
P_R_idx_29 ; t0 [ 18ULL ] = P_R_idx_20 ; t0 [ 19ULL ] = 0.0 ; t0 [ 20ULL ] =
0.0 ; t0 [ 21ULL ] = 0.0 ; t0 [ 22ULL ] = 0.0 ; t0 [ 23ULL ] = 300.0 ; t0 [
24ULL ] = 1.0 ; t0 [ 25ULL ] = 0.0 ; t0 [ 26ULL ] = 0.0 ; t0 [ 27ULL ] = 0.0
; t0 [ 28ULL ] = 0.0 ; t0 [ 29ULL ] = 0.0 ; t0 [ 30ULL ] = 0.0 ; t0 [ 31ULL ]
= 300.0 ; t0 [ 32ULL ] = 420.0 ; t0 [ 33ULL ] = 0.0 ; t0 [ 34ULL ] = 0.0 ; t0
[ 35ULL ] = 0.0 ; t0 [ 36ULL ] = 0.0 ; t0 [ 37ULL ] = 0.0 ; t0 [ 38ULL ] =
0.0 ; t0 [ 39ULL ] = 0.0 ; t0 [ 40ULL ] = 0.0 ; t0 [ 41ULL ] = 0.0 ; t0 [
42ULL ] = P_R_idx_4 * 0.001 ; t0 [ 43ULL ] = 0.0 ; t0 [ 44ULL ] = P_R_idx_5 ;
t0 [ 45ULL ] = 0.0 ; t0 [ 46ULL ] = 101325.0 ; t0 [ 47ULL ] = 0.0 ; t0 [
48ULL ] = P_R_idx_7 ; t0 [ 49ULL ] = 0.0 ; t0 [ 50ULL ] = 101325.0 ; t0 [
51ULL ] = 300.0 ; t0 [ 52ULL ] = 1.0 ; t0 [ 53ULL ] = 0.0 ; t0 [ 54ULL ] =
300.0 ; t0 [ 55ULL ] = 1.0 ; t0 [ 56ULL ] = 0.0 ; t0 [ 57ULL ] = 0.0 ; t0 [
58ULL ] = 0.0 ; t0 [ 59ULL ] = 300.0 ; t0 [ 60ULL ] = 420.0 ; t0 [ 61ULL ] =
0.0 ; t0 [ 62ULL ] = 0.0 ; t0 [ 63ULL ] = 0.0 ; t0 [ 64ULL ] = P_R_idx_28 *
0.001 ; t0 [ 65ULL ] = 0.0 ; t0 [ 66ULL ] = 0.0 ; t0 [ 67ULL ] = 300.0 ; t0 [
68ULL ] = 300.0 ; t0 [ 69ULL ] = 300.0 ; t0 [ 70ULL ] = 1.0 ; t0 [ 71ULL ] =
300.0 ; t0 [ 72ULL ] = 1.0 ; t0 [ 73ULL ] = 0.0 ; t0 [ 74ULL ] = 0.0 ; t0 [
75ULL ] = 300.0 ; t0 [ 76ULL ] = 300.0 ; t0 [ 77ULL ] = 1.0 ; t0 [ 78ULL ] =
300.0 ; t0 [ 79ULL ] = 1.0 ; t0 [ 80ULL ] = 0.0 ; t0 [ 81ULL ] = 0.0 ; t0 [
82ULL ] = 300.0 ; t0 [ 83ULL ] = 1.0 ; t0 [ 84ULL ] = 1.0 ; t0 [ 85ULL ] =
0.0 ; t0 [ 86ULL ] = P_R_idx_13 ; t0 [ 87ULL ] = 101325.0 ; t0 [ 88ULL ] =
0.0 ; t0 [ 89ULL ] = 420.0 ; t0 [ 90ULL ] = 0.0 ; t0 [ 91ULL ] = 0.0 ; t0 [
92ULL ] = 420.0 ; t0 [ 93ULL ] = 0.0 ; t0 [ 94ULL ] = 0.0 ; t0 [ 95ULL ] =
0.0 ; t0 [ 96ULL ] = 0.0 ; t0 [ 97ULL ] = 420.0 ; t0 [ 98ULL ] = 0.0 ; t0 [
99ULL ] = 0.0 ; t0 [ 100ULL ] = 420.0 ; t0 [ 101ULL ] = 0.0 ; t0 [ 102ULL ] =
0.0 ; t0 [ 103ULL ] = 0.0 ; t0 [ 104ULL ] = 420.0 ; t0 [ 105ULL ] = 0.0 ; t0
[ 106ULL ] = 420.0 ; t0 [ 107ULL ] = 0.0 ; t0 [ 108ULL ] = 0.0 ; t0 [ 109ULL
] = 0.0 ; t0 [ 110ULL ] = 101325.0 ; t0 [ 111ULL ] = 0.0 ; t0 [ 112ULL ] =
0.0 ; t0 [ 113ULL ] = 0.0 ; t0 [ 114ULL ] = P_R_idx_22 ; t0 [ 115ULL ] = 0.0
; t0 [ 116ULL ] = P_R_idx_19 * 0.001 ; t0 [ 117ULL ] = 420.0 ; t0 [ 118ULL ]
= 0.0 ; t0 [ 119ULL ] = 420.0 ; t0 [ 120ULL ] = 0.0 ; t0 [ 121ULL ] = 0.0 ;
for ( b = 0 ; b < 122 ; b ++ ) { out . mX [ b ] = t0 [ b ] ; } ( void ) LC ;
( void ) t2 ; return 0 ; }
