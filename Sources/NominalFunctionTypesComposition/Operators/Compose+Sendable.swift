import NominalFunctionTypes
import FunctionCompositionOperators

@_disfavoredOverload
@inlinable
public func <<< <
	A: AsyncThrowingFunction & Sendable,
	B: AsyncThrowingFunction & Sendable
>(
	_ a: A,
	_ b: B
) -> SendableAsyncThrowingFunc<B.Input, A.Output, Either<B.Failure, A.Failure>> where
	A.Input == B.Output
{
	SendableAsyncThrowingFunc { (input: B.Input) async throws(Either<B.Failure, A.Failure>) -> A.Output in
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

@_disfavoredOverload
@inlinable
public func <<< <
	A: AsyncThrowingFunction & Sendable,
	B: AsyncThrowingFunction & Sendable
>(
	_ a: A,
	_ b: B
) -> SendableAsyncThrowingFunc<B.Input, A.Output, A.Failure> where
	A.Input == B.Output,
	A.Failure == B.Failure
{
	SendableAsyncThrowingFunc { (input: B.Input) async throws(A.Failure) -> A.Output in
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

@_disfavoredOverload
@inlinable
public func <<< <
	A: AsyncFunction & Sendable,
	B: AsyncFunction & Sendable
>(
	_ a: A,
	_ b: B
) -> SendableAsyncFunc<B.Input, A.Output> where
	A.Input == B.Output
{
	SendableAsyncFunc { (input: B.Input) async -> A.Output in
		await a.run(with: b.run(with: input))
	}
}

@_disfavoredOverload
@inlinable
public func <<< <
	A: SyncThrowingFunction & Sendable,
	B: SyncThrowingFunction & Sendable
>(
	_ a: A,
	_ b: B
) -> SendableSyncThrowingFunc<B.Input, A.Output, Either<B.Failure, A.Failure>> where
	A.Input == B.Output
{
	SendableSyncThrowingFunc { (input: B.Input) throws(Either<B.Failure, A.Failure>) -> A.Output in
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

@_disfavoredOverload
@inlinable
public func <<< <
	A: SyncThrowingFunction & Sendable,
	B: SyncThrowingFunction & Sendable
>(
	_ a: A,
	_ b: B
) -> SendableSyncThrowingFunc<B.Input, A.Output, A.Failure> where
	A.Input == B.Output,
	A.Failure == B.Failure
{
	SendableSyncThrowingFunc { (input: B.Input) throws(A.Failure) -> A.Output in
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

@_disfavoredOverload
@inlinable
public func <<< <
	A: SyncFunction & Sendable,
	B: SyncFunction & Sendable
>(
	_ a: A,
	_ b: B
) -> SendableSyncFunc<B.Input, A.Output> where
	A.Input == B.Output
{
	SendableSyncFunc { (input: B.Input) -> A.Output in
		a.run(with: b.run(with: input))
	}
}
