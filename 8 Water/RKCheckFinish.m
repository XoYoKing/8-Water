//
//  RKCheckFinish.m
//  8 Water
//
//  Created by RyanLI on 14-4-7.
//  Copyright (c) 2014年 ruikaili. All rights reserved.
//

#import "RKCheckFinish.h"

@implementation RKCheckFinish
+ (id)checkFinisWithDefaultPaht;
{
    RKCheckFinish *checkFinish = [[RKCheckFinish alloc]init];
    
    //默认路径
    [checkFinish setPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"finish.plist"]];
    
    return checkFinish;
}

- (BOOL)canFinish;
{
    //文件管理对象
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    
    //文件不存在，即允许马上finish
    if (![fileManager fileExistsAtPath:_path])
    {
        //当前时区时间
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone]secondsFromGMT]];
        
        //压缩当前时间，写入文件
        [NSKeyedArchiver archiveRootObject:date toFile:_path];
        return YES;
    }
    
    //文件存在，解压，读取文件，转换成对象，获取上一次finish的时间
    NSDate *oldDate = (NSDate *)[NSKeyedUnarchiver unarchiveObjectWithFile:_path];
    
    //将上一次finish时间，往前推1小时
    NSDate *oldDateAddOneHour = [NSDate dateWithTimeInterval:3600 sinceDate:oldDate];
    
    //当前时区时间
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone]secondsFromGMT]];

    //比较当前时间，和，旧时间加上1小时，返回较迟的时间，若返回的世间是当前时间，则允许finish
    if ([nowDate isEqualToDate:[nowDate laterDate:oldDateAddOneHour]]) {
        //压缩当前时间，写入文件
        [NSKeyedArchiver archiveRootObject:nowDate toFile:_path];
        //允许YES
        return YES;
    }
    
    //时间未到，则NO
    return NO;
}

- (NSString *)lastTime
{
    //文件管理对象
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    
    //文件不存在
    if (![fileManager fileExistsAtPath:_path])
    {
        //当前时区时间
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone]secondsFromGMT]];
        
        //压缩当前时间，写入文件
        [NSKeyedArchiver archiveRootObject:date toFile:_path];
        
        //返回当前时间
        return [[date description]substringWithRange:NSRangeFromString(@"11,5")];
    }
    
    //文件存在，解压，读取文件，转换成对象，获取上一次的时间
    return [[(NSDate *)[NSKeyedUnarchiver unarchiveObjectWithFile:_path] description]substringWithRange:NSRangeFromString(@"11,5")];
}

@end
