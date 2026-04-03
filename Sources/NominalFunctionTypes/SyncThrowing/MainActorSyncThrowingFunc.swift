public protocol _MainActorSyncThrowingFunction<
	Input,
	Output,
	Failure
>: _MainActorAsyncThrowingFunction {
	@MainActor
	func run(with input: Input) throws(Failure) -> Output
}

public struct MainActorSyncThrowingFunc<
	Input,
	Output,
	Failure: Error
>: _MainActorSyncThrowingFunction, @MainActor SyncThrowingFunction, Sendable {
	@usableFromInline
	internal var call: @MainActor (Input) throws(Failure) -> Output

	public init(_ call: @escaping @MainActor (Input) throws(Failure) -> Output) {
		self.call = call
	}

	@inlinable
	public init(_ f: any _MainActorSyncThrowingFunction<Input, Output, Failure> & Sendable) {
		self.init(f.run)
	}

	@MainActor
	@inlinable
	public func run(with input: Input) throws(Failure) -> Output {
		return try call(input)
	}

	@MainActor
	@inlinable
	public func callAsFunction(_ input: Input) async throws(Failure) -> Output {
		return try call(input)
	}
}
