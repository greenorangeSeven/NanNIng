//
//  CommunityView.m
//  NanNIng
//  社区商务(跳蚤市场)
//  Created by mac on 14-8-11.
//  Copyright (c) 2014年 greenorange. All rights reserved.
//

#import "CommunityView.h"
#import "CommunityCell.h"

@interface CommunityView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CommunityView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.text = @"小区商务";
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [Tool getColorForGreen];
        titleLabel.textAlignment = UITextAlignmentCenter;
        self.navigationItem.titleView = titleLabel;
        
        UIButton *lBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        [lBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [lBtn setImage:[UIImage imageNamed:@"head_back"] forState:UIControlStateNormal];
        UIBarButtonItem *btnMy = [[UIBarButtonItem alloc]initWithCustomView:lBtn];
        self.navigationItem.leftBarButtonItem = btnMy;
        
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
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [Tool getBackgroundColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CommunityCell *cell = [_tableView dequeueReusableCellWithIdentifier:[CommunityCell ID]];
    
    if(cell == nil)
    {
        cell = [CommunityCell initWith];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CommunityCell *convView = [[ConvOrderView alloc] init];
//    convView.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:CommunityCell animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 124;
}

@end
