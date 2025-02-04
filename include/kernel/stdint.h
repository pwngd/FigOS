#pragma once

/* Fixed-width unsigned types */
typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;

/* Fixed-width signed types */
typedef signed char int8_t;
typedef signed short int16_t;
typedef signed int int32_t;
typedef signed long long int64_t;

/* Fast minimum-width types */
typedef int32_t int_fast16_t;
typedef int32_t int_fast32_t;
typedef uint32_t uint_fast16_t;
typedef uint32_t uint_fast32_t;

/* Pointer-sized types */
typedef int32_t intptr_t;
typedef uint32_t uintptr_t;

/* Limits */
#define INT8_MIN   (-0x7F-1)
#define INT16_MIN  (-0x7FFF-1)
#define INT32_MIN  (-0x7FFFFFFF-1)
#define INT64_MIN  (-0x7FFFFFFFFFFFFFFFLL-1)

#define INT8_MAX   0x7F
#define INT16_MAX  0x7FFF
#define INT32_MAX  0x7FFFFFFF
#define INT64_MAX  0x7FFFFFFFFFFFFFFFLL

#define UINT8_MAX  0xFF
#define UINT16_MAX 0xFFFF
#define UINT32_MAX 0xFFFFFFFFU
#define UINT64_MAX 0xFFFFFFFFFFFFFFFFULL