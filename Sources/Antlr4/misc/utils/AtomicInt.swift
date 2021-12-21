import CAntlrShims

final class AtomicInt {
    private var _storage: _AtomicIntStorage

    init() {
        _storage = _AtomicIntStorage()
        atomic_int_init(&_storage)
    }

    @discardableResult
    func increment() -> Int {
        atomic_int_inc(&_storage)
    }

    func load() -> Int {
        atomic_int_load(&_storage)
    }
}
