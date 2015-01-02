//
//  ProgressLayer.m
//  ArcFlipAnimation
//
//  Created by 臧其龙 on 15/1/2.
//  Copyright (c) 2015年 臧其龙. All rights reserved.
//

#import "ProgressLayer.h"

@implementation ProgressLayer

- (id)initWithLayer:(id)layer
{
    self = [super initWithLayer:layer];
    if (self) {
        ProgressLayer *otherLayer = (ProgressLayer *)layer;
        self.progress = otherLayer.progress;
        self.delegate = otherLayer.delegate;
    }
    return self;
}

// Override needsDisplayForKey so that we can define progress as being animatable.

+ (BOOL)needsDisplayForKey:(NSString*)key {
    if ([key isEqualToString:@"progress"]) {
        return YES;
    } else {
        return [super needsDisplayForKey:key];
    }
}

// Call our callback

- (void)drawInContext:(CGContextRef)ctx
{
    if (self.delegate)
    {
        [self.delegate progressUpdatedTo:self.progress];
    }
}

@end
