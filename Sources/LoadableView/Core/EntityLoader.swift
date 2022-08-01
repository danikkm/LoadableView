import SwiftUI

open class EntityLoader<Entity: Sendable>: ObservableObject {
    
    @MainActor @Published public private(set) var result = LoadableEntityPhase<Entity>.empty

    public typealias AsyncTask = Task<Entity, Error>

    private var task: AsyncTask?

    public init(task: AsyncTask? = nil) {
        if let task = task {
            self.task = task
        }
    }

    @MainActor
    public func load() async {
        if case .inProgress = result { return }

        result = .inProgress

        do {
            guard let value = try await task?.value else {
                let error = LoadableViewError.failedToUnwrapValue(task.debugDescription)

                result = .failure(error)
                
                return
            }

            result = .success(value)
        } catch {
            result = .failure(error)
        }
    }

    @MainActor
    public func loadIfNeeded() async {
        switch result {
        case .empty, .failure:
            await load()
        case .inProgress, .success:
            break
        }
    }
}
