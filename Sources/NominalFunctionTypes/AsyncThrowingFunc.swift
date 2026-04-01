import ConcurrencyExtras

public protocol AsyncThrowingFunction<
	Input,
	Output,
	Failure
>: _NominalFunctionType {
	associatedtype Failure: Error

	func run(_ input: Input) async throws(Failure) -> Output
}

extension AsyncThrowingFunction {
	func run(
		isolation: (any Actor)? = #isolation,
		_ input: Input
	) async throws(Failure) -> Output {
		try await self.run(input)
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
	public func run(_ input: Input) async throws(Failure) -> Output {
		return try await call(input)
	}

	@inlinable
	public func callAsFunction(_ input: Input) async throws(Failure) -> Output {
		return try await call(input)
	}

	public func uncheckedSendable() -> some AsyncThrowingFunction<Input, Output, Failure> & Sendable {
		let sendable = UncheckedSendable(self)
		return SendableAsyncThrowingFunc { (input: Input) async throws(Failure) -> Output in
			try await sendable.value.run(input)
		}
	}
}

public struct SendableAsyncThrowingFunc<
	Input,
	Output,
	Failure: Error
>: AsyncThrowingFunction, Sendable {
	@usableFromInline
	internal var call: @Sendable (Input) async throws(Failure) -> Output

	public init(_ call: @escaping @Sendable (Input) async throws(Failure) -> Output) {
		self.call = call
	}

	@inlinable
	public init(_ f: any AsyncThrowingFunction<Input, Output, Failure> & Sendable) {
		self.init(f.run)
	}

	@inlinable
	public func run(_ input: Input) async throws(Failure) -> Output {
		return try await call(input)
	}

	@inlinable
	public func callAsFunction(_ input: Input) async throws(Failure) -> Output {
		return try await call(input)
	}
}

public struct MainActorAsyncThrowingFunc<
	Input,
	Output,
	Failure: Error
>: @MainActor AsyncThrowingFunction, Sendable {
	@usableFromInline
	internal var call: @MainActor (Input) async throws(Failure) -> Output

	public init(_ call: @escaping @MainActor (Input) async throws(Failure) -> Output) {
		self.call = call
	}

	@MainActor
	@inlinable
	public func run(_ input: Input) async throws(Failure) -> Output {
		return try await call(input)
	}

	@MainActor
	@inlinable
	public func callAsFunction(_ input: Input) async throws(Failure) -> Output {
		return try await call(input)
	}
}
