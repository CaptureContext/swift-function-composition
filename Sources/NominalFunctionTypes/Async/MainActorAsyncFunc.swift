public protocol _MainActorAsyncFunction<
	Input,
	Output
>: _MainActorAsyncThrowingFunction where Failure == Never {

	@MainActor
	func run(with input: Input) async throws(Failure) -> Output
}

public struct MainActorAsyncFunc<
	Input,
	Output,
>: _MainActorAsyncFunction, @MainActor AsyncFunction, Sendable {
	@usableFromInline
	internal var call: @MainActor (Input) async -> Output

	public init(_ call: @escaping @MainActor (Input) async -> Output) {
		self.call = call
	}

	@inlinable
	public init(_ f: any _MainActorAsyncFunction<Input, Output> & Sendable) {
		self.init(f.run)
	}

	@MainActor
	@inlinable
	public func run(with input: Input) async -> Output {
		await call(input)
	}

	@MainActor
	@inlinable
	public func callAsFunction(_ input: Input) async -> Output {
		return await call(input)
	}
}

extension MainActorAsyncFunc where Input == Void {
	@MainActor
	@inlinable
	public func callAsFunction() async -> Output {
		return await call(())
	}
}
