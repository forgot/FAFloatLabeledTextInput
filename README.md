# FAFloatLabeledTextInput

[![Version](https://img.shields.io/cocoapods/v/FAFloatLabeledTextInput.svg?style=flat)](https://cocoapods.org/pods/FAFloatLabeledTextInput)
[![License](https://img.shields.io/cocoapods/l/FAFloatLabeledTextInput.svg?style=flat)](https://cocoapods.org/pods/FAFloatLabeledTextInput)
[![Platform](https://img.shields.io/cocoapods/p/FAFloatLabeledTextInput.svg?style=flat)](https://cocoapods.org/pods/FAFloatLabeledTextInput)

## Overview
A Swift 4.2 implementation of the UX pattern known as the "Float Label Pattern".

`FAFloatLabeledTextInput` includes subclasses for both `UITextField` and `UITextView`. Additionally, it provides a `UITableViewCell` subclass for each thats ready to work out of the box, and the `FAFloatLabeledTextViewTableViewCell` is configured to grow as needed to accommodate text.

This design was heavily inspired by @jverdi's [JVFloatLabeledTextField](https://github.com/jverdi/JVFloatLabeledTextField) and @aksswami's [FloatLabelFields](https://github.com/aksswami/FloatLabelFields).

![Example 1](https://user-images.githubusercontent.com/2170669/54080457-b255ec00-42b5-11e9-85c7-2a89d5c8ff92.gif)
![Example 2](https://user-images.githubusercontent.com/2170669/54080460-c26dcb80-42b5-11e9-89d2-340089101619.gif)

## Usage

Simply use `FAFloatLabledTextField` or `FAFloatLabledTextView` in place of `UITextField` or `UITextView`.

The `UITableViewCell` subclasses can be used directly in code, or in Interface Builder by setting the prototype cell's class to either `FAFloatLabeledTextFieldTableViewCell` or `FAFloatLabeledTextViewTableViewCell`.

```Swift
let titleField = FAFloatLabelTextField()
titleField.placeholder = "Title"
titleField.placeholderFont = .systemFont(ofSize: 16.0)
titleField.floatingLabelFont = .boldSystemFont(ofSize: 11.0)

let description = FAFloatLabelTextView()
descriptionField.placeholder = "Description"
descriptionField.placeholderFont = .systemFont(ofSize: 16.0)
descriptionField.floatingLabelFont = .boldSystemFont(ofSize: 11.0)
```

The code is well documented, and there are many options available, so I encourage you to give it a read.

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

This component uses Swift 4.2, which means it requires iOS 7 or later.

## Installation

FAFloatLabeledTextInput is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FAFloatLabeledTextInput'
```

## Author

[forgot](https://twitter.com/forgot)

Ideas? Questions? Open an issue, or hit me up on Twitter.

## License

FAFloatLabeledTextInput is available under the MIT license. See the LICENSE file for more info.
