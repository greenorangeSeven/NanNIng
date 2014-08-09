//
//  RepairsFormView.m
//  BeautyLife
//
//  Created by Seven on 14-8-2.
//  Copyright (c) 2014年 Seven. All rights reserved.
//

#import "RepairsFormView.h"

@interface RepairsFormView ()

@end

@implementation RepairsFormView

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
    [super viewDidLoad];
    [Tool roundView:self.bgView andCornerRadius:3.0];
    [Tool roundTextView:self.descTv andBorderWidth:1 andCornerRadius:4.0];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
