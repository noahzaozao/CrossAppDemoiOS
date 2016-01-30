//
//  CrossApp.m
//  CrossAppDemoiOS
//
//  Created by Noah on 1/30/16.
//  Copyright © 2016 Noah. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CrossApp.h"
#import "ViewController.h"

#import "GoogleMobileAds/GoogleMobileAds.h"
#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface CrossApp () <GADInterstitialDelegate, GADAppEventDelegate, SKStoreProductViewControllerDelegate>
@end

@implementation CrossApp

- (id)initWithViewController:(UIViewController*)viewController{
    self = [super init];
    if (self) {
        self.viewController = viewController;
        [self requestAd];
    }
    return self;
}


- (void)requestAd {
    _interstitial = [[DFPInterstitial alloc] initWithAdUnitID:@"/6087/defy_gaming_apps"];
    _interstitial.delegate = self;
    [_interstitial setAppEventDelegate:self];
    
    DFPRequest *request = [DFPRequest request];
    request.customTargeting = @{@"appid" : @"123456"};
    [self loadRequest: request];
}

- (IBAction)onTouchMoreBtn:(id)sender {
    [self show];
}

- (void)dealloc {
    _interstitial.delegate = nil;
}

- (void)loadRequest:(GADRequest *)request {
    [self.interstitial loadRequest:request];
}

- (BOOL)isReady {
    return self.interstitial.isReady;
}

- (void)show {
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController: self.viewController];
    } else {
        NSLog(@"GoogleMobileAdsPlugin: Interstitial is not ready to be shown.");
    }
}

#pragma mark GADInterstitialDelegate implementation

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    ((ViewController *)self.viewController).statusLabel.text = @"Status: isReady";
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    ((ViewController *)self.viewController).statusLabel.text = @"Status: failed to receive ad";
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    ((ViewController *)self.viewController).statusLabel.text = @"Status: loading";
    [self requestAd];
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
}

/// Below lines added for receive Admob app event

- (UIViewController *)topMostViewController
{
    UIViewController *vc = self.viewController;
    while (vc.presentedViewController)
    {
        vc = vc.presentedViewController;
    }
    return vc;
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

/// Called when the interstitial receives an app event.
- (void)interstitial:(GADInterstitial *)interstitial
  didReceiveAppEvent:(NSString *)name
            withInfo:(NSString *)info
{
    NSLog(@"Received appEvent: %@", name);
    if([name isEqualToString:@"appstore"]) {
        NSLog(@"URL opening: %@", info);
        
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [indicatorView setCenter:CGPointMake([self topMostViewController].view.frame.size.width /2 ,
                                             [self topMostViewController].view.frame.size.height / 2)];
        [[[self topMostViewController] view] addSubview:indicatorView];
        [indicatorView startAnimating];
        [[[self topMostViewController] view] setUserInteractionEnabled:false];
        
        SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
        
        // Configure View Controller
        [storeProductViewController setDelegate:self];
        [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : info} completionBlock:^(BOOL result, NSError *error) {
            [indicatorView stopAnimating];
            [indicatorView removeFromSuperview];
            [[[self topMostViewController] view] setUserInteractionEnabled:true];
            
            if (error) {
                NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);
                
            } else {
                // Present Store Product View Controller
                [[self topMostViewController] presentViewController:storeProductViewController animated:YES completion:nil];
                
            }
        }];
    }
}


@end
