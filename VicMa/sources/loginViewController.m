//
//  loginViewController.m
//  VicMa
//
//  Created by Sujith Achuthan on 7/28/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import "loginViewController.h"
#import "RootViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginButton.enabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self.usernameText setReturnKeyType:UIReturnKeyDone];
    [self.passwordText setReturnKeyType:UIReturnKeyDone];
    // Do any additional setup after loading the view.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currentTextField = [textField tag];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)login:(id)sender
{
    if (self.currentTextField == 0)
    {
        [self.usernameText resignFirstResponder];
    }
    else
    {
        [self.passwordText resignFirstResponder];
    }
    
    NSString *username = self.usernameText.text;
    NSString *password = self.passwordText.text;
    
    NSString *post = [NSString stringWithFormat:@"reqtype=login&username=%@&password=%@",username,password];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://54.149.57.116:8080/VicMa/DBServlet"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(conn) {
        [self startProgress];
    }
}

// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    if ([returnString isEqualToString:@"error"] == YES)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error"
                                                        message:@"Invalid Username/Password"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        NSArray *components = [returnString componentsSeparatedByString:@":"];
        self.authorizationLevel = [components[0] integerValue];
        self.userID = [components[1] integerValue];
        [self performSegueWithIdentifier:@"rootTable" sender:self];
    }
    
    [self removeProgress];
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error"
                                                    message:@"Invalid Username/Password"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    [self removeProgress];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"rootTable"])
    {
        [(RootViewController*)segue.destinationViewController setAuthorizationLevel: self.authorizationLevel];
        [(RootViewController*)segue.destinationViewController setUserID: self.userID];
    }
}

- (IBAction)clear:(id)sender
{
    self.usernameText.text = @"";
    self.passwordText.text = @"";
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.usernameText.text.length != 0 && self.passwordText.text.length != 0)
    {
        self.loginButton.enabled = YES;
    }
    else
    {
        self.loginButton.enabled = NO;
    }
    
    return YES;
}

- (void)startProgress
{
    self.waitingView = [[UIView alloc] initWithFrame:self.view.frame];
    UIActivityIndicatorView *progressBar = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.center.x-25, self.view.center.y-2, 50, 50)];
    
    [progressBar setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    
    [self.waitingView addSubview:progressBar];
    progressBar.center = self.waitingView.center;
    
    [self.view addSubview:self.waitingView];
    [progressBar startAnimating];
    
    self.waitingView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.waitingView.backgroundColor = [UIColor grayColor];
    self.waitingView.alpha = 0;
    [UIView animateWithDuration:.15 animations:^{
        self.waitingView.alpha = .5;
        self.waitingView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    CGRect keyboardBeginFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    UIViewAnimationCurve animationCurve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect newFrame = self.view.frame;
    CGRect keyboardFrameBegin = [self.view convertRect:keyboardBeginFrame toView:nil];
    
    CGFloat loginViewLocation = self.contentsView.frame.origin.y + self.contentsView.frame.size.height;
    
    newFrame.origin.y = 0;
    CGFloat keyboardHeight = MIN(keyboardFrameBegin.size.height,keyboardFrameBegin.size.width);
    
    if (loginViewLocation > (newFrame.size.height - keyboardHeight))
    {
        CGFloat difference = loginViewLocation - keyboardHeight;
        
        newFrame.origin.y -= difference;
    }
    
    self.view.frame = newFrame;
    
    [UIView commitAnimations];
}

- (void)removeProgress
{
    [self.waitingView removeFromSuperview];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

@end
