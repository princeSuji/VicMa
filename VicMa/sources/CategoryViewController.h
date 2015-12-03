//
//  CategoryViewController.h
//  VicMa
//
//  Created by Sujith Achuthan on 7/6/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Victim.h"

@interface CategoryViewController : UIViewController<UITextViewDelegate>

@property(strong) Victim *victim;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UITextView *notesView;

- (IBAction)categorySelected:(id)sender;

@end
