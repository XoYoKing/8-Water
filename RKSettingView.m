//
//  customTableView.m
//  Sport Manager
//
//  Created by RyanLI on 14-4-1.
//  Copyright (c) 2014年 ruikaili. All rights reserved.
//

#import "RKSettingView.h"

@implementation RKSettingView

#pragma mark-  初始化
+ (id)settingViewWithFrame:(CGRect)frame Style:(UITableViewStyle)style
{
    //创建对象
    RKSettingView *setting = [[RKSettingView alloc]initWithFrame:frame style:style];
    [setting setRowHeight:50];
    
    return setting;
}

@end
