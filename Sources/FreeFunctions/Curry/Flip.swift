@inlinable
public func flip1<A, B, C>(
	_ f: @escaping (A) -> (B) -> C
) -> (B) -> (A) -> C {
	return { b in
		{ a in f(a)(b) }
	}
}

@inlinable
public func flip1<A, B, C, D>(
	_ f: @escaping (A) -> (B) -> (C) -> D
) -> (B) -> (A) -> (C) -> D {
	return { b in
		{ a in f(a)(b) }
	}
}

@inlinable
public func flip1<A, B, C, D, E>(
	_ f: @escaping (A) -> (B) -> (C) -> (D) -> E
) -> (B) -> (A) -> (C) -> (D) -> E {
	return { b in
		{ a in f(a)(b) }
	}
}

@inlinable
public func flip1<A, B, C, D, E, F>(
	_ f: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> F
) -> (B) -> (A) -> (C) -> (D) -> (E) -> F {
	return { b in
		{ a in f(a)(b) }
	}
}

@inlinable
public func flip2<A, B, C, D>(
	_ f: @escaping (A) -> (B) -> (C) -> D
) -> (A) -> (C) -> (B) -> D {
	return { a in
		{ c in
			{ b in f(a)(b)(c) }
		}
	}
}

@inlinable
public func flip2<A, B, C, D, E>(
	_ f: @escaping (A) -> (B) -> (C) -> (D) -> E
) -> (A) -> (C) -> (B) -> (D) -> E {
	return { a in
		{ c in
			{ b in f(a)(b)(c) }
		}
	}
}

@inlinable
public func flip2<A, B, C, D, E, F>(
	_ f: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> F
) -> (A) -> (C) -> (B) -> (D) -> (E) -> F {
	return { a in
		{ c in
			{ b in f(a)(b)(c) }
		}
	}
}

@inlinable
public func flip3<A, B, C, D, E>(
	_ f: @escaping (A) -> (B) -> (C) -> (D) -> E
) -> (A) -> (B) -> (D) -> (C) -> E {
	return { a in
		{ b in
			{ d in
				{ c in
					f(a)(b)(c)(d)
				}
			}
		}
	}
}

@inlinable
public func flip3<A, B, C, D, E, F>(
	_ f: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> F
) -> (A) -> (B) -> (D) -> (C) -> (E) -> F {
	return { a in
		{ b in
			{ d in
				{ c in
					f(a)(b)(c)(d)
				}
			}
		}
	}
}

@inlinable
public func flip4<A, B, C, D, E, F>(
	_ f: @escaping (A) -> (B) -> (C) -> (D) -> (E) -> F
) -> (A) -> (B) -> (C) -> (E) -> (D) -> F {
	return { a in
		{ b in
			{ c in
				{ e in
					{ d in
						f(a)(b)(c)(d)(e)
					}
				}
			}
		}
	}
}
