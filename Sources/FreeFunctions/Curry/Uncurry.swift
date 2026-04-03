@inlinable
public func uncurry<A, B, C>(
	_ _f: @escaping (A) -> (B) -> C
) -> (A, B) -> C {
	return { a, b in
		_f(a)(b)
	}
}

@inlinable
public func uncurry<A, B, C, D>(
	_ _f: @escaping (A) -> (B) -> (C) -> D
) -> (A, B, C) -> D {
	return { a, b, c in
		_f(a)(b)(c)
	}
}

@inlinable
public func uncurry<A, B, C, D, E>(
	_ _f: @escaping (A) -> (B) -> (C) -> (D) -> E
) -> (A, B, C, D) -> E {
	return { a, b, c, d in
		_f(a)(b)(c)(d)
	}
}

@inlinable
public func uncurry<A, B, C, D, E, F>(
	_ _f: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> F
) -> (A, B, C, D, E) -> F {
	return { a, b, c, d, e in
		_f(a)(b)(c)(d)(e)
	}
}
