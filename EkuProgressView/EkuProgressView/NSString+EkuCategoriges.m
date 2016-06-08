//
//  NSString+EkuCategoriges.m
//  EkuKangDA
//
//  Created by ysghome on 16/2/22.
//  Copyright © 2016年 eku. All rights reserved.
//

#import "NSString+EkuCategoriges.h"

@implementation NSString (EkuCategoriges)
- (NSDictionary *)getParameterDicFromWebviewRequestString:(NSString *)requestStr{
    NSScanner *scanner = [NSScanner scannerWithString:requestStr];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"&?"]];
    NSString *tempString;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [scanner scanUpToString:@"?" intoString:nil];       //ignore the beginning of the string and skip to the vars
    while ([scanner scanUpToString:@"&" intoString:&tempString]) {
        if ([tempString rangeOfString:@"="].location != NSNotFound) {
            NSArray *valueArr = [tempString componentsSeparatedByString:@"="];
            NSString *keyStr = valueArr[0];
            NSString *valueStr = valueArr[1];
            NSString *keyDealStr = [keyStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSString *valueDealStr = [valueStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if (valueArr && valueArr.count > 0) {
                if ([valueArr[1] isEqualToString:@"(null)"]
                    ||[NSString isEmpty:keyStr trim:YES]) {
                    continue;
                }
                dic[keyDealStr] = valueDealStr;
            }
        }
    }
    return dic;
}

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

- (BOOL)isValidateIntNumber {
    NSString *numberRegex = @"^[0-9]*[1-9][0-9]*$";//正整数
    NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [numberPredicate evaluateWithObject:self];
}

- (NSDictionary *)getParameterDictionaty {
    return [self getParameterDicFromWebviewRequestString:self];
}

@end
