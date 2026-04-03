# swift-function-composition

[![CI](https://github.com/capturecontext/swift-function-composition/actions/workflows/ci.yml/badge.svg)](https://github.com/capturecontext/swift-function-composition/actions/workflows/ci.yml) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fcapturecontext%2Fswift-function-composition%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/capturecontext/swift-function-composition) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fcapturecontext%2Fswift-function-composition%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/capturecontext/swift-function-composition)

## Table of Contents

- [Motivation](#motivation)
- [Usage](#usage)
- [Installation](#installation)
- [License](#license)

## Motivation

## Usage

## Installation

### Basic

You can add `swift-function-composition` to an Xcode project by adding it as a package dependency.

1. From the **File** menu, select **Swift Packages › Add Package Dependency…**
2. Enter [`"https://github.com/capturecontext/swift-function-composition"`](https://github.com/capturecontext/swift-function-composition) into the package repository URL text field
3. Choose products you need to link to your project.

### Recommended

If you use SwiftPM for your project structure, add `swift-function-composition` dependency to your package file

```swift
.package(
  url: "https://github.com/capturecontext/swift-function-composition.git", 
  .upToNextMinor(from: "0.0.1"),
  traits: [<#Traits#>]
)
```

Available traits:
- `NominalTypes` – _Enables nominal function types_
- `Operators` – _Enables operators for composition_
- `Methods` – _Enables methods for composition of nominal function types_
- `Functions` – _Enables global functions for composition of nominal function types_
- `Currying` – _Enables exports of curry, uncurry and flip functions_

Do not forget about target dependencies

```swift
.product(
  name: "FunctionComposition", 
  package: "swift-function-composition"
)
```

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
