public protocol _MainActorNominalFunctionTypeMarker<
	Input,
	Output
> {
	associatedtype Input
	associatedtype Output
}

extension MainActorAsyncFunc: _MainActorNominalFunctionTypeMarker {}
extension MainActorAsyncThrowingFunc: _MainActorNominalFunctionTypeMarker {}
extension MainActorSyncFunc: _MainActorNominalFunctionTypeMarker {}
extension MainActorSyncThrowingFunc: _MainActorNominalFunctionTypeMarker {}
