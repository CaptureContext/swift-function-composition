// swift-tools-version: 6.1

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
			name: "FunctionComposition",
			targets: ["FunctionComposition"]
		),
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
			name: "NominalFunctionTypesComposition",
			targets: ["NominalFunctionTypesComposition"]
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
			name: "FunctionComposition",
			dependencies: [
				.target(
					name: "NominalFunctionTypesComposition",
					condition: .when(traits: ["NominalTypes"])
				),
			]
		),
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
			name: "NominalFunctionTypesComposition",
			dependencies: [
				.target(
					name: "NominalFunctionTypesCompositionFunctions",
					condition: .when(traits: ["Functions"])
				),
				.target(
					name: "NominalFunctionTypesCompositionMethods",
					condition: .when(traits: ["Methods"])
				),
				.target(
					name: "NominalFunctionTypesCompositionOperators",
					condition: .when(traits: ["Operators"])
				),
				.target(
					name: "_Currying",
					condition: .when(traits: ["Currying"])
				),
			],
			path: "Sources/NominalFunctionTypesComposition/Sources"
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

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// Workaround to ensure that all traits are included in documentation. Swift Package Index adds
// SPI_GENERATE_DOCS (https://github.com/SwiftPackageIndex/SwiftPackageIndex-Server/issues/2336)
// when building documentation, so only tweak the default traits in this condition.
let spiGenerateDocs = ProcessInfo.processInfo.environment["SPI_GENERATE_DOCS"] != nil

// Enable all traits for other CI actions.
let enableAllTraitsExplicit = ProcessInfo.processInfo.environment["ENABLE_ALL_TRAITS"] != nil

let enableAllTraits = spiGenerateDocs || enableAllTraitsExplicit

package.traits.formUnion([
	.trait(
		name: "NominalTypes",
		description: "Enables nominal function types"
	),
	.trait(
		name: "Functions",
		description: "Enables global functions for composition"
	),
	.trait(
		name: "Currying",
		description: "Enables exports of curry, uncurry and flip functions"
	),
	.trait(
		name: "Operators",
		description: "Enables operators for composition"
	),
	.trait(
		name: "Methods",
		description: "Enables methods for composition of nominal function types"
	),
])

package.traits.insert(.default(
	enabledTraits: Set(enableAllTraits ? package.traits.map(\.name) : [])
))
