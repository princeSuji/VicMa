//
//  CategoryViewController.m
//  VicMa
//
//  Created by Sujith Achuthan on 7/6/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import "CategoryViewController.h"
#import "BodyPartViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myView.frame = CGRectMake(self.myScrollView.frame.origin.x, self.myScrollView.frame.origin.y, self.myView.frame.size.width, self.myView.frame.size.height+80);
    self.myScrollView.contentSize = self.myView.bounds.size;
    
    if (self.victim.category != 0)
    {
        [[(UIButton *)[self.view viewWithTag:self.victim.category] titleLabel] setFont:[UIFont boldSystemFontOfSize:36]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    if (self.victim.notes == NULL || [self.victim.notes isEqualToString:@"null"])
    {
        self.victim.notes = @"";
    }
    self.notesView.text = self.victim.notes;
   
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlack;
    numberToolbar.translucent = YES;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.notesView.inputAccessoryView = numberToolbar;
    self.notesView.layer.borderWidth = 3.0f;
    self.notesView.layer.borderColor = [[UIColor blackColor] CGColor];
    // Do any additional setup after loading the view.
}

- (void)cancelNumberPad
{
    [self.notesView resignFirstResponder];
    self.notesView.text = self.victim.notes;
}
- (void)doneWithNumberPad
{
    self.victim.notes = self.notesView.text;
    [self.notesView resignFirstResponder];
}


- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    CGRect keyboardEndFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardBeginFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    UIViewAnimationCurve animationCurve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect newFrame = self.view.frame;
    CGRect keyboardFrameEnd = [self.view convertRect:keyboardEndFrame toView:nil];
    CGRect keyboardFrameBegin = [self.view convertRect:keyboardBeginFrame toView:nil];
    
    newFrame.origin.y -= (keyboardFrameBegin.origin.y - keyboardFrameEnd.origin.y);
    self.view.frame = newFrame;
    
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)categorySelected:(id)sender
{
    self.victim.category = [sender tag];
    self.victim.notes = self.notesView.text;
    
    [self performSegueWithIdentifier:@"bodyPart" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[segue destinationViewController] setVictim:self.victim];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
