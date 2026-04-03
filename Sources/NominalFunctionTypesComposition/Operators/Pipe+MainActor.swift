import NominalFunctionTypes
import FunctionCompositionOperators

@inlinable
public func >>> <
	A: _MainActorAsyncThrowingFunction & Sendable,
	B: _MainActorAsyncThrowingFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorAsyncThrowingFunc<B.Input, A.Output, Either<B.Failure, A.Failure>> where
	A.Input == B.Output,
	B.Input: Sendable
{
	MainActorAsyncThrowingFunc { (input: B.Input) async throws(Either<B.Failure, A.Failure>) -> A.Output in
		do {
			let partialResult = try await b.run(with: input)
			do {
				return try await a.run(with: partialResult)
			} catch {
				throw Either<B.Failure, A.Failure>.right(error as! A.Failure)
			}
		} catch {
			throw Either<B.Failure, A.Failure>.left(error as! B.Failure)
		}
	}
}

@inlinable
public func >>> <
	A: _MainActorAsyncThrowingFunction & Sendable,
	B: AsyncThrowingFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorAsyncThrowingFunc<B.Input, A.Output, Either<B.Failure, A.Failure>> where
	A.Input == B.Output,
	B.Input: Sendable
{
	MainActorAsyncThrowingFunc { (input: B.Input) async throws(Either<B.Failure, A.Failure>) -> A.Output in
		do {
			let partialResult = try await b.run(with: input)
			do {
				return try await a.run(with: partialResult)
			} catch {
				throw Either<B.Failure, A.Failure>.right(error as! A.Failure)
			}
		} catch {
			throw Either<B.Failure, A.Failure>.left(error as! B.Failure)
		}
	}
}

@inlinable
public func >>> <
	A: AsyncThrowingFunction & Sendable,
	B: _MainActorAsyncThrowingFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorAsyncThrowingFunc<B.Input, A.Output, Either<B.Failure, A.Failure>> where
	A.Input == B.Output,
	B.Input: Sendable
{
	MainActorAsyncThrowingFunc { (input: B.Input) async throws(Either<B.Failure, A.Failure>) -> A.Output in
		do {
			let partialResult = try await b.run(with: input)
			do {
				return try await a.run(with: partialResult)
			} catch {
				throw Either<B.Failure, A.Failure>.right(error as! A.Failure)
			}
		} catch {
			throw Either<B.Failure, A.Failure>.left(error as! B.Failure)
		}
	}
}

@inlinable
public func >>> <
	A: _MainActorAsyncThrowingFunction & Sendable,
	B: _MainActorAsyncThrowingFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorAsyncThrowingFunc<B.Input, A.Output, A.Failure> where
	A.Input == B.Output,
	A.Failure == B.Failure,
	B.Input: Sendable
{
	MainActorAsyncThrowingFunc { (input: B.Input) async throws(A.Failure) -> A.Output in
		do {
			let partialResult = try await b.run(with: input)
			do {
				return try await a.run(with: partialResult)
			} catch {
				throw error as! A.Failure
			}
		} catch {
			throw error as! B.Failure
		}
	}
}

@inlinable
public func >>> <
	A: _MainActorAsyncThrowingFunction & Sendable,
	B: AsyncThrowingFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorAsyncThrowingFunc<B.Input, A.Output, A.Failure> where
	A.Input == B.Output,
	A.Failure == B.Failure,
	B.Input: Sendable
{
	MainActorAsyncThrowingFunc { (input: B.Input) async throws(A.Failure) -> A.Output in
		do {
			let partialResult = try await b.run(with: input)
			do {
				return try await a.run(with: partialResult)
			} catch {
				throw error as! A.Failure
			}
		} catch {
			throw error as! B.Failure
		}
	}
}

@inlinable
public func >>> <
	A: AsyncThrowingFunction & Sendable,
	B: _MainActorAsyncThrowingFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorAsyncThrowingFunc<B.Input, A.Output, A.Failure> where
	A.Input == B.Output,
	A.Failure == B.Failure,
	B.Input: Sendable
{
	MainActorAsyncThrowingFunc { (input: B.Input) async throws(A.Failure) -> A.Output in
		do {
			let partialResult = try await b.run(with: input)
			do {
				return try await a.run(with: partialResult)
			} catch {
				throw error as! A.Failure
			}
		} catch {
			throw error as! B.Failure
		}
	}
}

@inlinable
public func >>> <
	A: _MainActorAsyncFunction & Sendable,
	B: _MainActorAsyncFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorAsyncFunc<B.Input, A.Output> where
	A.Input == B.Output,
	B.Input: Sendable
{
	MainActorAsyncFunc { (input: B.Input) async -> A.Output in
		await a.run(with: b.run(with: input))
	}
}

@inlinable
public func >>> <
	A: _MainActorAsyncFunction & Sendable,
	B: AsyncFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorAsyncFunc<B.Input, A.Output> where
	A.Input == B.Output,
	B.Input: Sendable
{
	MainActorAsyncFunc { (input: B.Input) async -> A.Output in
		await a.run(with: b.run(with: input))
	}
}

@inlinable
public func >>> <
	A: AsyncFunction & Sendable,
	B: _MainActorAsyncFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorAsyncFunc<B.Input, A.Output> where
	A.Input == B.Output,
	B.Input: Sendable
{
	MainActorAsyncFunc { (input: B.Input) async -> A.Output in
		await a.run(with: b.run(with: input))
	}
}

@inlinable
public func >>> <
	A: _MainActorSyncThrowingFunction & Sendable,
	B: _MainActorSyncThrowingFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorSyncThrowingFunc<B.Input, A.Output, Either<B.Failure, A.Failure>> where
	A.Input == B.Output,
	B.Input: Sendable
{
	MainActorSyncThrowingFunc { (input: B.Input) throws(Either<B.Failure, A.Failure>) -> A.Output in
		do {
			let partialResult = try b.run(with: input)
			do {
				return try a.run(with: partialResult)
			} catch {
				throw Either<B.Failure, A.Failure>.right(error as! A.Failure)
			}
		} catch {
			throw Either<B.Failure, A.Failure>.left(error as! B.Failure)
		}
	}
}

@inlinable
public func >>> <
	A: _MainActorSyncThrowingFunction & Sendable,
	B: SyncThrowingFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorSyncThrowingFunc<B.Input, A.Output, Either<B.Failure, A.Failure>> where
	A.Input == B.Output,
	B.Input: Sendable
{
	MainActorSyncThrowingFunc { (input: B.Input) throws(Either<B.Failure, A.Failure>) -> A.Output in
		do {
			let partialResult = try b.run(with: input)
			do {
				return try a.run(with: partialResult)
			} catch {
				throw Either<B.Failure, A.Failure>.right(error as! A.Failure)
			}
		} catch {
			throw Either<B.Failure, A.Failure>.left(error as! B.Failure)
		}
	}
}

@inlinable
public func >>> <
	A: SyncThrowingFunction & Sendable,
	B: _MainActorSyncThrowingFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorSyncThrowingFunc<B.Input, A.Output, Either<B.Failure, A.Failure>> where
	A.Input == B.Output,
	B.Input: Sendable
{
	MainActorSyncThrowingFunc { (input: B.Input) throws(Either<B.Failure, A.Failure>) -> A.Output in
		do {
			let partialResult = try b.run(with: input)
			do {
				return try a.run(with: partialResult)
			} catch {
				throw Either<B.Failure, A.Failure>.right(error as! A.Failure)
			}
		} catch {
			throw Either<B.Failure, A.Failure>.left(error as! B.Failure)
		}
	}
}

@inlinable
public func >>> <
	A: _MainActorSyncThrowingFunction & Sendable,
	B: _MainActorSyncThrowingFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorSyncThrowingFunc<B.Input, A.Output, A.Failure> where
	A.Input == B.Output,
	A.Failure == B.Failure,
	B.Input: Sendable
{
	MainActorSyncThrowingFunc { (input: B.Input) throws(A.Failure) -> A.Output in
		do {
			let partialResult = try b.run(with: input)
			do {
				return try a.run(with: partialResult)
			} catch {
				throw error as! A.Failure
			}
		} catch {
			throw error as! B.Failure
		}
	}
}

@inlinable
public func >>> <
	A: _MainActorSyncThrowingFunction & Sendable,
	B: SyncThrowingFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorSyncThrowingFunc<B.Input, A.Output, A.Failure> where
	A.Input == B.Output,
	A.Failure == B.Failure,
	B.Input: Sendable
{
	MainActorSyncThrowingFunc { (input: B.Input) throws(A.Failure) -> A.Output in
		do {
			let partialResult = try b.run(with: input)
			do {
				return try a.run(with: partialResult)
			} catch {
				throw error as! A.Failure
			}
		} catch {
			throw error as! B.Failure
		}
	}
}

@inlinable
public func >>> <
	A: SyncThrowingFunction & Sendable,
	B: _MainActorSyncThrowingFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorSyncThrowingFunc<B.Input, A.Output, A.Failure> where
	A.Input == B.Output,
	A.Failure == B.Failure,
	B.Input: Sendable
{
	MainActorSyncThrowingFunc { (input: B.Input) throws(A.Failure) -> A.Output in
		do {
			let partialResult = try b.run(with: input)
			do {
				return try a.run(with: partialResult)
			} catch {
				throw error as! A.Failure
			}
		} catch {
			throw error as! B.Failure
		}
	}
}

@inlinable
public func >>> <
	A: _MainActorSyncFunction & Sendable,
	B: _MainActorSyncFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorSyncFunc<B.Input, A.Output> where
	A.Input == B.Output,
	B.Input: Sendable
{
	MainActorSyncFunc { (input: B.Input) -> A.Output in
		a.run(with: b.run(with: input))
	}
}

@inlinable
public func >>> <
	A: _MainActorSyncFunction & Sendable,
	B: SyncFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorSyncFunc<B.Input, A.Output> where
	A.Input == B.Output,
	B.Input: Sendable
{
	MainActorSyncFunc { (input: B.Input) -> A.Output in
		a.run(with: b.run(with: input))
	}
}

@inlinable
public func >>> <
	A: SyncFunction & Sendable,
	B: _MainActorSyncFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> MainActorSyncFunc<B.Input, A.Output> where
	A.Input == B.Output,
	B.Input: Sendable
{
	MainActorSyncFunc { (input: B.Input) -> A.Output in
		a.run(with: b.run(with: input))
	}
}
