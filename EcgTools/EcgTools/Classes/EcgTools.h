//
//  EcgTools.h
//  EcgTools
//
//  Created by baotiao ni on 2017/2/8.
//  Copyright © 2017年 xijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EcgTools : NSObject

/**
 *  将时间戳转化为时间
 *
 *  @param string 时间戳
 *
 *  @return 格式化时间字符串
 */
+ (NSString *)dateFromText:(NSString *)string;

/**
 *  获取当前时间的格式化字符串
 *
 *  @return 时间格式化字符串
 */
+ (NSString *)currentDateTimeStr;

/**
 *  校验手机号码的有效性
 *
 *  @param mobileNum 手机号码
 *
 *  @return 是否有效
 */
+(BOOL)validateMobile:(NSString *)mobileNum;

/**
 *  判断字符串是否可以转换为11个数字
 *
 *  @param str 字符串
 *
 *  @return 是否可以转换
 */
+(BOOL)elevenNumbers:(NSString *)str;

/**
 *  判断字符串是否都是由数字组成
 *
 *  @param str 字符串
 *
 *  @return 是否由数字组成
 */
+(BOOL)allNumbers:(NSString *)str;

/**
 *  判断密码是否是由6-18位数字和字母组合
 *
 *  @param password 密码字符串
 *
 *  @return 是否有效
 */
+ (BOOL)checkPassword:(NSString *) password;

/**
 *  判断有效是否有效
 *
 *  @param email 邮箱
 *
 *  @return 是否邮箱
 */
+(BOOL)isValidateEmail:(NSString *)email;

/**
 *  32位MD5加密方式
 *
 *  @param srcString 源字符串
 *
 *  @return 加密后的字符串
 */
+(NSString *)getMd5_32Bit_String:(NSString *)srcString;

/**
 *  等比例压缩
 *
 *  @param sourceImage 源图片
 *  @param size        压缩大小
 *
 *  @return <#return value description#>
 */
+(UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

/**
 *  xml字符串转换为html字符串
 *
 *  @param xmlStr xml 字符串
 *
 *  @return html 字符串
 */
+(NSString *)htmlFormatString:(NSString *)xmlStr;

/**
 *  将iso88591字符串转换为unicode字符串
 *
 *  @param iso88591String 88591字符串
 *
 *  @return unicode字符串
 */
+(NSString *) changeISO88591StringToUnicodeString:(NSString *)iso88591String;

/**
 *  保存到user default
 *
 *  @param key   key
 *  @param value 值
 */
+(void)saveToNSUserDefaults:(NSString *)key withValue:(NSString *)value;

/**
 *  从 user default 删除数据
 *
 *  @param key key
 */
+(void)deleteFromNSUserDefaults:(NSString *)key;

/**
 *  从 user default 中读取数据
 *
 *  @param key key
 *
 *  @return 读取到的数据值
 */
+(NSString *)readValueFromNSUserDefaults:(NSString *)key;

/**
 *  获取uuid  每调用一次，值都会不同，如果需要保存，可以结合keychain
 *
 *  @return uuid
 */
+(NSString*)uuid;

/**
 *  获取当前时间的格式化字符串 格式是：20161024105324
 *
 *  @return 格式化时间字符串
 */
+(NSString *)allTimeStr;

/**
 *  获取指定时间的格式化字符串 格式是：20161024105324
 *
 *  @param date 日期
 *
 *  @return 格式化时间字符串
 */
+(NSString *)allTimeStr:(NSDate *)date;

/**
 *  根据时间戳获取标准时间格式 20160524021325
 *
 *  @param interval 时间戳
 *
 *  @return 格式化时间字符串
 */
+(NSString *)allTimeStrFromInterval:(NSTimeInterval)interval;

/**
 *  获取格式化时间字符串 格式是：2016-10-25 12:23:45
 *
 *  @param str 时间字符串
 *
 *  @return 格式化时间字符串
 */
+(NSString *)dateStrTodate:(NSString *)str;

/**
 *  秒转换为日期
 *
 *  @param sec 距离1970的秒数
 *
 *  @return 日期
 */
+(NSString *)secToDate:(NSTimeInterval)sec;

/**
 *  秒转换为格式化时间字符串
 *
 *  @param sec 秒
 *
 *  @return 格式化时间字符串
 */
+(NSString *)secToDate2:(NSTimeInterval)sec;

/**
 *  计算秒包含的小时
 *
 *  @param seconds 秒
 *
 *  @return 小时
 */
+(NSInteger)hours:(CGFloat)seconds;

/**
 *  计算去掉分钟后包含的分钟
 *
 *  @param seconds 秒
 *
 *  @return 分钟
 */
+(NSInteger)minutes:(CGFloat)seconds;

/**
 *  计算去掉小时分钟后剩余的秒
 *
 *  @param seconds 秒
 *
 *  @return 剩余的秒
 */
+(NSInteger)seconds:(CGFloat)seconds;

/**
 *  计算指定天之后的日期
 *
 *  @param date 指定日期
 *  @param days 指定天数
 *
 *  @return 日期
 */
+(NSDate *)someDayLater:(NSDate *)date after:(int)days;

/**
 *  格式化时间字符串转换为日期
 *
 *  @param str 格式化时间字符串
 *
 *  @return 日期
 */
+(NSDate *)stringToDate:(NSString *)str;

/**
 *  日期转为格式化时间字符串（系统时区）
 *
 *  @param date 日期
 *
 *  @return 格式化时间字符串
 */
+(NSString *)dateToStringUTC:(NSDate *)date;

/**
 *  日期转换为格式化时间字符串
 *
 *  @param date 日期
 *
 *  @return 格式化时间字符串
 */
+(NSString *)dateToStringSystemZone:(NSDate *)date;

/**
 *  获取手机点数
 *
 *  @param pixelsNum 像素数
 *
 *  @return 点数
 */
+ (float)p_pointsWithPixels:(float)pixelsNum;

/**
 *  添加本地通知
 */
+(void)addLocalNotification;

/**
 *  移除本地通知，在不需要此通知时记得移除
 */
+ (void)removeNotification;

/**
 *  注册推送通知
 */
+(void)registerRemoteNotification;

/**
 *  取消远程推送
 */
+(void)removeRemoteNotification;

/**
 *  清除缓存
 *
 *  @param selector selector
 *  @param owner    owner description
 */
+(void)clearCaches:(SEL)selector at:(id)owner;

/**
 *  判空字符串是否是各种空值
 *
 *  @param str 字符串
 *
 *  @return 是否是空值
 */
+(BOOL)isNull:(NSString *)str;

/**
 *  网络数据向dataModel赋值
 *  dataModel中的属性名要和字典中key名保持一致
 *  @param dataModel  数据模型
 *  @param dataSource 数据源字典
 *
 *  @return 是否赋值成功
 */
+ (BOOL)assignToModel:(id)dataModel fromDictionary:(NSDictionary *)dataSource;

/**
 *  动态计算字符串高度
 *
 *  @param text   string 字符串
 *  @param fount  字号
 *  @param width 宽度
 *
 *  @return 字符串高度
 */
+ (CGFloat)getHeightWithText:(NSString*)text labelFount:(UIFont*)fount andWidth:(CGFloat)width;

/**
 *  删除空格
 */
+ (NSString*)removeSpaceFromeString:(NSString*)string;

/**
 *  获取一定时间间隔后的格式化时间字符串
 *
 *  @param sec      秒
 *  @param duration 间隔
 *
 *  @return 格式化时间字符串
 */
+ (NSString *)dateAfterDuraionHHmm:(NSTimeInterval)sec withDuration:(NSTimeInterval)duration;

/**
 *  删除回车
 */
+ (NSString*)removeEnterFromeString:(NSString*)string;

/**
 *  删除特殊字符
 *
 *  @param delStr 特殊字符
 *  @param source 源字符串
 *
 *  @return 删除特殊字符后的字符串
 */
+(NSString *)deleteSpecialStr:(NSString *)delStr from:(NSString *)source;

/**
 *  用于在安卓版的时间戳解决
 *
 *  @param date 日期
 *
 *  @return 格式化时间字符串
 */
+(NSString *)dateToSUTC:(NSDate *)date;

/**
 *  秒转换为日期
 *
 *  @param sec 距离1970的秒数
 *
 *  @return 日期
 */
+(NSString *)secTDate:(NSTimeInterval)sec;

/**
 *  显示是昨天还是明天
 *
 */
+(NSString *)compareDate:(NSDate *)date;

/**
 *  病人列表的显示
 *
 *  @param sec 秒
 *
 *  @return 昨天还是明天
 */
+(NSString *)secToReportDate:(NSTimeInterval)sec;

/**
 *  获取时间戳
 *
 *  @param date 日期
 *
 *  @return 时间戳
 */
+ (NSString *)stringSince1970:(NSDate *)date;

/**
 *  时间字符串转时间戳
 *
 *  @param date 时间字符串
 *
 *  @return 时间戳
 */
+ (NSString *)getDate:(NSString *)date;

/**
 时间戳转时间字符串
 
 @param time 时间戳字符串
 @return 时间字符串 yyyyMMddHHmmss格式
 */
+(NSString *)getDateFromTime:(NSString *)time ;

/**
 时间戳 转 时间字符串
 
 @param sec 时间戳
 @return 时间字符串
 */
+(NSString *)secToDateString:(NSTimeInterval)sec;

/**
 时间戳与当前时间戳比较 yes:当前时间大， no:当前时间小
 
 @param timeStemp 时间戳字符串
 @return YES:比当前时间大 NO:比当前时间小
 */
+(BOOL)checkTimeStemp:(NSString *)timeStemp;

/**
 *  将date时间戳转变成时间字符串
 *
 *  @param dateStr          用于转换的时间
 *  @param formatString 时间格式(yyyy-MM-dd HH:mm:ss)
 *
 *  @return  返回字字符如（2012－8－8 11:11:11）
 */
+ (NSString *)getDateStringWithDate:(NSString *)dateStr
                         DateFormat:(NSString *)formatString;
/**
 *  判断字符串中是否含有中文
 *
 *  @param str 源字符串
 *
 *  @return 是否含有
 */
+ (BOOL)containChinese:(NSString *)str;

/**
 *  把单引号替换成双引号
 *
 *  @param str 源字符串
 *
 *  @return 替换后的字符串
 */
+ (NSString*)saveFiltration:(NSString*)str;

/**
 *  把双引号替换成单引号
 *
 *  @param str 源字符串
 *
 *  @return 替换后的字符串
 */

+ (NSString*)readFiltration:(NSString*)str;

/**
 获取字符串size
 
 @param string 目标字符串
 @param attributes 属性字典
 @return 字符串size
 */
+ (CGSize)getStringSizeWith:(NSString *)string attributes:(NSDictionary *)attributes;

/**
 获取当前系统的首选语言环境
 
 @return return value description
 */
+ (NSString *)getCurrentSetLanguage;

/**
 删除空格
 
 @param str 目标字符串
 @return 结果字符串
 */
+ (NSString *)handleSpecialString:(NSMutableString *)str;

/**
 将数组或字典转化成json
 
 @param objc objc description
 @return return value description
 */
+ (NSString *)transformObjc:(id)objc;

/**
 将json格式的字符串转换成数组或字典
 
 @param jsonString jsonString
 @return return 字典
 */
+ (id)transformJsonString:(NSString *)jsonString;

/**
 直插设备序列号转换为标准序列号
 
 @param snString 直插设备序列号
 @return 标准序列号
 */
+ (NSString *)transformAIODeviceSn:(NSString *)snString;
@end
