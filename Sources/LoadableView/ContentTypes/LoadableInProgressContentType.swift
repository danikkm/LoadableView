import SwiftUI

@frozen
public enum LoadableInProgressContentType<EmptyContent: View>: View {

    case `default`
    case custom(() -> EmptyContent)

    public var body: some View {
        switch self {
        case .default:
            ProgressView()
        case let .custom(content):
            content()
        }
    }
}
