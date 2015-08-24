//
//  BAViewController.m
//  BALoadingView
//
//  Created by Bryan Antigua on 08/21/2015.
//  Copyright (c) 2015 Bryan Antigua. All rights reserved.
//

#import "BAViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface BAViewController ()

@property(assign,nonatomic) bool firstLoad;
@property(assign,nonatomic) BACircleAnimation animationType;


@end

@implementation BAViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureButton];
    self.firstLoad = YES;
    self.animationType = BACircleAnimationFullCircle;
    self.backgroundView.backgroundColor = UIColorFromRGB(0x22313F);
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidLayoutSubviews {
    if (self.firstLoad) {
        [self.loadingView initialize];
        self.loadingView.lineCap = kCALineCapRound;
        self.loadingView.clockwise = true;
        self.loadingView.segmentColor = [UIColor whiteColor];
        [self.loadingView startAnimation:BACircleAnimationFullCircle];
        self.firstLoad = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private
- (IBAction)switchLoadingAnimation:(id)sender {
    if(self.animationType == BACircleAnimationFullCircle){
        [self.loadingView stopAnimation];
        self.loadingView.lineCap = kCALineCapRound;
        [self.loadingView startAnimation:BACircleAnimationSemiCircle];
        self.animationType = BACircleAnimationSemiCircle;
    }
    else {
        [self.loadingView stopAnimation];
        [self.loadingView startAnimation:BACircleAnimationFullCircle];
        self.animationType = BACircleAnimationFullCircle;

    }
}

- (void) configureButton {
    self.changeAnimationButton.backgroundColor = [UIColor clearColor];
    self.changeAnimationButton.layer.cornerRadius = 5;
    self.changeAnimationButton.layer.borderWidth = 1;
    self.changeAnimationButton.layer.borderColor = [UIColor whiteColor].CGColor;
}


#pragma mark - Public
- (IBAction)transformAnimation:(id)sender {
    UISlider *slider = (UISlider*)sender;
    CGFloat scale = 1 + 5*slider.value;
    self.loadingView.transform = CGAffineTransformMakeScale(scale,scale);
}
@end
