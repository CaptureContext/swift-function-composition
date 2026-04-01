import NominalFunctionTypes
import FunctionCompositionOperators

@inlinable
public func <| <F: AsyncThrowingFunction> (
	f: F,
	input: F.Input
) async throws(F.Failure) -> F.Output {
	return try await f.run(input)
}

@inlinable
public func <| <F: AsyncFunction> (
	f: F,
	input: F.Input
) async -> F.Output {
	return await f.run(input)
}

@inlinable
public func <| <F: SyncThrowingFunction> (
	f: F,
	input: F.Input
) throws(F.Failure) -> F.Output {
	return try f.run(input)
}

@inlinable
public func <| <F: SyncFunction> (
	f: F,
	input: F.Input
) -> F.Output {
	return f.run(input)
}

@inlinable
public func |> <F: AsyncThrowingFunction> (
	input: F.Input,
	f: F
) async throws(F.Failure) -> F.Output {
	return try await f.run(input)
}

@inlinable
public func |> <F: AsyncFunction> (
	input: F.Input,
	f: F
) async -> F.Output {
	return await f.run(input)
}

@inlinable
public func |> <F: SyncThrowingFunction> (
	input: F.Input,
	f: F
) throws(F.Failure) -> F.Output {
	return try f.run(input)
}

@inlinable
public func |> <F: SyncFunction> (
	input: F.Input,
	f: F
) -> F.Output {
	return f.run(input)
}
