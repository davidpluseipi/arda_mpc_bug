#include "ne_ds.h"
#include "plant_836bb176_1_ds_sys_struct.h"
#include "plant_836bb176_1_ds_a_p.h"
#include "plant_836bb176_1_ds.h"
#include "plant_836bb176_1_ds_externals.h"
#include "plant_836bb176_1_ds_external_struct.h"
#include "ssc_ml_fun.h"
int32_T plant_836bb176_1_ds_a_p ( const NeDynamicSystem * LC , const
NeDynamicSystemInput * t1 , NeDsMethodOutput * t2 ) { static int32_T
_cg_const_2 [ 167 ] = { 19 , 20 , 15 , 19 , 34 , 15 , 20 , 114 , 120 , 15 ,
19 , 20 , 99 , 96 , 97 , 99 , 79 , 76 , 77 , 79 , 56 , 57 , 59 , 59 , 49 , 50
, 59 , 89 , 90 , 99 , 69 , 70 , 79 , 119 , 111 , 112 , 114 , 114 , 119 , 120
, 58 , 78 , 98 , 113 , 25 , 41 , 121 , 23 , 35 , 39 , 3 , 23 , 46 , 33 , 26 ,
31 , 10 , 2 , 104 , 12 , 24 , 36 , 38 , 85 , 4 , 24 , 47 , 32 , 28 , 29 , 11
, 88 , 22 , 99 , 99 , 99 , 99 , 79 , 79 , 79 , 79 , 41 , 0 , 42 , 11 , 37 ,
39 , 84 , 40 , 1 , 3 , 48 , 1 , 18 , 59 , 2 , 6 , 69 , 70 , 6 , 14 , 89 , 90
, 10 , 14 , 49 , 50 , 59 , 59 , 59 , 3 , 7 , 44 , 66 , 53 , 60 , 4 , 8 , 45 ,
67 , 61 , 54 , 62 , 63 , 7 , 15 , 64 , 108 , 7 , 20 , 68 , 73 , 80 , 8 , 16 ,
65 , 109 , 81 , 74 , 82 , 83 , 11 , 15 , 86 , 106 , 93 , 100 , 101 , 94 , 102
, 12 , 16 , 87 , 107 , 103 , 114 , 15 , 105 , 114 , 114 , 114 , 15 , 21 , 115
, 116 , 117 , 118 } ; static int32_T _cg_const_1 [ 123 ] = { 0 , 2 , 5 , 9 ,
12 , 13 , 16 , 17 , 20 , 23 , 24 , 27 , 30 , 33 , 33 , 34 , 37 , 38 , 39 , 40
, 41 , 42 , 43 , 44 , 44 , 46 , 47 , 47 , 47 , 50 , 53 , 54 , 55 , 56 , 57 ,
59 , 64 , 67 , 68 , 70 , 70 , 70 , 72 , 73 , 74 , 75 , 76 , 77 , 78 , 79 , 80
, 81 , 81 , 81 , 81 , 81 , 82 , 82 , 84 , 88 , 88 , 89 , 89 , 89 , 92 , 94 ,
95 , 97 , 97 , 97 , 97 , 98 , 98 , 99 , 101 , 101 , 101 , 101 , 102 , 102 ,
103 , 105 , 105 , 105 , 106 , 107 , 108 , 109 , 110 , 114 , 116 , 120 , 121 ,
123 , 124 , 124 , 128 , 131 , 133 , 137 , 138 , 140 , 141 , 141 , 145 , 147 ,
148 , 150 , 154 , 155 , 155 , 156 , 156 , 158 , 159 , 160 , 161 , 163 , 164 ,
165 , 166 , 167 , 167 } ; PmSparsityPattern out ; int32_T b ; ( void ) t1 ; (
void ) LC ; out = t2 -> mA_P ; out . mNumCol = 122ULL ; out . mNumRow =
122ULL ; for ( b = 0 ; b < 123 ; b ++ ) { out . mJc [ b ] = _cg_const_1 [ b ]
; } for ( b = 0 ; b < 167 ; b ++ ) { out . mIr [ b ] = _cg_const_2 [ b ] ; }
( void ) LC ; ( void ) t2 ; return 0 ; }
