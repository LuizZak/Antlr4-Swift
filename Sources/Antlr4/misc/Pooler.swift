public protocol Poolable {
    mutating func reset()
}

public class Pooler<T: Poolable> {
    
    @usableFromInline
    final var pool: [T] = []
    
    @usableFromInline
    final func pull(_ creator: () -> T) -> T {
        if var value = pool.popLast() {
            value.reset()
            return value
        }
        
        let value = creator()
        return value
    }
    
    @usableFromInline
    final func repool(value: T) {
        var value = value
        value.reset()
        pool.append(value)
    }
}

extension Pooler where T: AnyObject {
    @inlinable
    func repool<C: RangeReplaceableCollection>(from collection: inout C) where C.Element == T {
        while !collection.isEmpty {
            var value = collection.removeFirst()
            
            if isKnownUniquelyReferenced(&value) {
                repool(value: value)
            }
        }
    }
}

extension Pooler where T: AnyObject & Hashable {
    @inlinable
    func repool(from set: inout Set<T>) {
        while !set.isEmpty {
            var value = set.removeFirst()
            
            if isKnownUniquelyReferenced(&value) {
                repool(value: value)
            }
        }
    }
}

extension Pooler where T: AnyObject & ATNConfig & Hashable {
    @inlinable
    func repool(from set: inout ATNConfigSet<T>) {
        var c = set.configs
        set.clear()
        repool(from: &c)
    }
}
