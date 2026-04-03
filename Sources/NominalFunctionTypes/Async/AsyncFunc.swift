import ConcurrencyExtras

public protocol AsyncFunction<
	Input,
	Output
>: AsyncThrowingFunction where Failure == Never {
	func run(with input: Input) async throws(Failure) -> Output
}

extension AsyncFunction {
	@inlinable
	public func run(with input: Input) async throws(Never) -> Output {
		return await run(with: input)
	}
}

public struct AsyncFunc<Input, Output>: AsyncFunction {
	@usableFromInline
	internal var call: (Input) async -> Output

	public init(_ call: @escaping (Input) async -> Output) {
		self.call = call
	}

	@inlinable
	public init(_ f: any AsyncFunction<Input, Output>) {
		self.init(f.run)
	}

	@inlinable
	public func run(with input: Input) async -> Output {
		return await call(input)
	}

	@inlinable
	public func callAsFunction(_ input: Input) async -> Output {
		return await call(input)
	}

	public func uncheckedSendable() -> SendableAsyncFunc<Input, Output> {
		let sendable = UncheckedSendable(self)
		return SendableAsyncFunc { (input: Input) async -> Output in
			await sendable.value.run(with: input)
		}
	}
}
