//
//  RKViewController.h
//  8 Water
//
//  Created by RyanLI on 14-4-3.
//  Copyright (c) 2014年 ruikaili. All rights reserved.
//

#import <UIKit/UIKit.h>

//Model
#import "RKRects.h"
#import "RKDictionary.h"
#import "RKCheckHelp.h"
#import "RKCheckFinish.h"

//View
#import "RKNavigationBar.h"
#import "RKToolbar.h"
#import "RKWaterView.h"
#import "RKTotalView.h"
#import "RKSettingView.h"
#import "RKHelpView.h"
#import "RKAboutView.h"


@interface RKViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UINavigationBarDelegate>
{
    RKRects *_rects;
    RKDictionary *_dictionary;
}
//基本视图
@property (strong,nonatomic) RKNavigationBar *navigationBar;
@property (strong,nonatomic) UINavigationItem *aboutItem;
@property (strong,nonatomic) RKToolbar *toolbar;

//自定义视图
@property (strong,nonatomic) RKWaterView *waterView;
@property (strong,nonatomic) RKTotalView *totalView;
@property (strong,nonatomic) RKSettingView *settingView;

@property (strong,nonatomic) UIScrollView *aboutView;

@property (strong,nonatomic) UISwitch *aSwitch;

//检查上一次时间
@property (strong,nonatomic) RKCheckFinish *isFinish;

@end
