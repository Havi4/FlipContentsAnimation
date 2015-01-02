//
//  ProgressLayer.h
//  ArcFlipAnimation
//
//  Created by 臧其龙 on 15/1/2.
//  Copyright (c) 2015年 臧其龙. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@protocol ProgressLayerProtocol <NSObject>

- (void)progressUpdatedTo:(CGFloat)progress;

@end

@interface ProgressLayer : CALayer

@property CGFloat progress;
@property (weak) id<ProgressLayerProtocol> delegate;

@end
