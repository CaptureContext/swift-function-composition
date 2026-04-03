import NominalFunctionTypes

extension AsyncThrowingFunction {
	@_disfavoredOverload
	@inlinable
	public func pipe<A: AsyncThrowingFunction>(
		_ a: A
	) -> AsyncThrowingFunc<Input, A.Output, Either<Failure, A.Failure>> where
		A.Input == Output
	{
		AsyncThrowingFunc { (input: Input) async throws(Either<Failure, A.Failure>) -> A.Output in
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
	public func pipe<A: AsyncThrowingFunction>(
		_ a: A
	) -> AsyncThrowingFunc<Input, A.Output, A.Failure> where
		A.Input == Output,
		Failure == A.Failure
	{
		AsyncThrowingFunc { (input: Input) async throws(A.Failure) -> A.Output in
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

extension AsyncFunction {
	@_disfavoredOverload
	@inlinable
	public func pipe<A: AsyncFunction>(
		_ a: A
	) -> AsyncFunc<Input, A.Output> where
		A.Input == Output
	{
		AsyncFunc { (input: Input) async -> A.Output in
			await a.run(with: self.run(with: input))
		}
	}
}

extension SyncThrowingFunction {
	@_disfavoredOverload
	@inlinable
	public func pipe<A: SyncThrowingFunction>(
		_ a: A
	) -> SyncThrowingFunc<Input, A.Output, Either<Failure, A.Failure>> where
		A.Input == Output
	{
		SyncThrowingFunc { (input: Input) throws(Either<Failure, A.Failure>) -> A.Output in
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
	public func pipe<A: SyncThrowingFunction>(
		_ a: A
	) -> SyncThrowingFunc<Input, A.Output, A.Failure> where
		A.Input == Output,
		Failure == A.Failure
	{
		SyncThrowingFunc { (input: Input) throws(A.Failure) -> A.Output in
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

extension SyncFunction {
	@_disfavoredOverload
	@inlinable
	public func pipe<A: SyncFunction>(
		_ a: A
	) -> SyncFunc<Input, A.Output> where
		A.Input == Output
	{
		SyncFunc { (input: Input) -> A.Output in
			a.run(with: self.run(with: input))
		}
	}
}
