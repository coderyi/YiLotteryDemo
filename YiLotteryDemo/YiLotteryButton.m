//
//  YiLotteryButton.m
//  YiLotteryDemo
//
//  Created by apple on 15/2/12.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//

#import "YiLotteryButton.h"

@implementation YiLotteryButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        50*43  - 110*43
        //        70  40  30*15
        float height=frame.size.height;
        float width=frame.size.width;
        //        self.layer.masksToBounds=YES;
        //        self.layer.cornerRadius=height/2;
        float labelWidth=70;
        self.backgroundColor=[UIColor colorWithRed:0.99 green:0.54 blue:0.16 alpha:1];
        float imageWidth=20;
        // float width=frame.size.width;
        _label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, height)];
        
        [self addSubview:_label];
        _titleImageView=[[UIImageView alloc] initWithFrame:CGRectMake(labelWidth+5, (height-15)/2, 30,15)];
        [self addSubview:_titleImageView];
        _titleImageView.image=[UIImage imageNamed:@"l4"];
        
        _label.font=[UIFont boldSystemFontOfSize:15];
        _label.textColor=[UIColor whiteColor];
        
        _label.textAlignment=NSTextAlignmentRight;
        _label.text=@"开始抽奖";
        
    }
    return self;
}
@end
