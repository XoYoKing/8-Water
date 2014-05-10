//
//  RKCheckHelp.m
//  8 Water
//
//  Created by RyanLI on 14-4-7.
//  Copyright (c) 2014年 ruikaili. All rights reserved.
//

#import "RKCheckHelp.h"

@implementation RKCheckHelp
+ (BOOL)isHelped
{
    //默认路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"help.plist"];
    
    //文件管理对象
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    
    //文件不存在，显示帮助画面
    if (![fileManager fileExistsAtPath:path])
    {
        [fileManager createFileAtPath:path contents:nil attributes:nil];
        return NO;
    }
    
    //文件存在，不显示帮助画面
    return YES;
}
@end
