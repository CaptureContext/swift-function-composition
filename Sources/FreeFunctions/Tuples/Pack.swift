// MARK: - Plain

@inlinable
public func pack<each Arg, T>(
	_ f: @escaping (repeat each Arg) -> T
) -> ((repeat each Arg)) -> T {
	return { (args: (repeat each Arg)) in
		f(repeat each args)
	}
}

// MARK: Sendable

@inlinable
public func pack<each Arg, T>(
	sendable f: @escaping @Sendable (repeat each Arg) -> T
) -> @Sendable ((repeat each Arg)) -> T {
	return { (args: (repeat each Arg)) in
		f(repeat each args)
	}
}

// MARK: - Async

@inlinable
public func pack<each Arg, T>(
	_ f: @escaping (repeat each Arg) async -> T
) -> ((repeat each Arg)) async -> T {
	return { (args: (repeat each Arg)) in
		await f(repeat each args)
	}
}

// MARK: Sendable

@inlinable
public func pack<each Arg, T>(
	sendable f: @escaping @Sendable (repeat each Arg) async -> T
) -> @Sendable ((repeat each Arg)) async -> T {
	return { (args: (repeat each Arg)) in
		await f(repeat each args)
	}
}

// MARK: - Throwing

@inlinable
public func pack<each Arg, T>(
	_ f: @escaping (repeat each Arg) throws -> T
) -> ((repeat each Arg)) throws -> T {
	return { (args: (repeat each Arg)) in
		try f(repeat each args)
	}
}

// MARK: Sendable

@inlinable
public func pack<each Arg, T>(
	sendable f: @escaping @Sendable (repeat each Arg) throws -> T
) -> @Sendable ((repeat each Arg)) throws -> T {
	return { (args: (repeat each Arg)) in
		try f(repeat each args)
	}
}


// MARK: - Async Throwing

@inlinable
public func pack<each Arg, T>(
	_ f: @escaping (repeat each Arg) async throws -> T
) -> ((repeat each Arg)) async throws -> T {
	return { (args: (repeat each Arg)) in
		try await f(repeat each args)
	}
}

// MARK: Sendable

@inlinable
public func pack<each Arg, T>(
	sendable f: @escaping @Sendable (repeat each Arg) async throws -> T
) -> @Sendable ((repeat each Arg)) async throws -> T {
	return { (args: (repeat each Arg)) in
		try await f(repeat each args)
	}
}
