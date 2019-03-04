//
//  ViewController.m
//  test_app_objc
//
//  Created by Andre Herculano on 04.03.19.
//  Copyright © 2019 CodeBike&More. All rights reserved.
//

#import "ViewController.h"

@import ConsentViewController;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ConsentViewController *cvc = [[ConsentViewController alloc] initWithAccountId:22 siteName:@"mobile.demo"];

    // this is optional, we're just adding custom targetting parameters to be used in the SourcePoint's portal
    [cvc setTargetingParamString:@"CMP" value:@"true"];

    [cvc setOnInteractionComplete:^(ConsentViewController * consentSDK) {
        Boolean consent = [consentSDK getPurposeConsentForId: @"5c0e813175223430a50fe465"];
        NSLog(@"User has given consent to My Custom Purpose: %s", consent ? "true" : "false");
    }];

    [self.view addSubview:cvc.view];
}


@end
