import Testing
import FunctionCompositionOperators
import NominalFunctionTypes
@testable import NominalFunctionTypesCompositionOperators

@Suite
struct ComposeTests {
	@Suite
	struct SendableAsyncThrowing {
		let a = SendableAsyncThrowingFunc(isNotZero)

		@Test
		func intoSendableAsyncThrowing() async throws {
			let b = SendableAsyncThrowingFunc(desc)
			let f = b <<< a
			try await sendableCheck(f.run)
		}

		@Test
		func intoAsyncThrowing() async throws {
			let b = AsyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableAsync() async throws {
			let b = SendableAsyncFunc(desc)
			let f = b <<< a
			try await sendableCheck(f.run)
		}

		@Test
		func intoAsync() async throws {
			let b = AsyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableSyncThrowing() async throws {
			let b = SendableSyncThrowingFunc(desc)
			let f = b <<< a
			try await sendableCheck(f.run)
		}

		@Test
		func intoSyncThrowing() async throws {
			let b = SyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableSync() async throws {
			let b = SendableSyncFunc(desc)
			let f = b <<< a
			try await sendableCheck(f.run)
		}

		@Test
		func intoSync() async throws {
			let b = SyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}
	}

	@Suite
	struct AsyncThrowing {
		let a = AsyncThrowingFunc(isNotZero)

		@Test
		func intoSendableAsyncThrowing() async throws {
			let b = SendableAsyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoAsyncThrowing() async throws {
			let b = AsyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableAsync() async throws {
			let b = SendableAsyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoAsync() async throws {
			let b = AsyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableSyncThrowing() async throws {
			let b = SendableSyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSyncThrowing() async throws {
			let b = SyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableSync() async throws {
			let b = SendableSyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSync() async throws {
			let b = SyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}
	}

	@Suite
	struct SendableAsync {
		let a = SendableAsyncFunc(isNotZero)

		@Test
		func intoSendableAsyncThrowing() async throws {
			let b = SendableAsyncThrowingFunc(desc)
			let f = b <<< a
			try await sendableCheck(f.run)
		}

		@Test
		func intoAsyncThrowing() async throws {
			let b = AsyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableAsync() async throws {
			let b = SendableAsyncFunc(desc)
			let f = b <<< a
			try await sendableCheck(f.run)
		}

		@Test
		func intoAsync() async throws {
			let b = AsyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableSyncThrowing() async throws {
			let b = SendableSyncThrowingFunc(desc)
			let f = b <<< a
			try await sendableCheck(f.run)
		}

		@Test
		func intoSyncThrowing() async throws {
			let b = SyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableSync() async throws {
			let b = SendableSyncFunc(desc)
			let f = b <<< a
			try await sendableCheck(f.run)
		}

		@Test
		func intoSync() async throws {
			let b = SyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}
	}

	@Suite
	struct Async {
		let a = AsyncFunc(isNotZero)

		@Test
		func intoSendableAsyncThrowing() async throws {
			let b = SendableAsyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoAsyncThrowing() async throws {
			let b = AsyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableAsync() async throws {
			let b = SendableAsyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoAsync() async throws {
			let b = AsyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableSyncThrowing() async throws {
			let b = SendableSyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSyncThrowing() async throws {
			let b = SyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableSync() async throws {
			let b = SendableSyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSync() async throws {
			let b = SyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}
	}

	@Suite
	struct SendableSyncThrowing {
		let a = SendableSyncThrowingFunc(isNotZero)

		@Test
		func intoSendableAsyncThrowing() async throws {
			let b = SendableAsyncThrowingFunc(desc)
			let f = b <<< a
			try await sendableCheck(f.run)
		}

		@Test
		func intoAsyncThrowing() async throws {
			let b = AsyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableAsync() async throws {
			let b = SendableAsyncFunc(desc)
			let f = b <<< a
			try await sendableCheck(f.run)
		}

		@Test
		func intoAsync() async throws {
			let b = AsyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableSyncThrowing() async throws {
			let b = SendableSyncThrowingFunc(desc)
			let f = b <<< a
			try await sendableCheck(f.run)
		}

		@Test
		func intoSyncThrowing() async throws {
			let b = SyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableSync() async throws {
			let b = SendableSyncFunc(desc)
			let f = b <<< a
			try await sendableCheck(f.run)
		}

		@Test
		func intoSync() async throws {
			let b = SyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}
	}

	@Suite
	struct SyncThrowing {
		let a = SyncThrowingFunc(isNotZero)

		@Test
		func intoSendableAsyncThrowing() async throws {
			let b = SendableAsyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoAsyncThrowing() async throws {
			let b = AsyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableAsync() async throws {
			let b = SendableAsyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoAsync() async throws {
			let b = AsyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableSyncThrowing() async throws {
			let b = SendableSyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSyncThrowing() async throws {
			let b = SyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableSync() async throws {
			let b = SendableSyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSync() async throws {
			let b = SyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}
	}

	@Suite
	struct SendableSync {
		let a = SendableSyncFunc(isNotZero)

		@Test
		func intoSendableAsyncThrowing() async throws {
			let b = SendableAsyncThrowingFunc(desc)
			let f = b <<< a
			try await sendableCheck(f.run)
		}

		@Test
		func intoAsyncThrowing() async throws {
			let b = AsyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableAsync() async throws {
			let b = SendableAsyncFunc(desc)
			let f = b <<< a
			try await sendableCheck(f.run)
		}

		@Test
		func intoAsync() async throws {
			let b = AsyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableSyncThrowing() async throws {
			let b = SendableSyncThrowingFunc(desc)
			let f = b <<< a
			try await sendableCheck(f.run)
		}

		@Test
		func intoSyncThrowing() async throws {
			let b = SyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableSync() async throws {
			let b = SendableSyncFunc(desc)
			let f = b <<< a
			try await sendableCheck(f.run)
		}

		@Test
		func intoSync() async throws {
			let b = SyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}
	}

	@Suite
	struct Sync {
		let a = SyncFunc(isNotZero)

		@Test
		func intoSendableAsyncThrowing() async throws {
			let b = SendableAsyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoAsyncThrowing() async throws {
			let b = AsyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableAsync() async throws {
			let b = SendableAsyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoAsync() async throws {
			let b = AsyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableSyncThrowing() async throws {
			let b = SendableSyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSyncThrowing() async throws {
			let b = SyncThrowingFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSendableSync() async throws {
			let b = SendableSyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}

		@Test
		func intoSync() async throws {
			let b = SyncFunc(desc)
			let f = b <<< a
			try await check(f.run)
		}
	}
}
