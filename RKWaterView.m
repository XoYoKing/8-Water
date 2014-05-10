//
//  RKWaterView.m
//  8 Water
//
//  Created by RyanLI on 14-4-3.
//  Copyright (c) 2014年 ruikaili. All rights reserved.
//

#import "RKWaterView.h"

@implementation RKWaterView

+ (id)waterViewWithFrame:(CGRect)frame Volumes:(NSInteger)volumes Target:(id)target
{
    //waterView
    RKWaterView *view = [[RKWaterView alloc] initWithFrame:frame];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    //today标签尺寸
    NSInteger labelWeitht = frame.size.width;
    NSInteger labelHeight = 30;
    
    //today标签属性
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, labelWeitht, labelHeight)];
    [label setText:@"TODAY"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue" size:25]];
    
    //finish按钮尺寸
    NSInteger finishWidth = 300;
    NSInteger finishHeight = 70;
    
    //finish与工具条的距离
    NSInteger finishtToToolbar = 10;
    
    //finish按钮属性
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn addTarget:target action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    
    //量杯尺寸
    NSInteger cupWidth = 200;
    NSInteger cupHeight = 240;
    
    //量杯与toolar的距离
    NSInteger cupToToolbar = 40;
    
    //量杯属性
    UIImageView *cup = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - cupWidth)/2 - 8, frame.size.height -cupHeight - cupToToolbar, cupWidth, cupHeight)];
    [cup setImage:[UIImage imageNamed:@"cup.png"]];
    
    //水条尺寸
    NSInteger volumeWidth = 164;
    NSInteger volumeHeight = 27;

    //下面有顺序依赖，不要乱加
    [view addSubview:label];
    [view addSubview:btn];
    
    
    //底部水条
    UIImageView *volumeBottom = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - volumeWidth)/2, frame.size.height - 77, volumeWidth, 34)];
    [volumeBottom setImage:[UIImage imageNamed:@"volume_bottom.png"]];
    [volumeBottom setHidden:YES];
    [view addSubview:volumeBottom];
    
    //中部水条
    for (int i = 1; i < 7; i++) {
        UIImageView *volume = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - volumeWidth)/2, frame.size.height - 77 - i*25, volumeWidth, volumeHeight)];
        [volume setImage:[UIImage imageNamed:@"volume_normal.png"]];
        [volume setHidden:YES];
        [view addSubview:volume];
    }
    
    //顶部水条
    UIImageView *volumeTop = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width - volumeWidth)/2 - 3, frame.size.height - 77 - 7*25, volumeWidth + 1, 34)];
    [volumeTop setImage:[UIImage imageNamed:@"volume_top.png"]];
    [volumeTop setHidden:YES];
    [view addSubview:volumeTop];
    
    //初始化量杯
    for (NSInteger i = 2; i < volumes + 2; i++) {
        [[view subviews][i]setHidden:NO];
    }
    
    
    //cup应该在最后放，才能遮挡水条
    [view addSubview:cup];
    
    return view;
}

#pragma mark- 刷新
- (void)refreshVolumes:(NSInteger)volumes
{
    //刷新量杯
    for (NSInteger i = 2; i < volumes + 2; i++) {
        [[self subviews][i]setHidden:NO];
    }
}
@end
