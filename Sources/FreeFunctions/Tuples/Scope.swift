// MARK: - Plain

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) -> B
) -> (A) -> (B) {
	return { f($0) }
}

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) -> B
) -> (A, A) -> (B, B) {
	return { (f($0), f($1)) }
}

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) -> B
) -> (A, A, A) -> (B, B, B) {
	return { (f($0), f($1), f($2)) }
}

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) -> B
) -> (A, A, A, A) -> (B, B, B, B) {
	return { (f($0), f($1), f($2), f($3)) }
}

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) -> B
) -> (A, A, A, A, A) -> (B, B, B, B, B) {
	return { (f($0), f($1), f($2), f($3), f($4)) }
}

// MARK: Sendable

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) -> B
) -> @Sendable (A) -> (B) {
	return { f($0) }
}

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) -> B
) -> @Sendable (A, A) -> (B, B) {
	return { (f($0), f($1)) }
}

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) -> B
) -> @Sendable (A, A, A) -> (B, B, B) {
	return { (f($0), f($1), f($2)) }
}

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) -> B
) -> @Sendable (A, A, A, A) -> (B, B, B, B) {
	return { (f($0), f($1), f($2), f($3)) }
}

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) -> B
) -> @Sendable (A, A, A, A, A) -> (B, B, B, B, B) {
	return { (f($0), f($1), f($2), f($3), f($4)) }
}

// MARK: - Async

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) async -> B
) -> (A) async -> (B) {
	return { await f($0) }
}

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) async -> B
) -> (A, A) async -> (B, B) {
	return { await (f($0), f($1)) }
}

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) async -> B
) -> (A, A, A) async -> (B, B, B) {
	return { await (f($0), f($1), f($2)) }
}

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) async -> B
) -> (A, A, A, A) async -> (B, B, B, B) {
	return { await (f($0), f($1), f($2), f($3)) }
}

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) async -> B
) -> (A, A, A, A, A) async -> (B, B, B, B, B) {
	return { await (f($0), f($1), f($2), f($3), f($4)) }
}

// MARK: Sendable

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) async -> B
) -> @Sendable (A) async -> (B) {
	return { await f($0) }
}

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) async -> B
) -> @Sendable (A, A) async -> (B, B) {
	return { await (f($0), f($1)) }
}

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) async -> B
) -> @Sendable (A, A, A) async -> (B, B, B) {
	return { await (f($0), f($1), f($2)) }
}

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) async -> B
) -> @Sendable (A, A, A, A) async -> (B, B, B, B) {
	return { await (f($0), f($1), f($2), f($3)) }
}

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) async -> B
) -> @Sendable (A, A, A, A, A) async -> (B, B, B, B, B) {
	return { await (f($0), f($1), f($2), f($3), f($4)) }
}

// MARK: - Throwing

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) throws -> B
) -> (A) throws -> (B) {
	return { try f($0) }
}

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) throws -> B
) -> (A, A) throws -> (B, B) {
	return { try (f($0), f($1)) }
}

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) throws -> B
) -> (A, A, A) throws -> (B, B, B) {
	return { try (f($0), f($1), f($2)) }
}

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) throws -> B
) -> (A, A, A, A) throws -> (B, B, B, B) {
	return { try (f($0), f($1), f($2), f($3)) }
}

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) throws -> B
) -> (A, A, A, A, A) throws -> (B, B, B, B, B) {
	return { try (f($0), f($1), f($2), f($3), f($4)) }
}

// MARK: Sendable

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) throws -> B
) -> @Sendable (A) throws -> (B) {
	return { try f($0) }
}

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) throws -> B
) -> @Sendable (A, A) throws -> (B, B) {
	return { try (f($0), f($1)) }
}

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) throws -> B
) -> @Sendable (A, A, A) throws -> (B, B, B) {
	return { try (f($0), f($1), f($2)) }
}

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) throws -> B
) -> @Sendable (A, A, A, A) throws -> (B, B, B, B) {
	return { try (f($0), f($1), f($2), f($3)) }
}

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) throws -> B
) -> @Sendable (A, A, A, A, A) throws -> (B, B, B, B, B) {
	return { try (f($0), f($1), f($2), f($3), f($4)) }
}


// MARK: - Async Throwing

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) async throws -> B
) -> (A) async throws -> (B) {
	return { try await f($0) }
}

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) async throws -> B
) -> (A, A) async throws -> (B, B) {
	return { try await (f($0), f($1)) }
}

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) async throws -> B
) -> (A, A, A) async throws -> (B, B, B) {
	return { try await (f($0), f($1), f($2)) }
}

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) async throws -> B
) -> (A, A, A, A) async throws -> (B, B, B, B) {
	return { try await (f($0), f($1), f($2), f($3)) }
}

@inlinable
public func scope<A, B>(
	_ f: @escaping (A) async throws -> B
) -> (A, A, A, A, A) async throws -> (B, B, B, B, B) {
	return { try await (f($0), f($1), f($2), f($3), f($4)) }
}

// MARK: Sendable

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) async throws -> B
) -> @Sendable (A) async throws -> (B) {
	return { try await f($0) }
}

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) async throws -> B
) -> @Sendable (A, A) async throws -> (B, B) {
	return { try await (f($0), f($1)) }
}

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) async throws -> B
) -> @Sendable (A, A, A) async throws -> (B, B, B) {
	return { try await (f($0), f($1), f($2)) }
}

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) async throws -> B
) -> @Sendable (A, A, A, A) async throws -> (B, B, B, B) {
	return { try await (f($0), f($1), f($2), f($3)) }
}

@inlinable
public func scope<A, B>(
	sendable f: @escaping @Sendable (A) async throws -> B
) -> @Sendable (A, A, A, A, A) async throws -> (B, B, B, B, B) {
	return { try await (f($0), f($1), f($2), f($3), f($4)) }
}
