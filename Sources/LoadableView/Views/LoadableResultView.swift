import SwiftUI

public struct LoadableResultView<Entity: Sendable,
                                 EmptyContent: View,
                                 InProgressContent: View,
                                 ErrorContent: View,
                                 Content: View>: View {

    public let result: LoadableEntityPhase<Entity>

    public let emptyContent: LoadableEmptyContentType<EmptyContent>
    public let inProgressContent: LoadableInProgressContentType<InProgressContent>
    public let errorContent: LoadableErrorContentType<ErrorContent>
    public let content: (_ item: Entity) -> Content
    public let reloadAction: (() -> Void)?

    public init(
        result: LoadableEntityPhase<Entity>,
        emptyContent: LoadableEmptyContentType<EmptyContent>,
        inProgressContent: LoadableInProgressContentType<InProgressContent>,
        errorContent: LoadableErrorContentType<ErrorContent>,
        @ViewBuilder content: @escaping (_ item: Entity) -> Content,
        reloadAction: (() -> Void)? = nil
    ) {
        self.result = result
        self.emptyContent = emptyContent
        self.inProgressContent = inProgressContent
        self.errorContent = errorContent
        self.content = content
        self.reloadAction = reloadAction
    }

    public var body: some View {
        switch result {
        case .empty:
            emptyContent
        case .inProgress:
            inProgressContent
        case let .success(entity):
            content(entity)
        case let .failure(error):
            switch errorContent {
            case .default:
                ErrorView(error: error, reloadAction: reloadAction)
            case let .custom(content):
                content()
            }
        }
    }
}
