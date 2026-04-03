import ConcurrencyExtras

public protocol SyncThrowingFunction<
	Input,
	Output,
	Failure
>: AsyncThrowingFunction {
	func run(with input: Input) throws(Failure) -> Output
}

extension SyncThrowingFunction {
	/// Alias for using sync `run` in async contexts
	@inlinable
	public func syncRun(with input: Input) throws(Failure) -> Output {
		return try run(with: input)
	}

	@inlinable
	public func run(with input: Input) async throws(Failure) -> Output {
		return try syncRun(with: input)
	}
}

public struct SyncThrowingFunc<
	Input,
	Output,
	Failure: Error
>: SyncThrowingFunction {
	@usableFromInline
	internal var call: (Input) throws(Failure) -> Output

	public init(_ call: @escaping (Input) throws(Failure) -> Output) {
		self.call = call
	}

	@inlinable
	public init(_ f: any SyncThrowingFunction<Input, Output, Failure>) {
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

	public func uncheckedSendable() -> some SyncThrowingFunction<Input, Output, Failure> & Sendable {
		let sendable = UncheckedSendable(self)
		return SendableSyncThrowingFunc { (input: Input) throws(Failure) -> Output in
			try sendable.value.run(with: input)
		}
	}
}
