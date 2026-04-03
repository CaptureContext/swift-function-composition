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

extension AsyncThrowingFunction where Self: Sendable {
	@_disfavoredOverload
	@inlinable
	public func compose<B: AsyncThrowingFunction & Sendable>(
		_ b: B
	) -> SendableAsyncThrowingFunc<B.Input, Output, Either<B.Failure, Failure>>
	where Input == B.Output {
		SendableAsyncThrowingFunc { (input: B.Input) async throws(Either<B.Failure, Failure>) -> Output in
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
	public func compose<B: AsyncThrowingFunction & Sendable>(
		_ b: B
	) -> SendableAsyncThrowingFunc<B.Input, Output, Failure>
	where Input == B.Output, Failure == B.Failure {
		SendableAsyncThrowingFunc { (input: B.Input) async throws(Failure) -> Output in
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
}

extension AsyncFunction where Self: Sendable {
	@_disfavoredOverload
	@inlinable
	public func compose<B: AsyncFunction & Sendable>(
		_ b: B
	) -> SendableAsyncFunc<B.Input, Output>
	where Input == B.Output {
		SendableAsyncFunc { (input: B.Input) async -> Output in
			await self.run(with: b.run(with: input))
		}
	}

	@inlinable
	public func compose<B: _MainActorAsyncFunction & Sendable>(
		_ b: B
	) -> MainActorAsyncFunc<B.Input, Output>
	where Input == B.Output, B.Input: Sendable {
		MainActorAsyncFunc { (input: B.Input) async -> Output in
			await self.run(with: b.run(with: input))
		}
	}
}

extension SyncThrowingFunction where Self: Sendable {
	@_disfavoredOverload
	@inlinable
	public func compose<B: SyncThrowingFunction & Sendable>(
		_ b: B
	) -> SendableSyncThrowingFunc<B.Input, Output, Either<B.Failure, Failure>>
	where Input == B.Output {
		SendableSyncThrowingFunc { (input: B.Input) throws(Either<B.Failure, Failure>) -> Output in
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
	public func compose<B: SyncThrowingFunction & Sendable>(
		_ b: B
	) -> SendableSyncThrowingFunc<B.Input, Output, Failure>
	where Input == B.Output, Failure == B.Failure {
		SendableSyncThrowingFunc { (input: B.Input) throws(Failure) -> Output in
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
}

extension SyncFunction where Self: Sendable {
	@_disfavoredOverload
	@inlinable
	public func compose<B: SyncFunction & Sendable>(
		_ b: B
	) -> SendableSyncFunc<B.Input, Output>
	where Input == B.Output {
		SendableSyncFunc { (input: B.Input) -> Output in
			self.run(with: b.run(with: input))
		}
	}

	@inlinable
	public func compose<B: _MainActorSyncFunction & Sendable>(
		_ b: B
	) -> MainActorSyncFunc<B.Input, Output>
	where Input == B.Output, B.Input: Sendable {
		MainActorSyncFunc { (input: B.Input) -> Output in
			self.run(with: b.run(with: input))
		}
	}
}

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
