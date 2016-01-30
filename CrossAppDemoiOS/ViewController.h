//
//  ViewController.h
//  CrossAppDemoiOS
//
//  Created by Noah on 1/30/16.
//  Copyright © 2016 Noah. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DFPInterstitial;
@class GADRequest;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

- (void)requestAd;

/// The interstitial ad.
@property(nonatomic, strong) DFPInterstitial *interstitial;

/// Makes an ad request. Additional targeting options can be supplied with a request object.
- (void)loadRequest:(GADRequest *)request;

/// Returns YES if the interstitial is ready to be displayed.
- (BOOL)isReady;

/// Shows the interstitial ad.
- (void)show;

@end

