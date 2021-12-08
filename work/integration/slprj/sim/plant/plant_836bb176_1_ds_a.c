#include "ne_ds.h"
#include "plant_836bb176_1_ds_sys_struct.h"
#include "plant_836bb176_1_ds_a.h"
#include "plant_836bb176_1_ds.h"
#include "plant_836bb176_1_ds_externals.h"
#include "plant_836bb176_1_ds_external_struct.h"
#include "ssc_ml_fun.h"
int32_T plant_836bb176_1_ds_a ( const NeDynamicSystem * LC , const
NeDynamicSystemInput * t195 , NeDsMethodOutput * t196 ) { PmRealVector out ;
real_T t6 [ 167 ] ; real_T intermediate_der17 [ 8 ] ; real_T
intermediate_der18 [ 8 ] ; real_T intermediate_der19 [ 8 ] ; real_T
intermediate_der20 [ 8 ] ; real_T intermediate_der21 [ 8 ] ; real_T t1 [ 8 ]
; real_T t2 [ 8 ] ; real_T t3 [ 8 ] ; real_T t4 [ 8 ] ; real_T t5 [ 8 ] ;
real_T t22 [ 5 ] ; real_T t27 [ 4 ] ; real_T t33 [ 4 ] ; real_T t35 [ 4 ] ;
real_T t37 [ 4 ] ; real_T t40 [ 4 ] ; real_T t42 [ 4 ] ; real_T t45 [ 4 ] ;
real_T t9 [ 4 ] ; real_T t183 ; real_T t184 ; real_T t194 ; size_t t83 ;
int32_T b ; ( void ) t195 ; ( void ) LC ; out = t196 -> mA ; t5 [ 0 ] = 0.0 ;
t5 [ 1 ] = 0.0 ; t5 [ 2 ] = 0.0 ; t5 [ 3 ] = 1.0 ; t5 [ 4 ] = 0.0 ; t5 [ 5 ]
= 0.0 ; t5 [ 6 ] = 0.0 ; t5 [ 7 ] = 0.0 ; t4 [ 0 ] = 0.0 ; t4 [ 1 ] = 1.0 ;
t4 [ 2 ] = 0.0 ; t4 [ 3 ] = 0.0 ; t4 [ 4 ] = 0.0 ; t4 [ 5 ] = 0.0 ; t4 [ 6 ]
= 0.0 ; t4 [ 7 ] = 0.0 ; t3 [ 0 ] = 0.0 ; t3 [ 1 ] = 0.0 ; t3 [ 2 ] = 0.0 ;
t3 [ 3 ] = 0.0 ; t3 [ 4 ] = 1.0 ; t3 [ 5 ] = 0.0 ; t3 [ 6 ] = 0.0 ; t3 [ 7 ]
= 0.0 ; t2 [ 0 ] = 0.0 ; t2 [ 1 ] = 0.0 ; t2 [ 2 ] = 1.0 ; t2 [ 3 ] = 0.0 ;
t2 [ 4 ] = 0.0 ; t2 [ 5 ] = 0.0 ; t2 [ 6 ] = 0.0 ; t2 [ 7 ] = 0.0 ; t1 [ 0 ]
= 0.0 ; t1 [ 1 ] = 0.0 ; t1 [ 2 ] = 0.0 ; t1 [ 3 ] = 0.0 ; t1 [ 4 ] = 0.0 ;
t1 [ 5 ] = 1.0 ; t1 [ 6 ] = 0.0 ; t1 [ 7 ] = 0.0 ; memcpy ( &
intermediate_der17 [ 0 ] , & t4 [ 0 ] , 64U ) ; memcpy ( & intermediate_der18
[ 0 ] , & t2 [ 0 ] , 64U ) ; memcpy ( & intermediate_der19 [ 0 ] , & t5 [ 0 ]
, 64U ) ; memcpy ( & intermediate_der20 [ 0 ] , & t3 [ 0 ] , 64U ) ; memcpy (
& intermediate_der21 [ 0 ] , & t1 [ 0 ] , 64U ) ; t9 [ 0ULL ] = -
0.00080200000000000009 ; t9 [ 1ULL ] = - 0.00040100000000000004 ; t183 =
intermediate_der17 [ 0ULL ] - t4 [ 0ULL ] ; t9 [ 2ULL ] = t183 / 100000.0 ;
t9 [ 3ULL ] = - 1.0 ; t184 = intermediate_der19 [ 0ULL ] - t5 [ 0ULL ] ; t22
[ 0ULL ] = 1.0 ; t22 [ 1ULL ] = - 1.0 ; t22 [ 2ULL ] = 1.0 ; t22 [ 3ULL ] = -
1.0 ; t22 [ 4ULL ] = 1.0 ; t27 [ 0ULL ] = - 1.0 ; t27 [ 1ULL ] = 1.0 ; t27 [
2ULL ] = 1.0 ; t27 [ 3ULL ] = - 1.0 ; t33 [ 0ULL ] = 1.0 ; t33 [ 1ULL ] = -
1.0 ; t33 [ 2ULL ] = 1.0 ; t33 [ 3ULL ] = - 1.0 ; t35 [ 0ULL ] = 1.0 ; t35 [
1ULL ] = - 1.0 ; t35 [ 2ULL ] = 1.0 ; t35 [ 3ULL ] = - 1.0 ; t37 [ 0ULL ] =
1.0 ; t37 [ 1ULL ] = - 1.0 ; t37 [ 2ULL ] = 1.0 ; t37 [ 3ULL ] = - 1.0 ; t40
[ 0ULL ] = 1.0 ; t40 [ 1ULL ] = - 1.0 ; t40 [ 2ULL ] = 1.0 ; t40 [ 3ULL ] = -
1.0 ; t42 [ 0ULL ] = 1.0 ; t42 [ 1ULL ] = - 1.0 ; t42 [ 2ULL ] = 1.0 ; t42 [
3ULL ] = - 1.0 ; t45 [ 0ULL ] = 1.0 ; t45 [ 1ULL ] = - 1.0 ; t45 [ 2ULL ] =
1.0 ; t45 [ 3ULL ] = - 1.0 ; t6 [ 0ULL ] = 0.00080200000000000009 ; t6 [ 1ULL
] = - 0.00040100000000000004 ; t6 [ 2ULL ] = 0.00040100000000000004 ; t6 [
3ULL ] = - 0.00040100000000000004 ; t6 [ 4ULL ] = - 1.0 ; for ( t83 = 0ULL ;
t83 < 4ULL ; t83 ++ ) { t6 [ t83 + 5ULL ] = t9 [ t83 ] ; } t6 [ 9ULL ] =
0.00040100000000000004 ; t6 [ 10ULL ] = - 0.00040100000000000004 ; t6 [ 11ULL
] = 0.00080200000000000009 ; t6 [ 12ULL ] = t183 / 100000.0 ; t6 [ 13ULL ] =
- 1.0 ; t6 [ 14ULL ] = - 1.0 ; t6 [ 15ULL ] = t184 / 100000.0 ; t6 [ 16ULL ]
= t183 / 100000.0 ; t6 [ 17ULL ] = - 1.0 ; t6 [ 18ULL ] = - 1.0 ; t6 [ 19ULL
] = t184 / 100000.0 ; t6 [ 20ULL ] = - 1.0 ; t6 [ 21ULL ] = - 1.0 ; t6 [
22ULL ] = t184 / 100000.0 ; t6 [ 23ULL ] = t183 / 100000.0 ; t6 [ 24ULL ] = -
1.0 ; t6 [ 25ULL ] = - 1.0 ; t6 [ 26ULL ] = - 1.0 ; t6 [ 27ULL ] = - 1.0 ; t6
[ 28ULL ] = - 1.0 ; t6 [ 29ULL ] = - 1.0 ; t6 [ 30ULL ] = - 1.0 ; t6 [ 31ULL
] = - 1.0 ; t6 [ 32ULL ] = - 1.0 ; t6 [ 33ULL ] = - 1.0 ; t6 [ 34ULL ] = -
1.0 ; t6 [ 35ULL ] = - 1.0 ; t6 [ 36ULL ] = t184 / 100000.0 ; t6 [ 37ULL ] =
- 1.0 ; t6 [ 38ULL ] = 1.0 ; t6 [ 39ULL ] = 1.0 ; t6 [ 40ULL ] = - 1.0 ; t6 [
41ULL ] = - 1.0 ; t6 [ 42ULL ] = - 1.0 ; t6 [ 43ULL ] = - 1.0 ; t6 [ 44ULL ]
= 1.0 ; t6 [ 45ULL ] = - 1.0 ; t6 [ 46ULL ] = 3.5 ; t6 [ 47ULL ] = - 1.0 ; t6
[ 48ULL ] = 1.0 ; t6 [ 49ULL ] = 1.0 ; t6 [ 50ULL ] = 1.0 ; t6 [ 51ULL ] = -
1.0 ; t6 [ 52ULL ] = 1.0 ; t6 [ 53ULL ] = 1.0 ; t6 [ 54ULL ] = 1.0 ; t6 [
55ULL ] = 1.0 ; t6 [ 56ULL ] = 1.0 ; t6 [ 57ULL ] = 1.0 ; t6 [ 58ULL ] = 1.0
; for ( t83 = 0ULL ; t83 < 5ULL ; t83 ++ ) { t6 [ t83 + 59ULL ] = t22 [ t83 ]
; } t6 [ 64ULL ] = 1.0 ; t6 [ 65ULL ] = - 1.0 ; t6 [ 66ULL ] = 1.0 ; t6 [
67ULL ] = 1.0 ; t6 [ 68ULL ] = - 1.0 ; t6 [ 69ULL ] = - 1.0 ; t6 [ 70ULL ] =
1.0 ; t6 [ 71ULL ] = 1.0 ; t6 [ 72ULL ] = - 1.0 ; t183 = intermediate_der21 [
0ULL ] - t1 [ 0ULL ] ; t6 [ 73ULL ] = t183 / 100000.0 ; t184 =
intermediate_der18 [ 0ULL ] - t2 [ 0ULL ] ; t6 [ 74ULL ] = t184 / 100000.0 ;
t194 = intermediate_der20 [ 0ULL ] - t3 [ 0ULL ] ; t6 [ 75ULL ] = t194 /
100000.0 ; t6 [ 76ULL ] = 1.0E-5 ; t6 [ 77ULL ] = t183 / 100000.0 ; t6 [
78ULL ] = t184 / 100000.0 ; t6 [ 79ULL ] = t194 / 100000.0 ; t6 [ 80ULL ] =
1.0E-5 ; t6 [ 81ULL ] = 1.0 ; t6 [ 82ULL ] = 1.0 ; t6 [ 83ULL ] = -
0.10000000000000002 ; for ( t83 = 0ULL ; t83 < 4ULL ; t83 ++ ) { t6 [ t83 +
84ULL ] = t27 [ t83 ] ; } t6 [ 88ULL ] = 1.0 ; t6 [ 89ULL ] = - 1.0 ; t6 [
90ULL ] = 1.0 ; t6 [ 91ULL ] = 1.0 ; t6 [ 92ULL ] = - 1.0 ; t6 [ 93ULL ] = -
1.0 ; t6 [ 94ULL ] = t194 / 100000.0 ; t6 [ 95ULL ] = 1.0 ; t6 [ 96ULL ] = -
1.0 ; t6 [ 97ULL ] = 1.0 ; t6 [ 98ULL ] = 1.0 ; t6 [ 99ULL ] = 1.0 ; t6 [
100ULL ] = - 1.0 ; t6 [ 101ULL ] = 1.0 ; t6 [ 102ULL ] = 1.0 ; t6 [ 103ULL ]
= 1.0 ; t6 [ 104ULL ] = - 1.0 ; t6 [ 105ULL ] = 1.0 ; t6 [ 106ULL ] = 1.0 ;
t6 [ 107ULL ] = t183 / 100000.0 ; t6 [ 108ULL ] = t184 / 100000.0 ; t6 [
109ULL ] = 1.0E-5 ; for ( t83 = 0ULL ; t83 < 4ULL ; t83 ++ ) { t6 [ t83 +
110ULL ] = t33 [ t83 ] ; } t6 [ 114ULL ] = 1.0 ; t6 [ 115ULL ] = 1.0 ; for (
t83 = 0ULL ; t83 < 4ULL ; t83 ++ ) { t6 [ t83 + 116ULL ] = t35 [ t83 ] ; } t6
[ 120ULL ] = 1.0 ; t6 [ 121ULL ] = 1.0 ; t6 [ 122ULL ] = 1.0 ; t6 [ 123ULL ]
= 1.0 ; for ( t83 = 0ULL ; t83 < 4ULL ; t83 ++ ) { t6 [ t83 + 124ULL ] = t37
[ t83 ] ; } t6 [ 128ULL ] = 1.0 ; t6 [ 129ULL ] = 1.0 ; t6 [ 130ULL ] = 1.0 ;
t6 [ 131ULL ] = 1.0 ; t6 [ 132ULL ] = 1.0 ; for ( t83 = 0ULL ; t83 < 4ULL ;
t83 ++ ) { t6 [ t83 + 133ULL ] = t40 [ t83 ] ; } t6 [ 137ULL ] = 1.0 ; t6 [
138ULL ] = 1.0 ; t6 [ 139ULL ] = 1.0 ; t6 [ 140ULL ] = 1.0 ; for ( t83 = 0ULL
; t83 < 4ULL ; t83 ++ ) { t6 [ t83 + 141ULL ] = t42 [ t83 ] ; } t6 [ 145ULL ]
= 1.0 ; t6 [ 146ULL ] = 1.0 ; t6 [ 147ULL ] = 1.0 ; t6 [ 148ULL ] = 1.0 ; t6
[ 149ULL ] = 1.0 ; for ( t83 = 0ULL ; t83 < 4ULL ; t83 ++ ) { t6 [ t83 +
150ULL ] = t45 [ t83 ] ; } t6 [ 154ULL ] = 1.0 ; t6 [ 155ULL ] = 1.0E-5 ; t6
[ 156ULL ] = - 1.0 ; t6 [ 157ULL ] = 1.0 ; t6 [ 158ULL ] = t183 / 100000.0 ;
t6 [ 159ULL ] = t184 / 100000.0 ; t6 [ 160ULL ] = t194 / 100000.0 ; t6 [
161ULL ] = - 1.0 ; t6 [ 162ULL ] = - 1.0 ; t6 [ 163ULL ] = 1.0 ; t6 [ 164ULL
] = 1.0 ; t6 [ 165ULL ] = 1.0 ; t6 [ 166ULL ] = 1.0 ; for ( b = 0 ; b < 167 ;
b ++ ) { out . mX [ b ] = t6 [ b ] ; } ( void ) LC ; ( void ) t196 ; return 0
; }
