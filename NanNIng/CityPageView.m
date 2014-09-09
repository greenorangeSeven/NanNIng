//
//  CityPageView.m
//  NanNIng
//
//  Created by Seven on 14-8-9.
//  Copyright (c) 2014年 greenorange. All rights reserved.
//

#import "CityPageView.h"
#import "CityView.h"

@interface CityPageView ()

@end

@implementation CityPageView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.text = @"智慧南宁";
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
    
}

- (void)settingAction
{
    [Tool pushToSettingView:self.navigationController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.view.frame.size.height);
    [Tool roundView:self.telBg andCornerRadius:3.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickCity:(UIButton *)sender
{
    CityView *cityView = [[CityView alloc] init];
    cityView.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:cityView animated:YES];
}

- (IBAction)clickDongmeng:(UIButton *)sender
{
    
}

- (IBAction)clickZhiyuan:(UIButton *)sender
{
    
}
- (IBAction)clickHelp:(UIButton *)sender
{
    
}
@end
