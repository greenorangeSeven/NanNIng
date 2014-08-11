//
//  CommunityView.h
//  NanNIng
//  社区商务(跳蚤市场)
//  Created by mac on 14-8-11.
//  Copyright (c) 2014年 greenorange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityView : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *item1Btn;
@property (weak, nonatomic) IBOutlet UIButton *item2Btn;
@property (weak, nonatomic) IBOutlet UIButton *item3Btn;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)item1Action:(id)sender;
- (IBAction)item2Action:(id)sender;
- (IBAction)item3Action:(id)sender;

@end
