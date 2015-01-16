//
//  NoNetworkManager.m
//  ShareBite
//
//  Created by William Falcon on 1/15/15.
//  Copyright (c) 2015 HACStudios. All rights reserved.
//

#import "NoNetworkManager.h"
#import "NoNetworkViewController.h"
#import "Reachability.h"

static float S_AUTO_TAKEOVER_DELAY = 1.0f;

typedef NS_ENUM(int, NoNetworkViewControllerState) {
    NoNetworkViewControllerStateHidden,
    NoNetworkViewControllerStateShowing
};

@interface NoNetworkManager ()
@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic, strong) NoNetworkViewController *takeoverViewController;
@property (assign) NoNetworkViewControllerState currentNoNetworkVCState;
@end

@implementation NoNetworkManager


#pragma mark - Public class methods
+ (void)enableLackOfNetworkTakeover {
    
    //init the network change observer
    NoNetworkManager *observer = [NoNetworkManager sharedInstance];
    [observer addReachabilityNotifications];
    
    //check current status on launch
    NetworkStatus remoteHostStatus = [observer.reachability currentReachabilityStatus];
    BOOL noNetwork = remoteHostStatus == NotReachable;
    
    //if not network, takeover screen after a slight delay
    if (noNetwork) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(S_AUTO_TAKEOVER_DELAY * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [observer showTakeoverVC];
        });
    }
}

/**
 Singleton
 */
+ (id)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
#pragma mark - Reachability utils

/**
 Main way to observe changes in the connectivity status
 */
- (void)addReachabilityNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
}


- (void)handleNetworkChange:(NSNotification *)notification {
    NetworkStatus remoteHostStatus = [self.reachability currentReachabilityStatus];
    
    BOOL noNetwork = remoteHostStatus == NotReachable;
    BOOL takeoverVCShowing = self.currentNoNetworkVCState == NoNetworkViewControllerStateShowing;
    
    if (noNetwork && !takeoverVCShowing) {
        [self showTakeoverVC];
        
    }else if (!noNetwork && takeoverVCShowing) {
        [self hideTakeoverVC];
    }
}

#pragma mark - Takeover push/pop
/**
 Pushes takeover VC on the current view controller visible
 */
- (void)showTakeoverVC{
    self.currentNoNetworkVCState = NoNetworkViewControllerStateShowing;

    //init takeover VC
    self.takeoverViewController = [[NoNetworkViewController alloc]initWithNibName:@"NoNetworkViewController" bundle:nil];
    self.takeoverViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.takeoverViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    //find topmost VC and put inside a nav controller
    UIViewController *topViewController = [self getTopMostViewController];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.takeoverViewController];
    
    //present the nav controller
    [topViewController presentViewController:nav animated:true completion:^{
        
    }];
}
/**
 Dismisses the takeover viewcontroller
 */
- (void)hideTakeoverVC{
    self.currentNoNetworkVCState = NoNetworkViewControllerStateHidden;
    [self.takeoverViewController dismissViewControllerAnimated:true completion:^{
        self.takeoverViewController = nil;
    }];
}

#pragma mark - Root VC Finding helpers

- (UIViewController*) getTopMostViewController
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    
    for (UIView *subView in [window subviews])
    {
        UIResponder *responder = [subView nextResponder];
        
        //added this block of code for iOS 8 which puts a UITransitionView in between the UIWindow and the UILayoutContainerView
        if ([responder isEqual:window])
        {
            //this is a UITransitionView
            if ([[subView subviews] count])
            {
                UIView *subSubView = [subView subviews][0]; //this should be the UILayoutContainerView
                responder = [subSubView nextResponder];
            }
        }
        
        if([responder isKindOfClass:[UIViewController class]]) {
            return [self topViewController: (UIViewController *) responder];
        }
    }
    
    return nil;
}

- (UIViewController *) topViewController: (UIViewController *) controller
{
    BOOL isPresenting = NO;
    do {
        // this path is called only on iOS 6+, so -presentedViewController is fine here.
        UIViewController *presented = [controller presentedViewController];
        isPresenting = presented != nil;
        if(presented != nil) {
            controller = presented;
        }
        
    } while (isPresenting);
    
    return controller;
}
@end
