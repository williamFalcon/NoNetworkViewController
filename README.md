# NoNetworkViewController
View controller that takes over screen when there is no internet connection. Critical for networked apps.

# Getting started
1. Import header file
````
#import "NoNetworkManager.h"
````

2. Start manager from didFinishLaunchingWithOptions in your AppDelegate file
````
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Enable takeover View Controller
    // Will show whenever the network goes out, and dissappear when network comes back in
    [NoNetworkManager enableLackOfNetworkTakeover];

    return YES;
}
````

# Dependencies
* [Reachability](https://developer.apple.com/library/ios/samplecode/Reachability/Introduction/Intro.html)
