import NominalFunctionTypes
import FunctionCompositionOperators

@inlinable
public func >>> <
	Input,
	Partial,
	Output,
	AFailure: Error,
	BFailure: Error
>(
	_ b: MainActorAsyncThrowingFunc<Input, Partial, BFailure>,
	_ a: MainActorAsyncThrowingFunc<Partial, Output, AFailure>
) -> MainActorAsyncThrowingFunc<Input, Output, Either<BFailure, AFailure>> {
	MainActorAsyncThrowingFunc { (input: Input) async throws(Either<BFailure, AFailure>) -> Output in
		do {
			let partialResult = try await b.run(input)
			do {
				return try await a.run(partialResult)
			} catch {
				throw Either<BFailure, AFailure>.right(error as! AFailure)
			}
		} catch {
			throw Either<BFailure, AFailure>.left(error as! BFailure)
		}
	}
}

@inlinable
public func >>> <
	Input,
	Partial,
	Output,
	Failure: Error
>(
	_ b: MainActorAsyncThrowingFunc<Input, Partial, Failure>,
	_ a: MainActorAsyncThrowingFunc<Partial, Output, Failure>
) -> MainActorAsyncThrowingFunc<Input, Output, Failure> {
	MainActorAsyncThrowingFunc { (input: Input) async throws(Failure) -> Output in
		do {
			let partialResult = try await b.run(input)
			do {
				return try await a.run(partialResult)
			} catch {
				throw error as! Failure
			}
		} catch {
			throw error as! Failure
		}
	}
}

@inlinable
public func >>> <
	Input,
	Partial,
	BFailure: Error,
	A: AsyncThrowingFunction & Sendable
>(
	_ b: MainActorAsyncThrowingFunc<Input, Partial, BFailure>,
	_ a: A
) -> MainActorAsyncThrowingFunc<Input, A.Output, Either<BFailure, A.Failure>>
where A.Input == Partial, Input: Sendable, Partial: Sendable {
	MainActorAsyncThrowingFunc { (input: Input) async throws(Either<BFailure, A.Failure>) -> A.Output in
		do {
			let partialResult = try await b.run(input)
			do {
				return try await a.run(partialResult)
			} catch {
				throw Either<BFailure, A.Failure>.right(error as! A.Failure)
			}
		} catch {
			throw Either<BFailure, A.Failure>.left(error as! BFailure)
		}
	}
}

@inlinable
public func >>> <
	Input,
	Partial,
	Failure: Error,
	A: AsyncThrowingFunction & Sendable
>(
	_ b: MainActorAsyncThrowingFunc<Input, Partial, Failure>,
	_ a: A
) -> MainActorAsyncThrowingFunc<Input, A.Output, Failure>
where A.Input == Partial, A.Failure == Failure, Input: Sendable, Partial: Sendable {
	MainActorAsyncThrowingFunc { (input: Input) async throws(Failure) -> A.Output in
		do {
			let partialResult = try await b.run(input)
			do {
				return try await a.run(partialResult)
			} catch {
				throw error as! Failure
			}
		} catch {
			throw error as! Failure
		}
	}
}

@inlinable
public func >>> <
	B: AsyncThrowingFunction & Sendable,
	Partial,
	Output,
	AFailure: Error
>(
	_ b: B,
	_ a: MainActorAsyncThrowingFunc<Partial, Output, AFailure>
) -> MainActorAsyncThrowingFunc<B.Input, Output, Either<B.Failure, AFailure>>
where B.Output == Partial, Partial: Sendable, B.Input: Sendable {
	MainActorAsyncThrowingFunc { (input: B.Input) async throws(Either<B.Failure, AFailure>) -> Output in
		do {
			let partialResult = try await b.run(input)
			do {
				return try await a.run(partialResult)
			} catch {
				throw Either<B.Failure, AFailure>.right(error as! AFailure)
			}
		} catch {
			throw Either<B.Failure, AFailure>.left(error as! B.Failure)
		}
	}
}

@inlinable
public func >>> <
	B: AsyncThrowingFunction & Sendable,
	Partial,
	Output,
	Failure: Error
>(
	_ b: B,
	_ a: MainActorAsyncThrowingFunc<Partial, Output, Failure>
) -> MainActorAsyncThrowingFunc<B.Input, Output, Failure>
where B.Output == Partial, B.Failure == Failure, Partial: Sendable, B.Input: Sendable {
	MainActorAsyncThrowingFunc { (input: B.Input) async throws(Failure) -> Output in
		do {
			let partialResult = try await b.run(input)
			do {
				return try await a.run(partialResult)
			} catch {
				throw error as! Failure
			}
		} catch {
			throw error as! Failure
		}
	}
}

@inlinable
public func >>> <
	Input,
	Partial,
	Output
>(
	_ b: MainActorAsyncFunc<Input, Partial>,
	_ a: MainActorAsyncFunc<Partial, Output>
) -> MainActorAsyncFunc<Input, Output> {
	MainActorAsyncFunc { (input: Input) async -> Output in
		let partialResult = await b.run(input)
		return await a.run(partialResult)
	}
}

@inlinable
public func >>> <
	Input,
	Partial,
	A: AsyncFunction & Sendable
>(
	_ b: MainActorAsyncFunc<Input, Partial>,
	_ a: A
) -> MainActorAsyncFunc<Input, A.Output>
where A.Input == Partial, Input: Sendable, Partial: Sendable {
	MainActorAsyncFunc { (input: Input) async -> A.Output in
		let partialResult = await b.run(input)
		return await a.run(partialResult)
	}
}

@inlinable
public func >>> <
	B: AsyncFunction & Sendable,
	Partial,
	Output
>(
	_ b: B,
	_ a: MainActorAsyncFunc<Partial, Output>
) -> MainActorAsyncFunc<B.Input, Output>
where B.Output == Partial, Partial: Sendable, B.Input: Sendable {
	MainActorAsyncFunc { (input: B.Input) async -> Output in
		let partialResult = await b.run(input)
		return await a.run(partialResult)
	}
}

@inlinable
public func >>> <
	Input,
	Partial,
	Output,
	AFailure: Error,
	BFailure: Error
>(
	_ b: MainActorSyncThrowingFunc<Input, Partial, BFailure>,
	_ a: MainActorSyncThrowingFunc<Partial, Output, AFailure>
) -> MainActorSyncThrowingFunc<Input, Output, Either<BFailure, AFailure>> {
	MainActorSyncThrowingFunc { (input: Input) throws(Either<BFailure, AFailure>) -> Output in
		do {
			let partialResult = try b.run(input)
			do {
				return try a.run(partialResult)
			} catch {
				throw Either<BFailure, AFailure>.right(error as! AFailure)
			}
		} catch {
			throw Either<BFailure, AFailure>.left(error as! BFailure)
		}
	}
}

@inlinable
public func >>> <
	Input,
	Partial,
	Output,
	Failure: Error
>(
	_ b: MainActorSyncThrowingFunc<Input, Partial, Failure>,
	_ a: MainActorSyncThrowingFunc<Partial, Output, Failure>
) -> MainActorSyncThrowingFunc<Input, Output, Failure> {
	MainActorSyncThrowingFunc { (input: Input) throws(Failure) -> Output in
		do {
			let partialResult = try b.run(input)
			do {
				return try a.run(partialResult)
			} catch {
				throw error as! Failure
			}
		} catch {
			throw error as! Failure
		}
	}
}

@inlinable
public func >>> <
	Input,
	Partial,
	BFailure: Error,
	A: SyncThrowingFunction & Sendable
>(
	_ b: MainActorSyncThrowingFunc<Input, Partial, BFailure>,
	_ a: A
) -> MainActorSyncThrowingFunc<Input, A.Output, Either<BFailure, A.Failure>>
where A.Input == Partial, Input: Sendable, Partial: Sendable {
	MainActorSyncThrowingFunc { (input: Input) throws(Either<BFailure, A.Failure>) -> A.Output in
		do {
			let partialResult = try b.run(input)
			do {
				return try a.run(partialResult)
			} catch {
				throw Either<BFailure, A.Failure>.right(error as! A.Failure)
			}
		} catch {
			throw Either<BFailure, A.Failure>.left(error as! BFailure)
		}
	}
}

@inlinable
public func >>> <
	Input,
	Partial,
	Failure: Error,
	A: SyncThrowingFunction & Sendable
>(
	_ b: MainActorSyncThrowingFunc<Input, Partial, Failure>,
	_ a: A
) -> MainActorSyncThrowingFunc<Input, A.Output, Failure>
where A.Input == Partial, A.Failure == Failure, Input: Sendable, Partial: Sendable {
	MainActorSyncThrowingFunc { (input: Input) throws(Failure) -> A.Output in
		do {
			let partialResult = try b.run(input)
			do {
				return try a.run(partialResult)
			} catch {
				throw error as! Failure
			}
		} catch {
			throw error as! Failure
		}
	}
}

@inlinable
public func >>> <
	B: SyncThrowingFunction & Sendable,
	Partial,
	Output,
	AFailure: Error
>(
	_ b: B,
	_ a: MainActorSyncThrowingFunc<Partial, Output, AFailure>
) -> MainActorSyncThrowingFunc<B.Input, Output, Either<B.Failure, AFailure>>
where B.Output == Partial, Partial: Sendable, B.Input: Sendable {
	MainActorSyncThrowingFunc { (input: B.Input) throws(Either<B.Failure, AFailure>) -> Output in
		do {
			let partialResult = try b.run(input)
			do {
				return try a.run(partialResult)
			} catch {
				throw Either<B.Failure, AFailure>.right(error as! AFailure)
			}
		} catch {
			throw Either<B.Failure, AFailure>.left(error as! B.Failure)
		}
	}
}

@inlinable
public func >>> <
	B: SyncThrowingFunction & Sendable,
	Partial,
	Output,
	Failure: Error
>(
	_ b: B,
	_ a: MainActorSyncThrowingFunc<Partial, Output, Failure>
) -> MainActorSyncThrowingFunc<B.Input, Output, Failure>
where B.Output == Partial, B.Failure == Failure, Partial: Sendable, B.Input: Sendable {
	MainActorSyncThrowingFunc { (input: B.Input) throws(Failure) -> Output in
		do {
			let partialResult = try b.run(input)
			do {
				return try a.run(partialResult)
			} catch {
				throw error as! Failure
			}
		} catch {
			throw error as! Failure
		}
	}
}

@inlinable
public func >>> <
	Input,
	Partial,
	Output
>(
	_ b: MainActorSyncFunc<Input, Partial>,
	_ a: MainActorSyncFunc<Partial, Output>
) -> MainActorSyncFunc<Input, Output> {
	MainActorSyncFunc { (input: Input) -> Output in
		a.run(b.run(input))
	}
}

@inlinable
public func >>> <
	Input,
	Partial,
	A: SyncFunction & Sendable
>(
	_ b: MainActorSyncFunc<Input, Partial>,
	_ a: A
) -> MainActorSyncFunc<Input, A.Output>
where A.Input == Partial, Input: Sendable, Partial: Sendable {
	MainActorSyncFunc { (input: Input) -> A.Output in
		a.run(b.run(input))
	}
}

@inlinable
public func >>> <
	B: SyncFunction & Sendable,
	Partial,
	Output
>(
	_ b: B,
	_ a: MainActorSyncFunc<Partial, Output>
) -> MainActorSyncFunc<B.Input, Output>
where B.Output == Partial, Partial: Sendable, B.Input: Sendable {
	MainActorSyncFunc { (input: B.Input) -> Output in
		a.run(b.run(input))
	}
}
