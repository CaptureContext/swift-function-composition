import ConcurrencyExtras

public protocol AsyncThrowingFunction<
	Input,
	Output,
	Failure
>: _NominalFunctionType {
	associatedtype Failure: Error

	func run(with input: Input) async throws(Failure) -> Output
}

extension AsyncThrowingFunction {
	func run(
		isolation: (any Actor)? = #isolation,
		with input: Input
	) async throws(Failure) -> Output {
		try await self.run(with: input)
	}
}

public struct AsyncThrowingFunc<
	Input,
	Output,
	Failure: Error
>: AsyncThrowingFunction {
	@usableFromInline
	internal var call: (Input) async throws(Failure) -> Output

	public init(_ call: @escaping (Input) async throws(Failure) -> Output) {
		self.call = call
	}

	@inlinable
	public init(_ f: any AsyncThrowingFunction<Input, Output, Failure>) {
		self.init(f.run)
	}

	@inlinable
	public func run(with input: Input) async throws(Failure) -> Output {
		return try await call(input)
	}

	@inlinable
	public func callAsFunction(_ input: Input) async throws(Failure) -> Output {
		return try await call(input)
	}

	public func uncheckedSendable() -> SendableAsyncThrowingFunc<Input, Output, Failure> {
		let sendable = UncheckedSendable(self)
		return SendableAsyncThrowingFunc { (input: Input) async throws(Failure) -> Output in
			try await sendable.value.run(with: input)
		}
	}
}
