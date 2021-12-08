#include "ne_ds.h"
#include "plant_836bb176_1_ds_sys_struct.h"
#include "plant_836bb176_1_ds_mode.h"
#include "plant_836bb176_1_ds.h"
#include "plant_836bb176_1_ds_externals.h"
#include "plant_836bb176_1_ds_external_struct.h"
#include "ssc_ml_fun.h"
int32_T plant_836bb176_1_ds_mode ( const NeDynamicSystem * LC , const
NeDynamicSystemInput * t85 , NeDsMethodOutput * t86 ) { ETTS0 efOut ; ETTS0
t0 ; PmIntVector out ; real_T X [ 122 ] ; real_T b_efOut [ 1 ] ; real_T t3 [
1 ] ; real_T Controlled_Reservoir_MA_p_ws_ratio_I ; real_T U_idx_0 ; real_T
U_idx_2 ; real_T U_idx_5 ; real_T intrm_sf_mf_159 ; real_T intrm_sf_mf_160 ;
real_T intrm_sf_mf_2 ; real_T intrm_sf_mf_287 ; real_T intrm_sf_mf_66 ;
real_T pipe3_gamma_AI ; real_T t25 ; real_T t26 ; real_T t27 ; real_T t28 ;
real_T t29 ; real_T t47 ; real_T t49 ; real_T t6 ; real_T t61 ; real_T t75 ;
real_T t78 ; real_T t80 ; real_T t9 ; size_t _in1ivar ; size_t b__in1ivar ;
size_t c__in1ivar ; size_t d__in1ivar ; int32_T t2_idx_1 ; int32_T t2_idx_15
; int32_T t2_idx_25 ; int32_T t2_idx_6 ; U_idx_0 = t85 -> mU . mX [ 0 ] ;
U_idx_2 = t85 -> mU . mX [ 2 ] ; U_idx_5 = t85 -> mU . mX [ 5 ] ; for (
t2_idx_1 = 0 ; t2_idx_1 < 122 ; t2_idx_1 ++ ) { X [ t2_idx_1 ] = t85 -> mX .
mX [ t2_idx_1 ] ; } out = t86 -> mMODE ; t3 [ 0ULL ] = X [ 31ULL ] ; _in1ivar
= 52ULL ; b__in1ivar = 1ULL ; tlu2_linear_linear_prelookup ( & efOut .
mField0 [ 0ULL ] , & efOut . mField1 [ 0ULL ] , & efOut . mField2 [ 0ULL ] ,
( ( _NeDynamicSystem * ) ( LC ) ) -> mField0 , & t3 [ 0ULL ] , & _in1ivar , &
b__in1ivar ) ; t0 = efOut ; c__in1ivar = 52ULL ; d__in1ivar = 1ULL ;
tlu2_1d_linear_linear_value ( & b_efOut [ 0ULL ] , & t0 . mField0 [ 0ULL ] ,
& t0 . mField1 [ 0ULL ] , & t0 . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * )
( LC ) ) -> mField1 , & c__in1ivar , & d__in1ivar ) ; t3 [ 0 ] = b_efOut [ 0
] ; Controlled_Reservoir_MA_p_ws_ratio_I = exp ( pmf_log ( X [ 24ULL ] *
100000.0 ) - t3 [ 0ULL ] ) ; if ( X [ 38ULL ] <= 0.0 ) { t78 = 0.0 ; } else {
t78 = X [ 38ULL ] >= 1.0 ? 1.0 : X [ 38ULL ] ; } intrm_sf_mf_2 = ( 1.0 - t78
) * 287.047 + t78 * 461.523 ; if ( X [ 8ULL ] <= 0.0 ) { t78 = 0.0 ; } else {
t78 = X [ 8ULL ] >= 1.0 ? 1.0 : X [ 8ULL ] ; } t47 = ( 1.0 - t78 ) * 287.047
+ t78 * 461.523 ; if ( X [ 5ULL ] <= 0.0 ) { t75 = 0.0 ; } else { t75 = X [
5ULL ] >= 1.0 ? 1.0 : X [ 5ULL ] ; } intrm_sf_mf_287 = ( 1.0 - t75 ) *
287.047 + t75 * 461.523 ; if ( X [ 7ULL ] <= 0.0 ) { t61 = 0.0 ; } else { t61
= X [ 7ULL ] >= 1.0 ? 1.0 : X [ 7ULL ] ; } intrm_sf_mf_159 = ( 1.0 - t61 ) *
287.047 + t61 * 461.523 ; if ( X [ 61ULL ] <= 0.0 ) { t49 = 0.0 ; } else {
t49 = X [ 61ULL ] >= 1.0 ? 1.0 : X [ 61ULL ] ; } intrm_sf_mf_160 = X [ 59ULL
] * ( ( 1.0 - t49 ) * 287.047 + t49 * 461.523 ) ; t49 = X [ 24ULL ] / (
intrm_sf_mf_160 == 0.0 ? 1.0E-16 : intrm_sf_mf_160 ) ; if ( X [ 26ULL ] <=
0.0 ) { intrm_sf_mf_160 = 0.0 ; } else { intrm_sf_mf_160 = X [ 26ULL ] >= 1.0
? 1.0 : X [ 26ULL ] ; } t80 = ( 1.0 - intrm_sf_mf_160 ) * 287.047 +
intrm_sf_mf_160 * 461.523 ; if ( X [ 53ULL ] <= 0.0 ) { intrm_sf_mf_160 = 0.0
; } else { intrm_sf_mf_160 = X [ 53ULL ] >= 1.0 ? 1.0 : X [ 53ULL ] ; }
intrm_sf_mf_66 = ( 1.0 - intrm_sf_mf_160 ) * 287.047 + intrm_sf_mf_160 *
461.523 ; if ( X [ 69ULL ] <= 216.59999999999997 ) { intrm_sf_mf_160 =
216.59999999999997 ; } else { intrm_sf_mf_160 = X [ 69ULL ] >= 623.15 ?
623.15 : X [ 69ULL ] ; } t6 = intrm_sf_mf_160 * intrm_sf_mf_160 ;
pipe3_gamma_AI = ( ( 1026.6477992877897 + intrm_sf_mf_160 * -
0.177515573577821 ) + t6 * 0.0003665817851591644 ) * ( 1.0 - t61 ) + ( (
1479.6504774710402 + intrm_sf_mf_160 * 1.2002114337050787 ) + t6 * -
0.00038614513167845434 ) * t61 ; t9 = pipe3_gamma_AI - intrm_sf_mf_159 ;
intrm_sf_mf_160 = pipe3_gamma_AI / ( t9 == 0.0 ? 1.0E-16 : t9 ) ; if ( X [
71ULL ] <= 216.59999999999997 ) { pipe3_gamma_AI = 216.59999999999997 ; }
else { pipe3_gamma_AI = X [ 71ULL ] >= 623.15 ? 623.15 : X [ 71ULL ] ; } t9 =
pipe3_gamma_AI * pipe3_gamma_AI ; t6 = ( ( 1026.6477992877897 +
pipe3_gamma_AI * - 0.177515573577821 ) + t9 * 0.0003665817851591644 ) * ( 1.0
- t61 ) + ( ( 1479.6504774710402 + pipe3_gamma_AI * 1.2002114337050787 ) + t9
* - 0.00038614513167845434 ) * t61 ; t25 = t6 - intrm_sf_mf_159 ; t61 = t6 /
( t25 == 0.0 ? 1.0E-16 : t25 ) ; if ( X [ 74ULL ] <= 0.0 ) { pipe3_gamma_AI =
0.0 ; } else { pipe3_gamma_AI = X [ 74ULL ] >= 1.0 ? 1.0 : X [ 74ULL ] ; } t6
= ( 1.0 - pipe3_gamma_AI ) * 287.047 + pipe3_gamma_AI * 461.523 ; if ( X [
56ULL ] <= 0.0 ) { pipe3_gamma_AI = 0.0 ; } else { pipe3_gamma_AI = X [ 56ULL
] >= 1.0 ? 1.0 : X [ 56ULL ] ; } t9 = ( 1.0 - pipe3_gamma_AI ) * 287.047 +
pipe3_gamma_AI * 461.523 ; if ( X [ 76ULL ] <= 216.59999999999997 ) {
pipe3_gamma_AI = 216.59999999999997 ; } else { pipe3_gamma_AI = X [ 76ULL ]
>= 623.15 ? 623.15 : X [ 76ULL ] ; } t29 = pipe3_gamma_AI * pipe3_gamma_AI ;
t25 = ( ( 1026.6477992877897 + pipe3_gamma_AI * - 0.177515573577821 ) + t29 *
0.0003665817851591644 ) * ( 1.0 - t75 ) + ( ( 1479.6504774710402 +
pipe3_gamma_AI * 1.2002114337050787 ) + t29 * - 0.00038614513167845434 ) *
t75 ; t26 = t25 - intrm_sf_mf_287 ; pipe3_gamma_AI = t25 / ( t26 == 0.0 ?
1.0E-16 : t26 ) ; if ( X [ 78ULL ] <= 216.59999999999997 ) { t25 =
216.59999999999997 ; } else { t25 = X [ 78ULL ] >= 623.15 ? 623.15 : X [
78ULL ] ; } t26 = t25 * t25 ; t29 = ( ( 1026.6477992877897 + t25 * -
0.177515573577821 ) + t26 * 0.0003665817851591644 ) * ( 1.0 - t75 ) + ( (
1479.6504774710402 + t25 * 1.2002114337050787 ) + t26 * -
0.00038614513167845434 ) * t75 ; t27 = t29 - intrm_sf_mf_287 ; t75 = t29 / (
t27 == 0.0 ? 1.0E-16 : t27 ) ; if ( X [ 67ULL ] <= 216.59999999999997 ) { t25
= 216.59999999999997 ; } else { t25 = X [ 67ULL ] >= 623.15 ? 623.15 : X [
67ULL ] ; } if ( X [ 81ULL ] <= 0.0 ) { t29 = 0.0 ; } else { t29 = X [ 81ULL
] >= 1.0 ? 1.0 : X [ 81ULL ] ; } t26 = ( 1.0 - t29 ) * 287.047 + t29 *
461.523 ; t27 = t25 * t25 ; t29 = ( ( 1026.6477992877897 + t25 * -
0.177515573577821 ) + t27 * 0.0003665817851591644 ) * ( 1.0 - t78 ) + ( (
1479.6504774710402 + t25 * 1.2002114337050787 ) + t27 * -
0.00038614513167845434 ) * t78 ; t28 = t29 - t47 ; t25 = t29 / ( t28 == 0.0 ?
1.0E-16 : t28 ) ; if ( X [ 15ULL ] <= 0.0 ) { t29 = 0.0 ; } else { t29 = X [
15ULL ] >= 1.0 ? 1.0 : X [ 15ULL ] ; } t27 = ( 1.0 - t29 ) * 287.047 + t29 *
461.523 ; if ( X [ 68ULL ] <= 216.59999999999997 ) { t29 = 216.59999999999997
; } else { t29 = X [ 68ULL ] >= 623.15 ? 623.15 : X [ 68ULL ] ; } t28 = t29 *
t29 ; t28 = ( ( 1026.6477992877897 + t29 * - 0.177515573577821 ) + t28 *
0.0003665817851591644 ) * ( 1.0 - t78 ) + ( ( 1479.6504774710402 + t29 *
1.2002114337050787 ) + t28 * - 0.00038614513167845434 ) * t78 ; t29 = t28 -
t47 ; t78 = t28 / ( t29 == 0.0 ? 1.0E-16 : t29 ) ; t2_idx_1 = ( int32_T ) ( X
[ 23ULL ] * t80 / ( X [ 24ULL ] == 0.0 ? 1.0E-16 : X [ 24ULL ] ) >= 0.0 ) ;
if ( t49 != t49 ) { t80 = t49 ; } else if ( t49 > 0.0 ) { t80 = 1.0 ; } else
{ t80 = t49 < 0.0 ? - 1.0 : 0.0 ; } t2_idx_6 = ( int32_T ) ( t47 * X [ 68ULL
] * t78 >= 0.0 ) ; t78 = X [ 84ULL ] * X [ 84ULL ] * t78 / ( t47 == 0.0 ?
1.0E-16 : t47 ) ; t2_idx_15 = ( int32_T ) ( intrm_sf_mf_159 * X [ 71ULL ] *
t61 >= 0.0 ) ; t61 = X [ 72ULL ] * X [ 72ULL ] * t61 / ( intrm_sf_mf_159 ==
0.0 ? 1.0E-16 : intrm_sf_mf_159 ) ; t2_idx_25 = ( int32_T ) ( intrm_sf_mf_287
* X [ 78ULL ] * t75 >= 0.0 ) ; t75 = X [ 79ULL ] * X [ 79ULL ] * t75 / (
intrm_sf_mf_287 == 0.0 ? 1.0E-16 : intrm_sf_mf_287 ) ; out . mX [ 0 ] = (
int32_T ) ( ( ( X [ 14ULL ] - 298.15 ) * 5.0E-5 + 1.0 ) * 200.0 > 0.0 ) ; out
. mX [ 1 ] = t2_idx_1 ; out . mX [ 2 ] = ( int32_T ) ( t49 >= 0.0 ) ; out .
mX [ 3 ] = ( int32_T ) t80 ; out . mX [ 4 ] = ( int32_T ) ( X [ 51ULL ] *
intrm_sf_mf_66 / ( X [ 52ULL ] == 0.0 ? 1.0E-16 : X [ 52ULL ] ) >= 0.0 ) ;
out . mX [ 5 ] = ( int32_T ) ( t47 * X [ 67ULL ] * t25 >= 0.0 ) ; out . mX [
6 ] = t2_idx_6 ; out . mX [ 7 ] = ( int32_T ) ( X [ 83ULL ] * X [ 83ULL ] *
t25 / ( t47 == 0.0 ? 1.0E-16 : t47 ) / ( X [ 67ULL ] == 0.0 ? 1.0E-16 : X [
67ULL ] ) >= 0.0 ) ; out . mX [ 8 ] = ( int32_T ) ( t78 / ( X [ 68ULL ] ==
0.0 ? 1.0E-16 : X [ 68ULL ] ) >= 0.0 ) ; out . mX [ 9 ] = ( int32_T ) ( t47 *
X [ 67ULL ] / ( X [ 83ULL ] == 0.0 ? 1.0E-16 : X [ 83ULL ] ) >= 0.0 ) ; out .
mX [ 10 ] = ( int32_T ) ( t47 * X [ 68ULL ] / ( X [ 84ULL ] == 0.0 ? 1.0E-16
: X [ 84ULL ] ) >= 0.0 ) ; out . mX [ 11 ] = ( int32_T ) ( U_idx_0 * 0.01 <=
0.01 ) ; out . mX [ 12 ] = ( int32_T ) ( t47 * X [ 9ULL ] / ( X [ 10ULL ] ==
0.0 ? 1.0E-16 : X [ 10ULL ] ) >= 0.0 ) ; out . mX [ 13 ] = ( int32_T ) ( t6 *
X [ 75ULL ] / ( X [ 16ULL ] == 0.0 ? 1.0E-16 : X [ 16ULL ] ) >= 0.0 ) ; out .
mX [ 14 ] = ( int32_T ) ( intrm_sf_mf_159 * X [ 69ULL ] * intrm_sf_mf_160 >=
0.0 ) ; out . mX [ 15 ] = t2_idx_15 ; out . mX [ 16 ] = ( int32_T ) ( X [
70ULL ] * X [ 70ULL ] * intrm_sf_mf_160 / ( intrm_sf_mf_159 == 0.0 ? 1.0E-16
: intrm_sf_mf_159 ) / ( X [ 69ULL ] == 0.0 ? 1.0E-16 : X [ 69ULL ] ) >= 0.0 )
; out . mX [ 17 ] = ( int32_T ) ( t61 / ( X [ 71ULL ] == 0.0 ? 1.0E-16 : X [
71ULL ] ) >= 0.0 ) ; out . mX [ 18 ] = ( int32_T ) ( intrm_sf_mf_159 * X [
69ULL ] / ( X [ 70ULL ] == 0.0 ? 1.0E-16 : X [ 70ULL ] ) >= 0.0 ) ; out . mX
[ 19 ] = ( int32_T ) ( intrm_sf_mf_159 * X [ 71ULL ] / ( X [ 72ULL ] == 0.0 ?
1.0E-16 : X [ 72ULL ] ) >= 0.0 ) ; out . mX [ 20 ] = ( int32_T ) (
intrm_sf_mf_159 * X [ 6ULL ] / ( X [ 12ULL ] == 0.0 ? 1.0E-16 : X [ 12ULL ] )
>= 0.0 ) ; out . mX [ 21 ] = ( int32_T ) ( U_idx_0 * 0.01 >= pmf_get_inf ( )
) ; out . mX [ 22 ] = ( int32_T ) ( X [ 54ULL ] * t9 / ( X [ 55ULL ] == 0.0 ?
1.0E-16 : X [ 55ULL ] ) >= 0.0 ) ; out . mX [ 23 ] = ( int32_T ) ( t26 * X [
82ULL ] / ( X [ 16ULL ] == 0.0 ? 1.0E-16 : X [ 16ULL ] ) >= 0.0 ) ; out . mX
[ 24 ] = ( int32_T ) ( intrm_sf_mf_287 * X [ 76ULL ] * pipe3_gamma_AI >= 0.0
) ; out . mX [ 25 ] = t2_idx_25 ; out . mX [ 26 ] = ( int32_T ) ( X [ 77ULL ]
* X [ 77ULL ] * pipe3_gamma_AI / ( intrm_sf_mf_287 == 0.0 ? 1.0E-16 :
intrm_sf_mf_287 ) / ( X [ 76ULL ] == 0.0 ? 1.0E-16 : X [ 76ULL ] ) >= 0.0 ) ;
out . mX [ 27 ] = ( int32_T ) ( t75 / ( X [ 78ULL ] == 0.0 ? 1.0E-16 : X [
78ULL ] ) >= 0.0 ) ; out . mX [ 28 ] = ( int32_T ) ( intrm_sf_mf_287 * X [
76ULL ] / ( X [ 77ULL ] == 0.0 ? 1.0E-16 : X [ 77ULL ] ) >= 0.0 ) ; out . mX
[ 29 ] = ( int32_T ) ( intrm_sf_mf_287 * X [ 78ULL ] / ( X [ 79ULL ] == 0.0 ?
1.0E-16 : X [ 79ULL ] ) >= 0.0 ) ; out . mX [ 30 ] = ( int32_T ) (
intrm_sf_mf_287 * X [ 4ULL ] / ( X [ 11ULL ] == 0.0 ? 1.0E-16 : X [ 11ULL ] )
>= 0.0 ) ; out . mX [ 31 ] = ( int32_T ) ( U_idx_5 <= 216.59999999999997 ) ;
out . mX [ 32 ] = ( int32_T ) ( U_idx_2 <= 216.59999999999997 ) ; out . mX [
33 ] = ( int32_T ) ( U_idx_5 >= 623.15 ) ; out . mX [ 34 ] = ( int32_T ) (
t27 * X [ 2ULL ] / ( X [ 16ULL ] == 0.0 ? 1.0E-16 : X [ 16ULL ] ) >= 0.0 ) ;
out . mX [ 35 ] = ( int32_T ) ( X [ 24ULL ] >= 0.01 ) ; out . mX [ 36 ] = (
int32_T ) ( X [ 24ULL ] <= pmf_get_inf ( ) ) ; out . mX [ 37 ] = ( int32_T )
( X [ 23ULL ] >= 216.59999999999997 ) ; out . mX [ 38 ] = ( int32_T ) ( X [
23ULL ] <= 623.15 ) ; out . mX [ 39 ] = ( int32_T ) ( X [ 55ULL ] >= 0.01 ) ;
out . mX [ 40 ] = ( int32_T ) ( X [ 55ULL ] <= pmf_get_inf ( ) ) ; out . mX [
41 ] = ( int32_T ) ( U_idx_2 >= 623.15 ) ; out . mX [ 42 ] = ( int32_T ) ( X
[ 54ULL ] >= 216.59999999999997 ) ; out . mX [ 43 ] = ( int32_T ) ( X [ 54ULL
] <= 623.15 ) ; out . mX [ 44 ] = ( int32_T ) ( X [ 52ULL ] >= 0.01 ) ; out .
mX [ 45 ] = ( int32_T ) ( X [ 52ULL ] <= pmf_get_inf ( ) ) ; out . mX [ 46 ]
= ( int32_T ) ( X [ 51ULL ] >= 216.59999999999997 ) ; out . mX [ 47 ] = (
int32_T ) ( X [ 51ULL ] <= 623.15 ) ; out . mX [ 48 ] = ( int32_T ) ( X [
10ULL ] >= 0.01 ) ; out . mX [ 49 ] = ( int32_T ) ( X [ 10ULL ] <=
pmf_get_inf ( ) ) ; out . mX [ 50 ] = ( int32_T ) ( X [ 9ULL ] >=
216.59999999999997 ) ; out . mX [ 51 ] = ( int32_T ) ( X [ 9ULL ] <= 623.15 )
; out . mX [ 52 ] = ( int32_T ) ( X [ 31ULL ] * intrm_sf_mf_2 / ( X [ 24ULL ]
== 0.0 ? 1.0E-16 : X [ 24ULL ] ) >= 0.0 ) ; out . mX [ 53 ] = ( int32_T ) ( X
[ 16ULL ] >= 0.01 ) ; out . mX [ 54 ] = ( int32_T ) ( X [ 16ULL ] <=
pmf_get_inf ( ) ) ; out . mX [ 55 ] = ( int32_T ) ( X [ 75ULL ] >=
216.59999999999997 ) ; out . mX [ 56 ] = ( int32_T ) ( X [ 75ULL ] <= 623.15
) ; out . mX [ 57 ] = ( int32_T ) ( X [ 12ULL ] >= 0.01 ) ; out . mX [ 58 ] =
( int32_T ) ( X [ 12ULL ] <= pmf_get_inf ( ) ) ; out . mX [ 59 ] = ( int32_T
) ( X [ 6ULL ] >= 216.59999999999997 ) ; out . mX [ 60 ] = ( int32_T ) ( X [
6ULL ] <= 623.15 ) ; out . mX [ 61 ] = ( int32_T ) ( X [ 82ULL ] >=
216.59999999999997 ) ; out . mX [ 62 ] = ( int32_T ) ( X [ 82ULL ] <= 623.15
) ; out . mX [ 63 ] = ( int32_T ) ( 1.0 <=
Controlled_Reservoir_MA_p_ws_ratio_I ) ; out . mX [ 64 ] = ( int32_T ) ( X [
11ULL ] >= 0.01 ) ; out . mX [ 65 ] = ( int32_T ) ( X [ 11ULL ] <=
pmf_get_inf ( ) ) ; out . mX [ 66 ] = ( int32_T ) ( X [ 4ULL ] >=
216.59999999999997 ) ; out . mX [ 67 ] = ( int32_T ) ( X [ 4ULL ] <= 623.15 )
; out . mX [ 68 ] = ( int32_T ) ( X [ 2ULL ] >= 216.59999999999997 ) ; out .
mX [ 69 ] = ( int32_T ) ( X [ 2ULL ] <= 623.15 ) ; out . mX [ 70 ] = (
int32_T ) ( X [ 17ULL ] > 0.0 ) ; out . mX [ 71 ] = ( int32_T ) ( X [ 0ULL ]
> 0.0 ) ; out . mX [ 72 ] = ( int32_T ) ( X [ 3ULL ] > 0.0 ) ; out . mX [ 73
] = ( int32_T ) ( X [ 18ULL ] > 0.0 ) ; out . mX [ 74 ] = ( int32_T ) ( X [
1ULL ] > 0.0 ) ; ( void ) LC ; ( void ) t86 ; return 0 ; }
