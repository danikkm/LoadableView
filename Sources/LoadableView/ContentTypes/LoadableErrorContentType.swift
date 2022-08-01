import SwiftUI

@frozen
public enum LoadableErrorContentType<ErrorContent: View> {
    case `default`
    case custom(() -> ErrorContent)
}
