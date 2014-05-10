//
//  RKViewController.m
//  8 Water
//
//  Created by RyanLI on 14-4-3.
//  Copyright (c) 2014年 ruikaili. All rights reserved.
//

#import "RKViewController.h"

@interface RKViewController ()

@end

@implementation RKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //加载数据
    _data = [RKData data];
    
    //加载视图
    _navigationBar = [RKNavigationBar navigationBarWithFrame:[_data navigationBarFrame] Title:@"Water"];
    _toolbar = [RKToolbar toolbarWithFrame:[_data toolbarFrame] Target:self];
    
    _waterView = [RKWaterView waterViewWithFrame:[_data bodyViewFrame] Volumes:[_data volumeOfToday] Target:self];
    _totalView = [RKTotalView totalViewWithFrame:[_data bodyViewFrame] Dictionary:[_data dictionaryFromFile]];
    _settingView = [RKSettingView settingViewWithFrame:[_data bodyViewFrame]];
    
    _aboutView = [RKAboutView aboutViewWithFrame:[_data aboutViewFrame]];
    
    //设置代理
    [_settingView setDelegate:self];
    [_settingView setDataSource:self];
    [_navigationBar setDelegate:self];
    
    
    //操作视图
    [[self view]addSubview:_navigationBar];
    [[self view]addSubview:_toolbar];
    
    [[self view]addSubview:_totalView];
    [[self view]addSubview:_settingView];
    [[self view]addSubview:_waterView];
    
    //检查是否观看帮助
    if(![_data isHelped])[[self view]addSubview:[RKHelpView helpView]];
    
    //检查字典
    [_data creatDictionary];
}

#pragma mark- navigationBarDelegate
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    [_aboutView removeFromSuperview];
    return YES;
}

#pragma mark- toolbarDelegate
- (void)water
{
    [[self view]bringSubviewToFront:_waterView];
    [[_navigationBar items][0]setTitle:@"Water"];
}

- (void)total
{
    [[self view]bringSubviewToFront:_totalView];
    [[_navigationBar items][0]setTitle:@"Total"];
    
}

- (void)setting
{
    [[self view]bringSubviewToFront:_settingView];
    [[_navigationBar items][0]setTitle:@"Settings"];
    
}

#pragma mark- waterView finish
- (void)finish:(id)sender
{
    if (!([_data volumeOfToday] < 8)){
        //提醒已够8杯水
        [[[UIAlertView alloc]initWithTitle:@"Mission Completed" message:@"" delegate:nil cancelButtonTitle:@"Great" otherButtonTitles:nil, nil] show];
        //将通知按钮设回NO
        [_aSwitch setOn:NO];
        //清除所有通知
        [[UIApplication sharedApplication]cancelAllLocalNotifications];
        return;
    }
    
    if (![_data isLimited]) {
        //提醒还没满1小时
        [[[UIAlertView alloc]initWithTitle:@"Come next hour" message:[NSString stringWithFormat:@"Last Time: %@",[_data lastTime]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    
    //添加一杯水
    [_data finishOneDrink];
    
    //刷新视图，不能用viewdidload，不是刷新，只是无限添加视图，引起内存崩溃
    [_totalView removeFromSuperview];
    
    [_waterView refreshVolumes:[_data volumeOfToday]];
    _totalView = [RKTotalView totalViewWithFrame:[_data bodyViewFrame] Dictionary:[_data dictionaryFromFile]];
    
    [[self view]addSubview:_totalView];
    [[self view]bringSubviewToFront:_waterView];
}

#pragma mark- settingViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    [cell addSubview:[[NSBundle mainBundle]loadNibNamed:@"tableViewCells" owner:self options:nil][0]];
    return cell;
}

#pragma mark- settingViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark- settingView switch
- (void)reminder:(id)sender
{
    //判断
    if (![_aSwitch isOn]) {
        //取消所有通知
        [[UIApplication sharedApplication]cancelAllLocalNotifications];
        return;
    }
    
    //获得今天的剩余喝水量
    NSInteger left = 8 - [_data volumeOfToday];
    
    //判断剩余是否已完成任务
    if (!(left != 0)) {
        [[[UIAlertView alloc]initWithTitle:@"Mission Completed" message:@"No need to remind today" delegate:nil cancelButtonTitle:@"Great" otherButtonTitles:nil, nil] show];
        [_aSwitch setOn:NO];
        return;
    }
    
    //初始化通知序列
    NSMutableArray *notifications = [[NSMutableArray alloc]init];
    
    //按照剩余喝水量生成通知序列
    int i = 1;
    while (left > 0) {
        //创建本地通知对象，用默认时区初始化
        UILocalNotification *notification = [UILocalNotification allocWithZone:(__bridge struct _NSZone *)([NSTimeZone defaultTimeZone])];
        
        //设置通知时间
        [notification setFireDate:[NSDate dateWithTimeIntervalSinceNow:3600*i]];
        
        //设置通知内容
        [notification setAlertBody:[NSString stringWithFormat:@"You have %d cups of water left!",left]];
        [notification setSoundName:UILocalNotificationDefaultSoundName];
        
        //添加到序列
        [notifications addObject:notification];
        i++;
        left--;
    }
    
    //序列添加到通知中心
    [[UIApplication sharedApplication]setScheduledLocalNotifications:notifications];
}

@end
