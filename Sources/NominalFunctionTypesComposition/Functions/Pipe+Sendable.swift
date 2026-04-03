import NominalFunctionTypes
import Either

// MARK: - AsyncThrowing

@_disfavoredOverload
@inlinable
public func pipe<
	F0: AsyncThrowingFunction & Sendable,
	F1: AsyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> SendableAsyncThrowingFunc<F0.Input, F1.Output, Either<F0.Failure, F1.Failure>> where
	F1.Input == F0.Output
{
	SendableAsyncThrowingFunc { (input: F0.Input) async throws(Either<F0.Failure, F1.Failure>) -> F1.Output in
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

@_disfavoredOverload
@inlinable
public func pipe<
	F0: AsyncThrowingFunction & Sendable,
	F1: AsyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> SendableAsyncThrowingFunc<F0.Input, F1.Output, F1.Failure> where
	F1.Input == F0.Output,
	F1.Failure == F0.Failure
{
	SendableAsyncThrowingFunc { (input: F0.Input) async throws(F0.Failure) -> F1.Output in
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

@_disfavoredOverload
@inlinable
public func pipe<
	F0: AsyncThrowingFunction & Sendable,
	F1: AsyncThrowingFunction & Sendable,
	F2: AsyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2
) -> SendableAsyncThrowingFunc<F0.Input, F2.Output, Either<Either<F0.Failure, F1.Failure>, F2.Failure>> where
	F1.Input == F0.Output,
	F2.Input == F1.Output
{
	pipe(pipe(f0, f1), f2)
}


@_disfavoredOverload
@inlinable
public func pipe<
	F0: AsyncThrowingFunction & Sendable,
	F1: AsyncThrowingFunction & Sendable,
	F2: AsyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2
) -> SendableAsyncThrowingFunc<F0.Input, F2.Output, F2.Failure> where
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
	F0: AsyncThrowingFunction & Sendable,
	F1: AsyncThrowingFunction & Sendable,
	F2: AsyncThrowingFunction & Sendable,
	F3: AsyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2,
	_ f3: F3
) -> SendableAsyncThrowingFunc<F0.Input, F3.Output, Either<Either<F0.Failure, F1.Failure>, Either<F2.Failure, F3.Failure>>> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F3.Input == F2.Output
{
	pipe(pipe(f0, f1), pipe(f2, f3))
}


@_disfavoredOverload
@inlinable
public func pipe<
	F0: AsyncThrowingFunction & Sendable,
	F1: AsyncThrowingFunction & Sendable,
	F2: AsyncThrowingFunction & Sendable,
	F3: AsyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2,
	_ f3: F3
) -> SendableAsyncThrowingFunc<F0.Input, F3.Output, F3.Failure> where
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

@_disfavoredOverload
@inlinable
public func pipe<
	F0: SyncThrowingFunction & Sendable,
	F1: SyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> SendableSyncThrowingFunc<F0.Input, F1.Output, Either<F0.Failure, F1.Failure>> where
	F1.Input == F0.Output
{
	SendableSyncThrowingFunc { (input: F0.Input) throws(Either<F0.Failure, F1.Failure>) -> F1.Output in
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

@_disfavoredOverload
@inlinable
public func pipe<
	F0: SyncThrowingFunction & Sendable,
	F1: SyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> SendableSyncThrowingFunc<F0.Input, F1.Output, F1.Failure> where
	F1.Input == F0.Output,
	F1.Failure == F0.Failure
{
	SendableSyncThrowingFunc { (input: F0.Input) throws(F0.Failure) -> F1.Output in
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

@_disfavoredOverload
@inlinable
public func pipe<
	F0: SyncThrowingFunction & Sendable,
	F1: SyncThrowingFunction & Sendable,
	F2: SyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2
) -> SendableSyncThrowingFunc<F0.Input, F2.Output, Either<Either<F0.Failure, F1.Failure>, F2.Failure>> where
	F1.Input == F0.Output,
	F2.Input == F1.Output
{
	pipe(pipe(f0, f1), f2)
}


@_disfavoredOverload
@inlinable
public func pipe<
	F0: SyncThrowingFunction & Sendable,
	F1: SyncThrowingFunction & Sendable,
	F2: SyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2
) -> SendableSyncThrowingFunc<F0.Input, F2.Output, F2.Failure> where
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
	F0: SyncThrowingFunction & Sendable,
	F1: SyncThrowingFunction & Sendable,
	F2: SyncThrowingFunction & Sendable,
	F3: SyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2,
	_ f3: F3
) -> SendableSyncThrowingFunc<F0.Input, F3.Output, Either<Either<F0.Failure, F1.Failure>, Either<F2.Failure, F3.Failure>>> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F3.Input == F2.Output
{
	pipe(pipe(f0, f1), pipe(f2, f3))
}


@_disfavoredOverload
@inlinable
public func pipe<
	F0: SyncThrowingFunction & Sendable,
	F1: SyncThrowingFunction & Sendable,
	F2: SyncThrowingFunction & Sendable,
	F3: SyncThrowingFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2,
	_ f3: F3
) -> SendableSyncThrowingFunc<F0.Input, F3.Output, F3.Failure> where
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

@_disfavoredOverload
@inlinable
public func pipe<
	F0: AsyncFunction & Sendable,
	F1: AsyncFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> SendableAsyncFunc<F0.Input, F1.Output> where
	F1.Input == F0.Output
{
	SendableAsyncFunc { (input: F0.Input) async -> F1.Output in
		await f1.run(with: f0.run(with: input))
	}
}

@_disfavoredOverload
@inlinable
public func pipe<
	F0: AsyncFunction & Sendable,
	F1: AsyncFunction & Sendable,
	F2: AsyncFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2,
) -> SendableAsyncFunc<F0.Input, F2.Output> where
	F1.Input == F0.Output,
	F2.Input == F1.Output
{
	SendableAsyncFunc { (input: F0.Input) async -> F2.Output in
		await f2.run(with: f1.run(with: f0.run(with: input)))
	}
}

@_disfavoredOverload
@inlinable
public func pipe<
	F0: AsyncFunction & Sendable,
	F1: AsyncFunction & Sendable,
	F2: AsyncFunction & Sendable,
	F3: AsyncFunction & Sendable,
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2,
	_ f3: F3
) -> SendableAsyncFunc<F0.Input, F3.Output> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F3.Input == F2.Output
{
	SendableAsyncFunc { (input: F0.Input) async -> F3.Output in
		await f3.run(with: f2.run(with: f1.run(with: f0.run(with: input))))
	}
}

// MARK: - Sync

@_disfavoredOverload
@inlinable
public func pipe<
	F0: SyncFunction & Sendable,
	F1: SyncFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1
) -> SendableSyncFunc<F0.Input, F1.Output> where
	F1.Input == F0.Output
{
	SendableSyncFunc { (input: F0.Input) -> F1.Output in
		f1.run(with: f0.run(with: input))
	}
}

@_disfavoredOverload
@inlinable
public func pipe<
	F0: SyncFunction & Sendable,
	F1: SyncFunction & Sendable,
	F2: SyncFunction & Sendable
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2,
) -> SendableSyncFunc<F0.Input, F2.Output> where
	F1.Input == F0.Output,
	F2.Input == F1.Output
{
	SendableSyncFunc { (input: F0.Input) -> F2.Output in
		f2.run(with: f1.run(with: f0.run(with: input)))
	}
}

@_disfavoredOverload
@inlinable
public func pipe<
	F0: SyncFunction & Sendable,
	F1: SyncFunction & Sendable,
	F2: SyncFunction & Sendable,
	F3: SyncFunction & Sendable,
>(
	_ f0: F0,
	_ f1: F1,
	_ f2: F2,
	_ f3: F3
) -> SendableSyncFunc<F0.Input, F3.Output> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F3.Input == F2.Output
{
	SendableSyncFunc { (input: F0.Input) -> F3.Output in
		f3.run(with: f2.run(with: f1.run(with: f0.run(with: input))))
	}
}
