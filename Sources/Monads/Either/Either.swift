public enum Either<Left, Right> {
	case left(Left)
	case right(Right)
}

extension Either: Equatable where Left: Equatable, Right: Equatable {}
extension Either: Hashable where Left: Hashable, Right: Hashable {}
extension Either: Sendable where Left: Sendable, Right: Sendable {}
extension Either: Error where Left: Error, Right: Error {}
