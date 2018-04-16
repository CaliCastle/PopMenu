
# ![](https://raw.githubusercontent.com/CaliCastle/PopMenu/master/.assets/popmenu_banner.jpg)

<p align="center">
    <a href="https://swift.org"><img src="https://img.shields.io/badge/swift-4%2B-orange.svg"></a>
    <a href="https://cocoapods.org/pods/NewPopMenu"><img src="https://img.shields.io/cocoapods/v/NewPopMenu.svg"></a>
    <a href="https://cocoapods.org/pods/NewPopMenu"><img src="https://img.shields.io/badge/pod%20name-NewPopMenu-5ba36b.svg"></a>
    <a href="https://cocoapods.org/pods/NewPopMenu"><img src="https://img.shields.io/cocoapods/p/NewPopMenu.svg"></a>
    <a href="https://cocoapods.org/pods/NewPopMenu"><img src="https://img.shields.io/cocoapods/l/NewPopMenu.svg"></a>
    <a href="https://calicastle.github.io/PopMenu/"><img src="https://img.shields.io/badge/see-Documentation-green.svg"></a>
</p>

## ⚙️ Installation

### For CocoaPods

Install **PopMenu** using [**CocoaPods**](https://cocoapods.org), add it to your **Podfile**:

> `PopMenu` was actually taken so let's call it `NewPopMenu` 'cause why not?

```ruby
pod 'NewPopMenu'
```

### For Carthage

Install **PopMenu** using [**Carthage**](https://github.com/Carthage/Carthage), add it to your **Cartfile**:

```text
github "CaliCastle/PopMenu"
```

## ⚠️ Requirements

* Xcode 8.0 +
* iOS 9.0 +
* Swift 4.0 +

## 👨🏻‍💻 How to Use

Integrating **PopMenu** is extremely easy with a familiar workflow like presenting `UIAlertController` with `UIAlertAction`

### Import Library \(NewPopMenu\)

```text
import NewPopMenu
```

### Basic Usage

There are 2 ways to present the menu in your view controller:

1. **Use the default manager**

2. **Use the `PopMenuViewController` class directly**

You can, however, choose either way to have the same result, whichever works best for you.

#### Which Should I Use?

Use the default manager if you want quick setup and present menu seamlessly.
 
Use the `PopMenuViewController` class directly if you want to have more control.

**If you don't want to scroll, click the link to jump forward:**

[Basic Usage - Using Manager](#using-manager)

[Basic Usage - Using Controller](#using-controller)

-------

### <a name="using-manager"></a> Basic Usage - Using Manager

The quickest way would be to use `PopMenuManager`'s _**default**_ singleton with no additional setup required:

```swift
let manager = PopMenuManager.default
```

**or**

If you prefer to manually initialize the controller:

```swift
let menuViewController = PopMenuViewController()
```

Add **actions** if you're using the manager:

```swift
manager.actions = [
    PopMenuDefaultAction(title: "Action Title 1", image: UIImage(named: "icon"),
    PopMenuDefaultAction(title: "Action Title 2", image: UIImage(named: "icon")
]
```

Or if you prefer the good ol' way to present a `UIAlertController` with `actionSheet` type, you can add each action like this:

```swift
let action1 = PopMenuDefaultAction(title: "Action Title 1", image: UIImage(named: "icon")
let action2 = PopMenuDefaultAction(title: "Action Title 2", image: UIImage(named: "icon")

manager.addAction(action1)
manager.addAction(action2)
```

That's how you set the actions for the menu.

Now all you have to do is to simply call `present()` on the manager, either pass the view controller in the `on` argument or PopMenuManager will automatically fetch the current top view controller to present the menu on top:

```swift
// Show menu without specifying which controller
manager.present()

// Or you can specify the controller to present on
manager.present(on: self)
```

Both should **work just fine**, but still, using `manager.present(on: ...)` manually would be a _**safer**_ way to go for presenting.

-------

### <a name="using-controller"></a> Basic Usage - Using Controller

-------

### Action Callback

In order to know which action button is tapped, you'll need to comform to `PopMenuViewControllerDelegate` protocol and then implement the method `popMenuDidSelectItem(at index: Int)` in your view controller:

```swift
class ViewController: UIViewController {
    
    func presentMenu() {
        let manager = PopMenuManager.default
        
        manager.popMenuDelegate = self
        
        manager.present(on: self)
    }

}

extension ViewController: PopMenuViewControllerDelegate {

    func popMenuDidSelectItem(at index: Int) {
        // Do stuff here...
    }
    
}
```

## 📗 Check Documentation

Documentation is available at [**https://calicastle.github.io/PopMenu/**](https://calicastle.github.io/PopMenu/)

