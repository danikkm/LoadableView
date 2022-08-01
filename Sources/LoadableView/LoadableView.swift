import SwiftUI

public struct LoadableView<Entity: Sendable,
                           EmptyContent: View,
                           InProgressContent: View,
                           ErrorContent: View,
                           Content: View>: View {

    @StateObject var model: EntityLoader<Entity>

    let emptyContent: LoadableEmptyContentType<EmptyContent>
    let inProgressContent: LoadableInProgressContentType<InProgressContent>
    let errorContent: LoadableErrorContentType<ErrorContent>
    let content: (_ item: Entity) -> Content

    public var body: some View {
        LoadableEntityView(
            model: model,
            emptyContent: emptyContent,
            inProgressContent: inProgressContent,
            errorContent: errorContent,
            content: content
        )
    }
}

public extension LoadableView {
    init(
        task: EntityLoader<Entity>.AsyncTask,
        emptyContent: LoadableEmptyContentType<EmptyContent>,
        inProgressContent: LoadableInProgressContentType<InProgressContent>,
        errorContent: LoadableErrorContentType<ErrorContent>,
        @ViewBuilder content: @escaping (_ item: Entity) -> Content
    ) {
        self.init(
            model: EntityLoader(task: task),
            emptyContent: emptyContent,
            inProgressContent: inProgressContent,
            errorContent: errorContent,
            content: content
        )
    }

    init(
        task: EntityLoader<Entity>.AsyncTask,
        @ViewBuilder content: @escaping (_ item: Entity) -> Content
    ) {
        self.init(
            model: EntityLoader(task: task),
            emptyContent: .default,
            inProgressContent: .default,
            errorContent: .default,
            content: content
        )
    }

}
