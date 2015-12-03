//
//  BodyPartViewController.h
//  VicMa
//
//  Created by Sujith Achuthan on 7/8/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Victim.h"

@interface BodyPartViewController : UIViewController

@property (assign) BOOL frontShown;
@property (weak, nonatomic) IBOutlet UIView *imageView;
@property (strong,nonatomic) Victim *victim;
@property(strong)NSMutableArray *checkBoxes;
@property (strong) UIView *injuryView;
@property (strong) NSMutableDictionary *injuries;
@property (strong) NSMutableDictionary *bodyParts;
@property (strong) NSString *bodyPart;
@property (strong) NSMutableDictionary *bodyInjuryDictionary;
@property (strong) UIView *waitingView;

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

- (IBAction)checkboxButton:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)buttonClicked:(id)sender;
- (IBAction)flipButtonClicked:(id)sender;
- (IBAction)submitButtonClicked:(id)sender;

@end
