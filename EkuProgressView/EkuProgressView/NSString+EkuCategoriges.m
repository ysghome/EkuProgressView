//
//  NSString+EkuCategoriges.m
//  EkuKangDA
//
//  Created by ysghome on 16/2/22.
//  Copyright © 2016年 eku. All rights reserved.
//

#import "NSString+EkuCategoriges.h"

@implementation NSString (EkuCategoriges)

- (BOOL)isPureInteger {
    NSScanner *scan = [NSScanner scannerWithString:self];
    NSInteger val;
    return [scan scanInteger:&val] && [scan isAtEnd];
}

- (BOOL)isPureFloat {
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

@end
