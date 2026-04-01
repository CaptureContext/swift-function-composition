import ConcurrencyExtras

public protocol AsyncFunction<
	Input,
	Output
>: AsyncThrowingFunction where Failure == Never {
	func run(_ input: Input) async throws(Failure) -> Output
}

extension AsyncFunction {
	@inlinable
	public func run(_ input: Input) async throws(Never) -> Output {
		return await run(input)
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
	public func run(_ input: Input) async -> Output {
		return await call(input)
	}

	@inlinable
	public func callAsFunction(_ input: Input) async -> Output {
		return await run(input)
	}

	public func uncheckedSendable() -> some AsyncFunction<Input, Output> & Sendable {
		let sendable = UncheckedSendable(self)
		return SendableAsyncFunc { (input: Input) async -> Output in
			await sendable.value.run(input)
		}
	}
}

public struct SendableAsyncFunc<
	Input,
	Output
>: AsyncFunction, Sendable {
	@usableFromInline
	internal var call: @Sendable (Input) async -> Output

	public init(_ call: @escaping @Sendable (Input) async -> Output) {
		self.call = call
	}

	@inlinable
	public init(_ f: any AsyncFunction<Input, Output> & Sendable) {
		self.init(f.run)
	}

	@inlinable
	public func run(_ input: Input) async -> Output {
		return await call(input)
	}
}

public struct MainActorAsyncFunc<
	Input,
	Output,
>: @MainActor AsyncFunction, Sendable {
	@usableFromInline
	internal var call: @MainActor (Input) async -> Output

	public init(_ call: @escaping @MainActor (Input) async -> Output) {
		self.call = call
	}

	@MainActor
	@inlinable
	public func run(_ input: Input) async -> Output {
		await call(input)
	}

	@MainActor
	@inlinable
	public func callAsFunction(_ input: Input) async -> Output {
		return await call(input)
	}
}
