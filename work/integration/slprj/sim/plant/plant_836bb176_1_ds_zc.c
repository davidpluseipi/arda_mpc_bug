#include "ne_ds.h"
#include "plant_836bb176_1_ds_sys_struct.h"
#include "plant_836bb176_1_ds_zc.h"
#include "plant_836bb176_1_ds.h"
#include "plant_836bb176_1_ds_externals.h"
#include "plant_836bb176_1_ds_external_struct.h"
#include "ssc_ml_fun.h"
int32_T plant_836bb176_1_ds_zc ( const NeDynamicSystem * LC , const
NeDynamicSystemInput * t98 , NeDsMethodOutput * t99 ) { ETTS0 efOut ; ETTS0
t0 ; PmRealVector out ; real_T X [ 122 ] ; real_T b_efOut [ 1 ] ; real_T t6 [
1 ] ; real_T U_idx_0 ; real_T U_idx_2 ; real_T U_idx_5 ; real_T
fan_Fan_MA_rho_A ; real_T intrm_sf_mf_159 ; real_T intrm_sf_mf_160 ; real_T
intrm_sf_mf_287 ; real_T intrm_sf_mf_302 ; real_T intrm_sf_mf_31 ; real_T
pipe2_gamma_BI ; real_T pipe3_gamma_AI ; real_T pipe3_gamma_BI ; real_T t15 ;
real_T t27 ; real_T t29 ; real_T t30 ; real_T t31 ; real_T t32 ; real_T t40 ;
real_T t42 ; real_T t46 ; real_T t51 ; real_T t5_idx_0 ; real_T t5_idx_1 ;
real_T t5_idx_10 ; real_T t5_idx_8 ; real_T t5_idx_9 ; real_T t7 ; real_T t92
; real_T t93 ; size_t _in1ivar ; size_t b__in1ivar ; size_t c__in1ivar ;
size_t d__in1ivar ; int32_T M_idx_11 ; int32_T M_idx_31 ; int32_T M_idx_32 ;
int32_T b ; M_idx_11 = t98 -> mM . mX [ 11 ] ; M_idx_31 = t98 -> mM . mX [ 31
] ; M_idx_32 = t98 -> mM . mX [ 32 ] ; U_idx_0 = t98 -> mU . mX [ 0 ] ;
U_idx_2 = t98 -> mU . mX [ 2 ] ; U_idx_5 = t98 -> mU . mX [ 5 ] ; for ( b = 0
; b < 122 ; b ++ ) { X [ b ] = t98 -> mX . mX [ b ] ; } out = t99 -> mZC ; t6
[ 0ULL ] = X [ 31ULL ] ; _in1ivar = 52ULL ; b__in1ivar = 1ULL ;
tlu2_linear_linear_prelookup ( & efOut . mField0 [ 0ULL ] , & efOut . mField1
[ 0ULL ] , & efOut . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * ) ( LC ) ) ->
mField0 , & t6 [ 0ULL ] , & _in1ivar , & b__in1ivar ) ; t0 = efOut ;
c__in1ivar = 52ULL ; d__in1ivar = 1ULL ; tlu2_1d_linear_linear_value ( &
b_efOut [ 0ULL ] , & t0 . mField0 [ 0ULL ] , & t0 . mField1 [ 0ULL ] , & t0 .
mField2 [ 0ULL ] , ( ( _NeDynamicSystem * ) ( LC ) ) -> mField1 , &
c__in1ivar , & d__in1ivar ) ; t6 [ 0 ] = b_efOut [ 0 ] ; t93 = exp ( pmf_log
( X [ 24ULL ] * 100000.0 ) - t6 [ 0ULL ] ) ; if ( X [ 38ULL ] <= 0.0 ) { t92
= 0.0 ; } else { t92 = X [ 38ULL ] >= 1.0 ? 1.0 : X [ 38ULL ] ; } t51 = ( 1.0
- t92 ) * 287.047 + t92 * 461.523 ; if ( X [ 8ULL ] <= 0.0 ) { t92 = 0.0 ; }
else { t92 = X [ 8ULL ] >= 1.0 ? 1.0 : X [ 8ULL ] ; } intrm_sf_mf_31 = ( 1.0
- t92 ) * 287.047 + t92 * 461.523 ; if ( X [ 5ULL ] <= 0.0 ) { pipe3_gamma_BI
= 0.0 ; } else { pipe3_gamma_BI = X [ 5ULL ] >= 1.0 ? 1.0 : X [ 5ULL ] ; }
intrm_sf_mf_287 = ( 1.0 - pipe3_gamma_BI ) * 287.047 + pipe3_gamma_BI *
461.523 ; if ( X [ 7ULL ] <= 0.0 ) { pipe2_gamma_BI = 0.0 ; } else {
pipe2_gamma_BI = X [ 7ULL ] >= 1.0 ? 1.0 : X [ 7ULL ] ; } intrm_sf_mf_159 = (
1.0 - pipe2_gamma_BI ) * 287.047 + pipe2_gamma_BI * 461.523 ; if ( X [ 61ULL
] <= 0.0 ) { fan_Fan_MA_rho_A = 0.0 ; } else { fan_Fan_MA_rho_A = X [ 61ULL ]
>= 1.0 ? 1.0 : X [ 61ULL ] ; } intrm_sf_mf_160 = X [ 59ULL ] * ( ( 1.0 -
fan_Fan_MA_rho_A ) * 287.047 + fan_Fan_MA_rho_A * 461.523 ) ;
fan_Fan_MA_rho_A = X [ 24ULL ] / ( intrm_sf_mf_160 == 0.0 ? 1.0E-16 :
intrm_sf_mf_160 ) ; if ( X [ 26ULL ] <= 0.0 ) { intrm_sf_mf_160 = 0.0 ; }
else { intrm_sf_mf_160 = X [ 26ULL ] >= 1.0 ? 1.0 : X [ 26ULL ] ; } t40 = (
1.0 - intrm_sf_mf_160 ) * 287.047 + intrm_sf_mf_160 * 461.523 ; if ( X [
53ULL ] <= 0.0 ) { intrm_sf_mf_160 = 0.0 ; } else { intrm_sf_mf_160 = X [
53ULL ] >= 1.0 ? 1.0 : X [ 53ULL ] ; } t42 = ( 1.0 - intrm_sf_mf_160 ) *
287.047 + intrm_sf_mf_160 * 461.523 ; if ( X [ 69ULL ] <= 216.59999999999997
) { intrm_sf_mf_160 = 216.59999999999997 ; } else { intrm_sf_mf_160 = X [
69ULL ] >= 623.15 ? 623.15 : X [ 69ULL ] ; } t46 = intrm_sf_mf_160 *
intrm_sf_mf_160 ; pipe3_gamma_AI = ( ( 1026.6477992877897 + intrm_sf_mf_160 *
- 0.177515573577821 ) + t46 * 0.0003665817851591644 ) * ( 1.0 -
pipe2_gamma_BI ) + ( ( 1479.6504774710402 + intrm_sf_mf_160 *
1.2002114337050787 ) + t46 * - 0.00038614513167845434 ) * pipe2_gamma_BI ;
t27 = pipe3_gamma_AI - intrm_sf_mf_159 ; intrm_sf_mf_160 = pipe3_gamma_AI / (
t27 == 0.0 ? 1.0E-16 : t27 ) ; if ( X [ 71ULL ] <= 216.59999999999997 ) {
pipe3_gamma_AI = 216.59999999999997 ; } else { pipe3_gamma_AI = X [ 71ULL ]
>= 623.15 ? 623.15 : X [ 71ULL ] ; } t27 = pipe3_gamma_AI * pipe3_gamma_AI ;
t46 = ( ( 1026.6477992877897 + pipe3_gamma_AI * - 0.177515573577821 ) + t27 *
0.0003665817851591644 ) * ( 1.0 - pipe2_gamma_BI ) + ( ( 1479.6504774710402 +
pipe3_gamma_AI * 1.2002114337050787 ) + t27 * - 0.00038614513167845434 ) *
pipe2_gamma_BI ; intrm_sf_mf_302 = t46 - intrm_sf_mf_159 ; pipe2_gamma_BI =
t46 / ( intrm_sf_mf_302 == 0.0 ? 1.0E-16 : intrm_sf_mf_302 ) ; if ( X [ 74ULL
] <= 0.0 ) { pipe3_gamma_AI = 0.0 ; } else { pipe3_gamma_AI = X [ 74ULL ] >=
1.0 ? 1.0 : X [ 74ULL ] ; } t46 = ( 1.0 - pipe3_gamma_AI ) * 287.047 +
pipe3_gamma_AI * 461.523 ; if ( X [ 56ULL ] <= 0.0 ) { pipe3_gamma_AI = 0.0 ;
} else { pipe3_gamma_AI = X [ 56ULL ] >= 1.0 ? 1.0 : X [ 56ULL ] ; } t27 = (
1.0 - pipe3_gamma_AI ) * 287.047 + pipe3_gamma_AI * 461.523 ; if ( X [ 76ULL
] <= 216.59999999999997 ) { pipe3_gamma_AI = 216.59999999999997 ; } else {
pipe3_gamma_AI = X [ 76ULL ] >= 623.15 ? 623.15 : X [ 76ULL ] ; } t15 =
pipe3_gamma_AI * pipe3_gamma_AI ; intrm_sf_mf_302 = ( ( 1026.6477992877897 +
pipe3_gamma_AI * - 0.177515573577821 ) + t15 * 0.0003665817851591644 ) * (
1.0 - pipe3_gamma_BI ) + ( ( 1479.6504774710402 + pipe3_gamma_AI *
1.2002114337050787 ) + t15 * - 0.00038614513167845434 ) * pipe3_gamma_BI ;
t29 = intrm_sf_mf_302 - intrm_sf_mf_287 ; pipe3_gamma_AI = intrm_sf_mf_302 /
( t29 == 0.0 ? 1.0E-16 : t29 ) ; if ( X [ 78ULL ] <= 216.59999999999997 ) {
intrm_sf_mf_302 = 216.59999999999997 ; } else { intrm_sf_mf_302 = X [ 78ULL ]
>= 623.15 ? 623.15 : X [ 78ULL ] ; } t29 = intrm_sf_mf_302 * intrm_sf_mf_302
; t15 = ( ( 1026.6477992877897 + intrm_sf_mf_302 * - 0.177515573577821 ) +
t29 * 0.0003665817851591644 ) * ( 1.0 - pipe3_gamma_BI ) + ( (
1479.6504774710402 + intrm_sf_mf_302 * 1.2002114337050787 ) + t29 * -
0.00038614513167845434 ) * pipe3_gamma_BI ; t30 = t15 - intrm_sf_mf_287 ;
pipe3_gamma_BI = t15 / ( t30 == 0.0 ? 1.0E-16 : t30 ) ; if ( X [ 67ULL ] <=
216.59999999999997 ) { intrm_sf_mf_302 = 216.59999999999997 ; } else {
intrm_sf_mf_302 = X [ 67ULL ] >= 623.15 ? 623.15 : X [ 67ULL ] ; } if ( X [
81ULL ] <= 0.0 ) { t15 = 0.0 ; } else { t15 = X [ 81ULL ] >= 1.0 ? 1.0 : X [
81ULL ] ; } t29 = ( 1.0 - t15 ) * 287.047 + t15 * 461.523 ; t30 =
intrm_sf_mf_302 * intrm_sf_mf_302 ; t15 = ( ( 1026.6477992877897 +
intrm_sf_mf_302 * - 0.177515573577821 ) + t30 * 0.0003665817851591644 ) * (
1.0 - t92 ) + ( ( 1479.6504774710402 + intrm_sf_mf_302 * 1.2002114337050787 )
+ t30 * - 0.00038614513167845434 ) * t92 ; t31 = t15 - intrm_sf_mf_31 ;
intrm_sf_mf_302 = t15 / ( t31 == 0.0 ? 1.0E-16 : t31 ) ; if ( X [ 15ULL ] <=
0.0 ) { t15 = 0.0 ; } else { t15 = X [ 15ULL ] >= 1.0 ? 1.0 : X [ 15ULL ] ; }
t30 = ( 1.0 - t15 ) * 287.047 + t15 * 461.523 ; if ( X [ 68ULL ] <=
216.59999999999997 ) { t15 = 216.59999999999997 ; } else { t15 = X [ 68ULL ]
>= 623.15 ? 623.15 : X [ 68ULL ] ; } t32 = t15 * t15 ; t31 = ( (
1026.6477992877897 + t15 * - 0.177515573577821 ) + t32 *
0.0003665817851591644 ) * ( 1.0 - t92 ) + ( ( 1479.6504774710402 + t15 *
1.2002114337050787 ) + t32 * - 0.00038614513167845434 ) * t92 ; t32 = t31 -
intrm_sf_mf_31 ; t92 = t31 / ( t32 == 0.0 ? 1.0E-16 : t32 ) ; if ( M_idx_11
== 0 ) { t15 = U_idx_0 * 0.01 - pmf_get_inf ( ) ; } else { t15 = 0.0 ; } if (
M_idx_32 == 0 ) { t31 = U_idx_2 - 623.15 ; } else { t31 = 0.0 ; } if (
M_idx_31 == 0 ) { t7 = U_idx_5 - 623.15 ; } else { t7 = 0.0 ; } t5_idx_0 =
t93 - 1.0 ; t5_idx_1 = X [ 31ULL ] * t51 / ( X [ 24ULL ] == 0.0 ? 1.0E-16 : X
[ 24ULL ] ) ; t93 = X [ 23ULL ] * t40 ; t5_idx_8 = t93 / ( X [ 24ULL ] == 0.0
? 1.0E-16 : X [ 24ULL ] ) ; t5_idx_9 = t93 / ( X [ 24ULL ] == 0.0 ? 1.0E-16 :
X [ 24ULL ] ) ; t51 = X [ 54ULL ] * t27 ; t5_idx_10 = t51 / ( X [ 55ULL ] ==
0.0 ? 1.0E-16 : X [ 55ULL ] ) ; t27 = X [ 51ULL ] * t42 ; t42 = t93 / ( X [
24ULL ] == 0.0 ? 1.0E-16 : X [ 24ULL ] ) ; t93 = t46 * X [ 75ULL ] ; t40 =
t51 / ( X [ 55ULL ] == 0.0 ? 1.0E-16 : X [ 55ULL ] ) ; t51 = t29 * X [ 82ULL
] ; t32 = intrm_sf_mf_31 * X [ 68ULL ] * t92 ; t92 = X [ 84ULL ] * X [ 84ULL
] * t92 / ( intrm_sf_mf_31 == 0.0 ? 1.0E-16 : intrm_sf_mf_31 ) ; out . mX [ 0
] = t5_idx_0 ; out . mX [ 1 ] = t5_idx_1 ; out . mX [ 2 ] = 0.01 - U_idx_0 *
0.01 ; out . mX [ 3 ] = 216.59999999999997 - U_idx_2 ; out . mX [ 4 ] = t15 ;
out . mX [ 5 ] = t31 ; out . mX [ 6 ] = 216.59999999999997 - U_idx_5 ; out .
mX [ 7 ] = t7 ; out . mX [ 8 ] = t5_idx_8 ; out . mX [ 9 ] = t5_idx_9 ; out .
mX [ 10 ] = t5_idx_10 ; out . mX [ 11 ] = t27 / ( X [ 52ULL ] == 0.0 ?
1.0E-16 : X [ 52ULL ] ) ; out . mX [ 12 ] = t42 ; out . mX [ 13 ] = t93 / ( X
[ 16ULL ] == 0.0 ? 1.0E-16 : X [ 16ULL ] ) ; out . mX [ 14 ] = t27 / ( X [
52ULL ] == 0.0 ? 1.0E-16 : X [ 52ULL ] ) ; out . mX [ 15 ] = t40 ; out . mX [
16 ] = t51 / ( X [ 16ULL ] == 0.0 ? 1.0E-16 : X [ 16ULL ] ) ; out . mX [ 17 ]
= t51 / ( X [ 16ULL ] == 0.0 ? 1.0E-16 : X [ 16ULL ] ) ; out . mX [ 18 ] =
t93 / ( X [ 16ULL ] == 0.0 ? 1.0E-16 : X [ 16ULL ] ) ; out . mX [ 19 ] =
fan_Fan_MA_rho_A ; out . mX [ 20 ] = fan_Fan_MA_rho_A ; out . mX [ 21 ] = X [
24ULL ] - 0.01 ; out . mX [ 22 ] = pmf_get_inf ( ) - X [ 24ULL ] ; out . mX [
23 ] = X [ 23ULL ] - 216.59999999999997 ; out . mX [ 24 ] = 623.15 - X [
23ULL ] ; out . mX [ 25 ] = X [ 55ULL ] - 0.01 ; out . mX [ 26 ] =
pmf_get_inf ( ) - X [ 55ULL ] ; out . mX [ 27 ] = X [ 54ULL ] -
216.59999999999997 ; out . mX [ 28 ] = 623.15 - X [ 54ULL ] ; out . mX [ 29 ]
= ( ( X [ 14ULL ] - 298.15 ) * 5.0E-5 + 1.0 ) * 200.0 ; out . mX [ 30 ] =
intrm_sf_mf_31 * X [ 67ULL ] * intrm_sf_mf_302 ; out . mX [ 31 ] = X [ 83ULL
] * X [ 83ULL ] * intrm_sf_mf_302 / ( intrm_sf_mf_31 == 0.0 ? 1.0E-16 :
intrm_sf_mf_31 ) / ( X [ 67ULL ] == 0.0 ? 1.0E-16 : X [ 67ULL ] ) ; out . mX
[ 32 ] = t32 ; out . mX [ 33 ] = t92 / ( X [ 68ULL ] == 0.0 ? 1.0E-16 : X [
68ULL ] ) ; out . mX [ 34 ] = intrm_sf_mf_31 * X [ 67ULL ] / ( X [ 83ULL ] ==
0.0 ? 1.0E-16 : X [ 83ULL ] ) ; out . mX [ 35 ] = intrm_sf_mf_31 * X [ 68ULL
] / ( X [ 84ULL ] == 0.0 ? 1.0E-16 : X [ 84ULL ] ) ; out . mX [ 36 ] = X [
52ULL ] - 0.01 ; out . mX [ 37 ] = pmf_get_inf ( ) - X [ 52ULL ] ; out . mX [
38 ] = X [ 51ULL ] - 216.59999999999997 ; out . mX [ 39 ] = 623.15 - X [
51ULL ] ; out . mX [ 40 ] = X [ 10ULL ] - 0.01 ; out . mX [ 41 ] =
pmf_get_inf ( ) - X [ 10ULL ] ; out . mX [ 42 ] = X [ 9ULL ] -
216.59999999999997 ; out . mX [ 43 ] = 623.15 - X [ 9ULL ] ; out . mX [ 44 ]
= intrm_sf_mf_31 * X [ 9ULL ] / ( X [ 10ULL ] == 0.0 ? 1.0E-16 : X [ 10ULL ]
) ; out . mX [ 45 ] = intrm_sf_mf_159 * X [ 69ULL ] * intrm_sf_mf_160 ; out .
mX [ 46 ] = X [ 70ULL ] * X [ 70ULL ] * intrm_sf_mf_160 / ( intrm_sf_mf_159
== 0.0 ? 1.0E-16 : intrm_sf_mf_159 ) / ( X [ 69ULL ] == 0.0 ? 1.0E-16 : X [
69ULL ] ) ; out . mX [ 47 ] = intrm_sf_mf_159 * X [ 71ULL ] * pipe2_gamma_BI
; out . mX [ 48 ] = X [ 72ULL ] * X [ 72ULL ] * pipe2_gamma_BI / (
intrm_sf_mf_159 == 0.0 ? 1.0E-16 : intrm_sf_mf_159 ) / ( X [ 71ULL ] == 0.0 ?
1.0E-16 : X [ 71ULL ] ) ; out . mX [ 49 ] = intrm_sf_mf_159 * X [ 69ULL ] / (
X [ 70ULL ] == 0.0 ? 1.0E-16 : X [ 70ULL ] ) ; out . mX [ 50 ] =
intrm_sf_mf_159 * X [ 71ULL ] / ( X [ 72ULL ] == 0.0 ? 1.0E-16 : X [ 72ULL ]
) ; out . mX [ 51 ] = X [ 16ULL ] - 0.01 ; out . mX [ 52 ] = pmf_get_inf ( )
- X [ 16ULL ] ; out . mX [ 53 ] = X [ 75ULL ] - 216.59999999999997 ; out . mX
[ 54 ] = 623.15 - X [ 75ULL ] ; out . mX [ 55 ] = X [ 12ULL ] - 0.01 ; out .
mX [ 56 ] = pmf_get_inf ( ) - X [ 12ULL ] ; out . mX [ 57 ] = X [ 6ULL ] -
216.59999999999997 ; out . mX [ 58 ] = 623.15 - X [ 6ULL ] ; out . mX [ 59 ]
= intrm_sf_mf_159 * X [ 6ULL ] / ( X [ 12ULL ] == 0.0 ? 1.0E-16 : X [ 12ULL ]
) ; out . mX [ 60 ] = intrm_sf_mf_287 * X [ 76ULL ] * pipe3_gamma_AI ; out .
mX [ 61 ] = X [ 77ULL ] * X [ 77ULL ] * pipe3_gamma_AI / ( intrm_sf_mf_287 ==
0.0 ? 1.0E-16 : intrm_sf_mf_287 ) / ( X [ 76ULL ] == 0.0 ? 1.0E-16 : X [
76ULL ] ) ; out . mX [ 62 ] = intrm_sf_mf_287 * X [ 78ULL ] * pipe3_gamma_BI
; out . mX [ 63 ] = X [ 79ULL ] * X [ 79ULL ] * pipe3_gamma_BI / (
intrm_sf_mf_287 == 0.0 ? 1.0E-16 : intrm_sf_mf_287 ) / ( X [ 78ULL ] == 0.0 ?
1.0E-16 : X [ 78ULL ] ) ; out . mX [ 64 ] = intrm_sf_mf_287 * X [ 76ULL ] / (
X [ 77ULL ] == 0.0 ? 1.0E-16 : X [ 77ULL ] ) ; out . mX [ 65 ] =
intrm_sf_mf_287 * X [ 78ULL ] / ( X [ 79ULL ] == 0.0 ? 1.0E-16 : X [ 79ULL ]
) ; out . mX [ 66 ] = X [ 82ULL ] - 216.59999999999997 ; out . mX [ 67 ] =
623.15 - X [ 82ULL ] ; out . mX [ 68 ] = X [ 11ULL ] - 0.01 ; out . mX [ 69 ]
= pmf_get_inf ( ) - X [ 11ULL ] ; out . mX [ 70 ] = X [ 4ULL ] -
216.59999999999997 ; out . mX [ 71 ] = 623.15 - X [ 4ULL ] ; out . mX [ 72 ]
= intrm_sf_mf_287 * X [ 4ULL ] / ( X [ 11ULL ] == 0.0 ? 1.0E-16 : X [ 11ULL ]
) ; out . mX [ 73 ] = X [ 2ULL ] - 216.59999999999997 ; out . mX [ 74 ] =
623.15 - X [ 2ULL ] ; out . mX [ 75 ] = t30 * X [ 2ULL ] / ( X [ 16ULL ] ==
0.0 ? 1.0E-16 : X [ 16ULL ] ) ; out . mX [ 76 ] = X [ 17ULL ] ; out . mX [ 77
] = X [ 0ULL ] ; out . mX [ 78 ] = X [ 3ULL ] ; out . mX [ 79 ] = X [ 18ULL ]
; out . mX [ 80 ] = X [ 1ULL ] ; ( void ) LC ; ( void ) t99 ; return 0 ; }
