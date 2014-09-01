//
//  ChooseAreaView.h
//  BeautyLife
//
//  Created by Seven on 14-7-31.
//  Copyright (c) 2014年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectHomeAddressView.h"

@interface ChooseAreaView : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *communityLb;
@property (weak, nonatomic) IBOutlet UILabel *regionLb;

- (IBAction)selectHomeAddressForCityAction:(id)sender;

@end
