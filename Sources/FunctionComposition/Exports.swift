#if NominalTypes && canImport(NominalFunctionTypesComposition)
@_exported import NominalFunctionTypesComposition

// _Currying is already exported from NominalFunctionTypesComposition if available
#elseif Currying && canImport(_Currying)
@_exported import _Currying
#endif
