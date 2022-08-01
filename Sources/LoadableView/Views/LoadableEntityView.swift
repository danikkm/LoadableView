import SwiftUI

public struct LoadableEntityView<Entity: Sendable,
                                 EmptyContent: View,
                                 InProgressContent: View,
                                 ErrorContent: View,
                                 Content: View>: View {

    @StateObject public var model: EntityLoader<Entity>

    public let emptyContent: LoadableEmptyContentType<EmptyContent>
    public let inProgressContent: LoadableInProgressContentType<InProgressContent>
    public let errorContent: LoadableErrorContentType<ErrorContent>
    public let content: (_ item: Entity) -> Content

    init(
        model: EntityLoader<Entity>,
        emptyContent: LoadableEmptyContentType<EmptyContent>,
        inProgressContent: LoadableInProgressContentType<InProgressContent>,
        errorContent: LoadableErrorContentType<ErrorContent>,
        @ViewBuilder content: @escaping (_ item: Entity) -> Content
    ) {
        _model = .init(wrappedValue: model)
        self.emptyContent = emptyContent
        self.inProgressContent = inProgressContent
        self.errorContent = errorContent
        self.content = content
    }

    init(
        model: EntityLoader<Entity>,
        @ViewBuilder content: @escaping (_ item: Entity) -> Content
    ) {
        _model = .init(wrappedValue: model)
        self.emptyContent = .default
        self.inProgressContent = .default
        self.errorContent = .default
        self.content = content
    }

    public var body: some View {
        LoadableResultView(
            result: model.result,
            emptyContent: emptyContent,
            inProgressContent: inProgressContent,
            errorContent: errorContent,
            content: content,
            reloadAction: { Task { await model.load() } }
        )
        .task {
            await model.loadIfNeeded()
        }
    }
}
