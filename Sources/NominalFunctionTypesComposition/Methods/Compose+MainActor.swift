import NominalFunctionTypes

extension _MainActorAsyncThrowingFunction where Self: Sendable {
	@inlinable
	public func compose<B: _MainActorAsyncThrowingFunction & Sendable>(
		_ b: B
	) -> MainActorAsyncThrowingFunc<B.Input, Output, Either<B.Failure, Failure>>
	where Input == B.Output, B.Input: Sendable {
		MainActorAsyncThrowingFunc { (input: B.Input) async throws(Either<B.Failure, Failure>) -> Output in
			do {
				let partialResult = try await b.run(with: input)
				do {
					return try await self.run(with: partialResult)
				} catch {
					throw Either<B.Failure, Failure>.right(error as! Failure)
				}
			} catch {
				throw Either<B.Failure, Failure>.left(error as! B.Failure)
			}
		}
	}

	@inlinable
	public func compose<B: AsyncThrowingFunction & Sendable>(
		_ b: B
	) -> MainActorAsyncThrowingFunc<B.Input, Output, Either<B.Failure, Failure>>
	where Input == B.Output, B.Input: Sendable {
		MainActorAsyncThrowingFunc { (input: B.Input) async throws(Either<B.Failure, Failure>) -> Output in
			do {
				let partialResult = try await b.run(with: input)
				do {
					return try await self.run(with: partialResult)
				} catch {
					throw Either<B.Failure, Failure>.right(error as! Failure)
				}
			} catch {
				throw Either<B.Failure, Failure>.left(error as! B.Failure)
			}
		}
	}

	@inlinable
	public func compose<B: _MainActorAsyncThrowingFunction & Sendable>(
		_ b: B
	) -> MainActorAsyncThrowingFunc<B.Input, Output, Failure>
	where Input == B.Output, Failure == B.Failure, B.Input: Sendable {
		MainActorAsyncThrowingFunc { (input: B.Input) async throws(Failure) -> Output in
			do {
				let partialResult = try await b.run(with: input)
				do {
					return try await self.run(with: partialResult)
				} catch {
					throw error as! Failure
				}
			} catch {
				throw error as! B.Failure
			}
		}
	}

	@inlinable
	public func compose<B: AsyncThrowingFunction & Sendable>(
		_ b: B
	) -> MainActorAsyncThrowingFunc<B.Input, Output, Failure>
	where Input == B.Output, Failure == B.Failure, B.Input: Sendable {
		MainActorAsyncThrowingFunc { (input: B.Input) async throws(Failure) -> Output in
			do {
				let partialResult = try await b.run(with: input)
				do {
					return try await self.run(with: partialResult)
				} catch {
					throw error as! Failure
				}
			} catch {
				throw error as! B.Failure
			}
		}
	}
}

extension _MainActorAsyncFunction where Self: Sendable {
	@inlinable
	public func compose<B: _MainActorAsyncFunction & Sendable>(
		_ b: B
	) -> MainActorAsyncFunc<B.Input, Output>
	where Input == B.Output, B.Input: Sendable {
		MainActorAsyncFunc { (input: B.Input) async -> Output in
			await self.run(with: b.run(with: input))
		}
	}

	@inlinable
	public func compose<B: AsyncFunction & Sendable>(
		_ b: B
	) -> MainActorAsyncFunc<B.Input, Output>
	where Input == B.Output, B.Input: Sendable {
		MainActorAsyncFunc { (input: B.Input) async -> Output in
			await self.run(with: b.run(with: input))
		}
	}
}

extension _MainActorSyncThrowingFunction where Self: Sendable {
	@inlinable
	public func compose<B: _MainActorSyncThrowingFunction & Sendable>(
		_ b: B
	) -> MainActorSyncThrowingFunc<B.Input, Output, Either<B.Failure, Failure>>
	where Input == B.Output, B.Input: Sendable {
		MainActorSyncThrowingFunc { (input: B.Input) throws(Either<B.Failure, Failure>) -> Output in
			do {
				let partialResult = try b.run(with: input)
				do {
					return try self.run(with: partialResult)
				} catch {
					throw Either<B.Failure, Failure>.right(error as! Failure)
				}
			} catch {
				throw Either<B.Failure, Failure>.left(error as! B.Failure)
			}
		}
	}

	@inlinable
	public func compose<B: SyncThrowingFunction & Sendable>(
		_ b: B
	) -> MainActorSyncThrowingFunc<B.Input, Output, Either<B.Failure, Failure>>
	where Input == B.Output, B.Input: Sendable {
		MainActorSyncThrowingFunc { (input: B.Input) throws(Either<B.Failure, Failure>) -> Output in
			do {
				let partialResult = try b.run(with: input)
				do {
					return try self.run(with: partialResult)
				} catch {
					throw Either<B.Failure, Failure>.right(error as! Failure)
				}
			} catch {
				throw Either<B.Failure, Failure>.left(error as! B.Failure)
			}
		}
	}

	@inlinable
	public func compose<B: _MainActorSyncThrowingFunction & Sendable>(
		_ b: B
	) -> MainActorSyncThrowingFunc<B.Input, Output, Failure>
	where Input == B.Output, Failure == B.Failure, B.Input: Sendable {
		MainActorSyncThrowingFunc { (input: B.Input) throws(Failure) -> Output in
			do {
				let partialResult = try b.run(with: input)
				do {
					return try self.run(with: partialResult)
				} catch {
					throw error as! Failure
				}
			} catch {
				throw error as! B.Failure
			}
		}
	}

	@inlinable
	public func compose<B: SyncThrowingFunction & Sendable>(
		_ b: B
	) -> MainActorSyncThrowingFunc<B.Input, Output, Failure>
	where Input == B.Output, Failure == B.Failure, B.Input: Sendable {
		MainActorSyncThrowingFunc { (input: B.Input) throws(Failure) -> Output in
			do {
				let partialResult = try b.run(with: input)
				do {
					return try self.run(with: partialResult)
				} catch {
					throw error as! Failure
				}
			} catch {
				throw error as! B.Failure
			}
		}
	}
}

extension _MainActorSyncFunction where Self: Sendable {
	@inlinable
	public func compose<B: _MainActorSyncFunction & Sendable>(
		_ b: B
	) -> MainActorSyncFunc<B.Input, Output>
	where Input == B.Output, B.Input: Sendable {
		MainActorSyncFunc { (input: B.Input) -> Output in
			self.run(with: b.run(with: input))
		}
	}

	@inlinable
	public func compose<B: SyncFunction & Sendable>(
		_ b: B
	) -> MainActorSyncFunc<B.Input, Output>
	where Input == B.Output, B.Input: Sendable {
		MainActorSyncFunc { (input: B.Input) -> Output in
			self.run(with: b.run(with: input))
		}
	}
}
