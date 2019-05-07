# RxTapAction

[![CI Status](https://img.shields.io/travis/RxSwiftCommunity/RxTapAction.svg?style=flat)](https://travis-ci.org/RxSwiftCommunity/RxTapAction)
[![Version](https://img.shields.io/cocoapods/v/RxTapAction.svg?style=flat)](https://cocoapods.org/pods/RxTapAction)
[![License](https://img.shields.io/cocoapods/l/RxTapAction.svg?style=flat)](https://cocoapods.org/pods/RxTapAction)
[![Platform](https://img.shields.io/cocoapods/p/RxTapAction.svg?style=flat)](https://cocoapods.org/pods/RxTapAction)

RxTapAction provides reactive extensions for adding tap action gesture to UIView or UICollectionView.

## Documentation

RxTapAction is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxTapAction'
```
Add tap action for UICollectionViewCell.

```Swift
collectionView.rx.highlightAction(.darken).disposed(by: disposeBag)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## License

RxTapAction is available under the MIT license. See the LICENSE file for more info.
