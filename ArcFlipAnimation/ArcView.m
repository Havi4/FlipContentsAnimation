//
//  ArcView.m
//  ArcFlipAnimation
//
//  Created by 臧其龙 on 15/1/2.
//  Copyright (c) 2015年 臧其龙. All rights reserved.
//

#import "ArcView.h"
#import "ProgressLayer.h"

@interface ArcView ()
{
    UIImageView *topView;
    
    UIImageView *bottomView;
    
    UIImageView *containerView;
    
    ProgressLayer *topLayer;
    ProgressLayer *bottomLayer;
    
    CAGradientLayer *topShadowLayer;
    CAGradientLayer *bottomShadowLayer;
}
@end

@implementation ArcView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        containerView = [[UIImageView alloc] initWithFrame:self.bounds];
        containerView.layer.cornerRadius = 44;
        containerView.layer.masksToBounds = YES;
        //containerView.backgroundColor = [UIColor blackColor];
        [self addSubview:containerView];
        
        topShadowLayer = [CAGradientLayer layer];
        topShadowLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)/2);
        topShadowLayer.colors =  @[(__bridge id)[UIColor whiteColor].CGColor,
                                   (__bridge id)[UIColor blackColor].CGColor];
        topShadowLayer.startPoint = CGPointMake(0.5, 0);
        topShadowLayer.endPoint = CGPointMake(0.5, 1.);
        topShadowLayer.opacity = 0;
        
        topView = [[UIImageView alloc] initWithFrame:self.bounds];
        
       // topView.image = [UIImage imageNamed:@"r_icon"];
        topView.layer.contents = (id)[UIImage imageNamed:@"r_icon"].CGImage;
        topView.layer.mask = [self maskForSection:FlipDirectionSectionTop];
        topView.layer.transform = [self transform3D];
        
        [topView.layer addSublayer:topShadowLayer];
        
        
        [self addSubview:topView];
        
        bottomView = [[UIImageView alloc] initWithFrame:self.bounds];
        bottomView.image = [UIImage imageNamed:@"r_icon"];
        bottomView.layer.mask = [self maskForSection:FlipDirectionSectionBottom];
        bottomView.layer.transform = [self transform3D];
        [self addSubview:bottomView];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
        self.layer.mask = maskLayer;
        self.backgroundColor = [UIColor colorWithRed:252./255 green:71./255 blue:31./255 alpha:1];
        
        topLayer = [ProgressLayer layer];
        topLayer.frame = self.bounds;
        topLayer.contents = (id)[UIImage imageNamed:@"r_icon"].CGImage;
        topLayer.mask = [self maskForSection:FlipDirectionSectionTop];
        topLayer.transform = [self transform3D];
        
        //[self.layer addSublayer:topLayer];
    }
    
    return self;
}

- (void)startAnimation
{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.toValue = @(-M_PI);
    animation.duration = 3.;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    [topView.layer addAnimation:animation forKey:@"rotate"];
    
    CABasicAnimation *topContentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
    topContentsAnimation.fromValue = (id)[UIImage imageNamed:@"r_icon"].CGImage;
    topContentsAnimation.toValue = (id)[UIImage imageNamed:@"r_hamburger"].CGImage;
    topContentsAnimation.duration = 0.1;
    topContentsAnimation.removedOnCompletion = NO;
    topContentsAnimation.beginTime = CACurrentMediaTime()+1.5;
    topContentsAnimation.fillMode = kCAFillModeForwards;
    [topView.layer addAnimation:topContentsAnimation forKey:@"content"];
    
    CABasicAnimation *containerAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
   // containerAnimation.fromValue = (id)[UIImage imageNamed:@"r_icon"].CGImage;
    containerAnimation.toValue = (id)[UIImage imageNamed:@"r_hamburger"].CGImage;
    containerAnimation.duration = 0.1;
    containerAnimation.removedOnCompletion = NO;
   // containerAnimation.beginTime = CACurrentMediaTime()+1.5;
    containerAnimation.fillMode = kCAFillModeForwards;
   // [containerView.layer addAnimation:containerAnimation forKey:@"content2"];
    containerView.image = [UIImage imageNamed:@"r_hamburger"];
    
}

- (void)animationDidStart:(CAAnimation *)anim
{
    topShadowLayer.opacity = 0.1;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"finished");
    bottomView.image = [UIImage imageNamed:@"r_hamburger"];
}

- (CATransform3D)transform3D
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 2.5 / -2000;
    return transform;
}

- (CAShapeLayer *)maskForSection:(FlipDirectionSection)section
{
    CGFloat halfWidth = CGRectGetWidth(self.bounds)/2;
    CGFloat halfHeight = CGRectGetHeight(self.bounds)/2;
    CAShapeLayer *layerMask = [CAShapeLayer layer];
    switch (section) {
        case FlipDirectionSectionTop:
        {
            layerMask.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(halfHeight, halfHeight) radius:halfWidth startAngle:0 endAngle:M_PI clockwise:NO].CGPath;
            
        }
            break;
        case FlipDirectionSectionBottom:
        {
            layerMask.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(halfHeight, halfHeight) radius:halfWidth startAngle:0 endAngle:M_PI clockwise:YES].CGPath;
            break;
        }
        default:
            break;
    }
    return layerMask;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
