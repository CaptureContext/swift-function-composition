import NominalFunctionTypes
import FunctionCompositionOperators

@inlinable
public func >>> <
	A: AsyncThrowingFunction,
	B: AsyncThrowingFunction
>(
	_ b: B,
	_ a: A
) -> AsyncThrowingFunc<B.Input, A.Output, Either<B.Failure, A.Failure>>
where A.Input == B.Output {
	AsyncThrowingFunc { (input: B.Input) async throws(Either<B.Failure, A.Failure>) -> A.Output in
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
	A: AsyncThrowingFunction,
	B: AsyncThrowingFunction
>(
	_ b: B,
	_ a: A
) -> AsyncThrowingFunc<B.Input, A.Output, A.Failure>
where A.Input == B.Output, A.Failure == B.Failure {
	AsyncThrowingFunc { (input: B.Input) async throws(A.Failure) -> A.Output in
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
	A: AsyncFunction,
	B: AsyncFunction
>(
	_ b: B,
	_ a: A
) -> AsyncFunc<B.Input, A.Output>
where A.Input == B.Output {
	AsyncFunc { (input: B.Input) async -> A.Output in
		await a.run(b.run(input))
	}
}

@inlinable
public func >>> <
	A: SyncThrowingFunction,
	B: SyncThrowingFunction
>(
	_ b: B,
	_ a: A
) -> SyncThrowingFunc<B.Input, A.Output, Either<B.Failure, A.Failure>>
where A.Input == B.Output {
	SyncThrowingFunc { (input: B.Input) throws(Either<B.Failure, A.Failure>) -> A.Output in
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
	A: SyncThrowingFunction,
	B: SyncThrowingFunction
>(
	_ b: B,
	_ a: A
) -> SyncThrowingFunc<B.Input, A.Output, A.Failure>
where A.Input == B.Output, A.Failure == B.Failure {
	SyncThrowingFunc { (input: B.Input) throws(A.Failure) -> A.Output in
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
	A: SyncFunction,
	B: SyncFunction
>(
	_ b: B,
	_ a: A
) -> SyncFunc<B.Input, A.Output>
where A.Input == B.Output {
	SyncFunc { (input: B.Input) -> A.Output in
		a.run(b.run(input))
	}
}
