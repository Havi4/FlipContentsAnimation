//
//  ArcView.h
//  ArcFlipAnimation
//
//  Created by 臧其龙 on 15/1/2.
//  Copyright (c) 2015年 臧其龙. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, FlipDirectionSection)
{
    FlipDirectionSectionLeft,
    FlipDirectionSectionRight,
    FlipDirectionSectionTop,
    FlipDirectionSectionBottom
};

@interface ArcView : UIView

- (void)startAnimation;

@end
