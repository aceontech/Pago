# Pago
Mini-framework for managing a UIPageViewController with Swift and Storyboards <br /> #WIP

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Installation

Only [Carthage](https://github.com/Carthage) for now. 
There are currently no tagged versions yet, so you will have to pull it from the master branch:

```ruby
github "jarrroo/Pago" "master"
```

## Minimum requirements

To use Pago, you will need to:

- iOS 8.0 and higher + Swift 2
- Use a `UIPageViewController` on a Storyboard
- Implement a (view)model which adopts `PageViewControllerViewModel`

## Usage

To use Pago, you need to adopt the `PageViewControllerViewModel` protocol on your (view)model class and set the `pages` property:

```swift
import Pago

class ExampleViewModel : PageViewControllerViewModel {
    var pages: [Page]
    
    required init() {
        self.pages = [
            BasicPage(id: "first", storyboardResource: ("Main", "firstController")),
            BasicPage(id: "second", storyboardResource: ("Main", "secondController")),
        ]
    }
}
```

Note that `"firstController"` and `"secondController"` point to the value entered in the `Storyboard ID` field in the 
`Identity Inspector` of Interface Builder, of the `Main` .storyboard file in your app bundle.

In the `viewDidLoad()` of the `UIPageViewController` hooked to the storyboard resource, simply embed an instance of 
`PageViewController`, generically typed to your (view)model, like so:

```swift
import Pago

class ExampleViewController: UIPageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        PageViewController<ExampleViewModel>().makeChildController(of: self)
    }
}
```

That's it! Pago will handle all the boilerplate. Simply provide it with a set of `Page` values through its model.

-----

Pago, or 'paĝo', is [Esperanto](https://translate.google.com/?ie=UTF-8&hl=en&client=tw-ob#auto/eo/page) for 'page'. Inspired by 
[@abexlumberg](https://twitter.com/abexlumberg) from the 
[Startup podcast at Gimlet Media](https://gimletmedia.com/episode/5-how-to-name-your-company/) ^.^
