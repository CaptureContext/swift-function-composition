public protocol _AnyNominalFunctionType {}

public protocol _NominalFunctionType<Input, Output>: _AnyNominalFunctionType {
	associatedtype Input
	associatedtype Output
}
