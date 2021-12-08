#include "ne_ds.h"
#include "plant_836bb176_1_ds_sys_struct.h"
#include "plant_836bb176_1_ds_iassert.h"
#include "plant_836bb176_1_ds.h"
#include "plant_836bb176_1_ds_externals.h"
#include "plant_836bb176_1_ds_external_struct.h"
#include "ssc_ml_fun.h"
int32_T plant_836bb176_1_ds_iassert ( const NeDynamicSystem * LC , const
NeDynamicSystemInput * t28 , NeDsMethodOutput * t29 ) { ETTS0 c_efOut ; ETTS0
e_efOut ; ETTS0 efOut ; ETTS0 g_efOut ; ETTS0 t2 ; PmIntVector out ; real_T X
[ 122 ] ; real_T b_efOut [ 1 ] ; real_T d_efOut [ 1 ] ; real_T f_efOut [ 1 ]
; real_T h_efOut [ 1 ] ; real_T t7 [ 1 ] ; real_T pipe1_p_ws_ratio_I ; real_T
pipe3_p_ws_ratio_I ; real_T
steam_injector_constant_volume_chamber_p_ws_ratio_I ; real_T t11_idx_0 ;
size_t _in1ivar ; size_t b__in1ivar ; size_t c__in1ivar ; size_t d__in1ivar ;
size_t e__in1ivar ; size_t f__in1ivar ; size_t g__in1ivar ; size_t h__in1ivar
; size_t i__in1ivar ; size_t j__in1ivar ; size_t k__in1ivar ; size_t
l__in1ivar ; size_t m__in1ivar ; size_t n__in1ivar ; size_t o__in1ivar ;
size_t p__in1ivar ; int32_T b ; for ( b = 0 ; b < 122 ; b ++ ) { X [ b ] =
t28 -> mX . mX [ b ] ; } out = t29 -> mIASSERT ; t7 [ 0ULL ] = X [ 9ULL ] ;
_in1ivar = 52ULL ; b__in1ivar = 1ULL ; tlu2_linear_linear_prelookup ( & efOut
. mField0 [ 0ULL ] , & efOut . mField1 [ 0ULL ] , & efOut . mField2 [ 0ULL ]
, ( ( _NeDynamicSystem * ) ( LC ) ) -> mField0 , & t7 [ 0ULL ] , & _in1ivar ,
& b__in1ivar ) ; t2 = efOut ; c__in1ivar = 52ULL ; d__in1ivar = 1ULL ;
tlu2_1d_linear_linear_value ( & b_efOut [ 0ULL ] , & t2 . mField0 [ 0ULL ] ,
& t2 . mField1 [ 0ULL ] , & t2 . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * )
( LC ) ) -> mField1 , & c__in1ivar , & d__in1ivar ) ; t11_idx_0 = b_efOut [ 0
] ; pipe1_p_ws_ratio_I = exp ( pmf_log ( X [ 10ULL ] * 100000.0 ) - t11_idx_0
) ; t7 [ 0ULL ] = X [ 4ULL ] ; e__in1ivar = 52ULL ; f__in1ivar = 1ULL ;
tlu2_linear_linear_prelookup ( & c_efOut . mField0 [ 0ULL ] , & c_efOut .
mField1 [ 0ULL ] , & c_efOut . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * ) (
LC ) ) -> mField0 , & t7 [ 0ULL ] , & e__in1ivar , & f__in1ivar ) ; t2 =
c_efOut ; g__in1ivar = 52ULL ; h__in1ivar = 1ULL ;
tlu2_1d_linear_linear_value ( & d_efOut [ 0ULL ] , & t2 . mField0 [ 0ULL ] ,
& t2 . mField1 [ 0ULL ] , & t2 . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * )
( LC ) ) -> mField1 , & g__in1ivar , & h__in1ivar ) ; t11_idx_0 = d_efOut [ 0
] ; pipe3_p_ws_ratio_I = exp ( pmf_log ( X [ 11ULL ] * 100000.0 ) - t11_idx_0
) ; t7 [ 0ULL ] = X [ 6ULL ] ; i__in1ivar = 52ULL ; j__in1ivar = 1ULL ;
tlu2_linear_linear_prelookup ( & e_efOut . mField0 [ 0ULL ] , & e_efOut .
mField1 [ 0ULL ] , & e_efOut . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * ) (
LC ) ) -> mField0 , & t7 [ 0ULL ] , & i__in1ivar , & j__in1ivar ) ; t2 =
e_efOut ; k__in1ivar = 52ULL ; l__in1ivar = 1ULL ;
tlu2_1d_linear_linear_value ( & f_efOut [ 0ULL ] , & t2 . mField0 [ 0ULL ] ,
& t2 . mField1 [ 0ULL ] , & t2 . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * )
( LC ) ) -> mField1 , & k__in1ivar , & l__in1ivar ) ; t11_idx_0 = f_efOut [ 0
] ; t11_idx_0 = exp ( pmf_log ( X [ 12ULL ] * 100000.0 ) - t11_idx_0 ) ; t7 [
0ULL ] = X [ 2ULL ] ; m__in1ivar = 52ULL ; n__in1ivar = 1ULL ;
tlu2_linear_linear_prelookup ( & g_efOut . mField0 [ 0ULL ] , & g_efOut .
mField1 [ 0ULL ] , & g_efOut . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * ) (
LC ) ) -> mField0 , & t7 [ 0ULL ] , & m__in1ivar , & n__in1ivar ) ; t2 =
g_efOut ; o__in1ivar = 52ULL ; p__in1ivar = 1ULL ;
tlu2_1d_linear_linear_value ( & h_efOut [ 0ULL ] , & t2 . mField0 [ 0ULL ] ,
& t2 . mField1 [ 0ULL ] , & t2 . mField2 [ 0ULL ] , ( ( _NeDynamicSystem * )
( LC ) ) -> mField1 , & o__in1ivar , & p__in1ivar ) ; t7 [ 0 ] = h_efOut [ 0
] ; steam_injector_constant_volume_chamber_p_ws_ratio_I = exp ( pmf_log ( X [
16ULL ] * 100000.0 ) - t7 [ 0ULL ] ) ; out . mX [ 0 ] = ( int32_T ) ( X [
86ULL ] <= pipe1_p_ws_ratio_I ) ; out . mX [ 1 ] = ( int32_T ) ( X [ 86ULL ]
<= 1.0 ) ; out . mX [ 2 ] = ( int32_T ) ( X [ 8ULL ] <= 1.0 ) ; out . mX [ 3
] = ( int32_T ) ( 1.0 - X [ 8ULL ] >= 0.0 ) ; out . mX [ 4 ] = ( int32_T ) (
X [ 48ULL ] <= t11_idx_0 ) ; out . mX [ 5 ] = ( int32_T ) ( X [ 48ULL ] <=
1.0 ) ; out . mX [ 6 ] = ( int32_T ) ( X [ 7ULL ] <= 1.0 ) ; out . mX [ 7 ] =
( int32_T ) ( 1.0 - X [ 7ULL ] >= 0.0 ) ; out . mX [ 8 ] = ( int32_T ) ( X [
44ULL ] <= pipe3_p_ws_ratio_I ) ; out . mX [ 9 ] = ( int32_T ) ( X [ 44ULL ]
<= 1.0 ) ; out . mX [ 10 ] = ( int32_T ) ( X [ 5ULL ] <= 1.0 ) ; out . mX [
11 ] = ( int32_T ) ( 1.0 - X [ 5ULL ] >= 0.0 ) ; out . mX [ 12 ] = ( int32_T
) ( X [ 114ULL ] <= steam_injector_constant_volume_chamber_p_ws_ratio_I ) ;
out . mX [ 13 ] = ( int32_T ) ( X [ 114ULL ] <= 1.0 ) ; out . mX [ 14 ] = (
int32_T ) ( X [ 15ULL ] <= 1.0 ) ; out . mX [ 15 ] = ( int32_T ) ( 1.0 - X [
15ULL ] >= 0.0 ) ; ( void ) LC ; ( void ) t29 ; return 0 ; }
