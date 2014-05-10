//
//  RKVolume.m
//  8 Water
//
//  Created by RyanLI on 14-4-5.
//  Copyright (c) 2014年 ruikaili. All rights reserved.
//

#import "RKDictionary.h"

@implementation RKDictionary

#pragma mark 初始化
+ (id)dictionaryWithDefaultPath
{
    
    //默认路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"data.plist"];
    //path = @"/users/ryanli/Desktop/data.plist";
    
    //创建对象
    RKDictionary *dic = [[RKDictionary alloc]init];
    
    //设置路径
    [dic setPath:path];
    
    return dic;
}

+ (id)dictionaryWithPath:(NSString *)path
{
    //创建对象
    RKDictionary *dic = [[RKDictionary alloc]init];
    
    //设置路径
    [dic setPath:path];
    
    return dic;
}

#pragma mark 文件操作
- (BOOL)creatFile
{
    //文件管理对象
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    
    //创建文件
    if (![fileManager fileExistsAtPath:_path])
    {
        //创建字典
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        //添加记录
        for (int i = -30; i < 365*5; i++) {
            //当前时区时间
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone]secondsFromGMT]];
            
            //基于当前时区，过去或未来的时间
            NSString *dateStr = [[[NSDate dateWithTimeInterval:3600*24*i sinceDate:date]description]substringToIndex:10];
            
            //写入字典
            [dic setValue:@"0" forKey:dateStr];
        }
        //写入文件
        [dic writeToFile:_path atomically:YES];
        return YES;
    }
    return NO;
}

- (NSMutableDictionary *)dictionaryFromFile
{
    //读取字典
    return [NSMutableDictionary dictionaryWithContentsOfFile:_path];
}

- (BOOL)saveDictionary:(NSMutableDictionary *)dic
{
    //保存字典
    return [dic writeToFile:_path atomically:YES];
}

#pragma mark 功能性
- (NSInteger)volumeOfToday
{
    //读取字典
    NSMutableDictionary *dic = [self dictionaryFromFile];
    
    //当前时区时间
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone]secondsFromGMT]];
    
    //基于当前时区
    NSString *dateStr = [[[NSDate dateWithTimeInterval:0 sinceDate:date]description]substringToIndex:10];
    
    //返回今天的喝水量
    return [dic[dateStr] intValue];
}

- (void)finishOneDrink
{
    //获取今天喝水量
    NSInteger volume = [self volumeOfToday];
    
    //当前时区时间
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone]secondsFromGMT]];
    
    //基于当前时区
    NSString *dateStr = [[[NSDate dateWithTimeInterval:0 sinceDate:date]description]substringToIndex:10];
    
    //读取字典
    NSMutableDictionary *dic = [self dictionaryFromFile];
    
    //修改字典
    [dic setValue:[NSString stringWithFormat:@"%d",volume + 1] forKey:dateStr];
    
    //保存字典
    [self saveDictionary:dic];
}

@end
