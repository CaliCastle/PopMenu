
# ![](https://raw.githubusercontent.com/CaliCastle/PopMenu/master/.gitbook/assets/popmenu_banner.jpg)

<p align="center">
    <a href="https://swift.org"><img src="https://img.shields.io/badge/swift-4%2B-orange.svg"></a>
    <a href="https://cocoapods.org/pods/NewPopMenu"><img src="https://img.shields.io/cocoapods/v/NewPopMenu.svg"></a>
    <a href="https://cocoapods.org/pods/NewPopMenu"><img src="https://img.shields.io/badge/pod%20name-NewPopMenu-5ba36b.svg"></a>
    <a href="https://cocoapods.org/pods/NewPopMenu"><img src="https://img.shields.io/cocoapods/p/NewPopMenu.svg"></a>
    <a href="https://cocoapods.org/pods/NewPopMenu"><img src="https://img.shields.io/cocoapods/l/NewPopMenu.svg"></a>
    <a href="https://cali.gitbook.io/popmenu/"><img src="https://img.shields.io/badge/docs-PopMenu-B4666C.svg"></a>
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

Integrating **PopMenu** is extremely easy with a familiar workflow just like `UIAlertController` and `UIAlertAction`

### Import Library \(NewPopMenu\)

```text
import NewPopMenu
```

### Basic Usage

The quickest way would be to use `PopMenuManager`'s _**default**_ singleton with no additional setup required:

```swift
let manager = PopMenuManager.default
```

Now that you've got the manager ready, you can go ahead and add **actions** to the manager:

```swift
manager.actions = [
    PopMenuDefaultAction(title: "Action Title 1", image: UIImage(named: "icon"),
    PopMenuDefaultAction(title: "Action Title 2", image: UIImage(named: "icon")
]
```

Or if you prefer the good ol' ways to present a `UIAlertController` with `actionSheet` type, you can add each action like this:

```swift
let action1 = PopMenuDefaultAction(title: "Action Title 1", image: UIImage(named: "icon")
let action2 = PopMenuDefaultAction(title: "Action Title 2", image: UIImage(named: "icon")

manager.addAction(action1)
manager.addAction(action2)
```

That's how you set the actions for the menu.

Now all you have to do is to simply call `present()` on the manager, either pass the view controller in the `above` argument or PopMenuManager will automatically fetch the current top view controller to present the menu on top:

```swift
class ViewController: UIViewController {

    /// i.e. button in the Storyboard is tapped.
    @IBAction func presentMenu(_ sender: UIButton) {
    
        // Show menu without specifying which controller to present from
        manager.present()
        
        // Or you can specify the controller
        manager.present(above: self)
        
    }  
     
}
```

Both should **work just fine**, but still, using `manager.present(above: ...)` manually would be a _**safer**_ way to go for presenting.

## 📗 Complete Documentation

Documentation is available at [**https://cali.gitbook.io/popmenu**](https://cali.gitbook.io/popmenu)

