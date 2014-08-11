//
//  SubtleView.m
//  BeautyLife
//
//  Created by mac on 14-8-5.
//  Copyright (c) 2014年 Seven. All rights reserved.
//

#import "SubtleView.h"
#import "SubtleCell.h"
#import "SubtleDetailView.h"

@interface SubtleView ()

@end

@implementation SubtleView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.text = @"特价超市";
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

#pragma mark 进入超市内页
- (void)goDetails
{
    SubtleDetailView *subtleDetailView = [[SubtleDetailView alloc] init];
    subtleDetailView.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:subtleDetailView animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.view.frame.size.height);
    self.view.backgroundColor = [Tool getBackgroundColor];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
