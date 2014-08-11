//
//  NoticeFrameView.m
//  BeautyLife
//
//  Created by Seven on 14-8-5.
//  Copyright (c) 2014年 Seven. All rights reserved.
//

#import "NoticeFrameView.h"

@interface NoticeFrameView ()

@end

@implementation NoticeFrameView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.text = @"物业通知公告";
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [Tool getColorForGreen];
        titleLabel.textAlignment = UITextAlignmentCenter;
        self.navigationItem.titleView = titleLabel;
        
        UIButton *lBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        [lBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [lBtn setImage:[UIImage imageNamed:@"head_back"] forState:UIControlStateNormal];
        UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]initWithCustomView:lBtn];
        self.navigationItem.leftBarButtonItem = btnBack;
    }
    return self;
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //适配iOS7uinavigationbar遮挡tableView的问题
    if(IS_IOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = [Tool getBackgroundColor];
    //下属控件初始化
    self.ticeView = [[NewsTableView alloc] init];
    self.activityView = [[NewsTableView alloc] init];
    self.activityView.view.hidden = YES;
    [self addChildViewController:self.ticeView];
    [self addChildViewController:self.activityView];
    [self.mainView addSubview:self.ticeView.view];
    [self.mainView addSubview:self.activityView.view];
}

- (IBAction)noticeAction:(id)sender {
    [self.noticeBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:127.0/255.0 blue:0.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.activityBtn setTitleColor:[UIColor scrollViewTexturedBackgroundColor] forState:UIControlStateNormal];
    self.ticeView.view.hidden = NO;
    self.activityView.view.hidden = YES;
}

- (IBAction)activityAction:(id)sender {
    [self.noticeBtn setTitleColor:[UIColor scrollViewTexturedBackgroundColor] forState:UIControlStateNormal];
    [self.activityBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:127.0/255.0 blue:0.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    self.ticeView.view.hidden = YES;
    self.activityView.view.hidden = NO;
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
}

@end
