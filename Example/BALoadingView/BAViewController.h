//
//  BAViewController.h
//  BALoadingView
//
//  Created by Bryan Antigua on 08/21/2015.
//  Copyright (c) 2015 Bryan Antigua. All rights reserved.
//

@import UIKit;
#import "BALoadingView.h"

@interface BAViewController : UIViewController
@property (strong, nonatomic) IBOutlet BALoadingView *loadingView;
- (IBAction)switchLoadingAnimation:(id)sender;
- (IBAction)transformAnimation:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *changeAnimationButton;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundView;

@end
