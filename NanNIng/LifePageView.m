//
//  LifePageView.m
//  BeautyLife
//
//  Created by Seven on 14-7-30.
//  Copyright (c) 2014年 Seven. All rights reserved.
//

#import "LifePageView.h"
#import "ConvView.h"
#import "RechargeView.h"
#import "SubtleView.h"
#import "BusinessView.h"
#import "CommunityView.h"
#import "ProjectCollectionView.h"

@interface LifePageView ()

@end

@implementation LifePageView

@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.text = @"智慧生活";
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [Tool getColorForGreen];
        titleLabel.textAlignment = UITextAlignmentCenter;
        self.navigationItem.titleView = titleLabel;
        
        UIButton *lBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 31, 28)];
        [lBtn addTarget:self action:@selector(myAction) forControlEvents:UIControlEventTouchUpInside];
        [lBtn setImage:[UIImage imageNamed:@"navi_my"] forState:UIControlStateNormal];
        UIBarButtonItem *btnMy = [[UIBarButtonItem alloc]initWithCustomView:lBtn];
        self.navigationItem.leftBarButtonItem = btnMy;
        
        UIButton *rBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 31, 28)];
        [rBtn addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
        [rBtn setImage:[UIImage imageNamed:@"navi_setting"] forState:UIControlStateNormal];
        UIBarButtonItem *btnSetting = [[UIBarButtonItem alloc]initWithCustomView:rBtn];
        self.navigationItem.rightBarButtonItem = btnSetting;
    }
    return self;
    
}

- (void)myAction
{
    [Tool pushToMyView:self.navigationController];
}

- (void)settingAction
{
    [Tool pushToSettingView:self.navigationController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [Tool getBackgroundColor];
    scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.view.frame.size.height);
    [Tool roundView:self.telBg andCornerRadius:3.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (IBAction)clickService:(UIButton *)sender
{
    ConvView *convView = [[ConvView alloc] init];
    convView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:convView animated:YES];
}

- (IBAction)clickRecharge:(UIButton *)sender
{
    RechargeView *rechargeView = [[RechargeView alloc] init];
    rechargeView.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:rechargeView animated:YES];
}

- (IBAction)clickSubtle:(UIButton *)sender
{
    SubtleView *subtleView = [[SubtleView alloc] init];
    subtleView.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:subtleView animated:YES];
}

- (IBAction)clickBusiness:(UIButton *)sender
{
    BusinessView *businessView = [[BusinessView alloc] init];
    businessView.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:businessView animated:YES];
}

- (IBAction)clickCommunity:(UIButton *)sender
{
    CommunityView *communityView = [[CommunityView alloc] init];
    communityView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:communityView animated:YES];
}

- (IBAction)clickBBS:(id)sender {
    ProjectCollectionView *projectView = [[ProjectCollectionView alloc] init];
    projectView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:projectView animated:YES];
}

- (IBAction)telAction:(id)sender{
    NSURL *phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", servicephone]];
    if (!phoneCallWebView) {
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneUrl]];
}

@end
