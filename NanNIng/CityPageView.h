//
//  CityPageView.h
//  NanNIng
//
//  Created by Seven on 14-8-9.
//  Copyright (c) 2014年 greenorange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityPageView : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *telBg;

- (IBAction)clickCity:(UIButton *)sender;

- (IBAction)clickDongmeng:(UIButton *)sender;

- (IBAction)clickZhiyuan:(UIButton *)sender;

- (IBAction)clickHelp:(UIButton *)sender;

@end
