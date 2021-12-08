#include "ne_ds.h"
#include "plant_836bb176_1_ds_sys_struct.h"
#include "plant_836bb176_1_ds_duf.h"
#include "plant_836bb176_1_ds.h"
#include "plant_836bb176_1_ds_externals.h"
#include "plant_836bb176_1_ds_external_struct.h"
#include "ssc_ml_fun.h"
int32_T plant_836bb176_1_ds_duf ( const NeDynamicSystem * LC , const
NeDynamicSystemInput * t30 , NeDsMethodOutput * t31 ) { ETTS0 c_efOut ; ETTS0
efOut ; ETTS0 f_efOut ; ETTS0 t2 ; PmRealVector out ; real_T X [ 122 ] ;
real_T t6 [ 8 ] ; real_T t12 [ 4 ] ; real_T b_efOut [ 1 ] ; real_T d_efOut [
1 ] ; real_T e_efOut [ 1 ] ; real_T g_efOut [ 1 ] ; real_T h_efOut [ 1 ] ;
real_T t10 [ 1 ] ; real_T U_idx_1 ; real_T U_idx_5 ; real_T U_idx_6 ; real_T
intermediate_der1922 ; real_T intermediate_der2023 ; real_T
intermediate_der2083 ; real_T intrm_sf_mf_416 ; real_T intrm_sf_mf_443 ;
real_T steam_injector_constant_volume_chamber_u_I ; real_T
steam_injector_constant_volume_chamber_u_a_I ; real_T
steam_injector_constant_volume_chamber_u_w_I ; real_T t9_idx_0 ; size_t
_in1ivar ; size_t b__in1ivar ; size_t c__in1ivar ; size_t d__in1ivar ; size_t
e__in1ivar ; size_t f__in1ivar ; size_t g__in1ivar ; size_t h__in1ivar ;
size_t i__in1ivar ; size_t j__in1ivar ; size_t k__in1ivar ; size_t l__in1ivar
; size_t m__in1ivar ; size_t n__in1ivar ; size_t o__in1ivar ; size_t
p__in1ivar ; size_t t13 ; int32_T M_idx_11 ; int32_T M_idx_21 ; int32_T
M_idx_31 ; int32_T M_idx_32 ; int32_T M_idx_33 ; int32_T M_idx_41 ; int32_T b
; boolean_T intrm_sf_mf_441 ; M_idx_11 = t30 -> mM . mX [ 11 ] ; M_idx_21 =
t30 -> mM . mX [ 21 ] ; M_idx_31 = t30 -> mM . mX [ 31 ] ; M_idx_32 = t30 ->
mM . mX [ 32 ] ; M_idx_33 = t30 -> mM . mX [ 33 ] ; M_idx_41 = t30 -> mM . mX
[ 41 ] ; U_idx_1 = t30 -> mU . mX [ 1 ] ; U_idx_5 = t30 -> mU . mX [ 5 ] ;
U_idx_6 = t30 -> mU . mX [ 6 ] ; for ( b = 0 ; b < 122 ; b ++ ) { X [ b ] =
t30 -> mX . mX [ b ] ; } out = t31 -> mDUF ; t10 [ 0ULL ] = X [ 31ULL ] ;
_in1ivar = 52ULL ; b__in1ivar = 1ULL ; tlu2_linear_linear_prelookup ( & efOut
. mField0 [ 0ULL ] , & efOut . mField1 [ 0ULL ] , & efOut . mField2 [ 0ULL ]
, ( ( _NeDynamicSystem * ) ( LC ) ) -> mField0 , & t10 [ 0ULL ] , & _in1ivar
, & b__in1ivar ) ; t2 = efOut ; c__in1ivar = 52ULL ; d__in1ivar = 1ULL ;
tlu2_1d_linear_linear_value ( & b_efOut [ 0ULL ] , & t2 . mField0 [ 0ULL ] ,
& t2 . mField1 [ 0ULL ] , & t2 . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * )
( LC ) ) -> mField1 , & c__in1ivar , & d__in1ivar ) ; t9_idx_0 = b_efOut [ 0
] ; steam_injector_constant_volume_chamber_u_I = exp ( pmf_log ( X [ 24ULL ]
* 100000.0 ) - t9_idx_0 ) ; if ( X [ 15ULL ] <= 0.0 ) { intrm_sf_mf_443 = 0.0
; } else { intrm_sf_mf_443 = X [ 15ULL ] >= 1.0 ? 1.0 : X [ 15ULL ] ; }
intrm_sf_mf_416 = ( 1.0 - intrm_sf_mf_443 ) * 287.047 + intrm_sf_mf_443 *
461.523 ; t10 [ 0ULL ] = X [ 2ULL ] ; e__in1ivar = 52ULL ; f__in1ivar = 1ULL
; tlu2_linear_linear_prelookup ( & c_efOut . mField0 [ 0ULL ] , & c_efOut .
mField1 [ 0ULL ] , & c_efOut . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * ) (
LC ) ) -> mField0 , & t10 [ 0ULL ] , & e__in1ivar , & f__in1ivar ) ; t2 =
c_efOut ; g__in1ivar = 52ULL ; h__in1ivar = 1ULL ;
tlu2_1d_linear_linear_value ( & d_efOut [ 0ULL ] , & t2 . mField0 [ 0ULL ] ,
& t2 . mField1 [ 0ULL ] , & t2 . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * )
( LC ) ) -> mField8 , & g__in1ivar , & h__in1ivar ) ; t9_idx_0 = d_efOut [ 0
] ; steam_injector_constant_volume_chamber_u_w_I = t9_idx_0 ; i__in1ivar =
52ULL ; j__in1ivar = 1ULL ; tlu2_1d_linear_linear_value ( & e_efOut [ 0ULL ]
, & t2 . mField0 [ 0ULL ] , & t2 . mField1 [ 0ULL ] , & t2 . mField2 [ 0ULL ]
, ( ( _NeDynamicSystem * ) ( LC ) ) -> mField9 , & i__in1ivar , & j__in1ivar
) ; t9_idx_0 = e_efOut [ 0 ] ; steam_injector_constant_volume_chamber_u_a_I =
( 1.0 - intrm_sf_mf_443 ) * steam_injector_constant_volume_chamber_u_w_I +
intrm_sf_mf_443 * t9_idx_0 ; intrm_sf_mf_441 = ( 0.0 <= (
steam_injector_constant_volume_chamber_u_I > 1.0 ? 1.0 :
steam_injector_constant_volume_chamber_u_I ) ) ; if ( intrm_sf_mf_441 ) {
intrm_sf_mf_443 = 0.0 ; } else { intrm_sf_mf_443 =
steam_injector_constant_volume_chamber_u_I > 1.0 ? 1.0 :
steam_injector_constant_volume_chamber_u_I ; } if ( intrm_sf_mf_441 ) {
steam_injector_constant_volume_chamber_u_I =
steam_injector_constant_volume_chamber_u_I > 1.0 ? 1.0 :
steam_injector_constant_volume_chamber_u_I ; } else {
steam_injector_constant_volume_chamber_u_I = 0.0 ; } if ( M_idx_31 != 0 ) {
U_idx_5 = 216.59999999999997 ; } else { U_idx_5 = M_idx_33 != 0 ? 623.15 :
U_idx_5 ; } t10 [ 0ULL ] = U_idx_6 >= 0.0 ? U_idx_5 : X [ 2ULL ] ; k__in1ivar
= 52ULL ; l__in1ivar = 1ULL ; tlu2_linear_linear_prelookup ( & f_efOut .
mField0 [ 0ULL ] , & f_efOut . mField1 [ 0ULL ] , & f_efOut . mField2 [ 0ULL
] , ( ( _NeDynamicSystem * ) ( LC ) ) -> mField0 , & t10 [ 0ULL ] , &
k__in1ivar , & l__in1ivar ) ; t2 = f_efOut ; m__in1ivar = 52ULL ; n__in1ivar
= 1ULL ; tlu2_1d_linear_linear_value ( & g_efOut [ 0ULL ] , & t2 . mField0 [
0ULL ] , & t2 . mField1 [ 0ULL ] , & t2 . mField2 [ 0ULL ] , ( (
_NeDynamicSystem * ) ( LC ) ) -> mField9 , & m__in1ivar , & n__in1ivar ) ;
t10 [ 0 ] = g_efOut [ 0 ] ; U_idx_5 = t10 [ 0ULL ] ; if ( M_idx_31 != 0 ) {
intermediate_der1922 = 0.0 ; } else { intermediate_der1922 = ( real_T ) (
M_idx_33 == 0 ) ; } o__in1ivar = 52ULL ; p__in1ivar = 1ULL ;
tlu2_1d_linear_linear_derivatives ( & h_efOut [ 0ULL ] , & t2 . mField0 [
0ULL ] , & t2 . mField1 [ 0ULL ] , & t2 . mField2 [ 0ULL ] , ( (
_NeDynamicSystem * ) ( LC ) ) -> mField9 , & o__in1ivar , & p__in1ivar ) ;
t10 [ 0 ] = h_efOut [ 0 ] ; intermediate_der1922 = t10 [ 0ULL ] * ( U_idx_6
>= 0.0 ? intermediate_der1922 : 0.0 ) ; if ( M_idx_11 != 0 ) {
intermediate_der2023 = 0.0 ; } else { intermediate_der2023 = M_idx_21 != 0 ?
0.0 : 0.01 ; } if ( M_idx_32 != 0 ) { intermediate_der2083 = 0.0 ; } else {
intermediate_der2083 = ( real_T ) ( M_idx_41 == 0 ) ; } if ( U_idx_1 <=
intrm_sf_mf_443 ) { steam_injector_constant_volume_chamber_u_I = 0.0 ; } else
{ steam_injector_constant_volume_chamber_u_I = ( real_T ) ! ( U_idx_1 >=
steam_injector_constant_volume_chamber_u_I ) ; } t12 [ 0ULL ] = - ( ( 1.0 - X
[ 15ULL ] ) * ( - 174.476 / ( intrm_sf_mf_416 == 0.0 ? 1.0E-16 :
intrm_sf_mf_416 ) ) ) ; t12 [ 1ULL ] = - ( ( ( t9_idx_0 - X [ 2ULL ] *
0.461523 ) - ( steam_injector_constant_volume_chamber_u_w_I - X [ 2ULL ] *
0.28704700000000005 ) ) * ( 1.0 - X [ 15ULL ] ) + (
steam_injector_constant_volume_chamber_u_a_I - intrm_sf_mf_416 * X [ 2ULL ] *
0.001 ) ) ; t12 [ 2ULL ] = - X [ 15ULL ] ; t12 [ 3ULL ] = U_idx_5 ; t6 [ 0ULL
] = - intermediate_der2023 ; t6 [ 1ULL ] = -
steam_injector_constant_volume_chamber_u_I ; t6 [ 2ULL ] = -
intermediate_der2083 ; t6 [ 3ULL ] = intermediate_der1922 * U_idx_6 ; for (
t13 = 0ULL ; t13 < 4ULL ; t13 ++ ) { t6 [ t13 + 4ULL ] = t12 [ t13 ] ; } out
. mX [ 0 ] = t6 [ 0 ] ; out . mX [ 1 ] = t6 [ 1 ] ; out . mX [ 2 ] = t6 [ 2 ]
; out . mX [ 3 ] = t6 [ 3 ] ; out . mX [ 4 ] = t6 [ 4 ] ; out . mX [ 5 ] = t6
[ 5 ] ; out . mX [ 6 ] = t6 [ 6 ] ; out . mX [ 7 ] = t6 [ 7 ] ; ( void ) LC ;
( void ) t31 ; return 0 ; }
