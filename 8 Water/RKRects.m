//
//  RKCommonRect.m
//  8 Water
//
//  Created by RyanLI on 14-4-3.
//  Copyright (c) 2014年 ruikaili. All rights reserved.
//

#import "RKRects.h"

@implementation RKRects
+ (id)rects
{
    RKRects *rect = [[RKRects alloc]init];
    //UIscreen 适应3.5inch/4.0inch
    CGRect screen = [[UIScreen mainScreen]bounds];
    
    //header
    NSInteger navigationBarHeight = 60;
    [rect setNavigationBar:CGRectMake(screen.origin.x, screen.origin.y, screen.size.width, navigationBarHeight)];
    
    //footer
    NSInteger toolbarHeight = 50;
    [rect setToolbar:CGRectMake(screen.origin.x, screen.size.height - toolbarHeight, screen.size.width, toolbarHeight)];
    
    //body +1边界像素
    [rect setCenterView:CGRectMake(screen.origin.x, screen.origin.y + navigationBarHeight + 1, screen.size.width , screen.size.height - navigationBarHeight - toolbarHeight - 2)];
    
    return rect;
}
@end
