//
//  ResponderViewController.h
//  VicMa
//
//  Created by Sujith Achuthan on 7/6/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CamFocus.h"
#import "Victim.h"

@interface ResponderViewController : UIViewController <NSXMLParserDelegate>

@property(strong) CamFocus *camFocus;
@property(strong) Victim *victim;
@property(strong) UIViewController *succeedingController;
@property(assign) BOOL victimFound;
@property(strong) UIView *victimFoundView;
@property(strong) NSString *xmlValue;
@property(strong) NSString *bodyPart;
@property(strong) NSMutableArray *injuries;
@property (strong) NSMutableDictionary *bodyInjuryDictionary;
@property (strong) UIView *waitingView;
@property (weak, nonatomic) IBOutlet UIButton *moveToStagingButton;

- (IBAction)flashButtonClicked:(id)sender;
- (IBAction)editVictim:(id)sender;
- (IBAction)moveToStaging:(id)sender;
- (IBAction)closeView:(id)sender;

@end
