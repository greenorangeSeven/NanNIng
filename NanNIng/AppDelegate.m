//
//  AppDelegate.m
//  NanNIng
//
//  Created by Seven on 14-8-8.
//  Copyright (c) 2014年 greenorange. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>

BMKMapManager* _mapManager;

@implementation AppDelegate
@synthesize mainPage;
@synthesize stewardPage;
@synthesize lifePage;
@synthesize shopCarPage;
@synthesize tabBarController;
@synthesize cityPage;
@synthesize appId, channelId, userId;

#define SUPPORT_IOS8 0

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //检查网络是否存在 如果不存在 则弹出提示
    [UserModel Instance].isNetworkRunning = [CheckNetwork isExistenceNetwork];
    //显示系统托盘
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    //初始化ShareSDK
    [ShareSDK registerApp:@"2cc31fa9badc"];
    [self initializePlat];
    
    //获取并保存用户信息
    [self saveUserInfo];
    [self saveAlipayKeyInfo];
    
    //首页
    self.mainPage = [[MainPageView alloc] initWithNibName:@"MainPageView" bundle:nil];
    mainPage.tabBarItem.image = [UIImage imageNamed:@"tab_main"];
    mainPage.tabBarItem.title = @"首页";
    UINavigationController *mainPageNav = [[UINavigationController alloc] initWithRootViewController:self.mainPage];
    //智慧物业
    self.stewardPage = [[StewardPageView alloc] initWithNibName:@"StewardPageView" bundle:nil];
    stewardPage.tabBarItem.image = [UIImage imageNamed:@"tab_steward"];
    stewardPage.tabBarItem.title = @"智慧物业";
    UINavigationController *stewardPageNav = [[UINavigationController alloc] initWithRootViewController:self.stewardPage];
    //智慧生活
    self.lifePage = [[LifePageView alloc] initWithNibName:@"LifePageView" bundle:nil];
    lifePage.tabBarItem.image = [UIImage imageNamed:@"tab_life"];
    lifePage.tabBarItem.title = @"智慧生活";
    UINavigationController *lifePageNav = [[UINavigationController alloc] initWithRootViewController:self.lifePage];
    //智慧城市
    self.cityPage = [[CityPageView alloc] initWithNibName:@"CityPageView" bundle:nil];
    cityPage.tabBarItem.image = [UIImage imageNamed:@"tab_nanning"];
    cityPage.tabBarItem.title = @"智慧南宁";
    UINavigationController *cityPageNav = [[UINavigationController alloc] initWithRootViewController:self.cityPage];
    
    //购物车
    self.shopCarPage = [[ShoppingCartView alloc] initWithNibName:@"ShoppingCartView" bundle:nil];
    shopCarPage.tabBarItem.image = [UIImage imageNamed:@"tab_shopcar"];
    shopCarPage.tabBarItem.title = @"购物车";
    UINavigationController *shopcarPageNav = [[UINavigationController alloc] initWithRootViewController:self.shopCarPage];

    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:
                                             mainPageNav,
                                             lifePageNav,
                                             stewardPageNav,
                                             cityPageNav,
                                             shopcarPageNav,
                                             nil];
    [[self.tabBarController tabBar] setSelectedImageTintColor:[Tool getColorForGreen]];
    [[self.tabBarController tabBar] setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
    //设置UINavigationController背景
    if (IS_IOS7) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top_bg7"]  forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"top_bg"]  forBarMetrics:UIBarMetricsDefault];
    }
    
    // 要使用百度地图，请先启动BaiduMapManager
	_mapManager = [[BMKMapManager alloc]init];
	BOOL ret = [_mapManager start:@"FqrlznfiCzEg2FIkzK22lzEM" generalDelegate:self];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
    //设置目录不进行IOS自动同步！否则审核不能通过
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [NSString stringWithFormat:@"%@/cfg", [paths objectAtIndex:0]];
    NSURL *dbURLPath = [NSURL fileURLWithPath:directory];
    [self addSkipBackupAttributeToItemAtURL:dbURLPath];
    [self addSkipBackupAttributeToPath:directory];
    
    [BPush setupChannel:launchOptions];
    [BPush setDelegate:self];
    
    [application setApplicationIconBadgeNumber:0];
#if SUPPORT_IOS8
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else
#endif
    {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:self.tabBarController ];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

#if SUPPORT_IOS8
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}
#endif

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    NSLog(@"test:%@",deviceToken);
    [BPush registerDeviceToken: deviceToken];
}

- (void) onMethod:(NSString*)method response:(NSDictionary*)data {
    NSLog(@"On method:%@", method);
    NSLog(@"data:%@", [data description]);
    NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
    if ([BPushRequestMethod_Bind isEqualToString:method]) {
        NSString *appid = [res valueForKey:BPushRequestAppIdKey];
        NSString *userid = [res valueForKey:BPushRequestUserIdKey];
        NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
        //NSString *requestid = [res valueForKey:BPushRequestRequestIdKey];
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        
        if (returnCode == BPushErrorCode_Success) {
            // 在内存中备份，以便短时间内进入可以看到这些值，而不需要重新bind
            self.appId = appid;
            self.channelId = channelid;
            self.userId = userid;
        }
    } else if ([BPushRequestMethod_Unbind isEqualToString:method]) {
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];

    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Receive Notify: %@", [userInfo JSONString]);
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if (application.applicationState == UIApplicationStateActive) {
        // Nothing to do if applicationState is Inactive, the iOS already displayed an alert view.
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Did receive a Remote Notification"
                                                            message:[NSString stringWithFormat:@"The application received this remote notification while it was running:\n%@", alert]
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
//        [alertView show];
    }
    [application setApplicationIconBadgeNumber:0];
    
    [BPush handleNotification:userInfo];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)saveUserInfo
{
    UserModel *usermodel = [UserModel Instance];
    if ([usermodel isLogin]) {
        NSString *userinfoUrl = [NSString stringWithFormat:@"%@%@?APPKey=%@&tel=%@", api_base_url, api_getuserinfo, appkey, [usermodel getUserValueForKey:@"tel"]];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:userinfoUrl]];
        [request setDelegate:self];
        [request setDidFailSelector:@selector(requestFailed:)];
        [request setDidFinishSelector:@selector(requestUserinfo:)];
        [request startAsynchronous];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    
}

- (void)requestUserinfo:(ASIHTTPRequest *)request
{
    [request setUseCookiePersistence:YES];
    NSData *data = [request.responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (!json) {
        return;
    }
    User *user = [Tool readJsonStrToUser:request.responseString];
    int userid = [user.id intValue];
    if (userid > 0) {
        //设置登录并保存用户信息
        UserModel *userModel = [UserModel Instance];
        [userModel saveIsLogin:YES];
        [userModel saveValue:user.id ForKey:@"id"];
        [userModel saveValue:user.cid ForKey:@"cid"];
        [userModel saveValue:user.build_id ForKey:@"build_id"];
        [userModel saveValue:user.house_number ForKey:@"house_number"];
        [userModel saveValue:user.carport_number ForKey:@"carport_number"];
        [userModel saveValue:user.name ForKey:@"name"];
        [userModel saveValue:user.nickname ForKey:@"nickname"];
        [userModel saveValue:user.address ForKey:@"address"];
        [userModel saveValue:user.tel ForKey:@"tel"];
        [userModel saveValue:user.pwd ForKey:@"pwd"];
        [userModel saveValue:user.avatar ForKey:@"avatar"];
        [userModel saveValue:user.email ForKey:@"email"];
        [userModel saveValue:user.card_id ForKey:@"card_id"];
        [userModel saveValue:user.property ForKey:@"property"];
        [userModel saveValue:user.plate_number ForKey:@"plate_number"];
        [userModel saveValue:user.credits ForKey:@"credits"];
        [userModel saveValue:user.remark ForKey:@"remark"];
        [userModel saveValue:user.checkin ForKey:@"checkin"];
    }
}

- (void)saveAlipayKeyInfo
{
    NSString *userinfoUrl = [NSString stringWithFormat:@"%@%@?APPKey=%@", api_base_url, api_getAlipay, appkey];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:userinfoUrl]];
    [request setDelegate:self];
    [request setDidFailSelector:@selector(requestFailed:)];
    [request setDidFinishSelector:@selector(requestAlipayInfo:)];
    [request startAsynchronous];
}

- (void)requestAlipayInfo:(ASIHTTPRequest *)request
{
    [request setUseCookiePersistence:YES];
    NSData *data = [request.responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (!json) {
        return;
    }
    AlipayInfo *alipay = [Tool readJsonStrToAliPay:request.responseString];
    if (alipay) {
        //保存支付宝信息
        UserModel *userModel = [UserModel Instance];
//        [userModel saveValue:alipay.DEFAULT_PARTNER ForKey:@"DEFAULT_PARTNER"];
//        [userModel saveValue:alipay.DEFAULT_SELLER ForKey:@"DEFAULT_SELLER"];
//        [userModel saveValue:alipay.PRIVATE ForKey:@"PRIVATE"];
//        [userModel saveValue:alipay.PUBLIC ForKey:@"PUBLIC"];
        [userModel saveDefaultPartner:alipay.DEFAULT_PARTNER];
        [userModel saveSeller:alipay.DEFAULT_SELLER];
        [userModel savePrivate:alipay.PRIVATE];
        [userModel savePublic:alipay.PUBLIC];
    }
}

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

- (void)addSkipBackupAttributeToPath:(NSString*)path {
    u_int8_t b = 1;
    setxattr([path fileSystemRepresentation], "com.apple.MobileBackup", &b, 1, 0, 0);
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic)
         {
             NSString *resultState = resultDic[@"resultStatus"];
             if([resultState isEqualToString:ORDER_PAY_OK])
             {
                 [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_PAY_NOTIC object:nil];
             }
         }];
    }
    if ([url.host isEqualToString:@"platformapi"])
    {//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic)
         {
             NSString *resultState = resultDic[@"resultStatus"];
             if([resultState isEqualToString:ORDER_PAY_OK])
             {
                 [[NSNotificationCenter defaultCenter] postNotificationName:ORDER_PAY_NOTIC object:nil];
             }
         }];
    }
    return YES;
}

//初始化分享
- (void)initializePlat
{
    /**
     连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
     http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
     **/
    [ShareSDK connectSinaWeiboWithAppKey:@"776664121"
                               appSecret:@"6bc2b43a27d9fa93307bced928a1f461"
                             redirectUri:@"www.nnzhsq.com"];
    
    /**
     连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
     http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入libWeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
     **/
    [ShareSDK connectTencentWeiboWithAppKey:@"801543497"
                                  appSecret:@"be5369e855e8cd050fc1407c554027c2"
                                redirectUri:@"http://www.nnzhsq.com"
                                   wbApiCls:[WeiboApi class]];
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    [ShareSDK connectWeChatWithAppId:@"wx84cb50828a634137" wechatCls:[WXApi class]];
}

@end
