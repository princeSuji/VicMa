//
//  RootTableViewController.h
//  VicMa
//
//  Created by Sujith Achuthan on 7/6/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootTableViewController : UITableViewController<UITextViewDelegate>

@property(strong) NSArray *buttonsArray;
@property(assign) NSInteger authorizationLevel;
@property(strong) UIViewController *succeedingController;
@property(strong) NSMutableDictionary *incidentDictionary;
@property(strong) NSString *locationName;
@property(assign) NSInteger incidentID;
@property(assign) UIView *createIncidentView;
@property(assign) NSInteger userID;

@property (weak, nonatomic) IBOutlet UIView *popupView;
@property(strong) UIView *incidentView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *incidentLabel;
@property (strong) UIView *waitingView;
@property (weak, nonatomic) IBOutlet UITextView *locationTextView;
@property (weak, nonatomic) IBOutlet UIButton *createIncidentButton;
@property (weak, nonatomic) IBOutlet UIView *incidentContentsView;

@property (weak, nonatomic) IBOutlet UIButton *createNewIncidentButton;
- (IBAction)createNewIncident:(id)sender;

- (IBAction)done:(id)sender;
- (IBAction)logout:(id)sender;
- (IBAction)createIncident:(id)sender;
@end
