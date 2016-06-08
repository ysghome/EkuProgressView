//
//  NSString+EkuCategoriges.h
//  EkuKangDA
//
//  Created by ysghome on 16/2/22.
//  Copyright © 2016年 eku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EkuCategoriges)

/**
 *  判断是否为整形（只能判断 integer ）
 *
 *  @return YSE/NO
 */
- (BOOL)isPureInteger;

/**
 *  判断是否是否浮点数
 *
 *  @return YES/NO
 */
- (BOOL)isPureFloat;

@end
