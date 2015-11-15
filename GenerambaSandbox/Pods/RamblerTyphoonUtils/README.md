# RamblerTyphoonUtils

[Typhoon](https://github.com/appsquickly/Typhoon) is a great tool, and iOS team in Rambler&Co loves it a lot. Besides actual contributing, we've developed some useful tools which cannot be included in the main project.

1. `RamblerInitialAssemblyCollector` - this class can be used for activating assemblies on startup instead of plist integration.
2. `RamblerTyphoonAssemblyTests` - A base test class used for `TyphoonAssembly` testing.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

RamblerTyphoonUtils is available through [CocoaPods](http://cocoapods.org). To use the `AssemblyCollector`:

```ruby
pod "RamblerTyphoonUtils/AssemblyCollector"
```

To use the `AssemblyTesting`:
```ruby
pod "RamblerTyphoonUtils/AssemblyTesting"
```

**Warning:** do not include `AssemblyTesting` subspec in the main target!

## Authors

- Egor Tolstoy, e.tolstoy@rambler-co.ru
- Irina Dyagileva, i.dyagileva@rambler-co.ru
- Andrey Rezanov, a.rezanov@rambler-co.ru
- Andrey Zarembo-Godzyatsky, a.zarembo-godzyatsky@rambler-co.ru

## License

RamblerTyphoonUtils is available under the MIT license. See the LICENSE file for more info.
