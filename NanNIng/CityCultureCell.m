//
//  CityCultureCell.m
//  NanNIng
//
//  Created by mac on 14-8-11.
//  Copyright (c) 2014年 greenorange. All rights reserved.
//

#import "CityCultureCell.h"

@implementation CityCultureCell

+ (id)initWith
{
    UINib *nib = [UINib nibWithNibName:@"CityCultureCell" bundle:nil];
    CityCultureCell *cell = [nib instantiateWithOwner:nil options:nil][0];
    
    return cell;
}

+ (NSString *)ID
{
    return @"CityCultureCell";
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
