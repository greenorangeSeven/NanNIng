//
//  StewardFeeView.m
//  BeautyLife
//
//  Created by Seven on 14-8-1.
//  Copyright (c) 2014年 Seven. All rights reserved.
//

#import "StewardFeeView.h"

@interface StewardFeeView ()

@end

@implementation StewardFeeView

@synthesize scrollView;
@synthesize bgView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Tool roundView:self.bgView andCornerRadius:3.0];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
