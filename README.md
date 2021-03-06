# NoNetworkViewController
View controller that takes over screen when there is no internet connection. Critical for networked apps.

![Example](https://raw.github.com/williamFalcon/NoNetworkViewController/master/ggnw3.gif)

##CocoaPods
```
pod 'NoNetworkViewController'
```

## How to Use
1. Import header file (if not using cocoapods or using swift)
```obj-c
#import "NoNetworkManager.h"
```

2. Start manager from didFinishLaunchingWithOptions in your AppDelegate file
```obj-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Enable takeover View Controller
    // Will show whenever the network goes out, and dissappear when network comes back in
    [NoNetworkManager enableLackOfNetworkTakeover];

    return YES;
}
```
## Designing for your project
1. Feel free to apply your own design by modifying the [NoNetworkViewController.xib file](https://github.com/williamFalcon/NoNetworkViewController/blob/master/NoNetworkViewController/NoNetworkViewController.xib)   

## Dependencies
* [Reachability](https://developer.apple.com/library/ios/samplecode/Reachability/Introduction/Intro.html)
