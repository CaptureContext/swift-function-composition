public struct SendableSyncThrowingFunc<
	Input,
	Output,
	Failure: Error
>: SyncThrowingFunction, Sendable {
	@usableFromInline
	internal var call: @Sendable (Input) throws(Failure) -> Output

	public init(_ call: @escaping @Sendable (Input) throws(Failure) -> Output) {
		self.call = call
	}

	@inlinable
	public init(_ f: any SyncThrowingFunction<Input, Output, Failure> & Sendable) {
		self.init(f.run)
	}

	@inlinable
	public func run(with input: Input) throws(Failure) -> Output {
		return try call(input)
	}

	@inlinable
	public func callAsFunction(_ input: Input) throws(Failure) -> Output {
		return try call(input)
	}
}

extension SendableSyncThrowingFunc where Input: Sendable, Output: Sendable {
	@inlinable
	public func mainActor() -> MainActorSyncThrowingFunc<Input, Output, Failure> {
		MainActorSyncThrowingFunc(call)
	}
}
