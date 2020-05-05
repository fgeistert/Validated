# Validated

[![Swift 5.2](https://img.shields.io/badge/Swift-5.2-orange.svg)]((https://developer.apple.com/swift))
[![SPM Compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://swift.org/package-manager/)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A rule-based validation framework.

<img src="https://user-images.githubusercontent.com/3149925/80971278-cb581f80-8e1c-11ea-93d0-cc88b122ca6b.gif" height="400"/> <img src="https://user-images.githubusercontent.com/3149925/80971519-330e6a80-8e1d-11ea-9658-16ebbab3b2ca.gif" height="400"/>

## Key Features
- rule-based
- easily extensible
- type-safe
- well tested
- combine support
- input formatting
- optional validation

## About this project

The basic idea is to separate the validation logic from the rest of your project. Validated self-encapsulates all validation logic into reusable rules. All rules are type-safe and tested. Additionally it features input formatting. Fields can also be marked as optional. 

## Usage
The project includes an Example project.

### Getting started

Using `Validated` is very simple and straight-forward.

#### Example with Property Wrapper
```swift
@Validated(rules: [.notEmpty, .isEmail], formatters: [.trimmed, .lowercased])
var email: String?
```

#### Manual validation and formatting
```swift
// validation
let validation = ValidationResult.validate("test@example.com", with: [.notEmpty, .isEmail])
XCTAssertTrue(validation.isValid) // true

// formatting
let newValue = ValidationResult.format("  abc   ", with: [.trimmed, .uppercased])
XCTAssertEqual(newValue, "ABC") // true
```

### Core Components

#### Result
The `ValidationResult` is an `Enum` that has two states:

```swift
case valid(_ value: Value?)
case notValid
```

`.valid` has an associated value, that will return the validated value, if there is one. This is optional, because the strategy can be `.optional`.

The `ValidationResult` also has two computed properties: `isValid` which returns a `Bool` and `value` which returns the optional value.

Additionally, `ValidationResult` houses the `.validate(..)` and `.format(..)` functions to manually invoke a validation and formatting of an input value.

> Note: `ValidationResult` also conforms to the `Equatable` protocol.

#### Rule
A rule is defined with a closure, that receives a `Value` and returns a `Bool`. The `Value` is not optional.

> Right now there are **42** rules included in the standard package.

##### Example
```swift
extension ValidationRule where Value: StringProtocol {
    static var notEmpty: Self {
        return ValidationRule {
            return !$0.isEmpty
        }
    }
}
```

> Note: **return** keywords can be ommitted, to make a rule even more lightweight.

#### Formatter
A formatter is similar to a rule. It is defined as a closure, that receives a `Value` and returns a `Value`. Neither are optional.

> Right now there are **7** formatters included in the standard package.

##### Example
```swift
extension ValidationFormatter where Value == String {    
    static var uppercased: Self {
        return ValidationFormatter {
            return $0.uppercased()
        }
    }
}
```

> Note: **return** keywords can be ommitted, to make a formatter even more lightweight.

#### Strategy
In some situations we only want to validate fields that actually contain something. To deal with this kind of situation `Validated` has two modes, that are reflected in `ValidationStrategy`.

The two modes are:

```swift
case required
case optional
``` 

If you are using a `@Validated` object, you can simply pass the strategy to the property wrapper like this:

```swift
@Validated(rule: .isURL, formatters: [.trimmed, .lowercased], strategy: .optional)
var website: String?
```

> Note: By default, `@Validated` uses the `.required` strategy.

#### Validated

The main usage of this framework is bundled within the `@Validated` property wrapper. It takes care of all the validating, formatting and contains the strategy logic. Additionally it contains optional Combine support. 

Defining it, is very straight-forward:

```swift
@Validated(rules: [.notEmpty, .isEmail], formatters: [.trimmed, .lowercased])
var email: String?
```

> Note: Formatting will be done, before the rules are checked. Therefore, it will validate the formatted values. 

##### Initialization

`@Validated` can be initialized in many ways:

- one `ValidationRule` or an Array of `ValidationRule`s
- zero, one or an Array of `ValidationFormatter`s
- a `ValidationStrategy`. By default, if none provided, it uses the `.required` strategy. 

##### Combine
`@Validated` also contains some Combine extensions. They will only take affect, if `Combine` can be imported. Basically, there are two publishers:

- `validationPublisher` -> publishes a `ValidationResult` for every change to the value.
- `valuePublisher` -> publishes a formatted value, whenever a `.valid` `ValidationResult` occurs. 

> Note: Even though Combine is supported, you can still use it without it. Validated is usable from iOS9+.

##### Projected Value
The projected value returns the `validationPublisher()`. It publishes a `ValidationResult` every time you make a change to the properties' value. 

###### Example

```swift
$email
    .sink { [weak self] (result) in
        switch result {
        case .valid(let value):
            self?.passwordValidLabel.text = "✅"
            print("new password: valid -> \(value ?? "nil")")
        case .notValid:
            self?.passwordValidLabel.text = "❌"
            print("new password: notValid")
        }
    }
    .store(in: &cancellables)
```

> Note: Make sure you connect your TextField to your `@Validated` object. This can be done by binding your TextField values to the property with Combine or using the NotificationCenter. Examples of how this can be done are included in the Example project.

## Customization

`Validated` was designed to make it easily extensible. Therefore making your own rules and formatters is encouraged. If you think that you created a rule or a formatter that would fit into the standard library, feel free to create a pull request. 

> Note: Every Rule and Formatter should be tested.

#### Making your own Rule

Here is an example of how you could make your own rule called `isAwesome`. 

```swift
extension ValidationRule where Value == String {
    static var isAwesome: Self {
        return ValidationRule {
            return $0 == "Awesome"
        }
    }
}
```

This could also be written like this:

```swift
extension ValidationRule {
    static var isAwesome<String>: Self {
        ValidationRule { $0 == "Awesome" }
    }
}
```

> Note: You can also have static functions that take additional input to validate.

#### Making your own Formatter

Here is an example of how you could make your own formatter called `replacedAWithB`, that replaces every occurance of `A` with a `B`.

```swift
extension ValidationFormatter where Value == String {
    static var replacedAWithB: Self {
        return ValidationFormatter {
            return $0.replacingOccurrences(of: "A", with: "B")
        }
    }
}
```

This could also be written like this:

```swift
extension ValidationFormatter {
    static var replacedAWithB<String>: Self {
        ValidationFormatter { $0.replacingOccurrences(of: "A", with: "B") }
    }
}
```

## Naming Conventions

There are certain naming conventions that should be followed to guarantee simple code and improve readability.

### ValidationRule
Every `ValidationRule` should be named in the present tense and should be treated in the third person. They should also be as short as possible while also being as expressive as possible.

Examples:

- `notEmpty`
- `contains`
- `startsWith`
- `isNumber`
- `isEmail`

### ValidationFormatter
Every `ValidationFormatter` should be named in the simple past tense (e.g. `trimmed` or `uppercased`). The reason behind this is, that formatters are applied inside the `@Validated` object, before it is returned when accessing the value. Therefore, the formatters have already been applied and the text is now `trimmed` or `uppercased`.

## Installation
### Swift Package Manager (Recommended)
Add the following dependency to your `Package.swift` file:
```
.package(url: "https://github.com/fgeistert/Validated.git", from: "1.0.1")
```

### Cartage
Add the following line to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile).

```
github "fgeistert/Validated" ~> 1.0.1
```

Then run `carthage update`.
### Manually
Just drag and drop the `.swift` files from the `Validated` folder into your project.

## Version Compatibility
Validated is built with Swift 5.2. It supports iOS9+.

## Contributing
- Open an issue
- Fork it
- Create new branch
- Commit all your changes to your branch
- Create a pull request

## Contact
You can [check out my website](https://fgeistert.com/) or [follow me on twitter](https://twitter.com/fgeistert).

