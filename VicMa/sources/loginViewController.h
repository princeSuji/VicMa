//
//  loginViewController.h
//  VicMa
//
//  Created by Sujith Achuthan on 7/28/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController <NSURLSessionDelegate>

@property(assign) NSInteger authorizationLevel;
@property(assign) NSInteger userID;

@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIView *contentsView;

@property (strong) UIView *waitingView;
@property (assign) NSInteger currentTextField;

- (IBAction)login:(id)sender;
- (IBAction)clear:(id)sender;

@end
