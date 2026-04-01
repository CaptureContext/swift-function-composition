import ConcurrencyExtras

public protocol SyncThrowingFunction<
	Input,
	Output,
	Failure
>: AsyncThrowingFunction {
	func run(_ input: Input) throws(Failure) -> Output
}

extension SyncThrowingFunction {
	// Used to help compiler's resolver
	@usableFromInline
	func _syncThrowingRun(_ input: Input) throws(Failure) -> Output {
		return try run(input)
	}

	@inlinable
	public func run(_ input: Input) async throws(Failure) -> Output {
		return try _syncThrowingRun(input)
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
	public func run(_ input: Input) throws(Failure) -> Output {
		return try call(input)
	}

	@inlinable
	public func callAsFunction(_ input: Input) throws(Failure) -> Output {
		return try call(input)
	}

	public func uncheckedSendable() -> some SyncThrowingFunction<Input, Output, Failure> & Sendable {
		let sendable = UncheckedSendable(self)
		return SendableSyncThrowingFunc { (input: Input) throws(Failure) -> Output in
			try sendable.value.run(input)
		}
	}
}

public struct SendableSyncThrowingFunc<
	Input,
	Output,
	Failure: Error
>: SyncThrowingFunction, Sendable {
	@usableFromInline
	internal var call: @Sendable (Input) throws(Failure) -> Output

	public init(_ call: @escaping @Sendable (Input) throws(Failure) -> Output) {
		self.call = call
	}

	@inlinable
	public init(_ f: any SyncThrowingFunction<Input, Output, Failure> & Sendable) {
		self.init(f.run)
	}

	@inlinable
	public func callAsFunction(_ input: Input) throws(Failure) -> Output {
		return try call(input)
	}

	@inlinable
	public func run(_ input: Input) throws(Failure) -> Output {
		return try call(input)
	}
}

public struct MainActorSyncThrowingFunc<
	Input,
	Output,
	Failure: Error
>: @MainActor SyncThrowingFunction, Sendable {
	@usableFromInline
	internal var call: @MainActor (Input) throws(Failure) -> Output

	public init(_ call: @escaping @MainActor (Input) throws(Failure) -> Output) {
		self.call = call
	}

	@MainActor
	@inlinable
	public func run(_ input: Input) throws(Failure) -> Output {
		return try call(input)
	}

	@MainActor
	@inlinable
	public func callAsFunction(_ input: Input) async throws(Failure) -> Output {
		return try call(input)
	}
}
