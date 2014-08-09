//
//  AppDelegate.h
//  NanNIng
//
//  Created by Seven on 14-8-8.
//  Copyright (c) 2014年 greenorange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckNetwork.h"
#import "MainPageView.h"
#import "StewardPageView.h"
#import "LifePageView.h"
#import "SettingView.h"
#import "CityPageView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) MainPageView *mainPage;
@property (strong, nonatomic) StewardPageView *stewardPage;
@property (strong, nonatomic) LifePageView *lifePage;
@property (strong, nonatomic) CityPageView *cityPage;
@property (strong, nonatomic) SettingView *settingPage;

@end
