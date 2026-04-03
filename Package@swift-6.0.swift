// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "swift-function-composition",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
		.tvOS(.v13),
		.watchOS(.v6),
		.macCatalyst(.v13),
		.visionOS(.v1),
	],
	products: [
		.library(
			name: "Either",
			targets: ["Either"]
		),
		.library(
			name: "_Currying",
			targets: ["_Currying"]
		),
		.library(
			name: "NominalFunctionTypes",
			targets: ["NominalFunctionTypes"]
		),
		.library(
			name: "NominalFunctionTypesCompositionFunctions",
			targets: ["NominalFunctionTypesCompositionFunctions"]
		),
		.library(
			name: "NominalFunctionTypesCompositionMethods",
			targets: ["NominalFunctionTypesCompositionMethods"]
		),
		.library(
			name: "NominalFunctionTypesCompositionOperators",
			targets: ["NominalFunctionTypesCompositionOperators"]
		),
	],
	dependencies: [
		.package(
			url: "https://github.com/pointfreeco/swift-concurrency-extras.git",
			from: "1.3.2"
		),
	],
	targets: [
		.target(
			name: "Either",
			path: "Sources/Monads/Either"
		),
		.target(
			name: "_Currying",
			path: "Sources/FreeFunctions/Curry"
		),
		.target(
			name: "FunctionCompositionOperators",
			dependencies: []
		),
		.target(
			name: "NominalFunctionTypes",
			dependencies: [
				.target(name: "Either"),
				.product(
					name: "ConcurrencyExtras",
					package: "swift-concurrency-extras"
				),
			]
		),
		.target(
			name: "NominalFunctionTypesCompositionFunctions",
			dependencies: [
				.target(name: "NominalFunctionTypes"),
			],
			path: "Sources/NominalFunctionTypesComposition/Functions"
		),
		.target(
			name: "NominalFunctionTypesCompositionMethods",
			dependencies: [
				.target(name: "NominalFunctionTypes"),
			],
			path: "Sources/NominalFunctionTypesComposition/Methods"
		),
		.target(
			name: "NominalFunctionTypesCompositionOperators",
			dependencies: [
				.target(name: "NominalFunctionTypes"),
				.target(name: "FunctionCompositionOperators"),
			],
			path: "Sources/NominalFunctionTypesComposition/Operators"
		),
		.testTarget(
			name: "NominalFunctionTypesCompositionOperatorsTests",
			dependencies: [
				.target(name: "NominalFunctionTypesCompositionOperators"),
			],
			path: "Tests/NominalFunctionTypesCompositionTests/Operators"
		),
		.testTarget(
			name: "NominalFunctionTypesCompositionMethodsTests",
			dependencies: [
				.target(name: "NominalFunctionTypesCompositionMethods"),
			],
			path: "Tests/NominalFunctionTypesCompositionTests/Methods"
		),
		.testTarget(
			name: "NominalFunctionTypesCompositionFunctionsTests",
			dependencies: [
				.target(name: "NominalFunctionTypesCompositionFunctions"),
			],
			path: "Tests/NominalFunctionTypesCompositionTests/Functions"
		),
	],
	swiftLanguageModes: [.v6]
)
