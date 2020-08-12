//
//  NSString+Extension.m
//  MeiPian
//
//  Created by 刘冉 on 2019/8/17.
//  Copyright © 2019 YZ_BMAC. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

// 验证邮箱格式
-(BOOL)isValidateEmail
{
    BOOL stricterFilter = YES;   //规定是否严格判断格式
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter?stricterFilterString:laxString;
    NSPredicate *emailCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailCheck evaluateWithObject:self];
}

// 验证身份证号码
- (BOOL)isValidateIDCard
{
    if (self.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    NSScanner* scan = [NSScanner scannerWithString:[self substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[self substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[self substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}

// 验证手机号码
- (BOOL)isValidateMobileNumber
{
    NSString *phoneRegex = @"^(1)\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

// 密码强度
- (BOOL)passwordStronger {
    NSString *passWordRegex = @"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{8,16}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [phoneTest evaluateWithObject:self];
}

// 正则判断手机号码地址格式
- (BOOL)isMobileNumber {
    NSString *str = self;
    if ([str length] == 0) {
        return NO;
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        return NO;
        
    }
    return YES;
    
}


- (BOOL)isOverseasValidateMobileNumber
{
    NSString *phoneRegex = @"^\\d{6,15}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
//是否含有系统表情
- (BOOL)isContainEmoji
{
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

// 剔除卡号里的非法字符
- (NSString *)getDigitsOnly
{
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < self.length; i++){
        c = [self characterAtIndex:i];
        if (isdigit(c)){
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    return digitsOnly;
}

// 验证银行卡 (模10“隔位乘2加”校验数算法)
- (BOOL)isValidCardNumber
{
    NSString *cardNo = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (13 > cardNo.length || 19 < cardNo.length) {//卡号长度为13-19位
        return NO;
    }
    
    int sum = 0;
    int cardCRC = [cardNo characterAtIndex:cardNo.length - 1] - '0';
    int count = 0;
    int calCRC = 0;
    for (NSInteger i = cardNo.length - 2; i >= 0; i--) {
        if (0 == count % 2) {
            int product = ([cardNo characterAtIndex:i] - '0') * 2;
            sum += (product / 10 + product % 10);
        } else {
            sum += ([cardNo characterAtIndex:i] - '0');
        }
        
        count++;
    }
    
    int mod = sum % 10;
    if (0 != mod) {
        calCRC = 10 - mod;
    }
    
    return cardCRC == calCRC;
}


- (float)stringWidthWithFont:(UIFont *)font height:(float)height
{
    if (self == nil || self.length == 0) {
        return 0;
    }
    
    NSString *copyString = [NSString stringWithFormat:@"%@", self];
    
    CGSize constrainedSize = CGSizeMake(999999, height);
    CGSize size  = CGSizeZero;
    size = [copyString boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    return size.width+1.0;
}

- (float)stringHeightWithFont:(UIFont *)font width:(float)width
{
    if (self == nil || self.length == 0) {
        return 0;
    }
    
    NSString *copyString = [NSString stringWithFormat:@"%@", self];
    
    CGSize constrainedSize = CGSizeMake(width, 999999);
    CGSize size  = CGSizeZero;
    
    size = [copyString boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil].size;
    return size.height+1.0;
    
    
}

#pragma mark - 32位 小写

- (NSString *)md5HashToLower32Bit {
    const char *input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);

    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
    [digest appendFormat:@"%02x", result[i]];
    }
    return digest;
}

#pragma mark - 32位 大写

- (NSString *)md5HashToUpper32Bit {
    const char *input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);

    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
    [digest appendFormat:@"%02X", result[i]];
    }

    return digest;
}

#pragma mark - 16位 小写

- (NSString *)md5HashToLower16Bit {
    NSString *md5Str = [self md5HashToLower32Bit];

    NSString *string;
    for (int i=0; i<24; i++) {
    string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }

    return string;
}

#pragma mark - 16位 大写

- (NSString *)md5HashToUpper16Bit {
    NSString *md5Str = [self md5HashToUpper32Bit];

    NSString *string;
    for (int i=0; i<24; i++) {
    string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }

    return string;
}

@end
