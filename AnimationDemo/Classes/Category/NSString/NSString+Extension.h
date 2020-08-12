//
//  NSString+Extension.h
//  MeiPian
//
//  Created by 刘冉 on 2019/8/17.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

/// 验证邮箱
-(BOOL)isValidateEmail;
/// 验证身份证号码
- (BOOL)isValidateIDCard;
/// 验证手机号码
- (BOOL)isValidateMobileNumber;
/// 海外手机号
- (BOOL)isOverseasValidateMobileNumber;
/// 验证银行卡 (模10“隔位乘2加”校验数算法)，字符串中若包含空格会被自动剔除后计算
- (BOOL)isValidCardNumber;
/// 正则判断手机号码地址格式
- (BOOL)isMobileNumber;
/// 是否含有系统表情
- (BOOL)isContainEmoji;
/// 正则验证密码强度
- (BOOL)passwordStronger;
/// 32位 (较为常用)
- (NSString *)md5HashToLower32Bit;
- (NSString *)md5HashToUpper32Bit;
/// 16位
- (NSString *)md5HashToLower16Bit;
- (NSString *)md5HashToUpper16Bit;

- (float)stringWidthWithFont:(UIFont *)font height:(float)height;
- (float)stringHeightWithFont:(UIFont *)font width:(float)width;

@end

NS_ASSUME_NONNULL_END
