//
//  myNavigationBar.m
//  Sport Manager
//
//  Created by RyanLI on 14-3-30.
//  Copyright (c) 2014年 ruikaili. All rights reserved.
//

#import "RKNavigationBar.h"

@implementation RKNavigationBar

+ (id)navigationBarWithFrame:(CGRect)frame Title:(NSString *)title
{
    RKNavigationBar *nav = [[RKNavigationBar alloc]initWithFrame:frame];
    
    [nav pushNavigationItem:[[UINavigationItem alloc]initWithTitle:title] animated:NO];
    
    return nav;
}

@end
