public protocol _MainActorAsyncThrowingFunction<
	Input,
	Output,
	Failure
>: _MainActorNominalFunctionTypeMarker {
	associatedtype Failure: Error

	@MainActor
	func run(with input: Input) async throws(Failure) -> Output
}

public struct MainActorAsyncThrowingFunc<
	Input,
	Output,
	Failure: Error
>: _MainActorAsyncThrowingFunction, @MainActor AsyncThrowingFunction, Sendable {
	@usableFromInline
	internal var call: @MainActor (Input) async throws(Failure) -> Output

	public init(_ call: @escaping @MainActor (Input) async throws(Failure) -> Output) {
		self.call = call
	}

	@MainActor
	@inlinable
	public func run(with input: Input) async throws(Failure) -> Output {
		return try await call(input)
	}

	@MainActor
	@inlinable
	public func callAsFunction(_ input: Input) async throws(Failure) -> Output {
		return try await call(input)
	}
}
