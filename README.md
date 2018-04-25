
# ![](https://raw.githubusercontent.com/CaliCastle/PopMenu/master/.assets/popmenu_banner.jpg)

<p align="center">
    <a href="https://join.slack.com/t/newpopmenu/shared_invite/enQtMzQ4OTExMzE0OTM1LWFhM2IxYmYxOGZmMTgzNjQxMWRiNzUyZmYwN2M4ZmQ2YWYxY2VhNWI3MDlmM2JhOTM5NjAwODlmNjQzMmVlODM"><img src="https://img.shields.io/badge/join-slack-lightgray.svg"></a>
    <a href="https://swift.org"><img src="https://img.shields.io/badge/swift-4%2B-orange.svg"></a>
    <a href="https://cocoapods.org/pods/NewPopMenu"><img src="https://img.shields.io/cocoapods/v/NewPopMenu.svg"></a>
    <a href="https://cocoapods.org/pods/NewPopMenu"><img src="https://img.shields.io/badge/pod%20name-NewPopMenu-5ba36b.svg"></a>
    <a href="https://cocoapods.org/pods/NewPopMenu"><img src="https://img.shields.io/cocoapods/p/NewPopMenu.svg"></a>
    <a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-support-B160B6.svg"></a>
    <a href="https://calicastle.github.io/PopMenu/"><img src="https://img.shields.io/badge/see-Documentation-green.svg"></a>
</p>

## Table of Contents

- [✍🏻 Description](#desc)

- [📱 Demo / Example](#demo)

- [⚙️ Installation](#installation)

- [⚠️ Requirements](#requirements)

- [👨🏻‍💻 How to Use](#how-to)

- [🙌🏻 Customization](#customization)

## <a name="desc"></a> ✍🏻 Description

**PopMenu** is designed as a quick _popup_ action menu, much like an action sheet in iOS. If you want an action sheet that looks great, you're in the right place!

**PopMenu** has the abilities of:

- Automatically position menu on screen if you specify the **source view**, like a popup. (edge detection)

- Full customization (icons, fonts, colors, background, styles, corners, height, status bar... you name it).

- Pan gesture control. (like 3D touch shortcuts on apps in home screen)

- Haptics enabled for selection or pan gesture.

## <a name="demo"></a> 📱 Demo / Example

#### Download or fork the repo and open the given `Example` Xcode project to try it out yourself!

What's a better way to know what `PopMenu` offers than some screenshots? Here's some to show you what you can do with `PopMenu`:

<p align="center"><img src="https://raw.githubusercontent.com/CaliCastle/PopMenu/master/.assets/Demo_Showcase.gif"></p>

![Demo1](https://raw.githubusercontent.com/CaliCastle/PopMenu/master/.assets/FeatureScreenShot_1.png)
![Demo2](https://raw.githubusercontent.com/CaliCastle/PopMenu/master/.assets/FeatureScreenShot_2.png)
![Demo3](https://raw.githubusercontent.com/CaliCastle/PopMenu/master/.assets/FeatureScreenShot_3.png)
![Demo4](https://raw.githubusercontent.com/CaliCastle/PopMenu/master/.assets/FeatureScreenShot_4.png)

## <a name="installation"></a> ⚙️ Installation

### For CocoaPods

Install **PopMenu** using [**CocoaPods**](https://cocoapods.org), add it to your **Podfile**:

> ‼️ `PopMenu` was actually taken so let's call it `NewPopMenu` 'cause why not?

```ruby
pod 'NewPopMenu'
```

### For Carthage

Install **PopMenu** using [**Carthage**](https://github.com/Carthage/Carthage), add it to your **Cartfile**:

```ruby
github "CaliCastle/PopMenu"
```

## <a name="requirements"></a> ⚠️ Requirements

* Xcode 8.0 +
* iOS 9.0 +
* Swift 4.0 +

## <a name="how-to"></a> 👨🏻‍💻 How to Use

Integrating **PopMenu** is extremely easy with a familiar workflow like presenting `UIAlertController` with `UIAlertAction`

### Import Library

```swift
import PopMenu
```

### Basic Usage

There are 2 ways to present the menu in your view controller:

1. **Use the default manager**

2. **Use the `PopMenuViewController` class directly**

You can, however, choose either way to have the same result, whichever works best for you.

#### Which Should I Use?

1. Use the default manager if you want quick setup and present menu seamlessly.
 
2. Use the `PopMenuViewController` class directly if you want to have more control.

**If you don't want to scroll, click the link to jump forward:**

[Basic Usage - Using Manager](#using-manager)

[Basic Usage - Using Controller](#using-controller)

-------

### <a name="using-manager"></a> Basic Usage - Using Manager

The quickest way would be to use `PopMenuManager`'s _**default**_ singleton with no additional setup required:

```swift
let manager = PopMenuManager.default
```

Add **actions** if you're using the manager:

```swift
manager.actions = [
    PopMenuDefaultAction(title: "Action Title 1"), // Text only action
    PopMenuDefaultAction(title: "Action Title 2", image: UIImage(named: "icon") // Text and image action
]
```

Or if you prefer the good ol' way similar to presenting a `UIAlertController` with `UIAlertAction`, you can add each action like that:

```swift
let action1 = PopMenuDefaultAction(title: "Action Title 1", image: UIImage(named: "icon"))
let action2 = PopMenuDefaultAction(title: "Action Title 2", image: UIImage(named: "icon"))

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

If you are using `PopMenuManager` to handle PopMenu, you can skip this section.

Manually initialize the controller:

```swift
let menuViewController = PopMenuViewController()
```

Add actions inside the initializer:

```swift
let menuViewController = PopMenuViewController(actions: [
    PopMenuDefaultAction(title: "Action Title 1", image: UIImage(named: "icon"),
    PopMenuDefaultAction(title: "Action Title 2", image: UIImage(named: "icon")
])
```

Finally, to present the menu all you have to do is call `present` method in your **ViewController** like a normal view controller:

```swift
class ViewController: UIViewController {

...
    func presentMenu() {
        let menuViewController = PopMenuViewController(actions: [
            PopMenuDefaultAction(title: "Action Title 1", image: UIImage(named: "icon"),
            PopMenuDefaultAction(title: "Action Title 2", image: UIImage(named: "icon")
        ])

        present(menuViewController, animated: true, completion: nil)
    }
...

}
```

### Source View

By default, `PopMenu` will present in the center of your screen. If you want it to display on the relative position of a view that the user tapped, you can pass the source view in like this:

```swift
class ViewController: UIViewController {

    @IBOutlet var aButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        aButton.addTarget()
    }

    @objc private func presentMenu() {
        // The manager way
        let manager = PopMenuManager.default
        manager.actions = [...]
        
        // Pass the UIView in present method
        manager.present(sourceView: aButton)


        // ===== or =====


        // The manual way
        let actions = [...]

        // Pass the UIView in init
        let menu = PopMenuViewController(sourceView: aButton, actions: actions)
        present(menu, animated: true, completion: nil)
    }

}
```

-------

### Selection Callback

In order to know which action button is tapped, there are two ways of doing that:
- Action Handler
- Delegate

### Action Handler

Simply pass the handler when instanstiating the action:

```swift
let action1 = PopMenuDefaultAction(title: "Action 1", didSelect: { action in
    // action is a `PopMenuAction`, in this case it's a `PopMenuDefaultAction`

    // Print out: 'Action 1 is tapped'
    print("\(action.title) is tapped")
})
```

### Delegate Method
 You'll need to comform to `PopMenuViewControllerDelegate` protocol and then implement the method `popMenuDidSelectItem(at index: Int)` in your view controller:

```swift
class ViewController: UIViewController {
    
    // Use manager to present menu.
    func presentMenuUsingManager() {
        let manager = PopMenuManager.default

        // Set delegate for callback
        manager.popMenuDelegate = self

        manager.present(on: self)
    }

    // Or manually init:
    func presentMenuManually() {
        let menu = PopMenuViewController(actions: [...])

        // Set delegate for callback
        menu.delegate = self

        present(menu, animated: true, completion: nil)
    }

}

extension ViewController: PopMenuViewControllerDelegate {

    func popMenuDidSelectItem(_ popMenuViewController: PopMenuViewController, at index: Int) {
        // Do stuff here...
    }
    
}
```
### Dismissal Callback

If you'd want more control to do additional steps when the menu is dismssed, you can do it like this:

```swift
// The manager way
manager.popMenuDidDismiss = { selected in
    // `selected` is a bool indicating if a selection has been made

    if !selected {
        // When the user tapped outside of the menu
    }
}
```

### Configurations

By default, PopMenu has pan gesture enabled, you can toggle it here:

```swift
// The manager way
manager.popMenuShouldEnablePanGesture = false
// The manual way
menu.shouldEnablePanGesture = false
```
By default, PopMenu has haptics enabled, you can toggle it here:

```swift
// The manager way
manager.popMenuShouldEnableHaptics = false
// The manual way
menu.shouldEnableHaptics = false
```


That's basically it! Congrats!

#### If you're a customization lover like me, then read along:

----------

## <a name="customization"></a> 🙌🏻 Customization

### Before moving on, customization should be applied before presenting the menu, and assume that you already have a:

variable of `PopMenuManager.default` called -> **`manager`**.

**----- or -----**

variable of `PopMenuViewController` called -> **`menu`**.

<br>

Action Dismissal // Default: true
---------

If you don't want the menu to auto-dismiss once a selection has been performed, you can change the property:

```swift
// The manager way
manager.popMenuShouldDismissOnSelection = false

// The manual way
menu.shouldDismissOnSelection = false
```

Background styles // Default: .dimmed(color: .black, opacity: 0.4)
---------

There are mainly 3 types of background styles:

- Blurred (dark, light & extra Light)
- Dimmed (color & opacity)
- None

Simply set the `popMenuBackgroundStyle` on the appearance property using `.` notation:
```swift
// The manager way
manager.popMenuAppearance.popMenuBackgroundStyle = .blurred(.dark)
manager.popMenuAppearance.popMenuBackgroundStyle = .blurred(.light)
manager.popMenuAppearance.popMenuBackgroundStyle = .blurred(.extralight)
manager.popMenuAppearance.popMenuBackgroundStyle = .dimmed(color: .white, opacity: 0.6)
manager.popMenuAppearance.popMenuBackgroundStyle = .none()

// The manual way, same to the code above
menu.appearance.popMenuBackgroundStyle = .blurred(.dark)
```

Action Color // Default: white
---------

To bulk set action colors is simple and straightforward:

```swift
// The manager way
manager.popMenuAppearance.popMenuColor.actionColor = UIColor.green // or use Color Literals if you're using Xcode 9

// The manual way
menu.appearance.popMenuColor.actionColor = UIColor.green
```

To set each action with different color, you'll have to specify in the `color` parameter initializer of action `PopMenuDefaultAction`:

```swift
let actions = [
    PopMenuDefaultAction(title: "Some Title", image: UIImage(named: "blah"), color: .gray),
    PopMenuDefaultAction(title: "Another Title", image: UIImage(named: "icon"), color: .yellow)
]
```

Background Color(s) // Default: flat black gradient
---------

There are 2 types of background colors:

- Solid fill (one color)
- Gradient fill (two colors)

To set the background color(s) of the menu:

```swift
// The manager way
manager.popMenuAppearance.popMenuColor.backgroundColor = .solid(fill: .gray) // A solid gray background color
manager.popMenuAppearance.popMenuColor.backgroundColor = .gradient(fill: .yellow, .pink) // A gradient from yellow to pink

// The manual way
menu.appearance.popMenuColor.backgroundColor = ...
```

Action Font // Default: .systemFont(ofSize: 16, weight: .semiBold)
---------

To set the font of all actions:

```swift
// The manager way
manager.popMenuAppearance.popMenuFont = UIFont(name: "AvenirNext-DemiBold", size: 14)!
manager.popMenuAppearance.popMenuFont = .systemFont(ofSize: 15, weight: .bold)

// The manual way
menu.appearance.popMenuFont = UIFont(name: "AvenirNext-DemiBold", size: 14)!
```

Corner Radius // Default: 24
---------

To set corner radius of the menu container:

```swift
// The manager way
manager.popMenuAppearance.popMenuCornerRadius = 10

// The manual way
menu.appearance.popMenuCornerRadius = 10
```

Action Height // Default: 50
---------

To set height of each action:

```swift
// The manager way
manager.popMenuAppearance.popMenuActionHeight = 65

// The manual way
menu.appearance.popMenuActionHeight = 65
```

Action Item Separator // Default: none
---------

To set the action item separator:

```swift
// The manager way
manager.popMenuAppearance.popMenuItemSeparator = .none()
manager.popMenuAppearance.popMenuItemSeparator = .fill() // Default height of 0.5, white color with 0.5 opacity
manager.popMenuAppearance.popMenuItemSeparator = .fill(.yellow, height: 1) // Or set it yourself

// The manual way
menu.appearance.popMenuItemSeparator = ...
```

Status Bar Style // Default: automatic detection based on background color
---------

If you don't want `PopMenu` to use automatic detection to set status bar style, you can override it:

```swift
manager.popMenuAppearance.popMenuStatusBarStyle = .default

// The manual way
menu.appearance.popMenuStatusBarStyle = .default
```
More customization coming, stay tuned...

## 💪🏻 Contribute

Thank you if you are interested in contributing to the project, I appreaciate it!

Before committing any changes, please make sure to read the [Contribution Guidelines](https://github.com/CaliCastle/PopMenu/blob/master/CONTRIBUTING.md) first, thank you!

## 📗 Check Documentation

Documentation and references is available at [**https://calicastle.github.io/PopMenu/**](https://calicastle.github.io/PopMenu/)

## [Join Our Slack Channel](https://join.slack.com/t/newpopmenu/shared_invite/enQtMzQ4OTExMzE0OTM1LWFhM2IxYmYxOGZmMTgzNjQxMWRiNzUyZmYwN2M4ZmQ2YWYxY2VhNWI3MDlmM2JhOTM5NjAwODlmNjQzMmVlODM)
