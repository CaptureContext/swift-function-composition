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
	public func run(with input: Input) async -> Output {
		return await call(input)
	}

	@inlinable
	public func callAsFunction(_ input: Input) async -> Output {
		return await call(input)
	}
}
