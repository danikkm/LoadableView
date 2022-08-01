import Foundation

/**
 AsyncResult represents the state of an asynchronous task and its result.

 It is similar to Swift's Result type but can also represent a 'no value' and 'work in progress' state.

 This type was created to enable a generic SwiftUI View that handles the 'no value' / 'work in progress' / 'error' states which are often very similar for many different Views. See ``LoadableResultView`` for a simple example implementation for such a view.
 */
@frozen public enum LoadableEntityPhase<Entity> {
    case empty
    case inProgress
    case success(Entity)
    case failure(Error)
}
