@inlinable
public func curry<A, B, C>(
	_ function: @escaping (A, B) -> C) -> (A) -> (B
	) -> C {
	return { (a: A) -> (B) -> C in
		{ (b: B) -> C in
			function(a, b)
		}
	}
}

@inlinable
public func curry<A, B, C, D>(
	_ function: @escaping (A, B, C) -> D
) -> (A) -> (B) -> (C) -> D {
	return { (a: A) -> (B) -> (C) -> D in
		{ (b: B) -> (C) -> D in
			{ (c: C) -> D in
				function(a, b, c)
			}
		}
	}
}

@inlinable
public func curry<A, B, C, D, E>(
	_ function: @escaping (A, B, C, D) -> E
) -> (A) -> (B) -> (C) -> (D) -> E {
	return { (a: A) -> (B) -> (C) -> (D) -> E in
		{ (b: B) -> (C) -> (D) -> E in
			{ (c: C) -> (D) -> E in
				{ (d: D) -> E in
					function(a, b, c, d)
				}
			}
		}
	}
}

@inlinable
public func curry<A, B, C, D, E, F>(
	_ function: @escaping (A, B, C, D, E) -> F
) -> (A) -> (B) -> (C) -> (D) -> (E) -> (F) {
	return { (a: A) -> (B) -> (C) -> (D) -> (E) -> F in
		{ (b: B) -> (C) -> (D) -> (E) -> F in
			{ (c: C) -> (D) -> (E) -> F in
				{ (d: D) -> (E) -> F in
					{ (e: E) -> F in
						function(a, b, c, d, e)
					}
				}
			}
		}
	}
}
