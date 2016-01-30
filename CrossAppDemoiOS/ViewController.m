//
//  ViewController.m
//  CrossAppDemoiOS
//
//  Created by Noah on 1/30/16.
//  Copyright © 2016 Noah. All rights reserved.
//

#import "ViewController.h"

#import "CrossApp.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.crossApp = [[CrossApp alloc] initWithViewController:self];
}

- (IBAction)onTouchMoreBtn:(id)sender {
    [[self crossApp] show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
