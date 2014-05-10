//
//  RKCheckFinish.h
//  8 Water
//
//  Created by RyanLI on 14-4-7.
//  Copyright (c) 2014年 ruikaili. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKCheckFinish : NSObject
@property (strong,nonatomic) NSString *path;
+ (id)checkFinisWithDefaultPaht;
- (BOOL)canFinish;
- (NSString *)lastTime;
@end
