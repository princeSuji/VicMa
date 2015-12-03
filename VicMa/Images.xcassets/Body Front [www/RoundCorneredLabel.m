//
//  RoundCorneredLabel.m
//  VicMa
//
//  Created by Sujith Achuthan on 8/5/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import "RoundCorneredLabel.h"

@implementation RoundCorneredLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.layer.cornerRadius = 5;
}


@end
