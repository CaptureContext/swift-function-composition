import NominalFunctionTypes
import Either

// MARK: - AsyncThrowing

@inlinable
public func pipe<
	F0: _MainActorAsyncThrowingFunction & Sendable,
	F1: _MainActorAsyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> MainActorAsyncThrowingFunc<F0.Input, F1.Output, Either<F0.Failure, F1.Failure>> where
	F1.Input == F0.Output
{
	MainActorAsyncThrowingFunc { (input: F0.Input) async throws(Either<F0.Failure, F1.Failure>) -> F1.Output in
		do {
			let partialResult = try await f0.run(with: input)
			do {
				return try await f1.run(with: partialResult)
			} catch {
				throw Either<F0.Failure, F1.Failure>.right(error as! F1.Failure)
			}
		} catch {
			throw Either<F0.Failure, F1.Failure>.left(error as! F0.Failure)
		}
	}
}

@inlinable
public func pipe<
	F0: _MainActorAsyncThrowingFunction & Sendable,
	F1: _MainActorAsyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> MainActorAsyncThrowingFunc<F0.Input, F1.Output, F1.Failure> where
	F1.Input == F0.Output,
	F1.Failure == F0.Failure
{
	MainActorAsyncThrowingFunc { (input: F0.Input) async throws(F0.Failure) -> F1.Output in
		do {
			let partialResult = try await f0.run(with: input)
			do {
				return try await f1.run(with: partialResult)
			} catch {
				throw error as! F1.Failure
			}
		} catch {
			throw error as! F0.Failure
		}
	}
}

@inlinable
public func pipe<
	F0: _MainActorAsyncThrowingFunction & Sendable,
	F1: AsyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> MainActorAsyncThrowingFunc<F0.Input, F1.Output, Either<F0.Failure, F1.Failure>> where
	F1.Input == F0.Output,
	F1.Input: Sendable
{
	MainActorAsyncThrowingFunc { (input: F0.Input) async throws(Either<F0.Failure, F1.Failure>) -> F1.Output in
		do {
			let partialResult = try await f0.run(with: input)
			do {
				return try await f1.run(with: partialResult)
			} catch {
				throw Either<F0.Failure, F1.Failure>.right(error as! F1.Failure)
			}
		} catch {
			throw Either<F0.Failure, F1.Failure>.left(error as! F0.Failure)
		}
	}
}

@inlinable
public func pipe<
	F0: AsyncThrowingFunction & Sendable,
	F1: _MainActorAsyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> MainActorAsyncThrowingFunc<F0.Input, F1.Output, F1.Failure> where
	F1.Input == F0.Output,
	F1.Failure == F0.Failure,
	F0.Input: Sendable
{
	MainActorAsyncThrowingFunc { (input: F0.Input) async throws(F0.Failure) -> F1.Output in
		do {
			let partialResult = try await f0.run(with: input)
			do {
				return try await f1.run(with: partialResult)
			} catch {
				throw error as! F1.Failure
			}
		} catch {
			throw error as! F0.Failure
		}
	}
}

// MARK: VariadicOverloads

@_disfavoredOverload
@inlinable
public func pipe<
	F0: _MainActorAsyncThrowingFunction & Sendable,
	F1: _MainActorAsyncThrowingFunction & Sendable,
	F2: _MainActorAsyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2
) -> MainActorAsyncThrowingFunc<F0.Input, F2.Output, Either<Either<F0.Failure, F1.Failure>, F2.Failure>> where
	F1.Input == F0.Output,
	F2.Input == F1.Output
{
	pipe(pipe(f0, f1), f2)
}


@_disfavoredOverload
@inlinable
public func pipe<
	F0: _MainActorAsyncThrowingFunction & Sendable,
	F1: _MainActorAsyncThrowingFunction & Sendable,
	F2: _MainActorAsyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2
) -> MainActorAsyncThrowingFunc<F0.Input, F2.Output, F2.Failure> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F1.Failure == F0.Failure,
	F2.Failure == F0.Failure
{
	pipe(pipe(f0, f1), f2)
}


@_disfavoredOverload
@inlinable
public func pipe<
	F0: _MainActorAsyncThrowingFunction & Sendable,
	F1: _MainActorAsyncThrowingFunction & Sendable,
	F2: _MainActorAsyncThrowingFunction & Sendable,
	F3: _MainActorAsyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2,
	_ f3: F3
) -> MainActorAsyncThrowingFunc<F0.Input, F3.Output, Either<Either<F0.Failure, F1.Failure>, Either<F2.Failure, F3.Failure>>> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F3.Input == F2.Output
{
	pipe(pipe(f0, f1), pipe(f2, f3))
}


@_disfavoredOverload
@inlinable
public func pipe<
	F0: _MainActorAsyncThrowingFunction & Sendable,
	F1: _MainActorAsyncThrowingFunction & Sendable,
	F2: _MainActorAsyncThrowingFunction & Sendable,
	F3: _MainActorAsyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2,
	_ f3: F3
) -> MainActorAsyncThrowingFunc<F0.Input, F3.Output, F3.Failure> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F3.Input == F2.Output,
	F1.Failure == F0.Failure,
	F2.Failure == F0.Failure,
	F3.Failure == F0.Failure
{
	pipe(pipe(f0, f1), pipe(f2, f3))
}

// MARK: - SyncThrowing

@inlinable
public func pipe<
	F0: _MainActorSyncThrowingFunction & Sendable,
	F1: _MainActorSyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> MainActorSyncThrowingFunc<F0.Input, F1.Output, Either<F0.Failure, F1.Failure>> where
	F1.Input == F0.Output
{
	MainActorSyncThrowingFunc { (input: F0.Input) throws(Either<F0.Failure, F1.Failure>) -> F1.Output in
		do {
			let partialResult = try f0.run(with: input)
			do {
				return try f1.run(with: partialResult)
			} catch {
				throw Either<F0.Failure, F1.Failure>.right(error as! F1.Failure)
			}
		} catch {
			throw Either<F0.Failure, F1.Failure>.left(error as! F0.Failure)
		}
	}
}

@inlinable
public func pipe<
	F0: _MainActorSyncThrowingFunction & Sendable,
	F1: _MainActorSyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> MainActorSyncThrowingFunc<F0.Input, F1.Output, F1.Failure> where
	F1.Input == F0.Output,
	F1.Failure == F0.Failure
{
	MainActorSyncThrowingFunc { (input: F0.Input) throws(F0.Failure) -> F1.Output in
		do {
			let partialResult = try f0.run(with: input)
			do {
				return try f1.run(with: partialResult)
			} catch {
				throw error as! F1.Failure
			}
		} catch {
			throw error as! F0.Failure
		}
	}
}

@inlinable
public func pipe<
	F0: _MainActorSyncThrowingFunction & Sendable,
	F1: SyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> MainActorSyncThrowingFunc<F0.Input, F1.Output, Either<F0.Failure, F1.Failure>> where
	F1.Input == F0.Output,
	F1.Input: Sendable
{
	MainActorSyncThrowingFunc { (input: F0.Input) throws(Either<F0.Failure, F1.Failure>) -> F1.Output in
		do {
			let partialResult = try f0.run(with: input)
			do {
				return try f1.run(with: partialResult)
			} catch {
				throw Either<F0.Failure, F1.Failure>.right(error as! F1.Failure)
			}
		} catch {
			throw Either<F0.Failure, F1.Failure>.left(error as! F0.Failure)
		}
	}
}

@inlinable
public func pipe<
	F0: SyncThrowingFunction & Sendable,
	F1: _MainActorSyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> MainActorSyncThrowingFunc<F0.Input, F1.Output, F1.Failure> where
	F1.Input == F0.Output,
	F1.Failure == F0.Failure,
	F0.Input: Sendable
{
	MainActorSyncThrowingFunc { (input: F0.Input) throws(F0.Failure) -> F1.Output in
		do {
			let partialResult = try f0.run(with: input)
			do {
				return try f1.run(with: partialResult)
			} catch {
				throw error as! F1.Failure
			}
		} catch {
			throw error as! F0.Failure
		}
	}
}

// MARK: VariadicOverloads

@_disfavoredOverload
@inlinable
public func pipe<
	F0: _MainActorSyncThrowingFunction & Sendable,
	F1: _MainActorSyncThrowingFunction & Sendable,
	F2: _MainActorSyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2
) -> MainActorSyncThrowingFunc<F0.Input, F2.Output, Either<Either<F0.Failure, F1.Failure>, F2.Failure>> where
	F1.Input == F0.Output,
	F2.Input == F1.Output
{
	pipe(pipe(f0, f1), f2)
}


@_disfavoredOverload
@inlinable
public func pipe<
	F0: _MainActorSyncThrowingFunction & Sendable,
	F1: _MainActorSyncThrowingFunction & Sendable,
	F2: _MainActorSyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2
) -> MainActorSyncThrowingFunc<F0.Input, F2.Output, F2.Failure> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F1.Failure == F0.Failure,
	F2.Failure == F0.Failure
{
	pipe(pipe(f0, f1), f2)
}


@_disfavoredOverload
@inlinable
public func pipe<
	F0: _MainActorSyncThrowingFunction & Sendable,
	F1: _MainActorSyncThrowingFunction & Sendable,
	F2: _MainActorSyncThrowingFunction & Sendable,
	F3: _MainActorSyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2,
	_ f3: F3
) -> MainActorSyncThrowingFunc<F0.Input, F3.Output, Either<Either<F0.Failure, F1.Failure>, Either<F2.Failure, F3.Failure>>> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F3.Input == F2.Output
{
	pipe(pipe(f0, f1), pipe(f2, f3))
}


@_disfavoredOverload
@inlinable
public func pipe<
	F0: _MainActorSyncThrowingFunction & Sendable,
	F1: _MainActorSyncThrowingFunction & Sendable,
	F2: _MainActorSyncThrowingFunction & Sendable,
	F3: _MainActorSyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2,
	_ f3: F3
) -> MainActorSyncThrowingFunc<F0.Input, F3.Output, F3.Failure> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F3.Input == F2.Output,
	F1.Failure == F0.Failure,
	F2.Failure == F0.Failure,
	F3.Failure == F0.Failure
{
	pipe(pipe(f0, f1), pipe(f2, f3))
}

// MARK: - Async

@inlinable
public func pipe<
	F0: _MainActorAsyncFunction & Sendable,
	F1: _MainActorAsyncFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> MainActorAsyncFunc<F0.Input, F1.Output> where
	F1.Input == F0.Output
{
	MainActorAsyncFunc { (input: F0.Input) async -> F1.Output in
		await f1.run(with:f0.run(with: input))
	}
}

@inlinable
public func pipe<
	F0: _MainActorAsyncFunction & Sendable,
	F1: AsyncFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> MainActorAsyncFunc<F0.Input, F1.Output> where
	F1.Input == F0.Output,
	F0.Input: Sendable
{
	MainActorAsyncFunc { (input: F0.Input) async -> F1.Output in
		await f1.run(with:f0.run(with: input))
	}
}

@inlinable
public func pipe<
	F0: AsyncFunction & Sendable,
	F1: _MainActorAsyncFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> MainActorAsyncFunc<F0.Input, F1.Output> where
	F1.Input == F0.Output,
	F0.Input: Sendable
{
	MainActorAsyncFunc { (input: F0.Input) async -> F1.Output in
		await f1.run(with: f0.run(with: input))
	}
}

// MARK: VariadicOverloads

@_disfavoredOverload
@inlinable
public func pipe<
	F0: _MainActorAsyncFunction & Sendable,
	F1: _MainActorAsyncFunction & Sendable,
	F2: _MainActorAsyncFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2
) -> MainActorAsyncFunc<F0.Input, F2.Output> where
	F1.Input == F0.Output,
	F2.Input == F1.Output
{
	MainActorAsyncFunc { (input: F0.Input) async -> F2.Output in
		await f2.run(with: f1.run(with: f0.run(with: input)))
	}
}

@_disfavoredOverload
@inlinable
public func pipe<
	F0: _MainActorAsyncFunction & Sendable,
	F1: _MainActorAsyncFunction & Sendable,
	F2: _MainActorAsyncFunction & Sendable,
	F3: _MainActorAsyncFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2,
	_ f3: F3
) -> MainActorAsyncFunc<F0.Input, F3.Output> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F3.Input == F2.Output
{
	MainActorAsyncFunc { (input: F0.Input) async -> F3.Output in
		await f3.run(with: f2.run(with: f1.run(with: f0.run(with: input))))
	}
}

// MARK: - Sync

@inlinable
public func pipe<
	F0: _MainActorSyncFunction & Sendable,
	F1: _MainActorSyncFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> MainActorSyncFunc<F0.Input, F1.Output> where
	F1.Input == F0.Output
{
	MainActorSyncFunc { (input: F0.Input) -> F1.Output in
		f1.run(with:f0.run(with: input))
	}
}

@inlinable
public func pipe<
	F0: _MainActorSyncFunction & Sendable,
	F1: SyncFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> MainActorSyncFunc<F0.Input, F1.Output> where
	F1.Input == F0.Output,
	F0.Input: Sendable
{
	MainActorSyncFunc { (input: F0.Input) -> F1.Output in
		f1.run(with:f0.run(with: input))
	}
}

@inlinable
public func pipe<
	F0: SyncFunction & Sendable,
	F1: _MainActorSyncFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> MainActorSyncFunc<F0.Input, F1.Output> where
	F1.Input == F0.Output,
	F0.Input: Sendable
{
	MainActorSyncFunc { (input: F0.Input) -> F1.Output in
		f1.run(with: f0.run(with: input))
	}
}

// MARK: VariadicOverloads

@_disfavoredOverload
@inlinable
public func pipe<
	F0: _MainActorSyncFunction & Sendable,
	F1: _MainActorSyncFunction & Sendable,
	F2: _MainActorSyncFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2
) -> MainActorSyncFunc<F0.Input, F2.Output> where
	F1.Input == F0.Output,
	F2.Input == F1.Output
{
	MainActorSyncFunc { (input: F0.Input) -> F2.Output in
		f2.run(with: f1.run(with: f0.run(with: input)))
	}
}

@_disfavoredOverload
@inlinable
public func pipe<
	F0: _MainActorSyncFunction & Sendable,
	F1: _MainActorSyncFunction & Sendable,
	F2: _MainActorSyncFunction & Sendable,
	F3: _MainActorSyncFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2,
	_ f3: F3
) -> MainActorSyncFunc<F0.Input, F3.Output> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F3.Input == F2.Output
{
	MainActorSyncFunc { (input: F0.Input) -> F3.Output in
		f3.run(with: f2.run(with: f1.run(with: f0.run(with: input))))
	}
}
