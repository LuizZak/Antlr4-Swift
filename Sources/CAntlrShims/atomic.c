#include "_CAntlrShims.h"

void atomic_int_init(volatile _AtomicIntStorage *value) {
    atomic_init(&value->value, 0);
}

size_t atomic_int_inc(volatile _AtomicIntStorage *value) {
    return atomic_fetch_add_explicit(&value->value, 1, memory_order_relaxed);
}

size_t atomic_int_load(volatile _AtomicIntStorage *value) {
    return atomic_load(&value->value);
}
