# BALoadingView

[![CI Status](http://img.shields.io/travis/Bryan Antigua/BALoadingView.svg?style=flat)](https://travis-ci.org/Bryan Antigua/BALoadingView)
[![Version](https://img.shields.io/cocoapods/v/BALoadingView.svg?style=flat)](http://cocoapods.org/pods/BALoadingView)
[![License](https://img.shields.io/cocoapods/l/BALoadingView.svg?style=flat)](http://cocoapods.org/pods/BALoadingView)
[![Platform](https://img.shields.io/cocoapods/p/BALoadingView.svg?style=flat)](http://cocoapods.org/pods/BALoadingView)

## Overview
![example1](https://github.com/antiguab/BALoadingView/blob/master/readmeAssets/example1.gif)
![example2](https://github.com/antiguab/BALoadingView/blob/master/readmeAssets/example2.gif)


A UIView that offers several loading animations.

<br/>

## Requirements
* Works on any iOS device

<br/>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

<br/>

## Getting Started
### Installation

BALoadingView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod "BALoadingView"
```

### Simple Usage


#### startAnimation:
To add a `BALoadingView` to your app, add the line:

```objc
BALoadingView *view = [[BALoadingView alloc] initWithFrame:self.view.frame];
[self.loadingView initialize];
[self.loadingView startAnimation:BACircleAnimationFullCircle];
//OR [self.loadingView startAnimation:BACircleAnimationSemiCircle];
```

This creates the following animation/button by default:

![example3a](https://github.com/antiguab/BALoadingView/blob/master/readmeAssets/example3a.gif)

Passing the `BACircleAnimationSemiCircle` enum produces:

![example3b](https://github.com/antiguab/BALoadingView/blob/master/readmeAssets/example3b.gif)


#### stopAnimation
`stopAnimation` removes the animations from the view.

### Advanced Usage
Listed below are examples of several properties that you can control. 

#### Initialize
`initialize` sets the default values and should be called before setting any properties.

#### Duration

If you want the loading animation to last longer/shorter, you can edit the `duration` property:

```objc
BALoadingView *loadingView = [[BALoadingView alloc] initWithFrame:self.view.frame];
[self.loadingView initialize];
self.loadingView.duration = 20.0f;
self.loadingView.segmentColor = [UIColor whiteColor];
[self.loadingView startAnimation:BACircleAnimationFullCircle];
```
This creates this view:

![example4](https://github.com/antiguab/BALoadingView/blob/master/readmeAssets/example4.gif)

#### Clockwise 

Editting the `clockwise` boolean property changes the direction of the full circle animation:

```objc
BALoadingView *loadingView = [[BALoadingView alloc] initWithFrame:self.view.frame];
[self.loadingView initialize];
self.loadingView.clockwise = YES;
self.loadingView.segmentColor = [UIColor whiteColor];
[self.loadingView startAnimation:BACircleAnimationFullCircle];
```
This creates this view:

![example5](https://github.com/antiguab/BALoadingView/blob/master/readmeAssets/example5.gif)

#### Segment Color 

the `segmentColor`property controls the color of the segments and can be used like like in the example above

#### Line Cap

the `lineCap`property controls the end caps for the semi circle animation. The rouded cap option is seen below:

```objc
[self.loadingView initialize];
self.loadingView.lineCap = kCALineCapRound;
self.loadingView.clockwise = true;
self.loadingView.segmentColor = [UIColor whiteColor];
[self.loadingView startAnimation:BACircleAnimationFullCircle];
```

The animation looks like this:

![example6](https://github.com/antiguab/BALoadingView/blob/master/readmeAssets/example6.gif)

## Author

Bryan Antigua, antigua.B@gmail.com - [bryanantigua.com](bryanantigua.com)


## License

BALoadingView is available under the MIT license. See the LICENSE file for more info.

