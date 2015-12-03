//
//  InjuryView.h
//  VicMa
//
//  Created by Sujith Achuthan on 7/14/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InjuryView : UIView

- (id)initWithInjuries:(NSArray *)injuryArray;

@property (weak, nonatomic) IBOutlet UIButton *injuryButton;
@property (weak, nonatomic) IBOutlet UILabel *injuryLabel;
@end
