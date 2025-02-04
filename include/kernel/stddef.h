#pragma once

/* Size type (32-bit for i686 architecture) */
typedef unsigned int size_t;
typedef signed int ssize_t;

/* Pointer difference type */
typedef signed int ptrdiff_t;

/* Null pointer constant */
#define NULL ((void*)0)

/* Offset of member in struct */
#define offsetof(type, member) __builtin_offsetof(type, member)