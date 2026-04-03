import NominalFunctionTypes

extension AsyncThrowingFunction where Self: Sendable {
	@_disfavoredOverload
	@inlinable
	public func pipe<A: AsyncThrowingFunction & Sendable>(
		_ a: A
	) -> SendableAsyncThrowingFunc<Input, A.Output, Either<Failure, A.Failure>> where
		A.Input == Output
	{
		SendableAsyncThrowingFunc { (input: Input) async throws(Either<Failure, A.Failure>) -> A.Output in
			do {
				let partialResult = try await self.run(with: input)
				do {
					return try await a.run(with: partialResult)
				} catch {
					throw Either<Failure, A.Failure>.right(error as! A.Failure)
				}
			} catch {
				throw Either<Failure, A.Failure>.left(error as! Failure)
			}
		}
	}

	@_disfavoredOverload
	@inlinable
	public func pipe<A: AsyncThrowingFunction & Sendable>(
		_ a: A
	) -> SendableAsyncThrowingFunc<Input, A.Output, A.Failure> where
		A.Input == Output,
		Failure == A.Failure
	{
		SendableAsyncThrowingFunc { (input: Input) async throws(A.Failure) -> A.Output in
			do {
				let partialResult = try await self.run(with: input)
				do {
					return try await a.run(with: partialResult)
				} catch {
					throw error as! A.Failure
				}
			} catch {
				throw error as! Failure
			}
		}
	}
}

extension AsyncFunction where Self: Sendable {
	@_disfavoredOverload
	@inlinable
	public func pipe<A: AsyncFunction & Sendable>(
		_ a: A
	) -> SendableAsyncFunc<Input, A.Output> where
		A.Input == Output
	{
		SendableAsyncFunc { (input: Input) async -> A.Output in
			await a.run(with: self.run(with: input))
		}
	}
}

extension SyncThrowingFunction where Self: Sendable {
	@_disfavoredOverload
	@inlinable
	public func pipe<A: SyncThrowingFunction & Sendable>(
		_ a: A
	) -> SendableSyncThrowingFunc<Input, A.Output, Either<Failure, A.Failure>> where
		A.Input == Output
	{
		SendableSyncThrowingFunc { (input: Input) throws(Either<Failure, A.Failure>) -> A.Output in
			do {
				let partialResult = try self.run(with: input)
				do {
					return try a.run(with: partialResult)
				} catch {
					throw Either<Failure, A.Failure>.right(error as! A.Failure)
				}
			} catch {
				throw Either<Failure, A.Failure>.left(error as! Failure)
			}
		}
	}

	@_disfavoredOverload
	@inlinable
	public func pipe<A: SyncThrowingFunction & Sendable>(
		_ a: A
	) -> SendableSyncThrowingFunc<Input, A.Output, A.Failure> where
		A.Input == Output,
		Failure == A.Failure
	{
		SendableSyncThrowingFunc { (input: Input) throws(A.Failure) -> A.Output in
			do {
				let partialResult = try self.run(with: input)
				do {
					return try a.run(with: partialResult)
				} catch {
					throw error as! A.Failure
				}
			} catch {
				throw error as! Failure
			}
		}
	}
}

extension SyncFunction where Self: Sendable {
	@_disfavoredOverload
	@inlinable
	public func pipe<A: SyncFunction & Sendable>(
		_ a: A
	) -> SendableSyncFunc<Input, A.Output> where
		A.Input == Output
	{
		SendableSyncFunc { (input: Input) -> A.Output in
			a.run(with: self.run(with: input))
		}
	}
}
