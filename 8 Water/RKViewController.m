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
    _rects = [RKRects rects];
    _isFinish = [RKCheckFinish checkFinisWithDefaultPaht];
    _dictionary = [RKDictionary dictionaryWithDefaultPath];
    [_dictionary creatFile];
    
    //加载视图
    _navigationBar = [RKNavigationBar navigationBarWithFrame:[_rects navigationBar] Title:@"Water"];
    _toolbar = [RKToolbar toolbarWithFrame:[_rects toolbar] Target:self];
    
    _waterView = [RKWaterView waterViewWithFrame:[_rects centerView] Volumes:[_dictionary volumeOfToday] Target:self];
    _totalView = [RKTotalView totalViewWithFrame:[_rects centerView] Dictionary:[_dictionary dictionaryFromFile]];
    _settingView = [RKSettingView settingViewWithFrame:[_rects centerView] Style:UITableViewStylePlain];
    
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
    if(![RKCheckHelp isHelped])[[self view]addSubview:[RKHelpView helpView]];
    
    //检查通知序列是否为空
//    if ([[[UIApplication sharedApplication]scheduledLocalNotifications]count] == 0)[_aSwitch setOn:NO];
}

#pragma mark- 视图切换
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
#pragma mark- settingView 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    //提醒行
    if([indexPath row] == 0)
    {
        //标题
        [[cell textLabel]setText:@"Remind me"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //switch
        NSInteger switchWidth = 49;
        NSInteger switchHeight = 31;
        _aSwitch = [[UISwitch alloc]initWithFrame:
                             CGRectMake(250,
                                        10,
                                        switchWidth,
                                        switchHeight)];
        //判断switch状态
        if ([[[UIApplication sharedApplication]scheduledLocalNotifications]count] != 0)[_aSwitch setOn:YES];
        else [_aSwitch setOn:NO];
        
        //switch绑定
        [_aSwitch addTarget:self action:@selector(reminder:) forControlEvents:UIControlEventValueChanged];
        
        [[cell contentView]addSubview:_aSwitch];
    }
    //帮助行
    if([indexPath row] == 1)
    {
        //标题
        [[cell textLabel]setText:@"Help"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    //关于行
    if([indexPath row] == 2)
    {
        //标题
        [[cell textLabel]setText:@"About"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    //评分行
    if([indexPath row] == 3)
    {
        //标题
        [[cell textLabel]setText:@"Give a Review"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    return cell;
}

#pragma mark- settingView 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //帮助行
    if([indexPath row] == 1)
    {
        RKHelpView *help = [RKHelpView helpView];
        [[tableView superview]addSubview:help];
    }
    
    //关于行
    if([indexPath row] == 2)
    {
        //*****************暂时实现，往后需要优化成一个AboutView******************
        
        //获得tableView尺寸
        CGRect table = [tableView bounds];
        
        //about导航item
        _aboutItem =[[UINavigationItem alloc]initWithTitle:@"About"];
        [_navigationBar pushNavigationItem:_aboutItem animated:YES];
        
        //aboutsxroll尺寸
        NSInteger aboutViewWidth = table.size.width;
        NSInteger aboutViewHeight = table.size.height + 300;
        
        //aboutscroll视图
        _aboutView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, aboutViewWidth, aboutViewHeight)];
        [_aboutView setBackgroundColor:[UIColor whiteColor]];
        
        //8-Water图标尺寸
        NSInteger iconWidth = 80;
        NSInteger iconHeight = 80;
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake((table.size.width - iconWidth)/2, 50,
                                                                         iconWidth,
                                                                         iconHeight)];
        [icon setImage:[UIImage imageNamed:@"icon-80x80.png"]];
        
        //claim尺寸
        NSInteger textViewWidth = 320;
        NSInteger textViewHeight = 800;
        
        UITextView *claim = [[UITextView alloc]initWithFrame:CGRectMake(0, iconHeight + 50 , textViewWidth, textViewHeight)];
        
        [claim setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:15]];
        [claim setTextAlignment:NSTextAlignmentCenter];
        [claim setEditable:NO];
        
        //claim文本
        [claim setText:@"8 Water\n\n"];
        [claim insertText:@"Version 1.0\n\n\n"];
        [claim insertText:@"Copyright:@RUI KAI LI\n"];
        [claim insertText:@"Email:ryanlrk@gmail.com\n"];
        [claim insertText:@"Tel:+86 18933 189363\n"];
        
        //添加到about
        [_aboutView addSubview:icon];
        [_aboutView addSubview:claim];
        
        //添加到tableview
        [tableView addSubview:_aboutView];
        
        //隐藏toolbar
        [_toolbar setHidden:YES];
    }
    
    //评分行
    if([indexPath row] == 3)
    {
        NSURL *url =[NSURL URLWithString:@"https://itunes.apple.com/us/app/8-water/id854375568?ls=1&mt=8"];
        [[UIApplication sharedApplication]openURL:url];
    }
}

#pragma mark- navigationBar 代理方法
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    [_aboutView removeFromSuperview];
    [_toolbar setHidden:NO];
    
    return YES;
}


#pragma mark- finish: 按钮方法
- (void)finish:(id)sender
{
    if (!([_dictionary volumeOfToday] < 8)){
        //提醒已够8杯水
        [[[UIAlertView alloc]initWithTitle:@"Mission Completed" message:@"" delegate:nil cancelButtonTitle:@"Great" otherButtonTitles:nil, nil] show];
        //将通知按钮设回NO
        [_aSwitch setOn:NO];
        //清除所有通知
        [[UIApplication sharedApplication]cancelAllLocalNotifications];
        return;
    }
    
    if (![_isFinish canFinish]) {
        //提醒还没满1小时
        [[[UIAlertView alloc]initWithTitle:@"Come next hour" message:[NSString stringWithFormat:@"Last Time: %@",[_isFinish lastTime]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    
    //添加一杯水
    [_dictionary finishOneDrink];
    
    //刷新视图，不能用viewdidload，不是刷新，只是无限添加视图，引起内存崩溃
    [_totalView removeFromSuperview];
    
    [_waterView refreshVolumes:[_dictionary volumeOfToday]];
    _totalView = [RKTotalView totalViewWithFrame:[_rects centerView] Dictionary:[_dictionary dictionaryFromFile]];
    
    [[self view]addSubview:_totalView];
    [[self view]bringSubviewToFront:_waterView];
}

#pragma mark- switch: 按钮方法
- (void)reminder:(id)sender
{
    //判断
    if (![_aSwitch isOn]) {
        //取消所有通知
        [[UIApplication sharedApplication]cancelAllLocalNotifications];
        return;
    }
    
    //获得今天的剩余喝水量
    NSInteger left = 8 - [_dictionary volumeOfToday];
    
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
