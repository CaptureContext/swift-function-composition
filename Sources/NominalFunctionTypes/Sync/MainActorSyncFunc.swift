public protocol _MainActorSyncFunction<
	Input,
	Output
>: _MainActorAsyncFunction, _MainActorSyncThrowingFunction where Failure == Never {
	@MainActor
	func run(with input: Input) -> Output
}

public struct MainActorSyncFunc<
	Input,
	Output
>: _MainActorSyncFunction, @MainActor SyncFunction, Sendable {
	@usableFromInline
	internal var call: @MainActor (Input) -> Output

	public init(_ call: @escaping @MainActor (Input) -> Output) {
		self.call = call
	}

	@inlinable
	public init(_ f: any _MainActorSyncFunction<Input, Output> & Sendable) {
		self.init(f.run)
	}

	@MainActor
	@inlinable
	public func run(with input: Input) -> Output {
		return call(input)
	}

	@MainActor
	@inlinable
	public func callAsFunction(_ input: Input) -> Output {
		return call(input)
	}
}

extension MainActorSyncFunc where Input == Void {
	@MainActor
	@inlinable
	public func callAsFunction() -> Output {
		return call(())
	}
}
