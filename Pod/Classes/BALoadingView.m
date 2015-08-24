//The MIT License (MIT)
//
//Copyright (c) 2015 Bryan Antigua <antigua.b@gmail.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.
#import "BALoadingView.h"

@interface BALoadingView ()

@property (strong, nonatomic) NSMutableArray *levels;
@property (assign, nonatomic) CGFloat lineWidth;
@property (assign, nonatomic) CGFloat buffer;
@property (strong, nonatomic) NSTimer *syncTimer;
@property (assign, nonatomic) bool animating;
@property (assign, nonatomic) BACircleAnimation animationType;
@property (assign,nonatomic) UIDeviceOrientation orientation;

@end

@implementation BALoadingView

#pragma mark - Custom Accessors

- (void)setDuration:(CGFloat)duration {
    _duration = duration;
}

- (void)setClockwise:(bool)clockwise {
    _clockwise = clockwise;
}

- (void)setSegmentColor:(UIColor *)segmentColor {
    _segmentColor = segmentColor;
    [self initialize];
}

- (void)setLineCap:(NSString*)lineCapStyle {
    _lineCap = lineCapStyle;
}

#pragma mark - Private

- (void)startTimer {
    if (self.animating) {
        if(self.syncTimer) {
            [self.syncTimer invalidate];
            self.syncTimer = nil;
        }
        self.syncTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(addSemiCircleAnimation) userInfo:nil repeats:NO];
    }
}

- (void)addFullCircleAnimation {
    for (int i = 0; i < self.levels.count; i++) {
        CAShapeLayer *layer = self.levels[i];
        layer.anchorPoint = CGPointMake(0.5, 0.5);
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        if(self.clockwise) {
            rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * 1.0 * (i+1)];
        }
        else {
            rotationAnimation.toValue = [NSNumber numberWithFloat: -M_PI * 2.0 * 1.0 * (i+1)];
        }
        rotationAnimation.duration = self.duration;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = INFINITY;
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [self.layer addSublayer:layer];
    }
}

- (void) addSemiCircleAnimation {
    for (int i = 1; i < self.levels.count; i++) {
        CAShapeLayer *layer = self.levels[i];
        if (self.lineCap) {
            layer.lineCap = _lineCap;
        }
        CABasicAnimation *stroke = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        stroke.fromValue = @(0);
        stroke.toValue =@(1);
        stroke.duration = 1-(1*i/(self.levels.count*2.0f));
        stroke.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        stroke.autoreverses = YES;
        stroke.removedOnCompletion = NO;
        stroke.fillMode = kCAFillModeForwards;
        [layer addAnimation:stroke forKey:nil];
        [self.layer addSublayer:layer];
    }
    [self startTimer];
}

#pragma mark - Public

- (void)initialize {
    
    self.levels = [NSMutableArray array];

    //defualt values
    _lineWidth = _lineWidth?_lineWidth:CGRectGetWidth(self.frame)/30.0f;
    _buffer = _buffer?_buffer:self.lineWidth;
    _duration = _duration?_duration:7.0f;
    _clockwise = _clockwise?true:_clockwise;
    _animating = NO;

    //center
    CAShapeLayer *center = [CAShapeLayer layer];
    center.frame = self.bounds;
    center.anchorPoint = CGPointMake(0.5, 0.5);
    center.lineWidth= self.lineWidth;
    UIBezierPath *centerPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2) radius:self.lineWidth startAngle:M_PI endAngle:0 clockwise:YES];
    center.path = centerPath.CGPath;
    if (self.segmentColor) {
        center.fillColor = self.segmentColor.CGColor;
    }
    [self.levels addObject:center];
    //other levels
    for (int i = 0; (center.lineWidth+self.buffer+i*(self.lineWidth+self.buffer)) < CGRectGetWidth(self.frame)/2; i++) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        layer.lineWidth=self.lineWidth;
        
        UIBezierPath *linePath =[UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2) radius:self.lineWidth+self.buffer+i*(layer.lineWidth + self.buffer) + layer.lineWidth/2 startAngle:M_PI endAngle:0 clockwise:YES];
        [linePath setLineCapStyle:kCGLineCapRound];

        layer.path = linePath.CGPath;
        layer.fillColor=[UIColor clearColor].CGColor;
        if (self.segmentColor) {
            layer.strokeColor=self.segmentColor.CGColor;
        }
        else {
            layer.strokeColor=[UIColor blackColor].CGColor;
        }
        [self.levels addObject:layer];
        
    }
    
}

- (void)startAnimation:(BACircleAnimation)animationType {
    
    self.animating = YES;
    _animationType = animationType;
    
    switch (animationType) {
        case BACircleAnimationFullCircle:
        {
            [self addFullCircleAnimation];
            break;
        }
        case BACircleAnimationSemiCircle:
        {
            [self addSemiCircleAnimation];
            break;
        }
            
        default:
            break;
    }

}

- (void)stopAnimation {
    for (int i = 0; i < self.levels.count; i++) {
        CAShapeLayer *layer = self.levels[i];
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
        layer.lineCap = nil;
        if(self.syncTimer) {
            [self.syncTimer invalidate];
            self.syncTimer = nil;
        }
    }
    
    self.animating = NO;
}
@end
