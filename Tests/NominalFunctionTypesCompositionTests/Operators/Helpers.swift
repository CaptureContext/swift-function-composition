import Testing
import NominalFunctionTypes

func isNotZero(_ value: Int) -> Bool { value != 0 }
func desc(_ value: Bool) -> String { value ? "true" : "false" }

func checkType<T, U>(
	of value: T,
	is target: U.Type,
	fileID: String = #fileID,
	filePath: String = #filePath,
	line: Int = #line,
	column: Int = #column
) async throws {
	let sourceLocation = SourceLocation(
		fileID: fileID,
		filePath: filePath,
		line: line,
		column: column
	)
	#expect(type(of: value) == target, sourceLocation: sourceLocation)
}

func check(
	_ f: (Int) async throws -> String,
	fileID: String = #fileID,
	filePath: String = #filePath,
	line: Int = #line,
	column: Int = #column
) async throws {
	let sourceLocation = SourceLocation(
		fileID: fileID,
		filePath: filePath,
		line: line,
		column: column
	)

	try await #expect(f(0) == "false", sourceLocation: sourceLocation)
	try await #expect(f(1) == "true", sourceLocation: sourceLocation)
}

func sendableCheck(
	_ f: @Sendable (Int) async throws -> String,
	fileID: String = #fileID,
	filePath: String = #filePath,
	line: Int = #line,
	column: Int = #column
) async throws {
	let sourceLocation = SourceLocation(
		fileID: fileID,
		filePath: filePath,
		line: line,
		column: column
	)

	try await #expect(f(0) == "false", sourceLocation: sourceLocation)
	try await #expect(f(1) == "true", sourceLocation: sourceLocation)
}

func makeAsyncThrowingFunc() -> some AsyncThrowingFunction<Bool, String, Error> {
	AsyncThrowingFunc(desc)
}

func makeSendableAsyncThrowingFunc() -> some AsyncThrowingFunction<Bool, String, Error> & Sendable {
	SendableAsyncThrowingFunc(desc)
}

func makeAsyncFunc() -> some AsyncFunction<Bool, String> {
	AsyncFunc(desc)
}

func makeSendableAsyncFunc() -> some AsyncFunction<Bool, String> & Sendable {
	SendableAsyncFunc(desc)
}

func makeSyncThrowingFunc() -> some SyncThrowingFunction<Bool, String, Error> {
	SyncThrowingFunc(desc)
}

func makeSendableSyncThrowingFunc() -> some SyncThrowingFunction<Bool, String, Error> & Sendable {
	SendableSyncThrowingFunc(desc)
}

func makeSyncFunc() -> some SyncFunction<Bool, String> {
	SyncFunc(desc)
}

func makeSendableSyncFunc() -> some SyncFunction<Bool, String> & Sendable {
	SendableSyncFunc(desc)
}
