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

    ConsentViewControllerError * error = nil;

    ConsentViewController *cvc = [[ConsentViewController alloc] initWithAccountId:22 siteName:@"mobile.demo" stagingCampaign:false andReturnError:&error];
    NSLog(@"Something bad happened while building ConsentViewController: %@", error);

    // this is optional, we're just adding custom targetting parameters to be used in the SourcePoint's portal
    [cvc setTargetingParamString:@"CMP" value:@"true"];

    [cvc setOnMessageReady:^(ConsentViewController * consentSDK) {
        [self.view addSubview:consentSDK.view];
        consentSDK.view.frame = self.view.bounds;
    }];

    [cvc setOnInteractionComplete:^(ConsentViewController * consentSDK) {
        ConsentViewControllerError * inError = nil;
        NSArray *iabVendorIds = [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], nil];
        NSArray *purposeConsents = [consentSDK getCustomPurposeConsentsAndReturnError: &inError];
        NSArray *vendorConsents = [consentSDK getCustomVendorConsentsAndReturnError: &inError];
        NSArray *iabVendorConsents = [consentSDK getIABVendorConsents:iabVendorIds error: &inError];
        NSArray *iabPurposeConsents = [consentSDK getIABVendorConsents:iabVendorIds error: &inError];
        NSLog(@"User has given IAB Vendor Consent to the purposes: %@", iabVendorConsents[0]);
        NSLog(@"User has given IAB Vendor Consent to the purposes: %@", iabVendorConsents[1]);
        NSLog(@"User has given IAB Purpose Consent to the purposes: %@", iabPurposeConsents[0]);
        NSLog(@"User has given IAB Purpose Consent to the purposes: %@", iabPurposeConsents[1]);
        NSLog(@"User has given consent to the purposes: %@", purposeConsents);
        NSLog(@"User has given consent to the vendors: %@", vendorConsents);
        [self.view willRemoveSubview:consentSDK.view];
        NSLog(@"onInteractionComplete: %@", inError);
    }];

    [cvc setOnErrorOccurred:^(ConsentViewControllerError * error) {
        NSLog(@"onErrorOccurred: %@", error);
    }];

    [cvc loadMessage];
}


@end
