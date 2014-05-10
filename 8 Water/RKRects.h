//
//  RKCommonRect.h
//  8 Water
//
//  Created by RyanLI on 14-4-3.
//  Copyright (c) 2014年 ruikaili. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKRects : NSObject
@property (assign) CGRect navigationBar;
@property (assign) CGRect centerView;
@property (assign) CGRect toolbar;
+ (id) rects;
@end
