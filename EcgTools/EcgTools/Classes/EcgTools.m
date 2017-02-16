//
//  EcgTools.m
//  EcgTools
//
//  Created by baotiao ni on 2017/2/8.
//  Copyright © 2017年 xijian. All rights reserved.
//

#import "EcgTools.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

static NSDateFormatter *dateFormatter  = nil;

/** 代码切换语言 **/
#define Load_String(key)  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:@"Localizable"]

@implementation EcgTools

/**
 *  将时间戳转化为时间
 *
 *  @param string 时间戳
 *
 *  @return 格式化时间字符串
 */
+ (NSString *)dateFromText:(NSString *)string {
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[string doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strTime = [dateFormatter stringFromDate:date1];
    return strTime;
}

/**
 *  获取当前时间的格式化字符串
 *
 *  @return 时间格式化字符串
 */
+ (NSString *)currentDateTimeStr {
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //设定时间格式,这里可以设置成自己需要的格式
    
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13
    NSLog(@"%@",currentDateStr);
    
    return currentDateStr;
}

/**
 *  校验手机号码的有效性
 *
 *  @param mobileNum 手机号码
 *
 *  @return 是否有效
 */
+(BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     *//*updated at 2015-8-24*/
    NSString * MOBILE = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 *  判断字符串是否可以转换为11个数字
 *
 *  @param str 字符串
 *
 *  @return 是否可以转换
 */
+(BOOL)elevenNumbers:(NSString *)str {
    NSString * eleven = @"^\\d{11}$";
    
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", eleven];
    
    if ([regex evaluateWithObject:str]) {
        return YES;
    }
    
    return NO;
}

/**
 *  判断字符串是否都是由数字组成
 *
 *  @param str 字符串
 *
 *  @return 是否由数字组成
 */
+(BOOL)allNumbers:(NSString *)str {
    NSString * eleven = @"^[0-9]*$";
    
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", eleven];
    
    if ([regex evaluateWithObject:str]) {
        return YES;
    }
    
    return NO;
}

/**
 *  判断密码是否是由6-18位数字和字母组合
 *
 *  @param password 密码字符串
 *
 *  @return 是否有效
 */
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

/**
 *  判断有效是否有效
 *
 *  @param email 邮箱
 *
 *  @return 是否邮箱
 */
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 *  32位MD5加密方式
 *
 *  @param srcString 源字符串
 *
 *  @return 加密后的字符串
 */
+(NSString *)getMd5_32Bit_String:(NSString *)srcString {
    if (srcString == nil) {
        return nil;
    }
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for(int i =0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}

/**
 *  等比例压缩
 *
 *  @param sourceImage 源图片
 *  @param size        压缩大小
 *
 *  @return <#return value description#>
 */
+(UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  xml字符串转换为html字符串
 *
 *  @param xmlStr xml 字符串
 *
 *  @return html 字符串
 */
+(NSString *)htmlFormatString:(NSString *)xmlStr {
    NSString *htmlString = nil;
    if (xmlStr && [xmlStr length] > 0) {
        
        if ([xmlStr rangeOfString:@"&"].location != NSNotFound) {
            htmlString = [xmlStr stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
        }
        
        if ([xmlStr rangeOfString:@" "].location != NSNotFound) {
            htmlString = [xmlStr stringByReplacingOccurrencesOfString:@" " withString:@"&nbsp;"];
        }
        
        if ([xmlStr rangeOfString:@"<"].location != NSNotFound) {
            htmlString = [xmlStr stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
        }
        
        if ([xmlStr rangeOfString:@">"].location != NSNotFound) {
            htmlString = [xmlStr stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
        }
        
        if ([xmlStr rangeOfString:@"\""].location != NSNotFound) {
            htmlString = [xmlStr stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
        }
        
        if ([xmlStr rangeOfString:@"'"].location != NSNotFound) {
            htmlString = [xmlStr stringByReplacingOccurrencesOfString:@"'" withString:@"&qpos;"];
        }
    }
    
    return htmlString;
}

/**
 *  将iso88591字符串转换为unicode字符串
 *
 *  @param iso88591String 88591字符串
 *
 *  @return unicode字符串
 */
+(NSString *)changeISO88591StringToUnicodeString:(NSString *)iso88591String
{
    if (([iso88591String rangeOfString:@"&amp;"].location == NSNotFound) && ([iso88591String rangeOfString:@"&#x"].location == NSNotFound)) {
        return iso88591String;
    }
    NSMutableString *srcString = [[NSMutableString alloc]initWithString:iso88591String];
    [srcString replaceOccurrencesOfString:@"&amp;" withString:@"&" options:NSLiteralSearch range:NSMakeRange(0, [srcString length])];
    [srcString replaceOccurrencesOfString:@"&#x" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [srcString length])];
    NSMutableString *desString = [[NSMutableString alloc]init] ;
    NSArray *arr = [srcString componentsSeparatedByString:@";"];
    
    for(int i=0;i<[arr count]-1;i++){
        NSString *v = [arr objectAtIndex:i];
        char *c = malloc(3);
        int value = [self changeHexStringToDec:v];
        c[1] = value  &0x00FF;
        c[0] = value >>8 &0x00FF;
        c[2] = '\0';
        [desString appendString:[NSString stringWithCString:c encoding:NSUnicodeStringEncoding]];
        free(c);
    }
    
    return desString;
}

/**
 *  将16进制字符串转换为十进制整数
 *
 *  @param strHex 16进制字符串
 *
 *  @return 十进制整数
 */
+(int) changeHexStringToDec:(NSString *)strHex
{
    int hexLength = [strHex length];
    int  ref = 0;
    for (int j = 0,i = hexLength -1; i >= 0 ;i-- )
    {
        char a = [strHex characterAtIndex:i];
        if (a == 'A') {
            ref += 10*pow(16,j);
        }
        else if(a == 'B'){
            ref += 11*pow(16,j);
        }
        else if(a == 'C'){
            ref += 12*pow(16,j);
        }
        else if(a == 'D'){
            ref += 13*pow(16,j);
        }
        else if(a == 'E'){
            ref += 14*pow(16,j);
        }
        else if(a == 'F'){
            ref += 15*pow(16,j);
        }
        else if(a == '0')
        {
            ref += 0;
        }
        else if(a == '1')
        {
            ref += 1*pow(16,j);
        }
        else if(a == '2')
        {
            ref += 2*pow(16,j);
        }
        else if(a == '3')
        {
            ref += 3*pow(16,j);
        }
        else if(a == '4')
        {
            ref += 4*pow(16,j);
        }
        else if(a == '5')
        {
            ref += 5*pow(16,j);
        }
        else if(a == '6')
        {
            ref += 6*pow(16,j);
        }
        else if(a == '7')
        {
            ref += 7*pow(16,j);
        }
        else if(a == '8')
        {
            ref += 8*pow(16,j);
        }
        else if(a == '9')
        {
            ref += 9*pow(16,j);
        }
        j++;
        
    }
    return ref;
}

/**
 *  处理unicode字符串
 *
 *  @param unicodeStr unicode字符串
 *
 *  @return 处理后的字符串
 */
+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

/**
 *  保存到user default
 *
 *  @param key   key
 *  @param value 值
 */
+(void)saveToNSUserDefaults:(NSString *)key withValue:(NSString *)value {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //存储时，除NSNumber类型使用对应的类型外，其他的都是使用setObject:forKey:
    [userDefaults setObject:value forKey:key];
    
    //这里建议同步存储到磁盘中，但是不是必须的
    [userDefaults synchronize];
}

/**
 *  从 user default 删除数据
 *
 *  @param key key
 */
+(void)deleteFromNSUserDefaults:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults removeObjectForKey:key];
    
    [userDefaults synchronize];
}

/**
 *  从 user default 中读取数据
 *
 *  @param key key
 *
 *  @return 读取到的数据值
 */
+(NSString *)readValueFromNSUserDefaults:(NSString *)key {
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    //读取NSString类型的数据
    NSString *value = [userDefaultes stringForKey:key];
    if (!value) {
        value = @"";
    }
    return value;
}

/**
 *  获取uuid  每调用一次，值都会不同，如果需要保存，可以结合keychain
 *
 *  @return uuid
 */
+(NSString*)uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (__bridge NSString *)CFStringCreateCopy( NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    result = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
    result = [result lowercaseString];
    return result;
}

/**
 *  获取当前时间的格式化字符串 格式是：20161024105324
 *
 *  @return 格式化时间字符串
 */
+(NSString *)allTimeStr {
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps  = [calendar components:unitFlags fromDate:now];
    int year = [comps year];
    int month = [comps month];
    int day = [comps day];
    int hour = [comps hour];
    int min = [comps minute];
    int sec = [comps second];
    NSString *str = [NSString stringWithFormat:@"%d%02d%02d%02d%02d%02d", year,month,day,hour,min,sec];
    
    return str;
}

/**
 *  获取指定时间的格式化字符串 格式是：20161024105324
 *
 *  @param date 日期
 *
 *  @return 格式化时间字符串
 */
+(NSString *)allTimeStr:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps  = [calendar components:unitFlags fromDate:date];
    int year = [comps year];
    int month = [comps month];
    int day = [comps day];
    int hour = [comps hour];
    int min = [comps minute];
    int sec = [comps second];
    NSString *str = [NSString stringWithFormat:@"%d%02d%02d%02d%02d%02d", year,month,day,hour,min,sec];
    
    return str;
}

/**
 *  根据时间戳获取标准时间格式 20160524021325
 *
 *  @param interval 时间戳
 *
 *  @return 格式化时间字符串
 */
+(NSString *)allTimeStrFromInterval:(NSTimeInterval)interval {
    NSString *lenStr = [NSString stringWithFormat:@"%0.0f",interval];
    if (lenStr && lenStr.length == 14) {
        return lenStr;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps  = [calendar components:unitFlags fromDate:date];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger min = [comps minute];
    NSInteger sec = [comps second];
    NSString *str = [NSString stringWithFormat:@"%ld%02ld%02ld%02ld%02ld%02ld", (long)year,(long)month,(long)day,(long)hour,(long)min,(long)sec];
    
    return str;
}

/**
 *  获取格式化时间字符串 格式是：2016-10-25 12:23:45
 *
 *  @param str 时间字符串
 *
 *  @return 格式化时间字符串
 */
+(NSString *)dateStrTodate:(NSString *)str {
    if (str == nil || [str length] < 14) {
        return nil;
    }
    NSString *newStr = nil;
    
    NSRange yRange = {0, 4};
    NSString *year = [str substringWithRange:yRange];
    
    NSRange mRange = {4, 2};
    NSString *month = [str substringWithRange:mRange];
    
    NSRange dRange = {6, 2};
    NSString *day = [str substringWithRange:dRange];
    
    NSRange hRange = {8, 2};
    NSString *hour = [str substringWithRange:hRange];
    
    NSRange minRange = {10, 2};
    NSString *min = [str substringWithRange:minRange];
    
    NSRange secRange = {12, 2};
    NSString *second = [str substringWithRange:secRange];
    
    newStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",year,month,day,hour,min, second];
    
    return newStr;
}

/**
 *  秒转换为日期
 *
 *  @param sec 距离1970的秒数
 *
 *  @return 日期
 */
+(NSString *)secToDate:(NSTimeInterval)sec {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:sec];
    
    return [EcgTools dateToStringUTC:date];
}

/**
 *  秒转换为日期
 *
 *  @param sec 距离1970的秒数
 *
 *  @return 日期
 */
+(NSString *)secTDate:(NSTimeInterval)sec {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:sec];
    
    return [EcgTools dateToSUTC:date];
}

/**
 *  病人列表的显示
 *
 *  @param sec 秒
 *
 *  @return 昨天还是明天
 */
+(NSString *)secToReportDate:(NSTimeInterval)sec {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:sec];
    
    return [EcgTools compareDate:date];
}

/**
 *  秒转换为格式化时间字符串
 *
 *  @param sec 秒
 *
 *  @return 格式化时间字符串
 */
+(NSString *)secToDate2:(NSTimeInterval)sec {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:sec];
    
    return  [self allTimeStr:date];
}

/**
 *  计算秒包含的小时
 *
 *  @param seconds 秒
 *
 *  @return 小时
 */
+(NSInteger)hours:(CGFloat)seconds {
    return seconds/3600;
}

/**
 *  计算去掉分钟后包含的分钟
 *
 *  @param seconds 秒
 *
 *  @return 分钟
 */
+(NSInteger)minutes:(CGFloat)seconds {
    CGFloat f = fmodf(seconds, 3600);
    return f/60;
}

/**
 *  计算去掉小时分钟后剩余的秒
 *
 *  @param seconds 秒
 *
 *  @return 剩余的秒
 */
+(NSInteger)seconds:(CGFloat)seconds {
    CGFloat f1 = fmodf(seconds, 3600);
    CGFloat f2 = fmodf(f1, 60);
    return f2;
}

/**
 *  计算指定天之后的日期
 *
 *  @param date 指定日期
 *  @param days 指定天数
 *
 *  @return 日期
 */
+(NSDate *)someDayLater:(NSDate *)date after:(int)days {
    NSDate* theDate;
    if(days!=0)
    {
        NSTimeInterval oneDay = 24*60*60*1;  //1天的长度
        theDate = [date initWithTimeInterval:oneDay*days sinceDate:date];
    }
    else
    {
        theDate = date;
    }
    
    return theDate;
}

/**
 *  格式化时间字符串转换为日期
 *
 *  @param str 格式化时间字符串
 *
 *  @return 日期
 */
+(NSDate *)stringToDate:(NSString *)str {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate *date = [dateFormatter dateFromString:str];
    NSLog(@"%@", date);
    
    return date;
}

/**
 *  日期转为格式化时间字符串（系统时区）
 *
 *  @param date 日期
 *
 *  @return 格式化时间字符串
 */
+(NSString *)dateToStringUTC:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];//[NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSString *strDate = [dateFormatter stringFromDate:date];
    NSLog(@"%@", strDate);
    
    return strDate;
}

/**
 *  显示是昨天还是明天
 *
 *  @param date 指定日期
 *
 *  @return 昨天或者明天
 */
+(NSString *)compareDate:(NSDate *)date{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSTimeZone *timeZone = [NSTimeZone systemTimeZone];//[NSTimeZone timeZoneWithName:@"UTC"];
        [dateFormatter setTimeZone:timeZone];
        
        NSString *strDate = [dateFormatter stringFromDate:date];
        NSRange range= {11,5};
        NSString *timer = [strDate substringWithRange:range];
        return timer;
        
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return Load_String(@"Yesterday");
    }
    //    }else if ([dateString isEqualToString:tomorrowString])
    //    {
    //        return @"明天";
    //    }
    else
    {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM-dd HH:mm:ss"];
        
        NSTimeZone *timeZone = [NSTimeZone systemTimeZone];//[NSTimeZone timeZoneWithName:@"UTC"];
        [dateFormatter setTimeZone:timeZone];
        
        NSString *strDate = [dateFormatter stringFromDate:date];
        NSRange range= {5,5};
        NSString *timer = [strDate substringWithRange:range];
        
        return timer;
    }
}

/**
 *  用于在安卓版的时间戳解决
 *
 *  @param date 日期
 *
 *  @return 格式化时间字符串
 */
+(NSString *)dateToSUTC:(NSDate *)date {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    });
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];//[NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSString *strDate = [dateFormatter stringFromDate:date];
    NSLog(@"%@", strDate);
    
    return strDate;
}

/**
 *  日期转换为格式化时间字符串
 *
 *  @param date 日期
 *
 *  @return 格式化时间字符串
 */
+(NSString *)dateToStringSystemZone:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeZone];
    
    NSString *strDate = [dateFormatter stringFromDate:date];
    NSLog(@"%@", strDate);
    
    return strDate;
}

/**
 *  获取手机点数
 *
 *  @param pixelsNum 像素数
 *
 *  @return 点数
 */
+ (float)p_pointsWithPixels:(float)pixelsNum
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale >= 2.0)) {
        // Retina display
        float scale = [UIScreen mainScreen].scale;
        return pixelsNum / scale;
    } else {
        // non-Retina display
        return pixelsNum;
    }
}

/**
 *  添加本地通知
 */
+(void)addLocalNotification {
    
    //定义本地通知对象
    UILocalNotification *notification=[[UILocalNotification alloc]init];
    //设置调用时间
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:0.0];//通知触发的时间，0s以后
    //notification.repeatInterval=2;//通知重复次数
    //notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
    
    //设置通知属性
    notification.alertBody=NSLocalizedString(@"newmessage", nil); //通知主体
    //UIApplication *application = [UIApplication sharedApplication];
    //application.applicationIconBadgeNumber +=1;
    //notification.applicationIconBadgeNumber+=1;//应用程序图标右上角显示的消息数
    //notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
    //notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
    //notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    //notification.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
    
    //设置用户信息
    //notification.userInfo=@{@"id":@1,@"user":@"Kenshin Cui"};//绑定到通知上的其他附加信息
    
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

/**
 *  移除本地通知，在不需要此通知时记得移除
 */
+ (void)removeNotification {
    UIApplication *app = [UIApplication sharedApplication];
    app.applicationIconBadgeNumber = 0;
    //app.scheduledLocalNotifications = nil;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

/**
 *  注册推送通知
 */
+(void)registerRemoteNotification{
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
    if([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
#if !TARGET_IPHONE_SIMULATOR
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
#endif
    //#ifdef __IPHONE_8_0
    //    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
    //
    //        UIUserNotificationType types = (UIUserNotificationTypeAlert |
    //                                        UIUserNotificationTypeSound |
    //                                        UIUserNotificationTypeBadge);
    //
    //        UIUserNotificationSettings *settings;
    //        settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    //        [[UIApplication sharedApplication] registerForRemoteNotifications];
    //        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    //
    //    } else {
    //        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
    //                                                                       UIRemoteNotificationTypeSound |
    //                                                                       UIRemoteNotificationTypeBadge);
    //        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    //    }
    //#else
    //    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
    //                                                                   UIRemoteNotificationTypeSound |
    //                                                                   UIRemoteNotificationTypeBadge);
    //    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    //#endif
}

/**
 *  取消远程推送
 */
+ (void)removeRemoteNotification {
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
}

/**
 *  清除缓存
 *
 *  @param selector selector
 *  @param owner    owner description
 */
+(void)clearCaches:(SEL)selector at:(id)owner {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        NSLog(@"files :%lu",(unsigned long)[files count]);
        for (NSString *p in files) {
            NSError *error;
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [owner performSelectorOnMainThread:selector withObject:nil waitUntilDone:YES];
        });
    });
}

/**
 *  判空字符串是否是各种空值
 *
 *  @param str 字符串
 *
 *  @return 是否是空值
 */
+(BOOL)isNull:(NSString *)str
{
    // 判断是否为空串
    if ([str isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([str isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (str==nil){
        return YES;
    }
    else if ([str isEqualToString:@""] || [str isEqualToString:@"<null>"] || [str isEqualToString:@"(null)"]){
        return YES;
    }
    
    return NO;
}

/**
 *  网络数据向dataModel赋值
 *  dataModel中的属性名要和字典中key名保持一致
 *  @param dataModel  数据模型
 *  @param dataSource 数据源字典
 *
 *  @return 是否赋值成功
 */
+ (BOOL)assignToModel:(id)dataModel fromDictionary:(NSDictionary *)dataSource {
    uint outCount;
    uint i;
    objc_property_t *properties = class_copyPropertyList([dataModel class], &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    
    BOOL ret = NO;
    for (NSString *key in keys) {
        
        ret = ([dataSource valueForKey:key]==nil)?NO:YES;
        
        if (ret) {
            id propertyValue = [dataSource valueForKey:key];
            //该值不为NSNULL，并且也不为nil
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                [dataModel setValue:propertyValue forKey:key];
            }
        }
    }
    return ret;
}

/**
 *  动态计算字符串高度
 *
 *  @param text   string 字符串
 *  @param fount  字号
 *  @param weight 宽度
 *
 *  @return 字符串高度
 */
+ (CGFloat)getHeightWithText:(NSString*)text labelFount:(UIFont*)fount andWidth:(CGFloat)width{
    CGFloat height = 0;
    CGSize size = CGSizeMake(width,2000); //设置一个行高上限
    NSDictionary *attribute = @{NSFontAttributeName: fount};
    CGSize labelsize = [text boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    height = labelsize.height;
    return height;
}

/**
 *  删除空格
 */
+ (NSString*)removeSpaceFromeString:(NSString*)string{
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/**
 *  获取一定时间间隔后的格式化时间字符串
 *
 *  @param sec      秒
 *  @param duration 间隔
 *
 *  @return 格式化时间字符串
 */
+ (NSString *)dateAfterDuraionHHmm:(NSTimeInterval)sec withDuration:(NSTimeInterval)duration {
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:sec];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeZone];
    
    NSString *strStartDate = [dateFormatter stringFromDate:startDate];
    NSLog(@"%@", strStartDate);
    
    NSDate *endDate = [startDate dateByAddingTimeInterval:duration];
    NSString *strEndDate = [dateFormatter stringFromDate:endDate];
    NSLog(@"%@", strEndDate);
    
    NSRange mRange = {11, 5};
    NSString *endStr = [strEndDate substringWithRange:mRange];
    
    NSString *finalDateStr = [NSString stringWithFormat:@"%@-%@", strStartDate, endStr];
    
    return finalDateStr;
}

/**
 *  删除回车
 *
 *  @param string 源字符串
 *
 *  @return 删除回车后的字符串
 */
+ (NSString*)removeEnterFromeString:(NSString*)string{
    return [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

/**
 *  删除特殊字符
 *
 *  @param delStr 特殊字符
 *  @param source 源字符串
 *
 *  @return 删除特殊字符后的字符串
 */
+(NSString *)deleteSpecialStr:(NSString *)delStr from:(NSString *)source {
    
    NSString *newStr = nil;
    
    if ([source rangeOfString:delStr].location != NSNotFound) {
        NSRange rg = [source rangeOfString:delStr];
        NSUInteger index = rg.location;
        newStr = [source substringToIndex:index];
    } else {
        newStr = source;
    }
    
    return newStr;
}

/**
 *  获取时间戳
 *
 *  @param date 日期
 *
 *  @return 时间戳
 */
+ (NSString *)stringSince1970:(NSDate *)date {
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString * string = [NSString stringWithFormat:@"%.0f",time];
    
    return string;
}

/**
 *  时间字符串转时间戳
 *
 *  @param date 时间字符串
 *
 *  @return 时间戳
 */
+ (NSString *)getDate:(NSString *)date
{
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setTimeZone:localzone];
    NSDate  *Date = [formatter dateFromString:date];
    NSString *timeStr =  [self stringSince1970:Date];
    
    return timeStr;
}

/**
 *  判断字符串中是否含有中文
 *
 *  @param str 源字符串
 *
 *  @return 是否含有
 */
+ (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++)
    {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        { return YES;
            
        }
    }
    
    return NO;
}

/**
 *  把单引号替换成双引号
 *
 *  @param str 源字符串
 *
 *  @return 替换后的字符串
 */
+ (NSString*)saveFiltration:(NSString*)str{
    return [str stringByReplacingOccurrencesOfString:@"'" withString:@"\"\""];
}

/**
 *  把双引号替换成单引号
 *
 *  @param str 源字符串
 *
 *  @return 替换后的字符串
 */
+ (NSString*)readFiltration:(NSString*)str{
    return [str stringByReplacingOccurrencesOfString:@"\"\"" withString:@"'"];
}


/**
 获取字符串size
 
 @param string 目标字符串
 @param attributes <#attributes description#>
 @return <#return value description#>
 */
+ (CGSize)getStringSizeWith:(NSString *)string attributes:(NSDictionary *)attributes
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return size;
}

/**
 获取当前系统的首选语言环境
 
 @return <#return value description#>
 */
+ (NSString *)getCurrentSetLanguage {
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *language = [languages objectAtIndex:0];
    return language;
}

/**
 删除空格
 
 @param str 目标字符串
 @return 结果字符串
 */
+ (NSString *)handleSpecialString:(NSMutableString *)str {
    NSString *resultSting = nil;
    resultSting = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return resultSting;
}

/**
 将数组或字典转化成json
 
 @param objc <#objc description#>
 @return <#return value description#>
 */
+ (NSString *)transformObjc:(id)objc {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:objc options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

/**
 将json格式的字符串转换成数组或字典
 
 @param jsonString <#jsonString description#>
 @return <#return value description#>
 */
+ (id)transformJsonString:(NSString *)jsonString {
    NSData* xmlData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id objc = [NSJSONSerialization  JSONObjectWithData:xmlData options:0 error:nil];
    return objc;
}

/**
 时间戳转时间yyyyMMddHHmmss
 
 @param time 时间戳
 @return yyyyMMddHHmmss
 */
+(NSString *)getDateFromTime:(NSString *)time {
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[time longLongValue]];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    
    return [formatter stringFromDate:date];
}

//时间戳比较
+(BOOL)checkTimeStemp:(NSString *)timeStemp{
    NSDate *senddate = [NSDate date];
    NSString *now = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    
    float a = [now floatValue] - [timeStemp floatValue];
    if (a>0) {
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)getDateStringWithDate:(NSString *)dateStr
                         DateFormat:(NSString *)formatString{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateStr floatValue]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formatString];
    NSString *dateString = [dateFormat stringFromDate:date];
    NSLog(@"date: %@", dateString);
    return dateString;
}

//将AIO设备号转换为标准字符串
+ (NSString *)transformAIODeviceSn:(NSString *)snString
{
    
    if (!snString) {
        return nil;
    }
    
    // 根据规则askSn的注释进行解码
    /**
     实际序列号为12个字符（a~z，A~Z，0~9）
     model：由生产排号并用指定字符命名，数值范围 [0，15]  具体编码可以到服务器上获取配置文件，转换为3个字符
     year: 需要补齐2位
     month：需要补齐2位
     num：补齐5位
     @return 返回字符格式@"%d:%d:%d:%d"  model（出厂型号编码）：year：month：num
     
     更新于2014-11-11见tower，model: [0]E01 [1]E13 [2]A08 [3]A16 [4]B10 [5]B16 [6]B18 [7]B19
     */
    /** 直插式序列号：读取失败时默认赋值ff:ff:ff:ff*/
    if ([snString isEqualToString:@"ff:ff:ff:ff"]) {
        
        /** 采集器设备序列号：FFFFFFFFFFFF*/
        return @"FFFFFFFFFFFF";
    }
    
    NSArray *numbers = [snString componentsSeparatedByString:@":"];
    NSString *source = [numbers objectAtIndex:0];
    
    NSString *resultStr = @"FFF";
    
    int result = [source intValue];
    
    switch (result) {
        case 0:
            resultStr = @"E01";
            break;
        case 1:
            resultStr = @"E13";
            break;
        case 2:
            resultStr = @"A08";
            break;
        case 3:
            resultStr = @"A16";
            break;
        case 4:
            resultStr = @"B10";
            break;
        case 5:
            resultStr = @"B16";
            break;
        case 6:
            resultStr = @"B18";
            break;
        case 7:
            resultStr = @"B19";
            break;
        default:
            resultStr = @"FFF";
            break;
    }
    //转换
    NSString *year = [NSString stringWithFormat:@"%02d",[[numbers objectAtIndex:1] intValue]];
    NSString *month = [NSString stringWithFormat:@"%02d",[[numbers objectAtIndex:2] intValue]];
    NSString *num = [NSString stringWithFormat:@"%05d",[[numbers objectAtIndex:3] intValue]];
    snString = [NSString stringWithFormat:@"%@%@%@%@",resultStr,year,month,num];
    
    
    
    return snString;
}

@end
