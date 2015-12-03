//
//  AdditionalInfoViewController.h
//  VicMa
//
//  Created by Sujith Achuthan on 7/9/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdditionalInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *plusTwoButton;
@property (weak, nonatomic) IBOutlet UIButton *minusTwoButton;
@property (weak, nonatomic) IBOutlet UIButton *respirationYes;
@property (weak, nonatomic) IBOutlet UIButton *respirationNo;
@property (weak, nonatomic) IBOutlet UIButton *mentalStatusCan;
@property (weak, nonatomic) IBOutlet UIButton *mentalStatusCant;

- (IBAction)perfusionButtonClicked:(id)sender;
- (IBAction)respirationSelected:(id)sender;
- (IBAction)mentalStatusSelected:(id)sender;

@end
