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
	public func run(with input: Input) async throws(Failure) -> Output {
		return try await call(input)
	}

	@inlinable
	public func callAsFunction(_ input: Input) async throws(Failure) -> Output {
		return try await call(input)
	}
}
