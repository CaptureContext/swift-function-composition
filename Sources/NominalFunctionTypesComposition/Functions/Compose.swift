import NominalFunctionTypes
import Either

// MARK: - AsyncThrowing

@_disfavoredOverload
@inlinable
public func compose<
	F1: AsyncThrowingFunction,
	F0: AsyncThrowingFunction
>(
	_ f1: F1,
	_ f0: F0
) -> AsyncThrowingFunc<F0.Input, F1.Output, Either<F0.Failure, F1.Failure>> where
	F1.Input == F0.Output
{
	AsyncThrowingFunc { (input: F0.Input) async throws(Either<F0.Failure, F1.Failure>) -> F1.Output in
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
public func compose<
	F1: AsyncThrowingFunction,
	F0: AsyncThrowingFunction
>(
	_ f1: F1,
	_ f0: F0
) -> AsyncThrowingFunc<F0.Input, F1.Output, F1.Failure> where
	F1.Input == F0.Output,
	F1.Failure == F0.Failure
{
	AsyncThrowingFunc { (input: F0.Input) async throws(F0.Failure) -> F1.Output in
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
public func compose<
	F2: AsyncThrowingFunction,
	F1: AsyncThrowingFunction,
	F0: AsyncThrowingFunction
>(
	_ f2: F2,
	_ f1: F1,
	_ f0: F0
) -> AsyncThrowingFunc<F0.Input, F2.Output, Either<Either<F0.Failure, F1.Failure>, F2.Failure>> where
	F1.Input == F0.Output,
	F2.Input == F1.Output
{
	compose(f2, compose(f1, f0))
}


@_disfavoredOverload
@inlinable
public func compose<
	F2: AsyncThrowingFunction,
	F1: AsyncThrowingFunction,
	F0: AsyncThrowingFunction
>(
	_ f2: F2,
	_ f1: F1,
	_ f0: F0
) -> AsyncThrowingFunc<F0.Input, F2.Output, F2.Failure> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F1.Failure == F0.Failure,
	F2.Failure == F0.Failure
{
	compose(f2, compose(f1, f0))
}


@_disfavoredOverload
@inlinable
public func compose<
	F3: AsyncThrowingFunction,
	F2: AsyncThrowingFunction,
	F1: AsyncThrowingFunction,
	F0: AsyncThrowingFunction
>(
	_ f3: F3,
	_ f2: F2,
	_ f1: F1,
	_ f0: F0
) -> AsyncThrowingFunc<F0.Input, F3.Output, Either<Either<F0.Failure, F1.Failure>, Either<F2.Failure, F3.Failure>>> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F3.Input == F2.Output
{
	compose(compose(f3, f2), compose(f1, f0))
}


@_disfavoredOverload
@inlinable
public func compose<
	F3: AsyncThrowingFunction,
	F2: AsyncThrowingFunction,
	F1: AsyncThrowingFunction,
	F0: AsyncThrowingFunction
>(
	_ f3: F3,
	_ f2: F2,
	_ f1: F1,
	_ f0: F0
) -> AsyncThrowingFunc<F0.Input, F3.Output, F3.Failure> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F3.Input == F2.Output,
	F1.Failure == F0.Failure,
	F2.Failure == F0.Failure,
	F3.Failure == F0.Failure
{
	compose(compose(f3, f2), compose(f1, f0))
}

// MARK: - SyncThrowing

@_disfavoredOverload
@inlinable
public func compose<
	F1: SyncThrowingFunction,
	F0: SyncThrowingFunction
>(
	_ f1: F1,
	_ f0: F0
) -> SyncThrowingFunc<F0.Input, F1.Output, Either<F0.Failure, F1.Failure>> where
	F1.Input == F0.Output
{
	SyncThrowingFunc { (input: F0.Input) throws(Either<F0.Failure, F1.Failure>) -> F1.Output in
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
public func compose<
	F1: SyncThrowingFunction,
	F0: SyncThrowingFunction
>(
	_ f1: F1,
	_ f0: F0
) -> SyncThrowingFunc<F0.Input, F1.Output, F1.Failure> where
	F1.Input == F0.Output,
	F1.Failure == F0.Failure
{
	SyncThrowingFunc { (input: F0.Input) throws(F0.Failure) -> F1.Output in
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
public func compose<
	F2: SyncThrowingFunction,
	F1: SyncThrowingFunction,
	F0: SyncThrowingFunction
>(
	_ f2: F2,
	_ f1: F1,
	_ f0: F0
) -> SyncThrowingFunc<F0.Input, F2.Output, Either<Either<F0.Failure, F1.Failure>, F2.Failure>> where
	F1.Input == F0.Output,
	F2.Input == F1.Output
{
	compose(f2, compose(f1, f0))
}


@_disfavoredOverload
@inlinable
public func compose<
	F2: SyncThrowingFunction,
	F1: SyncThrowingFunction,
	F0: SyncThrowingFunction
>(
	_ f2: F2,
	_ f1: F1,
	_ f0: F0
) -> SyncThrowingFunc<F0.Input, F2.Output, F2.Failure> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F1.Failure == F0.Failure,
	F2.Failure == F0.Failure
{
	compose(f2, compose(f1, f0))
}


@_disfavoredOverload
@inlinable
public func compose<
	F3: SyncThrowingFunction,
	F2: SyncThrowingFunction,
	F1: SyncThrowingFunction,
	F0: SyncThrowingFunction
>(
	_ f3: F3,
	_ f2: F2,
	_ f1: F1,
	_ f0: F0
) -> SyncThrowingFunc<F0.Input, F3.Output, Either<Either<F0.Failure, F1.Failure>, Either<F2.Failure, F3.Failure>>> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F3.Input == F2.Output
{
	compose(compose(f3, f2), compose(f1, f0))
}


@_disfavoredOverload
@inlinable
public func compose<
	F3: SyncThrowingFunction,
	F2: SyncThrowingFunction,
	F1: SyncThrowingFunction,
	F0: SyncThrowingFunction
>(
	_ f3: F3,
	_ f2: F2,
	_ f1: F1,
	_ f0: F0
) -> SyncThrowingFunc<F0.Input, F3.Output, F3.Failure> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F3.Input == F2.Output,
	F1.Failure == F0.Failure,
	F2.Failure == F0.Failure,
	F3.Failure == F0.Failure
{
	compose(compose(f3, f2), compose(f1, f0))
}

// MARK: - Async

@_disfavoredOverload
@inlinable
public func compose<
	F1: AsyncFunction,
	F0: AsyncFunction
>(
	_ f1: F1,
	_ f0: F0
) -> AsyncFunc<F0.Input, F1.Output> where
	F1.Input == F0.Output
{
	AsyncFunc { (input: F0.Input) async -> F1.Output in
		await f1.run(with: f0.run(with: input))
	}
}

@_disfavoredOverload
@inlinable
public func compose<
	F2: AsyncFunction,
	F1: AsyncFunction,
	F0: AsyncFunction
>(
	_ f2: F2,
	_ f1: F1,
	_ f0: F0
) -> AsyncFunc<F0.Input, F2.Output> where
	F1.Input == F0.Output,
	F2.Input == F1.Output
{
	AsyncFunc { (input: F0.Input) async -> F2.Output in
		await f2.run(with: f1.run(with: f0.run(with: input)))
	}
}

@_disfavoredOverload
@inlinable
public func compose<
	F3: AsyncFunction,
	F2: AsyncFunction,
	F1: AsyncFunction,
	F0: AsyncFunction
>(
	_ f3: F3,
	_ f2: F2,
	_ f1: F1,
	_ f0: F0
) -> AsyncFunc<F0.Input, F3.Output> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F3.Input == F2.Output
{
	AsyncFunc { (input: F0.Input) async -> F3.Output in
		await f3.run(with: f2.run(with: f1.run(with: f0.run(with: input))))
	}
}

// MARK: - Sync

@_disfavoredOverload
@inlinable
public func compose<
	F1: SyncFunction,
	F0: SyncFunction
>(
	_ f1: F1,
	_ f0: F0
) -> SyncFunc<F0.Input, F1.Output> where
	F1.Input == F0.Output
{
	SyncFunc { (input: F0.Input) -> F1.Output in
		f1.run(with: f0.run(with: input))
	}
}

@_disfavoredOverload
@inlinable
public func compose<
	F2: SyncFunction,
	F1: SyncFunction,
	F0: SyncFunction
>(
	_ f2: F2,
	_ f1: F1,
	_ f0: F0
) -> SyncFunc<F0.Input, F2.Output> where
	F1.Input == F0.Output,
	F2.Input == F1.Output
{
	SyncFunc { (input: F0.Input) -> F2.Output in
		f2.run(with: f1.run(with: f0.run(with: input)))
	}
}

@_disfavoredOverload
@inlinable
public func compose<
	F3: SyncFunction,
	F2: SyncFunction,
	F1: SyncFunction,
	F0: SyncFunction
>(
	_ f3: F3,
	_ f2: F2,
	_ f1: F1,
	_ f0: F0
) -> SyncFunc<F0.Input, F3.Output> where
	F1.Input == F0.Output,
	F2.Input == F1.Output,
	F3.Input == F2.Output
{
	SyncFunc { (input: F0.Input) -> F3.Output in
		f3.run(with: f2.run(with: f1.run(with: f0.run(with: input))))
	}
}
