import NominalFunctionTypes

extension AsyncThrowingFunction {
	@_disfavoredOverload
	@inlinable
	public func compose<B: AsyncThrowingFunction>(
		_ b: B
	) -> AsyncThrowingFunc<B.Input, Output, Either<B.Failure, Failure>>
	where Input == B.Output {
		AsyncThrowingFunc { (input: B.Input) async throws(Either<B.Failure, Failure>) -> Output in
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

	@_disfavoredOverload
	@inlinable
	public func compose<B: AsyncThrowingFunction>(
		_ b: B
	) -> AsyncThrowingFunc<B.Input, Output, Failure>
	where Input == B.Output, Failure == B.Failure {
		AsyncThrowingFunc { (input: B.Input) async throws(Failure) -> Output in
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

extension AsyncFunction {
	@_disfavoredOverload
	@inlinable
	public func compose<B: AsyncFunction>(
		_ b: B
	) -> AsyncFunc<B.Input, Output>
	where Input == B.Output {
		AsyncFunc { (input: B.Input) async -> Output in
			await self.run(with: b.run(with: input))
		}
	}
}

extension SyncThrowingFunction {
	@_disfavoredOverload
	@inlinable
	public func compose<B: SyncThrowingFunction>(
		_ b: B
	) -> SyncThrowingFunc<B.Input, Output, Either<B.Failure, Failure>>
	where Input == B.Output {
		SyncThrowingFunc { (input: B.Input) throws(Either<B.Failure, Failure>) -> Output in
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

	@_disfavoredOverload
	@inlinable
	public func compose<B: SyncThrowingFunction>(
		_ b: B
	) -> SyncThrowingFunc<B.Input, Output, Failure>
	where Input == B.Output, Failure == B.Failure {
		SyncThrowingFunc { (input: B.Input) throws(Failure) -> Output in
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

extension SyncFunction {
	@_disfavoredOverload
	@inlinable
	public func compose<B: SyncFunction>(
		_ b: B
	) -> SyncFunc<B.Input, Output>
	where Input == B.Output {
		SyncFunc { (input: B.Input) -> Output in
			self.run(with: b.run(with: input))
		}
	}
}
