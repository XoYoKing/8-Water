//
//  RKVolume.h
//  8 Water
//
//  Created by RyanLI on 14-4-5.
//  Copyright (c) 2014年 ruikaili. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKDictionary : NSObject

@property (strong,nonatomic) NSString *path;

//初始化
+ (id)dictionaryWithDefaultPath;
+ (id)dictionaryWithPath:(NSString *)path;

//文件操作
- (BOOL)creatFile;
- (NSMutableDictionary *)dictionaryFromFile;
- (BOOL)saveDictionary:(NSMutableDictionary *)dic;

//功能性
- (NSInteger)volumeOfToday;
- (void)finishOneDrink;

@end
