import ConcurrencyExtras

public protocol SyncFunction<
	Input,
	Output
>: AsyncFunction, SyncThrowingFunction where Failure == Never {
	func run(with input: Input) -> Output
}

extension SyncFunction {
	/// Alias for using sync `run` in async contexts
	@inlinable
	public func syncRun(with input: Input) -> Output {
		return run(with: input)
	}

	@inlinable
	public func run(with input: Input) async -> Output {
		return syncRun(with: input)
	}

	@inlinable
	public func run(with input: Input) throws(Failure) -> Output {
		return run(with: input)
	}
}

public struct SyncFunc<
	Input,
	Output
>: SyncFunction {
	@usableFromInline
	internal var call: (Input) -> Output

	public init(_ call: @escaping (Input) -> Output) {
		self.call = call
	}

	@inlinable
	public init(_ f: any SyncFunction<Input, Output>) {
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

	public func uncheckedSendable() -> SendableSyncFunc<Input, Output> {
		let sendable = UncheckedSendable(self)
		return SendableSyncFunc { (input: Input) -> Output in
			sendable.value.run(with: input)
		}
	}
}
