public struct SendableSyncFunc<
	Input,
	Output
>: SyncFunction, Sendable {
	@usableFromInline
	internal var call: @Sendable (Input) -> Output

	public init(_ call: @escaping @Sendable (Input) -> Output) {
		self.call = call
	}

	@inlinable
	public init(_ f: any SyncFunction<Input, Output> & Sendable) {
		self.init(f.run)
	}

	@inlinable
	public func run(with input: Input) -> Output {
		return call(input)
	}

	@inlinable
	public func callAsFunction(_ input: Input) -> Output {
		return call(input)
	}
}

extension SendableSyncFunc where Input: Sendable, Output: Sendable {
	@inlinable
	public func mainActor() -> MainActorSyncFunc<Input, Output> {
		MainActorSyncFunc(call)
	}
}
