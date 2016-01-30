//
//  ViewController.h
//  CrossAppDemoiOS
//
//  Created by Noah on 1/30/16.
//  Copyright © 2016 Noah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrossApp.h"

@class DFPInterstitial;
@class GADRequest;

@interface ViewController : UIViewController

@property (nonatomic, strong) CrossApp *crossApp;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

