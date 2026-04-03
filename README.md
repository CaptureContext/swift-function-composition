# swift-function-composition

[![CI](https://github.com/capturecontext/swift-function-composition/actions/workflows/ci.yml/badge.svg)](https://github.com/capturecontext/swift-function-composition/actions/workflows/ci.yml) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fcapturecontext%2Fswift-function-composition%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/capturecontext/swift-function-composition) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fcapturecontext%2Fswift-function-composition%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/capturecontext/swift-function-composition)

## Table of Contents

- [Motivation](#motivation)
- [Usage](#usage)
- [Installation](#installation)
- [License](#license)

## Motivation

Function composition is a practical way to build larger behavior from small, focused transformations. Keeping each step small makes it easier to test, reuse, and reason about, while composition keeps the final pipeline readable and local to the call site.

In Swift, that style is often expressed with plain closure types and lightweight helpers. That works well for straightforward cases, and similar composition tools already exist in the ecosystem.

The harder problem appears when composition and overload selection need to account for more than a raw `(A) -> B` shape. Once `async`, `throws`, `Sendable`, or `MainActor` isolation become part of the contract, structural function types do not give the compiler a strong nominal surface to resolve against reliably.

`swift-function-composition` approaches that problem by wrapping closures in nominal types and composing those explicit wrapper types instead of raw signatures. That gives overloads something concrete to target and lets composed values preserve the strongest semantics available in the chain.

## Usage

The examples below assume you import `FunctionComposition` and enable `NominalTypes` plus the corresponding `Operators`, `Methods`, or `Functions` traits in SwiftPM.

### 1. Choose a wrapper

Use the base wrappers when you only need the core effect model:

- `SyncFunc<Input, Output>`
- `SyncThrowingFunc<Input, Output, Failure>`
- `AsyncFunc<Input, Output>`
- `AsyncThrowingFunc<Input, Output, Failure>`

Specialized variants refine those same families:

- `Sendable...` variants represent functions whose value is sendable.
- `MainActor...` variants represent functions isolated to `MainActor`.

All wrappers expose `run(with:)` and `callAsFunction(_:)`, so they can be invoked explicitly or used much like ordinary closures.

### 2. Compose wrapped functions

Start by wrapping the functions you want to combine:

```swift
import FunctionComposition

let isNotZero = SyncFunc<Int, Bool> { $0 != 0 }
let describe = SyncFunc<Bool, String> { $0 ? "true" : "false" }
```

The same composition model is available through operators, methods, and free functions:

Operators:

```swift
let f = SyncFunc(\.count) <<< describe <<< isNotZero
let result = f.run(with: 10) // 2
```

Methods:

```swift
let f = describe.compose(isNotZero).compose(SyncFunc(\.count))
let result = f.run(with: 10) // 2
```

Functions:

```swift
let f = compose(SyncFunc(\.count), describe, isNotZero)
let result = f.run(with: 10) // 2
```

> [!Note]
>
> _Functions API is more limited for chaining than Methods or Operators APIs:_
>
> - _Max variadic parameters count is 4_
> - _Variadic parameters overloads will preserve MainActor only if all accepted wrappers are MainActor wrappers_

### 3. Convert into stronger wrappers when needed

Base wrappers can be promoted into stronger variants when you know more about the function than the original type encodes.

Use `.uncheckedSendable()` to wrap a base function as a sendable one when you know that crossing concurrency boundaries is safe:

```swift
let sendableIsNotZero = SyncFunc<Int, Bool> { $0 != 0 }
  .uncheckedSendable()
```

Use `.mainActor()` on sendable wrappers when `Input` and `Output` are `Sendable` and the function should be treated as main-actor isolated:

```swift
let mainActorDescribe = SendableSyncFunc<Bool, String> { $0 ? "true" : "false" }
  .mainActor()
```

These conversion helpers are intentionally explicit. `uncheckedSendable()` is an unchecked promise made by the caller, while `mainActor()` upgrades a sendable wrapper into the corresponding `MainActor` variant.

### 4. Preservation rules

Composition returns the nominal wrapper that matches the strongest semantics required by the chain. The effect model combines monotonically:

- `sync` + `async` → `async`
- `non-throwing` + `throwing` → `throwing`
- `Sendable` + `~Sendable` → `~Sendable`
- `Sendable` + `MainActor` becomes `MainActor`
- `~Sendable` + `MainActor` is not supported

For example:

```swift
let loadFlag = SendableAsyncThrowingFunc<Int, Bool, Never> { $0 != 0 }
let describe = SendableSyncFunc<Bool, String> { $0 ? "true" : "false" }

// SendableAsyncThrowingFunc<Int, String, Never>
let f = describe <<< loadFlag
```

When two throwing functions use different failure types, the composed failure is represented with `Either`. `MainActor` wrappers preserve main-actor isolation for the compatible sendable compositions supported by the library.

### 5. Choose an API surface

`FunctionComposition` re-exports the nominal composition modules that match the traits enabled in your package. Enable `Operators`, `Methods`, or `Functions` to choose the surface you prefer, and use `pipe(...)` when you want the free-function API in forward order.

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
  traits: [<#Traits#>] // swift-tools-version>=6.1
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

> [!Note]
>
> _Some products like `FunctionComposition` require `swift-tools-version>=6.1`, if you're using older toolchain, refer to [Package@swift-6.0.swift](Package@swift-6.0.swift) to figure out supported products_

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
