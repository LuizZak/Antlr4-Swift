#ifndef _CANTLR_SHIMS_H
#define _CANTLR_SHIMS_H 1

#include <stdatomic.h>

typedef struct {
    atomic_size_t value;
} _AtomicIntStorage;

void atomic_int_init(volatile _AtomicIntStorage *value);
size_t atomic_int_inc(volatile _AtomicIntStorage *value);
size_t atomic_int_load(volatile _AtomicIntStorage *value);

#endif
