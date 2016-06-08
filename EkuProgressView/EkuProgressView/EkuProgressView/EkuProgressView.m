//
//  EkuProgressView.m
//  EkuProgressView
//
//  Created by ysghome on 6/8/16.
//  Copyright © 2016 ysghome. All rights reserved.
//

#import "EkuProgressView.h"
#import "EkuLine.h"

@interface EkuProgressView()

@property (nonatomic, strong) EkuLine *line;

@end

@implementation EkuProgressView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.pageCount = 3;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self.line setNeedsDisplay];
}

- (EkuLine *)line {
    if (!_line) {
        _line = [EkuLine layer];
        _line.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _line.pageCount = self.pageCount;
        _line.selectedPage = 1;
        _line.unSelectedColor = self.unSelectedColor;
        _line.selectedColor = self.selectedColor;
        _line.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer:_line];
    }
    
    return _line;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.line setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

- (UIColor *)unSelectedColor {
    if (!_unSelectedColor) {
        return [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.00];
    }
    return _unSelectedColor;
}

- (UIColor *)selectedColor {
    if (!_selectedColor) {
        return [UIColor colorWithRed:0.98 green:0.42 blue:0.46 alpha:1.00];
    }
    return _selectedColor;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    CGFloat pinnedProgress = MIN(MAX(progress, 0.0f), 1.0f);
    [self.line setProgress:pinnedProgress animated:YES];
}

@end
