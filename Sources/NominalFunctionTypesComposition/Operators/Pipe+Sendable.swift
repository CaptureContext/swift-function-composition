import NominalFunctionTypes
import FunctionCompositionOperators

@inlinable
public func >>> <
	A: AsyncThrowingFunction & Sendable,
	B: AsyncThrowingFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> SendableAsyncThrowingFunc<B.Input, A.Output, Either<B.Failure, A.Failure>>
where A.Input == B.Output {
	SendableAsyncThrowingFunc { (input: B.Input) async throws(Either<B.Failure, A.Failure>) -> A.Output in
		do {
			let partialResult = try await b.run(input)
			do {
				return try await a.run(partialResult)
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
	B: AsyncThrowingFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> SendableAsyncThrowingFunc<B.Input, A.Output, A.Failure>
where A.Input == B.Output, A.Failure == B.Failure {
	SendableAsyncThrowingFunc { (input: B.Input) async throws(A.Failure) -> A.Output in
		do {
			let partialResult = try await b.run(input)
			do {
				return try await a.run(partialResult)
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
	A: AsyncFunction & Sendable,
	B: AsyncFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> SendableAsyncFunc<B.Input, A.Output>
where A.Input == B.Output {
	SendableAsyncFunc { (input: B.Input) async -> A.Output in
		await a.run(b.run(input))
	}
}

@inlinable
public func >>> <
	A: SyncThrowingFunction & Sendable,
	B: SyncThrowingFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> SendableSyncThrowingFunc<B.Input, A.Output, Either<B.Failure, A.Failure>>
where A.Input == B.Output {
	SendableSyncThrowingFunc { (input: B.Input) throws(Either<B.Failure, A.Failure>) -> A.Output in
		do {
			let partialResult = try b.run(input)
			do {
				return try a.run(partialResult)
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
	B: SyncThrowingFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> SendableSyncThrowingFunc<B.Input, A.Output, A.Failure>
where A.Input == B.Output, A.Failure == B.Failure {
	SendableSyncThrowingFunc { (input: B.Input) throws(A.Failure) -> A.Output in
		do {
			let partialResult = try b.run(input)
			do {
				return try a.run(partialResult)
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
	A: SyncFunction & Sendable,
	B: SyncFunction & Sendable
>(
	_ b: B,
	_ a: A
) -> SendableSyncFunc<B.Input, A.Output>
where A.Input == B.Output {
	SendableSyncFunc { (input: B.Input) -> A.Output in
		a.run(b.run(input))
	}
}
