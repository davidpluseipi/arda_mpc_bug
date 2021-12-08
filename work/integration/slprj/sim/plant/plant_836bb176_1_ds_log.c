#include "ne_ds.h"
#include "plant_836bb176_1_ds_sys_struct.h"
#include "plant_836bb176_1_ds_log.h"
#include "plant_836bb176_1_ds.h"
#include "plant_836bb176_1_ds_externals.h"
#include "plant_836bb176_1_ds_external_struct.h"
#include "ssc_ml_fun.h"
int32_T plant_836bb176_1_ds_log ( const NeDynamicSystem * LC , const
NeDynamicSystemInput * t185 , NeDsMethodOutput * t186 ) { ETTS0 c_efOut ;
ETTS0 e_efOut ; ETTS0 efOut ; ETTS0 g_efOut ; ETTS0 p_efOut ; ETTS0 t1 ;
ETTS0 t2 ; ETTS0 t3 ; ETTS0 t4 ; PmRealVector out ; real_T t10 [ 509 ] ;
real_T X [ 122 ] ; real_T Measurement_Selector_MA1_F [ 8 ] ; real_T
Measurement_Selector_MA_F [ 8 ] ; real_T pipe1_F [ 8 ] ; real_T
steam_injector_Measurement_Selector_MA_F [ 8 ] ; real_T b_efOut [ 1 ] ;
real_T d_efOut [ 1 ] ; real_T f_efOut [ 1 ] ; real_T h_efOut [ 1 ] ; real_T
i_efOut [ 1 ] ; real_T j_efOut [ 1 ] ; real_T k_efOut [ 1 ] ; real_T l_efOut
[ 1 ] ; real_T m_efOut [ 1 ] ; real_T n_efOut [ 1 ] ; real_T o_efOut [ 1 ] ;
real_T q_efOut [ 1 ] ; real_T r_efOut [ 1 ] ; real_T s_efOut [ 1 ] ; real_T
t24 [ 1 ] ; real_T Conductive_Heat_Transfer1_T ; real_T
Conductive_Heat_Transfer2_T ; real_T Conductive_Heat_Transfer4_T ; real_T
Conductive_Heat_Transfer_T ; real_T Controlled_Reservoir_MA_A_x_g ; real_T
Controlled_Reservoir_MA_Phi_A ; real_T
Controlled_Reservoir_MA_convection_A_mdot ; real_T
Controlled_Reservoir_MA_convection_A_mdot_w ; real_T PS_Terminator1_I ;
real_T PS_Terminator2_I ; real_T PS_Terminator5_I ; real_T U_idx_0 ; real_T
U_idx_1 ; real_T U_idx_2 ; real_T U_idx_3 ; real_T U_idx_4 ; real_T U_idx_5 ;
real_T U_idx_6 ; real_T intrm_sf_mf_139 ; real_T intrm_sf_mf_419 ; real_T
intrm_sf_mf_58 ; real_T pipe1_x_a_I ; real_T
sensors_Measurement_Selector_MA_P ; real_T
steam_injector_constant_volume_chamber_rho_I ; real_T t19_idx_0 ; real_T t36
; real_T t45 ; real_T t52 ; real_T t53 ; real_T t62 ; real_T t63 ; real_T t65
; real_T t66 ; real_T t67 ; real_T t70 ; real_T t71 ; real_T t73 ; real_T t74
; real_T t76 ; real_T t78 ; real_T t79 ; real_T t80 ; real_T t81 ; real_T t85
; real_T t87 ; real_T t88 ; real_T t90 ; size_t _in1ivar ; size_t ab__in1ivar
; size_t b__in1ivar ; size_t bb__in1ivar ; size_t c__in1ivar ; size_t
cb__in1ivar ; size_t d__in1ivar ; size_t db__in1ivar ; size_t e__in1ivar ;
size_t eb__in1ivar ; size_t f__in1ivar ; size_t fb__in1ivar ; size_t
g__in1ivar ; size_t gb__in1ivar ; size_t h__in1ivar ; size_t hb__in1ivar ;
size_t i__in1ivar ; size_t ib__in1ivar ; size_t j__in1ivar ; size_t
jb__in1ivar ; size_t k__in1ivar ; size_t kb__in1ivar ; size_t l__in1ivar ;
size_t lb__in1ivar ; size_t m__in1ivar ; size_t mb__in1ivar ; size_t
n__in1ivar ; size_t o__in1ivar ; size_t p__in1ivar ; size_t q__in1ivar ;
size_t r__in1ivar ; size_t s__in1ivar ; size_t t33 ; size_t t__in1ivar ;
size_t u__in1ivar ; size_t v__in1ivar ; size_t w__in1ivar ; size_t x__in1ivar
; size_t y__in1ivar ; int32_T b ; U_idx_0 = t185 -> mU . mX [ 0 ] ; U_idx_1 =
t185 -> mU . mX [ 1 ] ; U_idx_2 = t185 -> mU . mX [ 2 ] ; U_idx_3 = t185 ->
mU . mX [ 3 ] ; U_idx_4 = t185 -> mU . mX [ 4 ] ; U_idx_5 = t185 -> mU . mX [
5 ] ; U_idx_6 = t185 -> mU . mX [ 6 ] ; for ( b = 0 ; b < 122 ; b ++ ) { X [
b ] = t185 -> mX . mX [ b ] ; } out = t186 -> mLOG ;
Conductive_Heat_Transfer_T = - X [ 1ULL ] + X [ 0ULL ] ;
Conductive_Heat_Transfer1_T = - X [ 2ULL ] + X [ 1ULL ] ;
Conductive_Heat_Transfer2_T = - X [ 3ULL ] + X [ 0ULL ] ;
Conductive_Heat_Transfer4_T = - X [ 3ULL ] + X [ 2ULL ] ;
Controlled_Reservoir_MA_A_x_g = X [ 25ULL ] * 1.5 ;
Controlled_Reservoir_MA_Phi_A = - X [ 28ULL ] + - X [ 29ULL ] ;
Controlled_Reservoir_MA_convection_A_mdot = - X [ 33ULL ] + - X [ 34ULL ] ;
Controlled_Reservoir_MA_convection_A_mdot_w = - X [ 35ULL ] + - X [ 36ULL ] ;
if ( X [ 38ULL ] <= 0.0 ) { pipe1_x_a_I = 0.0 ; } else { pipe1_x_a_I = X [
38ULL ] >= 1.0 ? 1.0 : X [ 38ULL ] ; } t53 = X [ 31ULL ] * ( ( 1.0 -
pipe1_x_a_I ) * 287.047 + pipe1_x_a_I * 461.523 ) ; Measurement_Selector_MA_F
[ 0ULL ] = X [ 46ULL ] ; Measurement_Selector_MA_F [ 1ULL ] = X [ 4ULL ] ;
Measurement_Selector_MA_F [ 2ULL ] = X [ 44ULL ] ; Measurement_Selector_MA_F
[ 3ULL ] = X [ 5ULL ] ; Measurement_Selector_MA_F [ 4ULL ] = X [ 45ULL ] ;
Measurement_Selector_MA_F [ 5ULL ] = X [ 43ULL ] ; Measurement_Selector_MA_F
[ 6ULL ] = 0.0 ; Measurement_Selector_MA_F [ 7ULL ] = 0.0 ;
Measurement_Selector_MA1_F [ 0ULL ] = X [ 50ULL ] ;
Measurement_Selector_MA1_F [ 1ULL ] = X [ 6ULL ] ; Measurement_Selector_MA1_F
[ 2ULL ] = X [ 48ULL ] ; Measurement_Selector_MA1_F [ 3ULL ] = X [ 7ULL ] ;
Measurement_Selector_MA1_F [ 4ULL ] = X [ 49ULL ] ;
Measurement_Selector_MA1_F [ 5ULL ] = X [ 47ULL ] ;
Measurement_Selector_MA1_F [ 6ULL ] = 0.0 ; Measurement_Selector_MA1_F [ 7ULL
] = 0.0 ; t24 [ 0ULL ] = X [ 9ULL ] ; _in1ivar = 52ULL ; b__in1ivar = 1ULL ;
tlu2_linear_linear_prelookup ( & efOut . mField0 [ 0ULL ] , & efOut . mField1
[ 0ULL ] , & efOut . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * ) ( LC ) ) ->
mField0 , & t24 [ 0ULL ] , & _in1ivar , & b__in1ivar ) ; t4 = efOut ;
c__in1ivar = 52ULL ; d__in1ivar = 1ULL ; tlu2_1d_linear_linear_value ( &
b_efOut [ 0ULL ] , & t4 . mField0 [ 0ULL ] , & t4 . mField1 [ 0ULL ] , & t4 .
mField2 [ 0ULL ] , ( ( _NeDynamicSystem * ) ( LC ) ) -> mField1 , &
c__in1ivar , & d__in1ivar ) ; t19_idx_0 = b_efOut [ 0 ] ; PS_Terminator1_I =
exp ( pmf_log ( X [ 10ULL ] * 100000.0 ) - t19_idx_0 ) ; if (
PS_Terminator1_I >= 1.0 ) { t62 = ( PS_Terminator1_I - 1.0 ) * 461.523 +
287.047 ; intrm_sf_mf_58 = 287.047 / ( t62 == 0.0 ? 1.0E-16 : t62 ) ; } else
{ intrm_sf_mf_58 = 1.0 ; } PS_Terminator2_I = intrm_sf_mf_58 * 0.01 ;
PS_Terminator1_I = ( X [ 8ULL ] - intrm_sf_mf_58 ) / ( PS_Terminator2_I ==
0.0 ? 1.0E-16 : PS_Terminator2_I ) ; if ( X [ 8ULL ] - intrm_sf_mf_58 <= 0.0
) { PS_Terminator1_I = 0.0 ; } else if ( X [ 8ULL ] - intrm_sf_mf_58 >=
intrm_sf_mf_58 * 0.01 ) { PS_Terminator1_I = X [ 8ULL ] - intrm_sf_mf_58 ; }
else { PS_Terminator1_I = ( X [ 8ULL ] - intrm_sf_mf_58 ) * (
PS_Terminator1_I * PS_Terminator1_I * 3.0 - PS_Terminator1_I *
PS_Terminator1_I * PS_Terminator1_I * 2.0 ) ; } if ( X [ 8ULL ] <= 0.0 ) {
intrm_sf_mf_58 = 0.0 ; } else { intrm_sf_mf_58 = X [ 8ULL ] >= 1.0 ? 1.0 : X
[ 8ULL ] ; } t62 = ( 1.0 - intrm_sf_mf_58 ) * 287.047 + intrm_sf_mf_58 *
461.523 ; t66 = t62 * X [ 9ULL ] ; t63 = X [ 10ULL ] / ( t66 == 0.0 ? 1.0E-16
: t66 ) ; PS_Terminator1_I = PS_Terminator1_I * t63 * 0.0020268299163899908 /
0.001 ; PS_Terminator1_I *= 100000.0 ; t24 [ 0ULL ] = X [ 4ULL ] ; e__in1ivar
= 52ULL ; f__in1ivar = 1ULL ; tlu2_linear_linear_prelookup ( & c_efOut .
mField0 [ 0ULL ] , & c_efOut . mField1 [ 0ULL ] , & c_efOut . mField2 [ 0ULL
] , ( ( _NeDynamicSystem * ) ( LC ) ) -> mField0 , & t24 [ 0ULL ] , &
e__in1ivar , & f__in1ivar ) ; t2 = c_efOut ; g__in1ivar = 52ULL ; h__in1ivar
= 1ULL ; tlu2_1d_linear_linear_value ( & d_efOut [ 0ULL ] , & t2 . mField0 [
0ULL ] , & t2 . mField1 [ 0ULL ] , & t2 . mField2 [ 0ULL ] , ( (
_NeDynamicSystem * ) ( LC ) ) -> mField1 , & g__in1ivar , & h__in1ivar ) ;
t19_idx_0 = d_efOut [ 0 ] ; PS_Terminator2_I = exp ( pmf_log ( X [ 11ULL ] *
100000.0 ) - t19_idx_0 ) ; if ( PS_Terminator2_I >= 1.0 ) {
steam_injector_constant_volume_chamber_rho_I = ( PS_Terminator2_I - 1.0 ) *
461.523 + 287.047 ; t65 = 287.047 / (
steam_injector_constant_volume_chamber_rho_I == 0.0 ? 1.0E-16 :
steam_injector_constant_volume_chamber_rho_I ) ; } else { t65 = 1.0 ; } t71 =
t65 * 0.01 ; PS_Terminator2_I = ( X [ 5ULL ] - t65 ) / ( t71 == 0.0 ? 1.0E-16
: t71 ) ; if ( X [ 5ULL ] - t65 <= 0.0 ) { PS_Terminator2_I = 0.0 ; } else if
( X [ 5ULL ] - t65 >= t65 * 0.01 ) { PS_Terminator2_I = X [ 5ULL ] - t65 ; }
else { PS_Terminator2_I = ( X [ 5ULL ] - t65 ) * ( PS_Terminator2_I *
PS_Terminator2_I * 3.0 - PS_Terminator2_I * PS_Terminator2_I *
PS_Terminator2_I * 2.0 ) ; } if ( X [ 5ULL ] <= 0.0 ) { t65 = 0.0 ; } else {
t65 = X [ 5ULL ] >= 1.0 ? 1.0 : X [ 5ULL ] ; } t66 = ( 1.0 - t65 ) * 287.047
+ t65 * 461.523 ; t73 = t66 * X [ 4ULL ] ; t67 = X [ 11ULL ] / ( t73 == 0.0 ?
1.0E-16 : t73 ) ; PS_Terminator2_I = PS_Terminator2_I * t67 *
0.0020268299163899908 / 0.001 ; PS_Terminator2_I *= 100000.0 ; t24 [ 0ULL ] =
X [ 6ULL ] ; i__in1ivar = 52ULL ; j__in1ivar = 1ULL ;
tlu2_linear_linear_prelookup ( & e_efOut . mField0 [ 0ULL ] , & e_efOut .
mField1 [ 0ULL ] , & e_efOut . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * ) (
LC ) ) -> mField0 , & t24 [ 0ULL ] , & i__in1ivar , & j__in1ivar ) ; t3 =
e_efOut ; k__in1ivar = 52ULL ; l__in1ivar = 1ULL ;
tlu2_1d_linear_linear_value ( & f_efOut [ 0ULL ] , & t3 . mField0 [ 0ULL ] ,
& t3 . mField1 [ 0ULL ] , & t3 . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * )
( LC ) ) -> mField1 , & k__in1ivar , & l__in1ivar ) ; t19_idx_0 = f_efOut [ 0
] ; PS_Terminator5_I = exp ( pmf_log ( X [ 12ULL ] * 100000.0 ) - t19_idx_0 )
; if ( PS_Terminator5_I >= 1.0 ) { t76 = ( PS_Terminator5_I - 1.0 ) * 461.523
+ 287.047 ; steam_injector_constant_volume_chamber_rho_I = 287.047 / ( t76 ==
0.0 ? 1.0E-16 : t76 ) ; } else { steam_injector_constant_volume_chamber_rho_I
= 1.0 ; } t78 = steam_injector_constant_volume_chamber_rho_I * 0.01 ;
PS_Terminator5_I = ( X [ 7ULL ] -
steam_injector_constant_volume_chamber_rho_I ) / ( t78 == 0.0 ? 1.0E-16 : t78
) ; if ( X [ 7ULL ] - steam_injector_constant_volume_chamber_rho_I <= 0.0 ) {
PS_Terminator5_I = 0.0 ; } else if ( X [ 7ULL ] -
steam_injector_constant_volume_chamber_rho_I >=
steam_injector_constant_volume_chamber_rho_I * 0.01 ) { PS_Terminator5_I = X
[ 7ULL ] - steam_injector_constant_volume_chamber_rho_I ; } else {
PS_Terminator5_I = ( X [ 7ULL ] -
steam_injector_constant_volume_chamber_rho_I ) * ( PS_Terminator5_I *
PS_Terminator5_I * 3.0 - PS_Terminator5_I * PS_Terminator5_I *
PS_Terminator5_I * 2.0 ) ; } if ( X [ 7ULL ] <= 0.0 ) {
steam_injector_constant_volume_chamber_rho_I = 0.0 ; } else {
steam_injector_constant_volume_chamber_rho_I = X [ 7ULL ] >= 1.0 ? 1.0 : X [
7ULL ] ; } t70 = ( 1.0 - steam_injector_constant_volume_chamber_rho_I ) *
287.047 + steam_injector_constant_volume_chamber_rho_I * 461.523 ; t80 = t70
* X [ 6ULL ] ; t71 = X [ 12ULL ] / ( t80 == 0.0 ? 1.0E-16 : t80 ) ;
PS_Terminator5_I = PS_Terminator5_I * t71 * 0.0020268299163899908 / 0.001 ;
PS_Terminator5_I *= 100000.0 ; t73 = X [ 25ULL ] * 0.5 ; t74 = X [ 57ULL ] *
0.1 + - U_idx_3 ; if ( X [ 61ULL ] <= 0.0 ) { t76 = 0.0 ; } else { t76 = X [
61ULL ] >= 1.0 ? 1.0 : X [ 61ULL ] ; } t85 = X [ 59ULL ] * ( ( 1.0 - t76 ) *
287.047 + t76 * 461.523 ) ; t87 = fabs ( X [ 24ULL ] / ( t85 == 0.0 ? 1.0E-16
: t85 ) ) ; t76 = X [ 33ULL ] / ( t87 == 0.0 ? 1.0E-16 : t87 ) ; t88 =
pmf_sqrt ( X [ 57ULL ] * X [ 57ULL ] + 1.0966227112321507 ) + X [ 57ULL ] ;
t52 = t88 / 2.0 ; t78 = 104.71975511965977 / ( t52 == 0.0 ? 1.0E-16 : t52 ) *
t76 ; if ( t78 < 0.0 ) { t79 = 0.064 ; } else if ( t78 * 10.0 <= 120000.0 ) {
t79 = t78 * t78 * - 6.9444444444444442E-11 + 0.064 ; } else if ( t78 * 10.0
<= 188000.0 ) { t79 = ( t78 * 2.0478662053056511E-5 + t78 * t78 * -
9.2272202998846584E-10 ) + - 0.058871972318339079 ; } else { t79 = ( t78 *
10.0 - 188000.0 ) * - 1.4215686274509803E-6 ; } t78 = t52 /
104.71975511965977 * ( t52 / 104.71975511965977 ) * t79 ; t52 = t78 * t76 ;
t79 = t74 * X [ 57ULL ] * - 0.1 ; if ( t52 >= 0.0 ) { if ( t52 * 0.001 <=
fabs ( t79 ) * 0.001 + 6.4800000000000014E-10 ) { t19_idx_0 = fabs ( t79 ) *
0.001 + 6.4800000000000014E-10 ; t80 = t52 / ( t19_idx_0 == 0.0 ? 1.0E-16 :
t19_idx_0 ) * 0.001 ; } else { t80 = 1.0 ; } } else { t80 = 0.0 ; } t81 = X [
57ULL ] * 0.1 ; t87 = ( ( X [ 14ULL ] - 298.15 ) * 5.0E-5 + 1.0 ) * 200.0 ;
t87 = X [ 62ULL ] * X [ 62ULL ] * ( t87 > 0.0 ? t87 : 0.0 ) ; t24 [ 0ULL ] =
X [ 31ULL ] ; m__in1ivar = 52ULL ; n__in1ivar = 1ULL ;
tlu2_linear_linear_prelookup ( & g_efOut . mField0 [ 0ULL ] , & g_efOut .
mField1 [ 0ULL ] , & g_efOut . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * ) (
LC ) ) -> mField0 , & t24 [ 0ULL ] , & m__in1ivar , & n__in1ivar ) ; t1 =
g_efOut ; o__in1ivar = 52ULL ; p__in1ivar = 1ULL ;
tlu2_1d_linear_linear_value ( & h_efOut [ 0ULL ] , & t1 . mField0 [ 0ULL ] ,
& t1 . mField1 [ 0ULL ] , & t1 . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * )
( LC ) ) -> mField8 , & o__in1ivar , & p__in1ivar ) ; t19_idx_0 = h_efOut [ 0
] ; q__in1ivar = 52ULL ; r__in1ivar = 1ULL ; tlu2_1d_linear_linear_value ( &
i_efOut [ 0ULL ] , & t1 . mField0 [ 0ULL ] , & t1 . mField1 [ 0ULL ] , & t1 .
mField2 [ 0ULL ] , ( ( _NeDynamicSystem * ) ( LC ) ) -> mField9 , &
q__in1ivar , & r__in1ivar ) ; t85 = i_efOut [ 0 ] ; t88 = ( 1.0 - pipe1_x_a_I
) * t19_idx_0 + t85 * pipe1_x_a_I ; s__in1ivar = 52ULL ; t__in1ivar = 1ULL ;
tlu2_1d_linear_linear_value ( & j_efOut [ 0ULL ] , & t4 . mField0 [ 0ULL ] ,
& t4 . mField1 [ 0ULL ] , & t4 . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * )
( LC ) ) -> mField8 , & s__in1ivar , & t__in1ivar ) ; t19_idx_0 = j_efOut [ 0
] ; pipe1_x_a_I = t19_idx_0 ; u__in1ivar = 52ULL ; v__in1ivar = 1ULL ;
tlu2_1d_linear_linear_value ( & k_efOut [ 0ULL ] , & t4 . mField0 [ 0ULL ] ,
& t4 . mField1 [ 0ULL ] , & t4 . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * )
( LC ) ) -> mField9 , & u__in1ivar , & v__in1ivar ) ; t19_idx_0 = k_efOut [ 0
] ; intrm_sf_mf_139 = ( 1.0 - intrm_sf_mf_58 ) * pipe1_x_a_I + intrm_sf_mf_58
* t19_idx_0 ; if ( X [ 69ULL ] <= 216.59999999999997 ) { pipe1_x_a_I =
216.59999999999997 ; } else { pipe1_x_a_I = X [ 69ULL ] >= 623.15 ? 623.15 :
X [ 69ULL ] ; } t36 = pipe1_x_a_I * pipe1_x_a_I ; t19_idx_0 = ( (
1026.6477992877897 + pipe1_x_a_I * - 0.177515573577821 ) + t36 *
0.0003665817851591644 ) * ( 1.0 -
steam_injector_constant_volume_chamber_rho_I ) + ( ( 1479.6504774710402 +
pipe1_x_a_I * 1.2002114337050787 ) + t36 * - 0.00038614513167845434 ) *
steam_injector_constant_volume_chamber_rho_I ; t90 = t19_idx_0 - t70 ;
pipe1_x_a_I = - pmf_sqrt ( fabs ( X [ 70ULL ] * X [ 70ULL ] * ( t19_idx_0 / (
t90 == 0.0 ? 1.0E-16 : t90 ) ) / ( t70 == 0.0 ? 1.0E-16 : t70 ) / ( X [ 69ULL
] == 0.0 ? 1.0E-16 : X [ 69ULL ] ) ) ) * 0.0020268299163899908 ; if ( X [
71ULL ] <= 216.59999999999997 ) { t19_idx_0 = 216.59999999999997 ; } else {
t19_idx_0 = X [ 71ULL ] >= 623.15 ? 623.15 : X [ 71ULL ] ; } t90 = t19_idx_0
* t19_idx_0 ; t36 = ( ( 1026.6477992877897 + t19_idx_0 * - 0.177515573577821
) + t90 * 0.0003665817851591644 ) * ( 1.0 -
steam_injector_constant_volume_chamber_rho_I ) + ( ( 1479.6504774710402 +
t19_idx_0 * 1.2002114337050787 ) + t90 * - 0.00038614513167845434 ) *
steam_injector_constant_volume_chamber_rho_I ; t19_idx_0 = t36 - t70 ; t70 =
- pmf_sqrt ( fabs ( X [ 72ULL ] * X [ 72ULL ] * ( t36 / ( t19_idx_0 == 0.0 ?
1.0E-16 : t19_idx_0 ) ) / ( t70 == 0.0 ? 1.0E-16 : t70 ) / ( X [ 71ULL ] ==
0.0 ? 1.0E-16 : X [ 71ULL ] ) ) ) * 0.0020268299163899908 ; t19_idx_0 = X [
73ULL ] / ( pipe1_x_a_I == 0.0 ? 1.0E-16 : pipe1_x_a_I ) ; pipe1_x_a_I = - X
[ 66ULL ] / ( t70 == 0.0 ? 1.0E-16 : t70 ) ; t85 = pipe1_x_a_I - t19_idx_0 ;
t70 = ( t85 / 2.0 * 1.0E-5 - - 0.01 ) / 0.02 ; t36 = t70 * t70 * 3.0 - t70 *
t70 * t70 * 2.0 ; if ( t85 / 2.0 * 1.0E-5 <= - 0.01 ) { t70 = t19_idx_0 *
1.0E-5 ; } else if ( ( pipe1_x_a_I - t19_idx_0 ) / 2.0 * 1.0E-5 >= 0.01 ) {
t70 = pipe1_x_a_I * 1.0E-5 ; } else { t70 = ( ( 1.0 - t36 ) * t19_idx_0 + t36
* pipe1_x_a_I ) * 1.0E-5 ; } w__in1ivar = 52ULL ; x__in1ivar = 1ULL ;
tlu2_1d_linear_linear_value ( & l_efOut [ 0ULL ] , & t3 . mField0 [ 0ULL ] ,
& t3 . mField1 [ 0ULL ] , & t3 . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * )
( LC ) ) -> mField8 , & w__in1ivar , & x__in1ivar ) ; t19_idx_0 = l_efOut [ 0
] ; pipe1_x_a_I = t19_idx_0 ; y__in1ivar = 52ULL ; ab__in1ivar = 1ULL ;
tlu2_1d_linear_linear_value ( & m_efOut [ 0ULL ] , & t3 . mField0 [ 0ULL ] ,
& t3 . mField1 [ 0ULL ] , & t3 . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * )
( LC ) ) -> mField9 , & y__in1ivar , & ab__in1ivar ) ; t19_idx_0 = m_efOut [
0 ] ; t36 = ( 1.0 - steam_injector_constant_volume_chamber_rho_I ) *
pipe1_x_a_I + steam_injector_constant_volume_chamber_rho_I * t19_idx_0 ; if (
X [ 76ULL ] <= 216.59999999999997 ) { pipe1_x_a_I = 216.59999999999997 ; }
else { pipe1_x_a_I = X [ 76ULL ] >= 623.15 ? 623.15 : X [ 76ULL ] ; }
sensors_Measurement_Selector_MA_P = pipe1_x_a_I * pipe1_x_a_I ;
steam_injector_constant_volume_chamber_rho_I = ( ( 1026.6477992877897 +
pipe1_x_a_I * - 0.177515573577821 ) + sensors_Measurement_Selector_MA_P *
0.0003665817851591644 ) * ( 1.0 - t65 ) + ( ( 1479.6504774710402 +
pipe1_x_a_I * 1.2002114337050787 ) + sensors_Measurement_Selector_MA_P * -
0.00038614513167845434 ) * t65 ; t85 =
steam_injector_constant_volume_chamber_rho_I - t66 ; pipe1_x_a_I = - pmf_sqrt
( fabs ( X [ 77ULL ] * X [ 77ULL ] * (
steam_injector_constant_volume_chamber_rho_I / ( t85 == 0.0 ? 1.0E-16 : t85 )
) / ( t66 == 0.0 ? 1.0E-16 : t66 ) / ( X [ 76ULL ] == 0.0 ? 1.0E-16 : X [
76ULL ] ) ) ) * 0.0020268299163899908 ; if ( X [ 78ULL ] <=
216.59999999999997 ) { steam_injector_constant_volume_chamber_rho_I =
216.59999999999997 ; } else { steam_injector_constant_volume_chamber_rho_I =
X [ 78ULL ] >= 623.15 ? 623.15 : X [ 78ULL ] ; } t45 =
steam_injector_constant_volume_chamber_rho_I *
steam_injector_constant_volume_chamber_rho_I ; t19_idx_0 = ( (
1026.6477992877897 + steam_injector_constant_volume_chamber_rho_I * -
0.177515573577821 ) + t45 * 0.0003665817851591644 ) * ( 1.0 - t65 ) + ( (
1479.6504774710402 + steam_injector_constant_volume_chamber_rho_I *
1.2002114337050787 ) + t45 * - 0.00038614513167845434 ) * t65 ; t85 =
t19_idx_0 - t66 ; t66 = - pmf_sqrt ( fabs ( X [ 79ULL ] * X [ 79ULL ] * (
t19_idx_0 / ( t85 == 0.0 ? 1.0E-16 : t85 ) ) / ( t66 == 0.0 ? 1.0E-16 : t66 )
/ ( X [ 78ULL ] == 0.0 ? 1.0E-16 : X [ 78ULL ] ) ) ) * 0.0020268299163899908
; steam_injector_constant_volume_chamber_rho_I = X [ 33ULL ] / ( pipe1_x_a_I
== 0.0 ? 1.0E-16 : pipe1_x_a_I ) ; pipe1_x_a_I = X [ 80ULL ] / ( t66 == 0.0 ?
1.0E-16 : t66 ) ; t85 = pipe1_x_a_I -
steam_injector_constant_volume_chamber_rho_I ; t66 = ( t85 / 2.0 * 1.0E-5 - -
0.01 ) / 0.02 ; t19_idx_0 = t66 * t66 * 3.0 - t66 * t66 * t66 * 2.0 ; if (
t85 / 2.0 * 1.0E-5 <= - 0.01 ) { t66 =
steam_injector_constant_volume_chamber_rho_I * 1.0E-5 ; } else if ( (
pipe1_x_a_I - steam_injector_constant_volume_chamber_rho_I ) / 2.0 * 1.0E-5
>= 0.01 ) { t66 = pipe1_x_a_I * 1.0E-5 ; } else { t66 = ( ( 1.0 - t19_idx_0 )
* steam_injector_constant_volume_chamber_rho_I + t19_idx_0 * pipe1_x_a_I ) *
1.0E-5 ; } if ( X [ 67ULL ] <= 216.59999999999997 ) { pipe1_x_a_I =
216.59999999999997 ; } else { pipe1_x_a_I = X [ 67ULL ] >= 623.15 ? 623.15 :
X [ 67ULL ] ; } t85 = pipe1_x_a_I * pipe1_x_a_I ;
steam_injector_constant_volume_chamber_rho_I = ( ( 1026.6477992877897 +
pipe1_x_a_I * - 0.177515573577821 ) + t85 * 0.0003665817851591644 ) * ( 1.0 -
intrm_sf_mf_58 ) + ( ( 1479.6504774710402 + pipe1_x_a_I * 1.2002114337050787
) + t85 * - 0.00038614513167845434 ) * intrm_sf_mf_58 ; t85 =
steam_injector_constant_volume_chamber_rho_I - t62 ; pipe1_x_a_I = - pmf_sqrt
( fabs ( X [ 83ULL ] * X [ 83ULL ] * (
steam_injector_constant_volume_chamber_rho_I / ( t85 == 0.0 ? 1.0E-16 : t85 )
) / ( t62 == 0.0 ? 1.0E-16 : t62 ) / ( X [ 67ULL ] == 0.0 ? 1.0E-16 : X [
67ULL ] ) ) ) * 0.0020268299163899908 ; bb__in1ivar = 52ULL ; cb__in1ivar =
1ULL ; tlu2_1d_linear_linear_value ( & n_efOut [ 0ULL ] , & t2 . mField0 [
0ULL ] , & t2 . mField1 [ 0ULL ] , & t2 . mField2 [ 0ULL ] , ( (
_NeDynamicSystem * ) ( LC ) ) -> mField8 , & bb__in1ivar , & cb__in1ivar ) ;
t19_idx_0 = n_efOut [ 0 ] ; steam_injector_constant_volume_chamber_rho_I =
t19_idx_0 ; db__in1ivar = 52ULL ; eb__in1ivar = 1ULL ;
tlu2_1d_linear_linear_value ( & o_efOut [ 0ULL ] , & t2 . mField0 [ 0ULL ] ,
& t2 . mField1 [ 0ULL ] , & t2 . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * )
( LC ) ) -> mField9 , & db__in1ivar , & eb__in1ivar ) ; t19_idx_0 = o_efOut [
0 ] ; t90 = ( 1.0 - t65 ) * steam_injector_constant_volume_chamber_rho_I +
t65 * t19_idx_0 ; if ( X [ 15ULL ] <= 0.0 ) { t65 = 0.0 ; } else { t65 = X [
15ULL ] >= 1.0 ? 1.0 : X [ 15ULL ] ; }
steam_injector_constant_volume_chamber_rho_I = ( 1.0 - t65 ) * 287.047 + t65
* 461.523 ; t24 [ 0ULL ] = X [ 2ULL ] ; fb__in1ivar = 52ULL ; gb__in1ivar =
1ULL ; tlu2_linear_linear_prelookup ( & p_efOut . mField0 [ 0ULL ] , &
p_efOut . mField1 [ 0ULL ] , & p_efOut . mField2 [ 0ULL ] , ( (
_NeDynamicSystem * ) ( LC ) ) -> mField0 , & t24 [ 0ULL ] , & fb__in1ivar , &
gb__in1ivar ) ; t1 = p_efOut ; hb__in1ivar = 52ULL ; ib__in1ivar = 1ULL ;
tlu2_1d_linear_linear_value ( & q_efOut [ 0ULL ] , & t1 . mField0 [ 0ULL ] ,
& t1 . mField1 [ 0ULL ] , & t1 . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * )
( LC ) ) -> mField1 , & hb__in1ivar , & ib__in1ivar ) ; t24 [ 0 ] = q_efOut [
0 ] ; t19_idx_0 = exp ( pmf_log ( X [ 16ULL ] * 100000.0 ) - t24 [ 0ULL ] ) ;
if ( t19_idx_0 >= 1.0 ) { t85 = ( t19_idx_0 - 1.0 ) * 461.523 + 287.047 ;
sensors_Measurement_Selector_MA_P = 287.047 / ( t85 == 0.0 ? 1.0E-16 : t85 )
; } else { sensors_Measurement_Selector_MA_P = 1.0 ; } t85 =
sensors_Measurement_Selector_MA_P * 0.01 ; intrm_sf_mf_419 = ( X [ 15ULL ] -
sensors_Measurement_Selector_MA_P ) / ( t85 == 0.0 ? 1.0E-16 : t85 ) ; if ( X
[ 15ULL ] - sensors_Measurement_Selector_MA_P <= 0.0 ) { intrm_sf_mf_419 =
0.0 ; } else if ( X [ 15ULL ] - sensors_Measurement_Selector_MA_P >=
sensors_Measurement_Selector_MA_P * 0.01 ) { intrm_sf_mf_419 = X [ 15ULL ] -
sensors_Measurement_Selector_MA_P ; } else { intrm_sf_mf_419 = ( X [ 15ULL ]
- sensors_Measurement_Selector_MA_P ) * ( intrm_sf_mf_419 * intrm_sf_mf_419 *
3.0 - intrm_sf_mf_419 * intrm_sf_mf_419 * intrm_sf_mf_419 * 2.0 ) ; }
jb__in1ivar = 52ULL ; kb__in1ivar = 1ULL ; tlu2_1d_linear_linear_value ( &
r_efOut [ 0ULL ] , & t1 . mField0 [ 0ULL ] , & t1 . mField1 [ 0ULL ] , & t1 .
mField2 [ 0ULL ] , ( ( _NeDynamicSystem * ) ( LC ) ) -> mField8 , &
jb__in1ivar , & kb__in1ivar ) ; t24 [ 0 ] = r_efOut [ 0 ] ; t19_idx_0 = t24 [
0ULL ] ; lb__in1ivar = 52ULL ; mb__in1ivar = 1ULL ;
tlu2_1d_linear_linear_value ( & s_efOut [ 0ULL ] , & t1 . mField0 [ 0ULL ] ,
& t1 . mField1 [ 0ULL ] , & t1 . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * )
( LC ) ) -> mField9 , & lb__in1ivar , & mb__in1ivar ) ; t24 [ 0 ] = s_efOut [
0 ] ; sensors_Measurement_Selector_MA_P = t24 [ 0ULL ] ; t45 = ( 1.0 - t65 )
* t19_idx_0 + t65 * sensors_Measurement_Selector_MA_P ; if ( X [ 68ULL ] <=
216.59999999999997 ) { t65 = 216.59999999999997 ; } else { t65 = X [ 68ULL ]
>= 623.15 ? 623.15 : X [ 68ULL ] ; } t85 = t65 * t65 ; t19_idx_0 = ( (
1026.6477992877897 + t65 * - 0.177515573577821 ) + t85 *
0.0003665817851591644 ) * ( 1.0 - intrm_sf_mf_58 ) + ( ( 1479.6504774710402 +
t65 * 1.2002114337050787 ) + t85 * - 0.00038614513167845434 ) *
intrm_sf_mf_58 ; t85 = t19_idx_0 - t62 ; intrm_sf_mf_58 = - pmf_sqrt ( fabs (
X [ 84ULL ] * X [ 84ULL ] * ( t19_idx_0 / ( t85 == 0.0 ? 1.0E-16 : t85 ) ) /
( t62 == 0.0 ? 1.0E-16 : t62 ) / ( X [ 68ULL ] == 0.0 ? 1.0E-16 : X [ 68ULL ]
) ) ) * 0.0020268299163899908 ; t62 = X [ 66ULL ] / ( pipe1_x_a_I == 0.0 ?
1.0E-16 : pipe1_x_a_I ) ; pipe1_x_a_I = X [ 34ULL ] / ( intrm_sf_mf_58 == 0.0
? 1.0E-16 : intrm_sf_mf_58 ) ; t85 = pipe1_x_a_I - t62 ; intrm_sf_mf_58 = (
t85 / 2.0 * 1.0E-5 - - 0.01 ) / 0.02 ; t65 = intrm_sf_mf_58 * intrm_sf_mf_58
* 3.0 - intrm_sf_mf_58 * intrm_sf_mf_58 * intrm_sf_mf_58 * 2.0 ; if ( t85 /
2.0 * 1.0E-5 <= - 0.01 ) { intrm_sf_mf_58 = t62 * 1.0E-5 ; } else if ( (
pipe1_x_a_I - t62 ) / 2.0 * 1.0E-5 >= 0.01 ) { intrm_sf_mf_58 = pipe1_x_a_I *
1.0E-5 ; } else { intrm_sf_mf_58 = ( ( 1.0 - t65 ) * t62 + t65 * pipe1_x_a_I
) * 1.0E-5 ; } pipe1_F [ 0ULL ] = X [ 87ULL ] ; pipe1_F [ 1ULL ] = X [ 9ULL ]
; pipe1_F [ 2ULL ] = X [ 86ULL ] ; pipe1_F [ 3ULL ] = X [ 8ULL ] ; pipe1_F [
4ULL ] = X [ 65ULL ] ; pipe1_F [ 5ULL ] = X [ 85ULL ] ; pipe1_F [ 6ULL ] =
0.0 ; pipe1_F [ 7ULL ] = 0.0 ; sensors_Measurement_Selector_MA_P = X [ 87ULL
] * 1.0E-5 ; steam_injector_Measurement_Selector_MA_F [ 0ULL ] = X [ 110ULL ]
; steam_injector_Measurement_Selector_MA_F [ 1ULL ] = X [ 2ULL ] ;
steam_injector_Measurement_Selector_MA_F [ 2ULL ] = X [ 114ULL ] ;
steam_injector_Measurement_Selector_MA_F [ 3ULL ] = X [ 15ULL ] ;
steam_injector_Measurement_Selector_MA_F [ 4ULL ] = X [ 115ULL ] ;
steam_injector_Measurement_Selector_MA_F [ 5ULL ] = X [ 113ULL ] ;
steam_injector_Measurement_Selector_MA_F [ 6ULL ] = 0.0 ;
steam_injector_Measurement_Selector_MA_F [ 7ULL ] = 0.0 ; t19_idx_0 = X [
110ULL ] * 1.0E-5 ; t85 = steam_injector_constant_volume_chamber_rho_I * X [
2ULL ] ; steam_injector_constant_volume_chamber_rho_I = X [ 16ULL ] / ( t85
== 0.0 ? 1.0E-16 : t85 ) ; t85 = - ( intrm_sf_mf_419 *
steam_injector_constant_volume_chamber_rho_I * 0.25 / 0.001 * 100000.0 ) ;
t10 [ 0ULL ] = X [ 0ULL ] ; t10 [ 1ULL ] = X [ 1ULL ] ; t10 [ 2ULL ] =
Conductive_Heat_Transfer_T * 0.401 ; t10 [ 3ULL ] =
Conductive_Heat_Transfer_T ; t10 [ 4ULL ] = X [ 1ULL ] ; t10 [ 5ULL ] = X [
2ULL ] ; t10 [ 6ULL ] = Conductive_Heat_Transfer1_T * 0.401 ; t10 [ 7ULL ] =
Conductive_Heat_Transfer1_T ; t10 [ 8ULL ] = X [ 0ULL ] ; t10 [ 9ULL ] = X [
3ULL ] ; t10 [ 10ULL ] = Conductive_Heat_Transfer2_T * 0.401 ; t10 [ 11ULL ]
= Conductive_Heat_Transfer2_T ; t10 [ 12ULL ] = X [ 2ULL ] ; t10 [ 13ULL ] =
X [ 3ULL ] ; t10 [ 14ULL ] = Conductive_Heat_Transfer4_T * 0.401 ; t10 [
15ULL ] = Conductive_Heat_Transfer4_T ; t10 [ 16ULL ] = X [ 23ULL ] ; t10 [
17ULL ] = X [ 24ULL ] * 0.1 ; t10 [ 18ULL ] = Controlled_Reservoir_MA_A_x_g ;
t10 [ 19ULL ] = X [ 26ULL ] ; t10 [ 20ULL ] = X [ 27ULL ] ; t10 [ 21ULL ] = X
[ 38ULL ] ; t10 [ 22ULL ] = X [ 31ULL ] ; t10 [ 23ULL ] = X [ 24ULL ] * 0.1 ;
t10 [ 24ULL ] = U_idx_0 * 999.99999999999989 ; t10 [ 25ULL ] =
Controlled_Reservoir_MA_Phi_A ; t10 [ 26ULL ] = X [ 30ULL ] ; t10 [ 27ULL ] =
U_idx_2 ; t10 [ 28ULL ] = U_idx_1 ; t10 [ 29ULL ] = X [ 23ULL ] ; t10 [ 30ULL
] = X [ 24ULL ] * 0.1 ; t10 [ 31ULL ] = Controlled_Reservoir_MA_A_x_g ; t10 [
32ULL ] = X [ 26ULL ] ; t10 [ 33ULL ] = Controlled_Reservoir_MA_Phi_A ; t10 [
34ULL ] = X [ 32ULL ] ; t10 [ 35ULL ] =
Controlled_Reservoir_MA_convection_A_mdot ; t10 [ 36ULL ] =
Controlled_Reservoir_MA_A_x_g ; t10 [ 37ULL ] =
Controlled_Reservoir_MA_convection_A_mdot_w ; t10 [ 38ULL ] = X [ 37ULL ] ;
t10 [ 39ULL ] = t88 ; t10 [ 40ULL ] =
Controlled_Reservoir_MA_convection_A_mdot ; t10 [ 41ULL ] =
Controlled_Reservoir_MA_A_x_g ; t10 [ 42ULL ] =
Controlled_Reservoir_MA_convection_A_mdot_w ; t10 [ 43ULL ] = X [ 24ULL ] / (
t53 == 0.0 ? 1.0E-16 : t53 ) ; t10 [ 44ULL ] = 1.0 - X [ 38ULL ] ; t10 [
45ULL ] = X [ 39ULL ] ; t10 [ 46ULL ] = X [ 40ULL ] ; t10 [ 47ULL ] = X [
1ULL ] ; t10 [ 48ULL ] = ( ( ( ( X [ 1ULL ] * - 0.00080200000000000009 + X [
2ULL ] * 0.00040100000000000004 ) + X [ 0ULL ] * 0.00040100000000000004 ) + -
X [ 41ULL ] ) + - X [ 42ULL ] ) * 1000.0 ; t10 [ 49ULL ] = U_idx_2 ; t10 [
50ULL ] = U_idx_2 ; for ( t33 = 0ULL ; t33 < 8ULL ; t33 ++ ) { t10 [ t33 +
51ULL ] = Measurement_Selector_MA_F [ t33 ] ; } t10 [ 59ULL ] = 0.0 ; t10 [
60ULL ] = X [ 46ULL ] * 1.0E-5 * 99999.999999999985 ; t10 [ 61ULL ] = X [
4ULL ] ; t10 [ 62ULL ] = X [ 44ULL ] ; for ( t33 = 0ULL ; t33 < 8ULL ; t33 ++
) { t10 [ t33 + 63ULL ] = Measurement_Selector_MA1_F [ t33 ] ; } t10 [ 71ULL
] = 0.0 ; t10 [ 72ULL ] = X [ 50ULL ] * 1.0E-5 * 99999.999999999985 ; t10 [
73ULL ] = X [ 6ULL ] ; t10 [ 74ULL ] = X [ 48ULL ] ; t10 [ 75ULL ] = X [ 6ULL
] ; t10 [ 76ULL ] = X [ 4ULL ] ; t10 [ 77ULL ] = X [ 51ULL ] ; t10 [ 78ULL ]
= X [ 52ULL ] * 0.1 ; t10 [ 79ULL ] = X [ 53ULL ] ; t10 [ 80ULL ] =
PS_Terminator1_I ; t10 [ 81ULL ] = PS_Terminator2_I ; t10 [ 82ULL ] =
PS_Terminator5_I ; t10 [ 83ULL ] = U_idx_0 ; t10 [ 84ULL ] = U_idx_1 ; t10 [
85ULL ] = U_idx_2 ; t10 [ 86ULL ] = X [ 1ULL ] ; t10 [ 87ULL ] = X [ 1ULL ] ;
t10 [ 88ULL ] = X [ 1ULL ] ; t10 [ 89ULL ] = X [ 23ULL ] ; t10 [ 90ULL ] = X
[ 24ULL ] * 0.1 ; t10 [ 91ULL ] = Controlled_Reservoir_MA_A_x_g ; t10 [ 92ULL
] = X [ 26ULL ] ; t10 [ 93ULL ] = X [ 54ULL ] ; t10 [ 94ULL ] = X [ 55ULL ] *
0.1 ; t10 [ 95ULL ] = t73 ; t10 [ 96ULL ] = X [ 56ULL ] ; t10 [ 97ULL ] = t74
; t10 [ 98ULL ] = U_idx_3 ; t10 [ 99ULL ] = U_idx_3 ; t10 [ 100ULL ] =
U_idx_3 ; t10 [ 101ULL ] = X [ 23ULL ] ; t10 [ 102ULL ] = X [ 24ULL ] * 0.1 ;
t10 [ 103ULL ] = Controlled_Reservoir_MA_A_x_g ; t10 [ 104ULL ] = X [ 26ULL ]
; t10 [ 105ULL ] = X [ 54ULL ] ; t10 [ 106ULL ] = X [ 55ULL ] * 0.1 ; t10 [
107ULL ] = t73 ; t10 [ 108ULL ] = X [ 56ULL ] ; t10 [ 109ULL ] = X [ 28ULL ]
; t10 [ 110ULL ] = X [ 58ULL ] ; t10 [ 111ULL ] = X [ 57ULL ] ; t10 [ 112ULL
] = X [ 23ULL ] ; t10 [ 113ULL ] = X [ 24ULL ] * 0.1 ; t10 [ 114ULL ] =
Controlled_Reservoir_MA_A_x_g ; t10 [ 115ULL ] = X [ 26ULL ] ; t10 [ 116ULL ]
= X [ 28ULL ] ; t10 [ 117ULL ] = X [ 60ULL ] ; t10 [ 118ULL ] = X [ 33ULL ] ;
t10 [ 119ULL ] = t73 ; t10 [ 120ULL ] = X [ 35ULL ] ; t10 [ 121ULL ] = X [
25ULL ] ; t10 [ 122ULL ] = X [ 61ULL ] ; t10 [ 123ULL ] = X [ 59ULL ] ; t10 [
124ULL ] = X [ 54ULL ] ; t10 [ 125ULL ] = X [ 55ULL ] * 0.1 ; t10 [ 126ULL ]
= t73 ; t10 [ 127ULL ] = X [ 56ULL ] ; t10 [ 128ULL ] = X [ 58ULL ] ; t10 [
129ULL ] = X [ 60ULL ] ; t10 [ 130ULL ] = - X [ 33ULL ] ; t10 [ 131ULL ] = -
t73 ; t10 [ 132ULL ] = - X [ 35ULL ] ; t10 [ 133ULL ] = X [ 25ULL ] ; t10 [
134ULL ] = X [ 61ULL ] ; t10 [ 135ULL ] = X [ 57ULL ] ; t10 [ 136ULL ] = X [
33ULL ] ; t10 [ 137ULL ] = t52 ; t10 [ 138ULL ] = t74 * - 0.1 ; t10 [ 139ULL
] = t79 ; t10 [ 140ULL ] = t80 ; t10 [ 141ULL ] = - X [ 33ULL ] ; t10 [
142ULL ] = t73 ; t10 [ 143ULL ] = - t73 ; t10 [ 144ULL ] = X [ 35ULL ] ; t10
[ 145ULL ] = - X [ 35ULL ] ; t10 [ 146ULL ] = t78 ; t10 [ 147ULL ] = t76 ;
t10 [ 148ULL ] = X [ 13ULL ] ; t10 [ 149ULL ] = X [ 57ULL ] ; t10 [ 150ULL ]
= X [ 57ULL ] ; t10 [ 151ULL ] = X [ 13ULL ] ; t10 [ 152ULL ] = X [ 57ULL ] ;
t10 [ 153ULL ] = - t74 ; t10 [ 154ULL ] = t81 ; t10 [ 155ULL ] = U_idx_3 ;
t10 [ 156ULL ] = - t74 ; t10 [ 157ULL ] = t74 * t74 ; t10 [ 158ULL ] = X [
57ULL ] ; t10 [ 159ULL ] = - t74 ; t10 [ 160ULL ] = t81 ; t10 [ 161ULL ] =
t74 * 0.1 ; t10 [ 162ULL ] = t81 ; t10 [ 163ULL ] = t81 * 10.0 ; t10 [ 164ULL
] = U_idx_3 ; t10 [ 165ULL ] = X [ 62ULL ] ; t10 [ 166ULL ] = U_idx_4 ; t10 [
167ULL ] = U_idx_4 ; t10 [ 168ULL ] = U_idx_4 ; t10 [ 169ULL ] = X [ 14ULL ]
; t10 [ 170ULL ] = U_idx_4 ; t10 [ 171ULL ] = X [ 14ULL ] ; t10 [ 172ULL ] =
( - X [ 63ULL ] + - X [ 64ULL ] ) * 1000.0 ; t10 [ 173ULL ] = X [ 14ULL ] ;
t10 [ 174ULL ] = - X [ 62ULL ] ; t10 [ 175ULL ] = U_idx_4 ; t10 [ 176ULL ] =
t87 ; t10 [ 177ULL ] = X [ 51ULL ] ; t10 [ 178ULL ] = X [ 52ULL ] * 0.1 ; t10
[ 179ULL ] = X [ 53ULL ] ; t10 [ 180ULL ] = X [ 23ULL ] ; t10 [ 181ULL ] = X
[ 24ULL ] * 0.1 ; t10 [ 182ULL ] = Controlled_Reservoir_MA_A_x_g ; t10 [
183ULL ] = X [ 26ULL ] ; t10 [ 184ULL ] = X [ 19ULL ] ; t10 [ 185ULL ] = X [
94ULL ] ; t10 [ 186ULL ] = X [ 8ULL ] ; t10 [ 187ULL ] = X [ 67ULL ] ; t10 [
188ULL ] = X [ 9ULL ] ; t10 [ 189ULL ] = X [ 66ULL ] ; t10 [ 190ULL ] = X [
83ULL ] * 0.1 ; t10 [ 191ULL ] = X [ 10ULL ] * 100.0 ; t10 [ 192ULL ] = X [
65ULL ] ; t10 [ 193ULL ] = t63 ; t10 [ 194ULL ] = X [ 68ULL ] ; t10 [ 195ULL
] = X [ 34ULL ] ; t10 [ 196ULL ] = X [ 84ULL ] * 0.1 ; for ( t33 = 0ULL ; t33
< 8ULL ; t33 ++ ) { t10 [ t33 + 197ULL ] = pipe1_F [ t33 ] ; } t10 [ 205ULL ]
= X [ 14ULL ] ; t10 [ 206ULL ] = X [ 85ULL ] ; t10 [ 207ULL ] =
intrm_sf_mf_58 ; t10 [ 208ULL ] = X [ 88ULL ] ; t10 [ 209ULL ] = X [ 29ULL ]
; t10 [ 210ULL ] = X [ 63ULL ] ; t10 [ 211ULL ] = X [ 86ULL ] ; t10 [ 212ULL
] = X [ 9ULL ] ; t10 [ 213ULL ] = X [ 8ULL ] ; t10 [ 214ULL ] =
PS_Terminator1_I ; t10 [ 215ULL ] = X [ 51ULL ] ; t10 [ 216ULL ] = X [ 52ULL
] * 0.1 ; t10 [ 217ULL ] = X [ 53ULL ] ; t10 [ 218ULL ] = X [ 88ULL ] ; t10 [
219ULL ] = X [ 89ULL ] ; t10 [ 220ULL ] = X [ 66ULL ] ; t10 [ 221ULL ] = X [
90ULL ] ; t10 [ 222ULL ] = X [ 91ULL ] ; t10 [ 223ULL ] = X [ 23ULL ] ; t10 [
224ULL ] = X [ 24ULL ] * 0.1 ; t10 [ 225ULL ] = Controlled_Reservoir_MA_A_x_g
; t10 [ 226ULL ] = X [ 26ULL ] ; t10 [ 227ULL ] = X [ 29ULL ] ; t10 [ 228ULL
] = X [ 92ULL ] ; t10 [ 229ULL ] = X [ 34ULL ] ; t10 [ 230ULL ] =
Controlled_Reservoir_MA_A_x_g ; t10 [ 231ULL ] = X [ 36ULL ] ; t10 [ 232ULL ]
= X [ 93ULL ] ; t10 [ 233ULL ] = intrm_sf_mf_139 ; t10 [ 234ULL ] =
Controlled_Reservoir_MA_A_x_g ; t10 [ 235ULL ] = X [ 90ULL ] ; t10 [ 236ULL ]
= X [ 36ULL ] ; t10 [ 237ULL ] = 1.0 - X [ 8ULL ] ; t10 [ 238ULL ] = X [
75ULL ] ; t10 [ 239ULL ] = X [ 16ULL ] * 0.1 ; t10 [ 240ULL ] = X [ 74ULL ] ;
t10 [ 241ULL ] = X [ 51ULL ] ; t10 [ 242ULL ] = X [ 52ULL ] * 0.1 ; t10 [
243ULL ] = X [ 53ULL ] ; t10 [ 244ULL ] = X [ 20ULL ] ; t10 [ 245ULL ] = X [
102ULL ] ; t10 [ 246ULL ] = X [ 7ULL ] ; t10 [ 247ULL ] = X [ 69ULL ] ; t10 [
248ULL ] = X [ 6ULL ] ; t10 [ 249ULL ] = X [ 73ULL ] ; t10 [ 250ULL ] = X [
70ULL ] * 0.1 ; t10 [ 251ULL ] = X [ 12ULL ] * 100.0 ; t10 [ 252ULL ] = X [
49ULL ] ; t10 [ 253ULL ] = t71 ; t10 [ 254ULL ] = X [ 71ULL ] ; t10 [ 255ULL
] = - X [ 66ULL ] ; t10 [ 256ULL ] = X [ 72ULL ] * 0.1 ; for ( t33 = 0ULL ;
t33 < 8ULL ; t33 ++ ) { t10 [ t33 + 257ULL ] = Measurement_Selector_MA1_F [
t33 ] ; } t10 [ 265ULL ] = X [ 3ULL ] ; t10 [ 266ULL ] = X [ 47ULL ] ; t10 [
267ULL ] = t70 ; t10 [ 268ULL ] = X [ 95ULL ] ; t10 [ 269ULL ] = - X [ 88ULL
] ; t10 [ 270ULL ] = X [ 96ULL ] ; t10 [ 271ULL ] = X [ 48ULL ] ; t10 [
272ULL ] = X [ 6ULL ] ; t10 [ 273ULL ] = X [ 7ULL ] ; t10 [ 274ULL ] =
PS_Terminator5_I ; t10 [ 275ULL ] = X [ 75ULL ] ; t10 [ 276ULL ] = X [ 16ULL
] * 0.1 ; t10 [ 277ULL ] = X [ 74ULL ] ; t10 [ 278ULL ] = X [ 95ULL ] ; t10 [
279ULL ] = X [ 97ULL ] ; t10 [ 280ULL ] = X [ 73ULL ] ; t10 [ 281ULL ] = X [
98ULL ] ; t10 [ 282ULL ] = X [ 99ULL ] ; t10 [ 283ULL ] = X [ 51ULL ] ; t10 [
284ULL ] = X [ 52ULL ] * 0.1 ; t10 [ 285ULL ] = X [ 53ULL ] ; t10 [ 286ULL ]
= - X [ 88ULL ] ; t10 [ 287ULL ] = X [ 100ULL ] ; t10 [ 288ULL ] = - X [
66ULL ] ; t10 [ 289ULL ] = - X [ 90ULL ] ; t10 [ 290ULL ] = X [ 101ULL ] ;
t10 [ 291ULL ] = t36 ; t10 [ 292ULL ] = X [ 98ULL ] ; t10 [ 293ULL ] = - X [
90ULL ] ; t10 [ 294ULL ] = 1.0 - X [ 7ULL ] ; t10 [ 295ULL ] = X [ 54ULL ] ;
t10 [ 296ULL ] = X [ 55ULL ] * 0.1 ; t10 [ 297ULL ] = t73 ; t10 [ 298ULL ] =
X [ 56ULL ] ; t10 [ 299ULL ] = X [ 82ULL ] ; t10 [ 300ULL ] = X [ 16ULL ] *
0.1 ; t10 [ 301ULL ] = X [ 81ULL ] ; t10 [ 302ULL ] = X [ 21ULL ] ; t10 [
303ULL ] = X [ 109ULL ] ; t10 [ 304ULL ] = X [ 5ULL ] ; t10 [ 305ULL ] = X [
76ULL ] ; t10 [ 306ULL ] = X [ 4ULL ] ; t10 [ 307ULL ] = X [ 33ULL ] ; t10 [
308ULL ] = X [ 77ULL ] * 0.1 ; t10 [ 309ULL ] = X [ 11ULL ] * 0.1 ; t10 [
310ULL ] = X [ 45ULL ] ; t10 [ 311ULL ] = t67 ; t10 [ 312ULL ] = X [ 78ULL ]
; t10 [ 313ULL ] = X [ 80ULL ] ; t10 [ 314ULL ] = X [ 79ULL ] * 0.1 ; for (
t33 = 0ULL ; t33 < 8ULL ; t33 ++ ) { t10 [ t33 + 315ULL ] =
Measurement_Selector_MA_F [ t33 ] ; } t10 [ 323ULL ] = X [ 1ULL ] ; t10 [
324ULL ] = X [ 43ULL ] ; t10 [ 325ULL ] = t66 ; t10 [ 326ULL ] = - X [ 58ULL
] ; t10 [ 327ULL ] = X [ 103ULL ] ; t10 [ 328ULL ] = X [ 41ULL ] ; t10 [
329ULL ] = X [ 44ULL ] ; t10 [ 330ULL ] = X [ 4ULL ] ; t10 [ 331ULL ] = X [
5ULL ] ; t10 [ 332ULL ] = PS_Terminator2_I ; t10 [ 333ULL ] = X [ 54ULL ] ;
t10 [ 334ULL ] = X [ 55ULL ] * 0.1 ; t10 [ 335ULL ] = t73 ; t10 [ 336ULL ] =
X [ 56ULL ] ; t10 [ 337ULL ] = - X [ 58ULL ] ; t10 [ 338ULL ] = X [ 104ULL ]
; t10 [ 339ULL ] = X [ 33ULL ] ; t10 [ 340ULL ] = t73 ; t10 [ 341ULL ] = X [
35ULL ] ; t10 [ 342ULL ] = X [ 105ULL ] ; t10 [ 343ULL ] = X [ 82ULL ] ; t10
[ 344ULL ] = X [ 16ULL ] * 0.1 ; t10 [ 345ULL ] = X [ 81ULL ] ; t10 [ 346ULL
] = X [ 103ULL ] ; t10 [ 347ULL ] = X [ 106ULL ] ; t10 [ 348ULL ] = X [ 80ULL
] ; t10 [ 349ULL ] = X [ 107ULL ] ; t10 [ 350ULL ] = X [ 108ULL ] ; t10 [
351ULL ] = t90 ; t10 [ 352ULL ] = t73 ; t10 [ 353ULL ] = X [ 35ULL ] ; t10 [
354ULL ] = X [ 107ULL ] ; t10 [ 355ULL ] = 1.0 - X [ 5ULL ] ; t10 [ 356ULL ]
= X [ 23ULL ] ; t10 [ 357ULL ] = X [ 24ULL ] * 0.1 ; t10 [ 358ULL ] =
Controlled_Reservoir_MA_A_x_g ; t10 [ 359ULL ] = X [ 26ULL ] ; t10 [ 360ULL ]
= X [ 23ULL ] ; t10 [ 361ULL ] = X [ 24ULL ] * 0.1 ; t10 [ 362ULL ] =
Controlled_Reservoir_MA_A_x_g ; t10 [ 363ULL ] = X [ 26ULL ] ; for ( t33 =
0ULL ; t33 < 8ULL ; t33 ++ ) { t10 [ t33 + 364ULL ] = pipe1_F [ t33 ] ; } for
( t33 = 0ULL ; t33 < 8ULL ; t33 ++ ) { t10 [ t33 + 372ULL ] = pipe1_F [ t33 ]
; } t10 [ 380ULL ] = 0.0 ; t10 [ 381ULL ] = sensors_Measurement_Selector_MA_P
* 99999.999999999985 ; t10 [ 382ULL ] = X [ 9ULL ] ; t10 [ 383ULL ] = X [
86ULL ] ; t10 [ 384ULL ] = sensors_Measurement_Selector_MA_P *
99999.999999999985 ; t10 [ 385ULL ] = X [ 9ULL ] ; t10 [ 386ULL ] = X [ 86ULL
] ; t10 [ 387ULL ] = 0.0 ; t10 [ 388ULL ] = X [ 23ULL ] ; t10 [ 389ULL ] = X
[ 24ULL ] * 0.1 ; t10 [ 390ULL ] = Controlled_Reservoir_MA_A_x_g ; t10 [
391ULL ] = X [ 26ULL ] ; t10 [ 392ULL ] = X [ 23ULL ] ; t10 [ 393ULL ] = X [
24ULL ] * 0.1 ; t10 [ 394ULL ] = Controlled_Reservoir_MA_A_x_g ; t10 [ 395ULL
] = X [ 26ULL ] ; t10 [ 396ULL ] = - X [ 29ULL ] ; t10 [ 397ULL ] = X [
111ULL ] * 1.0E-6 ; t10 [ 398ULL ] = - X [ 34ULL ] ; t10 [ 399ULL ] = -
Controlled_Reservoir_MA_A_x_g ; t10 [ 400ULL ] = - X [ 36ULL ] ; t10 [ 401ULL
] = X [ 111ULL ] * 1.0E-6 ; t10 [ 402ULL ] = X [ 82ULL ] ; t10 [ 403ULL ] = X
[ 16ULL ] * 0.1 ; t10 [ 404ULL ] = X [ 81ULL ] ; t10 [ 405ULL ] = X [ 75ULL ]
; t10 [ 406ULL ] = X [ 16ULL ] * 0.1 ; t10 [ 407ULL ] = X [ 74ULL ] ; t10 [
408ULL ] = U_idx_6 ; t10 [ 409ULL ] = X [ 112ULL ] ; t10 [ 410ULL ] = X [
2ULL ] ; t10 [ 411ULL ] = X [ 15ULL ] ; t10 [ 412ULL ] = U_idx_5 ; t10 [
413ULL ] = - U_idx_6 ; t10 [ 414ULL ] = X [ 2ULL ] ; for ( t33 = 0ULL ; t33 <
8ULL ; t33 ++ ) { t10 [ t33 + 415ULL ] =
steam_injector_Measurement_Selector_MA_F [ t33 ] ; } t10 [ 423ULL ] = 0.0 ;
t10 [ 424ULL ] = t19_idx_0 * 99999.999999999985 ; t10 [ 425ULL ] = X [ 2ULL ]
; t10 [ 426ULL ] = X [ 114ULL ] ; t10 [ 427ULL ] = t19_idx_0 *
99999.999999999985 ; t10 [ 428ULL ] = X [ 2ULL ] ; t10 [ 429ULL ] = X [
114ULL ] ; t10 [ 430ULL ] = - t85 ; t10 [ 431ULL ] = 0.0 ; t10 [ 432ULL ] =
U_idx_5 ; t10 [ 433ULL ] = X [ 82ULL ] ; t10 [ 434ULL ] = X [ 16ULL ] * 0.1 ;
t10 [ 435ULL ] = X [ 81ULL ] ; t10 [ 436ULL ] = X [ 75ULL ] ; t10 [ 437ULL ]
= X [ 16ULL ] * 0.1 ; t10 [ 438ULL ] = X [ 74ULL ] ; t10 [ 439ULL ] = X [
2ULL ] ; t10 [ 440ULL ] = X [ 16ULL ] * 0.1 ; t10 [ 441ULL ] = X [ 15ULL ] ;
t10 [ 442ULL ] = X [ 2ULL ] ; t10 [ 443ULL ] = X [ 16ULL ] * 0.1 ; t10 [
444ULL ] = X [ 15ULL ] ; for ( t33 = 0ULL ; t33 < 8ULL ; t33 ++ ) { t10 [ t33
+ 445ULL ] = steam_injector_Measurement_Selector_MA_F [ t33 ] ; } t10 [
453ULL ] = X [ 2ULL ] ; t10 [ 454ULL ] = X [ 113ULL ] ; t10 [ 455ULL ] = - X
[ 103ULL ] ; t10 [ 456ULL ] = - X [ 95ULL ] ; t10 [ 457ULL ] = - X [ 112ULL ]
; t10 [ 458ULL ] = X [ 2ULL ] ; t10 [ 459ULL ] = X [ 22ULL ] ; t10 [ 460ULL ]
= X [ 121ULL ] ; t10 [ 461ULL ] = X [ 15ULL ] ; t10 [ 462ULL ] = X [ 16ULL ]
* 100.0 ; t10 [ 463ULL ] = steam_injector_constant_volume_chamber_rho_I ; t10
[ 464ULL ] = ( ( X [ 1ULL ] * 0.00040100000000000004 + X [ 3ULL ] *
0.00040100000000000004 ) + X [ 2ULL ] * - 0.00080200000000000009 ) + - X [
116ULL ] ; t10 [ 465ULL ] = X [ 114ULL ] ; t10 [ 466ULL ] = X [ 2ULL ] ; t10
[ 467ULL ] = X [ 15ULL ] ; t10 [ 468ULL ] = - t85 ; t10 [ 469ULL ] = X [
82ULL ] ; t10 [ 470ULL ] = X [ 16ULL ] * 0.1 ; t10 [ 471ULL ] = X [ 81ULL ] ;
t10 [ 472ULL ] = - X [ 103ULL ] ; t10 [ 473ULL ] = X [ 117ULL ] ; t10 [
474ULL ] = - X [ 80ULL ] ; t10 [ 475ULL ] = - X [ 107ULL ] ; t10 [ 476ULL ] =
X [ 118ULL ] ; t10 [ 477ULL ] = X [ 75ULL ] ; t10 [ 478ULL ] = X [ 16ULL ] *
0.1 ; t10 [ 479ULL ] = X [ 74ULL ] ; t10 [ 480ULL ] = - X [ 95ULL ] ; t10 [
481ULL ] = X [ 119ULL ] ; t10 [ 482ULL ] = - X [ 73ULL ] ; t10 [ 483ULL ] = -
X [ 98ULL ] ; t10 [ 484ULL ] = X [ 120ULL ] ; t10 [ 485ULL ] = t45 ; t10 [
486ULL ] = - X [ 80ULL ] ; t10 [ 487ULL ] = - X [ 73ULL ] ; t10 [ 488ULL ] =
U_idx_6 ; t10 [ 489ULL ] = - X [ 107ULL ] ; t10 [ 490ULL ] = - X [ 98ULL ] ;
t10 [ 491ULL ] = 1.0 - X [ 15ULL ] ; t10 [ 492ULL ] = X [ 115ULL ] ; t10 [
493ULL ] = U_idx_6 ; t10 [ 494ULL ] = X [ 14ULL ] ; t10 [ 495ULL ] = X [
64ULL ] * 1000.0 ; t10 [ 496ULL ] = X [ 17ULL ] ; t10 [ 497ULL ] = X [ 0ULL ]
; t10 [ 498ULL ] = ( ( X [ 1ULL ] * 0.00040100000000000004 + X [ 3ULL ] *
0.00040100000000000004 ) + X [ 0ULL ] * - 0.00080200000000000009 ) * 1000.0 ;
t10 [ 499ULL ] = X [ 0ULL ] ; t10 [ 500ULL ] = X [ 3ULL ] ; t10 [ 501ULL ] =
( ( ( X [ 3ULL ] * - 0.00080200000000000009 + X [ 2ULL ] *
0.00040100000000000004 ) + X [ 0ULL ] * 0.00040100000000000004 ) + - X [
96ULL ] ) * 1000.0 ; t10 [ 502ULL ] = X [ 3ULL ] ; t10 [ 503ULL ] = X [ 2ULL
] ; t10 [ 504ULL ] = X [ 116ULL ] * 1000.0 ; t10 [ 505ULL ] = X [ 18ULL ] ;
t10 [ 506ULL ] = X [ 1ULL ] ; t10 [ 507ULL ] = X [ 42ULL ] * 1000.0 ; t10 [
508ULL ] = X [ 1ULL ] ; for ( b = 0 ; b < 509 ; b ++ ) { out . mX [ b ] = t10
[ b ] ; } ( void ) LC ; ( void ) t186 ; return 0 ; }
