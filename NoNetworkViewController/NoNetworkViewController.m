//
//  NoNetworkViewController.m
//  ShareBite
//
//  Created by William Falcon on 1/15/15.
//  Copyright (c) 2015 HACStudios. All rights reserved.
//

#import "NoNetworkViewController.h"
#import "Reachability.h"

@interface NoNetworkViewController()
@property (strong, nonatomic) IBOutlet UIButton *actionButton;
@property (assign) BOOL originalNavigationBarState;
@end

@implementation NoNetworkViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.actionButton.layer.cornerRadius = 5.0f;
    self.actionButton.layer.borderColor = [UIColor colorWithRed:149.0/255.0f green:154.0/255.0f blue:153.0/255.0f alpha:1.0].CGColor;
    self.actionButton.layer.borderWidth = 0.5;
    
    //[self blurBackground];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //hide nav bar
    self.originalNavigationBarState = self.navigationController.navigationBar.hidden;
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //show nav bar
    self.navigationController.navigationBar.hidden = self.originalNavigationBarState;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)mainActionPressed:(UIButton *)sender {
}

#pragma mark - UI Utils
- (void)blurBackground {
    self.view.backgroundColor = [UIColor clearColor];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithEffect:effect];
    blurView.frame = self.view.bounds;
    [self.view insertSubview:blurView atIndex:0];
}

@end






