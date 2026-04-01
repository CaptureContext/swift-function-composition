import ConcurrencyExtras

public protocol SyncFunction<
	Input,
	Output
>: AsyncFunction, SyncThrowingFunction where Failure == Never {
	func run(_ input: Input) -> Output
}

extension SyncFunction {
	@usableFromInline
	func _syncRun(_ input: Input) -> Output {
		return run(input)
	}

	public func run(_ input: Input) async -> Output {
		return _syncRun(input)
	}

	public func run(_ input: Input) throws(Failure) -> Output {
		return run(input)
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
	public func run(_ input: Input) -> Output {
		return call(input)
	}

	@inlinable
	public func callAsFunction(_ input: Input) -> Output {
		return call(input)
	}

	public func uncheckedSendable() -> some SyncFunction<Input, Output> & Sendable {
		let sendable = UncheckedSendable(self)
		return SendableSyncFunc { (input: Input) -> Output in
			sendable.value.run(input)
		}
	}
}

public struct SendableSyncFunc<
	Input,
	Output
>: SyncFunction, Sendable {
	@usableFromInline
	internal var call: @Sendable (Input) -> Output

	public init(_ call: @escaping @Sendable (Input) -> Output) {
		self.call = call
	}

	@inlinable
	public init(_ f: any SyncFunction<Input, Output> & Sendable) {
		self.init(f.run)
	}

	@inlinable
	public func run(_ input: Input) -> Output {
		return call(input)
	}

	@inlinable
	public func callAsFunction(_ input: Input) -> Output {
		return call(input)
	}
}

public struct MainActorSyncFunc<
	Input,
	Output
>: @MainActor SyncFunction, Sendable {
	@usableFromInline
	internal var call: @MainActor (Input) -> Output

	public init(_ call: @escaping @MainActor (Input) -> Output) {
		self.call = call
	}

	@MainActor
	@inlinable
	public func run(_ input: Input) -> Output {
		return call(input)
	}

	@MainActor
	@inlinable
	public func callAsFunction(_ input: Input) -> Output {
		return call(input)
	}
}
