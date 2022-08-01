import SwiftUI

@frozen
public enum LoadableEmptyContentType<EmptyContent: View>: View {

    case `default`
    case custom(() -> EmptyContent)

    public var body: some View {
        switch self {
        case .default:
            Text("")
        case let .custom(content):
            content()
        }
    }
}
