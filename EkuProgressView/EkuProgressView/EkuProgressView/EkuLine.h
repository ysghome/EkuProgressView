//
//  EkuLine.h
//  EkuKangDA
//
//  Created by ysghome on 5/20/16.
//  Copyright © 2016 eku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
/**
 *  候诊室的进度条线
 */
@interface EkuLine : CALayer

// page的个数
@property(nonatomic, assign) NSInteger pageCount;

//选中的item  1,2,3,4
@property(nonatomic, assign) NSInteger selectedPage;

// pageControl线的高度
@property(nonatomic, assign) CGFloat lineHeight;

// 白色小球和节点中的大球的间歇
@property (nonatomic, assign) CGFloat whiteInterval;

//小球的直径
@property(nonatomic, assign) CGFloat ballDiameter;

//未选中的颜色
@property(nonatomic, strong) UIColor *unSelectedColor;

//选中的颜色
@property(nonatomic, strong) UIColor *selectedColor;

//选中的长度
@property(nonatomic, assign) CGFloat selectedLineLength;

//直线动画接口:传入目标index作为参数
- (void)animateSelectedLineToNewIndex:(NSInteger)newIndex;

//修改进度条进度
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
