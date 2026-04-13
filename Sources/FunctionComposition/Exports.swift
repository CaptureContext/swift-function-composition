#if NominalTypes && canImport(NominalFunctionTypesComposition)
@_exported import NominalFunctionTypesComposition
#endif

// _Currying is already exported from NominalFunctionTypesComposition if available
#if !NominalTypes && Currying && canImport(_Currying)
@_exported import _Currying
#endif

// _Tuples is already exported from NominalFunctionTypesComposition if available
#if !NominalTypes && Tuples && canImport(_Tuples)
@_exported import _Tuples
#endif
