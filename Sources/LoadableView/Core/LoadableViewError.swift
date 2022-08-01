import Foundation

public typealias ErrorDescription = String

enum LoadableViewError: Error {
    case failedToUnwrapValue(ErrorDescription)
}

extension LoadableViewError: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case let .failedToUnwrapValue(errorDescription):
            return errorDescription
        }
    }
}
