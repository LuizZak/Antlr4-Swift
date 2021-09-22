#if os(Windows)

import Foundation
import WinSDK

///
/// Using class so it can be shared even if
/// it appears to be a field in a class.
///
class Mutex {

    ///
    /// The mutex instance.
    ///
    private var section = CRITICAL_SECTION()

    ///
    /// Initialization
    ///
    init() {
        InitializeCriticalSection(&section)
    }
    
    deinit {
        // free the mutex resource
        DeleteCriticalSection(&section)
    }

    ///
    /// Running the supplied closure synchronously.
    ///
    /// - Parameter closure: the closure to run
    /// - Returns: the value returned by the closure
    /// - Throws: the exception populated by the closure run
    ///
    @discardableResult
    func synchronized<R>(closure: () throws -> R) rethrows -> R {
        EnterCriticalSection(&section)
        defer {
            LeaveCriticalSection(&section)
        }
        return try closure()
    }
}

#endif
