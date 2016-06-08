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
 *  将webview中拦截的url字符串，转换为参数字典
 *
 *  @param requestStr 请求url字符串
 *
 *  @return 参数字典
 */
- (NSDictionary *)getParameterDicFromWebviewRequestString:(NSString *)requestStr;

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

/**
 *  验证是否输入的是纯数字 正整数 不能判断 002 这样的数据
 *
 *  @return YES/NO
 */
- (BOOL)isValidateIntNumber;

/**
 *  把当前的 string（URL 类型的 sting） 转换为参数字典
 *
 *  @return 参数字典
 */
- (NSDictionary *)getParameterDictionaty;

@end
