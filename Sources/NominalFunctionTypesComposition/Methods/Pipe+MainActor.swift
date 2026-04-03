import NominalFunctionTypes

extension AsyncThrowingFunction where Self: Sendable {
	@inlinable
	public func pipe<A: _MainActorAsyncThrowingFunction & Sendable>(
		_ a: A
	) -> MainActorAsyncThrowingFunc<Input, A.Output, Either<Failure, A.Failure>> where
		A.Input == Output,
		Input: Sendable
	{
		MainActorAsyncThrowingFunc { (input: Input) async throws(Either<Failure, A.Failure>) -> A.Output in
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

	@inlinable
	public func pipe<A: _MainActorAsyncThrowingFunction & Sendable>(
		_ a: A
	) -> MainActorAsyncThrowingFunc<Input, A.Output, A.Failure> where
		A.Input == Output,
		Failure == A.Failure,
		Input: Sendable
	{
		MainActorAsyncThrowingFunc { (input: Input) async throws(A.Failure) -> A.Output in
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
	@inlinable
	public func pipe<A: _MainActorAsyncFunction & Sendable>(
		_ a: A
	) -> MainActorAsyncFunc<Input, A.Output> where
		A.Input == Output,
		Input: Sendable
	{
		MainActorAsyncFunc { (input: Input) async -> A.Output in
			await a.run(with: self.run(with: input))
		}
	}
}

extension SyncThrowingFunction where Self: Sendable {
	@inlinable
	public func pipe<A: _MainActorSyncThrowingFunction & Sendable>(
		_ a: A
	) -> MainActorSyncThrowingFunc<Input, A.Output, Either<Failure, A.Failure>> where
		A.Input == Output,
		Input: Sendable
	{
		MainActorSyncThrowingFunc { (input: Input) throws(Either<Failure, A.Failure>) -> A.Output in
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

	@inlinable
	public func pipe <A: _MainActorSyncThrowingFunction & Sendable>(
		_ a: A
	) -> MainActorSyncThrowingFunc<Input, A.Output, A.Failure> where
		A.Input == Output,
		Failure == A.Failure,
		Input: Sendable
	{
		MainActorSyncThrowingFunc { (input: Input) throws(A.Failure) -> A.Output in
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
	@inlinable
	public func pipe<A: _MainActorSyncFunction & Sendable>(
		_ a: A
	) -> MainActorSyncFunc<Input, A.Output> where
		A.Input == Output,
		Input: Sendable
	{
		MainActorSyncFunc { (input: Input) -> A.Output in
			a.run(with: self.run(with: input))
		}
	}
}

extension _MainActorAsyncThrowingFunction where Self: Sendable {
	@inlinable
	public func pipe<A: _MainActorAsyncThrowingFunction & Sendable>(
		_ a: A
	) -> MainActorAsyncThrowingFunc<Input, A.Output, Either<Failure, A.Failure>> where
		A.Input == Output,
		Input: Sendable
	{
		MainActorAsyncThrowingFunc { (input: Input) async throws(Either<Failure, A.Failure>) -> A.Output in
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

	@inlinable
	public func pipe<A: AsyncThrowingFunction & Sendable>(
		_ a: A
	) -> MainActorAsyncThrowingFunc<Input, A.Output, Either<Failure, A.Failure>> where
		A.Input == Output,
		Input: Sendable
	{
		MainActorAsyncThrowingFunc { (input: Input) async throws(Either<Failure, A.Failure>) -> A.Output in
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

	@inlinable
	public func pipe<A: _MainActorAsyncThrowingFunction & Sendable>(
		_ a: A
	) -> MainActorAsyncThrowingFunc<Input, A.Output, A.Failure> where
		A.Input == Output,
		Failure == A.Failure,
		Input: Sendable
	{
		MainActorAsyncThrowingFunc { (input: Input) async throws(A.Failure) -> A.Output in
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

	@inlinable
	public func pipe<A: AsyncThrowingFunction & Sendable>(
		_ a: A
	) -> MainActorAsyncThrowingFunc<Input, A.Output, A.Failure> where
		A.Input == Output,
		Failure == A.Failure,
		Input: Sendable
	{
		MainActorAsyncThrowingFunc { (input: Input) async throws(A.Failure) -> A.Output in
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

extension _MainActorAsyncFunction where Self: Sendable {
	@inlinable
	public func pipe<A: _MainActorAsyncFunction & Sendable>(
		_ a: A
	) -> MainActorAsyncFunc<Input, A.Output> where
		A.Input == Output,
		Input: Sendable
	{
		MainActorAsyncFunc { (input: Input) async -> A.Output in
			await a.run(with: self.run(with: input))
		}
	}

	@inlinable
	public func pipe<A: AsyncFunction & Sendable>(
		_ a: A
	) -> MainActorAsyncFunc<Input, A.Output> where
		A.Input == Output,
		Input: Sendable
	{
		MainActorAsyncFunc { (input: Input) async -> A.Output in
			await a.run(with: self.run(with: input))
		}
	}
}

extension _MainActorSyncThrowingFunction where Self: Sendable {
	@inlinable
	public func pipe<A: _MainActorSyncThrowingFunction & Sendable>(
		_ a: A
	) -> MainActorSyncThrowingFunc<Input, A.Output, Either<Failure, A.Failure>> where
		A.Input == Output,
		Input: Sendable
	{
		MainActorSyncThrowingFunc { (input: Input) throws(Either<Failure, A.Failure>) -> A.Output in
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

	@inlinable
	public func pipe<A: SyncThrowingFunction & Sendable>(
		_ a: A
	) -> MainActorSyncThrowingFunc<Input, A.Output, Either<Failure, A.Failure>> where
		A.Input == Output,
		Input: Sendable
	{
		MainActorSyncThrowingFunc { (input: Input) throws(Either<Failure, A.Failure>) -> A.Output in
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

	@inlinable
	public func pipe<A: _MainActorSyncThrowingFunction & Sendable>(
		_ a: A
	) -> MainActorSyncThrowingFunc<Input, A.Output, A.Failure> where
		A.Input == Output,
		Failure == A.Failure,
		Input: Sendable
	{
		MainActorSyncThrowingFunc { (input: Input) throws(A.Failure) -> A.Output in
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

	@inlinable
	public func pipe<A: SyncThrowingFunction & Sendable>(
		_ a: A
	) -> MainActorSyncThrowingFunc<Input, A.Output, A.Failure> where
		A.Input == Output,
		Failure == A.Failure,
		Input: Sendable
	{
		MainActorSyncThrowingFunc { (input: Input) throws(A.Failure) -> A.Output in
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

extension _MainActorSyncFunction where Self: Sendable {
	@inlinable
	public func pipe<A: _MainActorSyncFunction & Sendable>(
		_ a: A
	) -> MainActorSyncFunc<Input, A.Output> where
		A.Input == Output,
		Input: Sendable
	{
		MainActorSyncFunc { (input: Input) -> A.Output in
			a.run(with: self.run(with: input))
		}
	}

	@inlinable
	public func pipe<A: SyncFunction & Sendable>(
		_ a: A
	) -> MainActorSyncFunc<Input, A.Output> where
		A.Input == Output,
		Input: Sendable
	{
		MainActorSyncFunc { (input: Input) -> A.Output in
			a.run(with: self.run(with: input))
		}
	}
}
