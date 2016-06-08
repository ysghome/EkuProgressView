//
//  EkuLine.m
//  EkuKangDA
//
//  Created by ysghome on 5/20/16.
//  Copyright © 2016 eku. All rights reserved.
//

//相邻小球之间的距离
#define DISTANCE ((self.frame.size.width - self.ballDiameter) / (self.pageCount - 1))

#import "EkuLine.h"

@implementation EkuLine {
    CGFloat initialSelectedLineLength; // 记录上一次选中的长度
}

#pragma mark-- Initialize

//第一次显示提供默认值
- (id)init {
    self = [super init];
    if (self) {
        //属性默认值
        self.selectedPage = 1;
        self.lineHeight = 2.0;
        self.whiteInterval = 2.0;
        self.ballDiameter = 10.0;
        self.unSelectedColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00];
        self.selectedColor = [UIColor colorWithRed:0.98 green:0.42 blue:0.46 alpha:1.00];
        self.pageCount = 3;
    }
    return self;
}

//必须重载  drawInContext前必调此方法，需要拷贝上一个状态
- (id)initWithLayer:(EkuLine *)layer {
    self = [super initWithLayer:layer];
    if (self) {
        self.selectedPage = layer.selectedPage;
        self.lineHeight = layer.lineHeight;
        self.whiteInterval = layer.whiteInterval;
        self.ballDiameter = layer.ballDiameter;
        self.unSelectedColor = layer.unSelectedColor;
        self.selectedColor = layer.selectedColor;
        self.pageCount = layer.pageCount;
        self.selectedLineLength = layer.selectedLineLength;
        self.masksToBounds = layer.masksToBounds;
    }
    return self;
}

#pragma mark-- Setter
- (void)setSelectedPage:(NSInteger)selectedPage {
    if (_selectedPage != selectedPage) {
        _selectedPage = selectedPage;
        initialSelectedLineLength = _selectedLineLength;
    }
}

#pragma mark-- override Class func
+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqual:@"selectedLineLength"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

// invoke when call setNeedDisplay
- (void)drawInContext:(CGContextRef)ctx {
    if (self.pageCount == 1) {
        CGMutablePathRef linePath = CGPathCreateMutable();
        CGPathMoveToPoint(linePath, nil, self.frame.size.width / 2, self.frame.size.height / 2);
        CGRect circleRect = CGRectMake(self.frame.size.width / 2 - self.ballDiameter / 2, self.frame.size.height / 2 - self.ballDiameter / 2, self.ballDiameter, self.ballDiameter);
        CGPathAddEllipseInRect(linePath, nil, circleRect);

        CGContextAddPath(ctx, linePath);
        CGContextSetFillColorWithColor(ctx, self.selectedColor.CGColor);
        CGContextFillPath(ctx);
        CGPathRelease(linePath);
        return;
    }

    CGMutablePathRef linePath = CGPathCreateMutable();
    CGPathMoveToPoint(linePath, nil, self.ballDiameter / 2, self.frame.size.height / 2);

    //画默认颜色的背景线
    CGFloat cornerWidth = self.lineHeight <= (self.frame.size.width - self.ballDiameter) ? (self.lineHeight / 2) : ((self.frame.size.width - self.ballDiameter) / 2);
    CGPathAddRoundedRect(linePath, nil, CGRectMake(self.ballDiameter / 2, self.frame.size.height / 2 - self.lineHeight / 2, self.frame.size.width - self.ballDiameter, self.lineHeight), cornerWidth, self.lineHeight / 2);
    //画pageCount个小圆
    for (NSInteger i = 0; i < self.pageCount; i++) {
        CGRect circleRect = CGRectMake(0 + i * DISTANCE, self.frame.size.height / 2 - self.ballDiameter / 2, self.ballDiameter, self.ballDiameter);
        CGPathAddEllipseInRect(linePath, nil, circleRect);
    }

    CGContextAddPath(ctx, linePath);
    CGContextSetFillColorWithColor(ctx, self.unSelectedColor.CGColor);
    CGContextFillPath(ctx);
    CGPathRelease(linePath);

    //绘制白色小圆
    CGMutablePathRef whitePath = CGPathCreateMutable();
    for (NSInteger i = 0; i < self.pageCount; i++) {
        CGFloat whiteInterval = self.whiteInterval;
        CGRect whiteRect = CGRectMake(0 + i * DISTANCE + whiteInterval, self.frame.size.height / 2 - self.ballDiameter / 2 + whiteInterval, self.ballDiameter - whiteInterval * 2, self.ballDiameter - whiteInterval * 2);
        CGPathAddEllipseInRect(whitePath, nil, whiteRect);
    }
    CGContextAddPath(ctx, whitePath);
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextFillPath(ctx);
    CGPathRelease(whitePath);

    //添加进度 line
    CGContextBeginPath(ctx);
    linePath = CGPathCreateMutable();
    //画带颜色圆角的线
    cornerWidth = self.lineHeight <= self.selectedLineLength ? (self.lineHeight / 2) : (self.selectedLineLength / 2);
    CGPathAddRoundedRect(linePath, nil, CGRectMake(self.ballDiameter / 2, self.frame.size.height / 2 - self.lineHeight / 2, self.selectedLineLength, self.lineHeight), cornerWidth, self.lineHeight / 2);
    //画pageCount个有色小圆
    for (NSInteger i = 0; i < self.pageCount; i++) {
        if (i * DISTANCE <= self.selectedLineLength + 0.000001) {
            CGRect circleRect = CGRectMake(0 + i * DISTANCE, self.frame.size.height / 2 - self.ballDiameter / 2, self.ballDiameter, self.ballDiameter);
            CGPathAddEllipseInRect(linePath, nil, circleRect);
        }
    }

    CGContextAddPath(ctx, linePath);
    CGContextSetFillColorWithColor(ctx, self.selectedColor.CGColor);
    CGContextFillPath(ctx);
    CGPathRelease(linePath);

    //绘制白色小圆
    whitePath = CGPathCreateMutable();
    for (NSInteger i = 0; i < self.pageCount; i++) {
        CGFloat whiteInterval = self.whiteInterval;
        if (i * DISTANCE <= self.selectedLineLength + 0.000001) {
            CGRect whiteRect = CGRectMake(0 + i * DISTANCE + whiteInterval, self.frame.size.height / 2 - self.ballDiameter / 2 + whiteInterval, self.ballDiameter - whiteInterval * 2, self.ballDiameter - whiteInterval * 2);
            CGPathAddEllipseInRect(whitePath, nil, whiteRect);
        }
    }
    CGContextAddPath(ctx, whitePath);
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextFillPath(ctx);
    CGPathRelease(whitePath);
}

/**
 *  设置进度条
 *
 *  @param progress 进度
 *  @param animated 是否动画
 */
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    CGFloat pinnedProgress = MIN(MAX(progress, 0.0f), 1.0f);
    if (pinnedProgress == (self.selectedLineLength / self.frame.size.width)) {
        return;
    }
    CGFloat newLineLength = self.frame.size.width * pinnedProgress;
    NSInteger newIndex = newLineLength / DISTANCE;
    
    if (animated) {
        CAKeyframeAnimation *anim = [self createHalfCurveAnima:@"selectedLineLength"
                                                      duration:0.8
                                                     fromValue:@(self.selectedLineLength)
                                                       toValue:@(newLineLength)];
        
        self.selectedLineLength = newLineLength;//动画有问题
        [self addAnimation:anim forKey:@"lineAnimation"];
        self.selectedPage = newIndex;
    } else {
        self.selectedLineLength = newLineLength;
        self.selectedPage = newIndex;
        [self setNeedsDisplay];
    }
}

- (void)animateSelectedLineToNewIndex:(NSInteger)newIndex {
    CGFloat newLineLength = (newIndex - 1) * DISTANCE;
    if (newLineLength == self.selectedLineLength) {
        return;
    }
    // Half curve animation
    CAKeyframeAnimation *anim = [self createHalfCurveAnima:@"selectedLineLength"
                                                  duration:0.8
                                                 fromValue:@(self.selectedLineLength)
                                                   toValue:@(newLineLength)];

    self.selectedLineLength = newLineLength;//动画有问题
    [self addAnimation:anim forKey:@"lineAnimation"];
    self.selectedPage = newIndex;
//    [self setNeedsDisplay];
}

/**
 *  进度条动画
 *
 *  @param keypath   <#keypath description#>
 *  @param duration  <#duration description#>
 *  @param fromValue <#fromValue description#>
 *  @param toValue   <#toValue description#>
 *
 *  @return <#return value description#>
 */
- (CAKeyframeAnimation *)createHalfCurveAnima:(NSString *)keypath
                                     duration:(CFTimeInterval)duration
                                    fromValue:(id)fromValue
                                      toValue:(id)toValue {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:keypath];
    anim.values = [self halfCurveAnimationValues:fromValue toValue:toValue duration:duration];
    anim.duration = duration;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = YES;
    anim.delegate = self;
    return anim;
}

- (NSMutableArray *)halfCurveAnimationValues:(id)fromValue toValue:(id)toValue duration:(CGFloat)duration {
    NSInteger numOfFrames = duration * 60;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numOfFrames];
    for (NSInteger i = 0; i < numOfFrames; i++) {
        [values addObject:@(0.0)];
    }
    CGFloat diff = [toValue floatValue] - [fromValue floatValue];
    for (NSInteger frame = 0; frame < numOfFrames; frame++) {
        CGFloat x = (CGFloat) frame / (CGFloat) numOfFrames;
        CGFloat value = [fromValue floatValue] + diff * (-x * (x - 2));
        values[frame] = @(value);
    }
    return values;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self removeAnimationForKey:@"selectedLineLength"];
    [self setNeedsDisplay];
}

@end
