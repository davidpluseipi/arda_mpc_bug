#include "ne_ds.h"
#include "plant_836bb176_1_ds_sys_struct.h"
#include "plant_836bb176_1_ds_m.h"
#include "plant_836bb176_1_ds.h"
#include "plant_836bb176_1_ds_externals.h"
#include "plant_836bb176_1_ds_external_struct.h"
#include "ssc_ml_fun.h"
int32_T plant_836bb176_1_ds_m ( const NeDynamicSystem * LC , const
NeDynamicSystemInput * t41 , NeDsMethodOutput * t42 ) { PmRealVector out ;
real_T X [ 122 ] ; real_T intrm_sf_mf_133 ; real_T intrm_sf_mf_31 ; real_T
pipe1_rho_I ; real_T pipe2_rho_I ; real_T pipe3_rho_I ; real_T
steam_injector_constant_volume_chamber_rho_I ; real_T t11 ; real_T t14 ;
real_T t23 ; real_T t25 ; real_T t27 ; real_T t28 ; real_T t32 ; int32_T b ;
( void ) LC ; for ( b = 0 ; b < 122 ; b ++ ) { X [ b ] = t41 -> mX . mX [ b ]
; } out = t42 -> mM ; if ( X [ 8ULL ] <= 0.0 ) {
steam_injector_constant_volume_chamber_rho_I = 0.0 ; } else {
steam_injector_constant_volume_chamber_rho_I = X [ 8ULL ] >= 1.0 ? 1.0 : X [
8ULL ] ; } intrm_sf_mf_31 = ( 1.0 -
steam_injector_constant_volume_chamber_rho_I ) * 287.047 +
steam_injector_constant_volume_chamber_rho_I * 461.523 ; t23 = intrm_sf_mf_31
* X [ 9ULL ] ; pipe1_rho_I = X [ 10ULL ] / ( t23 == 0.0 ? 1.0E-16 : t23 ) ;
if ( X [ 5ULL ] <= 0.0 ) { t23 = 0.0 ; } else { t23 = X [ 5ULL ] >= 1.0 ? 1.0
: X [ 5ULL ] ; } t25 = ( 1.0 - t23 ) * 287.047 + t23 * 461.523 ; t32 = t25 *
X [ 4ULL ] ; pipe3_rho_I = X [ 11ULL ] / ( t32 == 0.0 ? 1.0E-16 : t32 ) ; if
( X [ 7ULL ] <= 0.0 ) { t32 = 0.0 ; } else { t32 = X [ 7ULL ] >= 1.0 ? 1.0 :
X [ 7ULL ] ; } t27 = ( 1.0 - t32 ) * 287.047 + t32 * 461.523 ; t28 = t27 * X
[ 6ULL ] ; pipe2_rho_I = X [ 12ULL ] / ( t28 == 0.0 ? 1.0E-16 : t28 ) ; if (
X [ 9ULL ] <= 216.59999999999997 ) { t28 = 216.59999999999997 ; } else { t28
= X [ 9ULL ] >= 623.15 ? 623.15 : X [ 9ULL ] ; } t11 = t28 * t28 ;
intrm_sf_mf_133 = ( ( 1026.6477992877897 + t28 * - 0.177515573577821 ) + t11
* 0.0003665817851591644 ) * ( 1.0 -
steam_injector_constant_volume_chamber_rho_I ) + ( ( 1479.6504774710402 + t28
* 1.2002114337050787 ) + t11 * - 0.00038614513167845434 ) *
steam_injector_constant_volume_chamber_rho_I ; if ( X [ 6ULL ] <=
216.59999999999997 ) { steam_injector_constant_volume_chamber_rho_I =
216.59999999999997 ; } else { steam_injector_constant_volume_chamber_rho_I =
X [ 6ULL ] >= 623.15 ? 623.15 : X [ 6ULL ] ; } t14 =
steam_injector_constant_volume_chamber_rho_I *
steam_injector_constant_volume_chamber_rho_I ; t28 = ( ( 1026.6477992877897 +
steam_injector_constant_volume_chamber_rho_I * - 0.177515573577821 ) + t14 *
0.0003665817851591644 ) * ( 1.0 - t32 ) + ( ( 1479.6504774710402 +
steam_injector_constant_volume_chamber_rho_I * 1.2002114337050787 ) + t14 * -
0.00038614513167845434 ) * t32 ; if ( X [ 4ULL ] <= 216.59999999999997 ) {
steam_injector_constant_volume_chamber_rho_I = 216.59999999999997 ; } else {
steam_injector_constant_volume_chamber_rho_I = X [ 4ULL ] >= 623.15 ? 623.15
: X [ 4ULL ] ; } t14 = steam_injector_constant_volume_chamber_rho_I *
steam_injector_constant_volume_chamber_rho_I ; t32 = ( ( 1026.6477992877897 +
steam_injector_constant_volume_chamber_rho_I * - 0.177515573577821 ) + t14 *
0.0003665817851591644 ) * ( 1.0 - t23 ) + ( ( 1479.6504774710402 +
steam_injector_constant_volume_chamber_rho_I * 1.2002114337050787 ) + t14 * -
0.00038614513167845434 ) * t23 ; if ( X [ 15ULL ] <= 0.0 ) {
steam_injector_constant_volume_chamber_rho_I = 0.0 ; } else {
steam_injector_constant_volume_chamber_rho_I = X [ 15ULL ] >= 1.0 ? 1.0 : X [
15ULL ] ; } t23 = ( 1.0 - steam_injector_constant_volume_chamber_rho_I ) *
287.047 + steam_injector_constant_volume_chamber_rho_I * 461.523 ; if ( X [
2ULL ] <= 216.59999999999997 ) { t11 = 216.59999999999997 ; } else { t11 = X
[ 2ULL ] >= 623.15 ? 623.15 : X [ 2ULL ] ; } t14 = t11 * t11 ; t14 = ( (
1026.6477992877897 + t11 * - 0.177515573577821 ) + t14 *
0.0003665817851591644 ) * ( 1.0 -
steam_injector_constant_volume_chamber_rho_I ) + ( ( 1479.6504774710402 + t11
* 1.2002114337050787 ) + t14 * - 0.00038614513167845434 ) *
steam_injector_constant_volume_chamber_rho_I ; t11 = t23 * X [ 2ULL ] ;
steam_injector_constant_volume_chamber_rho_I = X [ 16ULL ] / ( t11 == 0.0 ?
1.0E-16 : t11 ) ; out . mX [ 0 ] = - 0.447 ; out . mX [ 1 ] = - 0.447 ; out .
mX [ 2 ] = - ( 1.0 / ( X [ 2ULL ] == 0.0 ? 1.0E-16 : X [ 2ULL ] ) ) *
steam_injector_constant_volume_chamber_rho_I * 25000.0 ; out . mX [ 3 ] = (
t14 - t23 ) * steam_injector_constant_volume_chamber_rho_I * 25.0 ; out . mX
[ 4 ] = - 0.447 ; out . mX [ 5 ] = - ( 1.0 / ( X [ 4ULL ] == 0.0 ? 1.0E-16 :
X [ 4ULL ] ) ) * pipe3_rho_I * 202.68299163899908 ; out . mX [ 6 ] = ( t32 -
t25 ) * pipe3_rho_I * 0.20268299163899908 ; out . mX [ 7 ] = pipe3_rho_I *
202.68299163899908 ; out . mX [ 8 ] = - ( 1.0 / ( X [ 6ULL ] == 0.0 ? 1.0E-16
: X [ 6ULL ] ) ) * pipe2_rho_I * 202.68299163899908 ; out . mX [ 9 ] = ( t28
- t27 ) * pipe2_rho_I * 0.20268299163899908 ; out . mX [ 10 ] = pipe2_rho_I *
202.68299163899908 ; out . mX [ 11 ] = pipe1_rho_I * 202.68299163899908 ; out
. mX [ 12 ] = - ( 1.0 / ( X [ 9ULL ] == 0.0 ? 1.0E-16 : X [ 9ULL ] ) ) *
pipe1_rho_I * 202.68299163899908 ; out . mX [ 13 ] = ( intrm_sf_mf_133 -
intrm_sf_mf_31 ) * pipe1_rho_I * 0.20268299163899908 ; out . mX [ 14 ] = 1.0
/ ( X [ 10ULL ] == 0.0 ? 1.0E-16 : X [ 10ULL ] ) * pipe1_rho_I *
202.68299163899908 ; out . mX [ 15 ] = 1.0 / ( X [ 11ULL ] == 0.0 ? 1.0E-16 :
X [ 11ULL ] ) * pipe3_rho_I * 202.68299163899908 ; out . mX [ 16 ] = 1.0 / (
X [ 12ULL ] == 0.0 ? 1.0E-16 : X [ 12ULL ] ) * pipe2_rho_I *
202.68299163899908 ; out . mX [ 17 ] = 1.0 ; out . mX [ 18 ] = 1.0E-5 ; out .
mX [ 19 ] = steam_injector_constant_volume_chamber_rho_I * 25000.0 ; out . mX
[ 20 ] = 1.0 / ( X [ 16ULL ] == 0.0 ? 1.0E-16 : X [ 16ULL ] ) *
steam_injector_constant_volume_chamber_rho_I * 25000.0 ; out . mX [ 21 ] = -
0.447 ; out . mX [ 22 ] = - 0.447 ; out . mX [ 23 ] = 1.0 ; out . mX [ 24 ] =
1.0 ; out . mX [ 25 ] = 1.0 ; out . mX [ 26 ] = 1.0 ; ( void ) LC ; ( void )
t42 ; return 0 ; }
