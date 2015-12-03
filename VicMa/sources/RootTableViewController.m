//
//  RootTableViewController.m
//  VicMa
//
//  Created by Sujith Achuthan on 7/6/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import "RootTableViewController.h"
#import "ResponderViewController.h"
#import "RootViewController.h"
#import "IncidentView.h"
#import "IncidentCommanderBaseViewController.h"

@interface RootTableViewController ()

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    UINavigationController *rootViewController = self.navigationController;
    
    self.authorizationLevel = [(RootViewController*)rootViewController authorizationLevel];
    self.userID = [(RootViewController*)rootViewController userID];
    
    [self getIncidents];
    
    self.buttonsArray = @[@"Respoder",@"Incident Commander"];
    
    self.navigationItem.hidesBackButton = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.authorizationLevel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString   stringWithFormat:@"Cell %li",(long)indexPath.section]];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"Cell %li",(long)indexPath.section]];
        
    }
    
//    cell.textLabel.text = [self.buttonsArray objectAtIndex: indexPath.row];
    
    //    search_items *pro = [searchCount objectAtIndex:[indexPath row]];
    //
    //    cell.textLabel.text = pro.s_showroomName;
    
    
    
    UIButton* aButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [aButton setTag:[indexPath row]];
    
    [aButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    aButton.frame = CGRectMake(0, 0,tableView.frame.size.width,cell.frame.size.height);
    [aButton sizeThatFits:cell.frame.size];
    [aButton setTitle:[self.buttonsArray objectAtIndex: indexPath.row] forState:UIControlStateNormal];
    [aButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
    
    [cell.contentView addSubview:aButton];
    
    return cell;
}

-(void)buttonClicked:(UIButton*)sender {
    NSInteger tag = sender.tag;
    
    if (tag == 0)
    {
    
        [self performSegueWithIdentifier:@"responderScreen" sender:self];
        
        self.succeedingController = (ResponderViewController *)[self.storyboard instantiateViewControllerWithIdentifier: @"responderScreen"];
    }
    else if(tag == 1)
    {
        [self performSegueWithIdentifier:@"incidentCommander" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"responderScreen"])
    {
        ResponderViewController *responderViewController = segue.destinationViewController;
        responderViewController.victim = [[Victim alloc] init];
        
        responderViewController.victim.incidentID = self.incidentID;
    }
    else if ([[segue identifier] isEqualToString:@"incidentCommander"])
    {
        IncidentCommanderBaseViewController *incidentCommander = segue.destinationViewController;
        incidentCommander.incidentID = (NSInteger)self.incidentID;
        incidentCommander.userID = self.userID;
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)getIncidents
{
    self.incidentDictionary = [[NSMutableDictionary alloc] init];
    
    NSString *post = [NSString stringWithFormat:@"reqtype=getIncidents"];
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

- (void)showIncidentSelector
{
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"incidentViewController" owner:self options:nil];
    
    self.incidentView = [subviewArray objectAtIndex:0];
    
    self.incidentView.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    self.incidentView.center = self.view.center;
    self.incidentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
    
    [(UIView *)self.popupView layer].cornerRadius = 5;
    [(UIView *)self.popupView layer].shadowOpacity = 0.8;
    self.popupView.center = self.incidentView.center;
    [(UIView *)self.popupView layer].shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    CGFloat yPoint = 40;
    int i=1;
    
    for (NSString *currentIncident in [self.incidentDictionary allKeys])
    {
//        NSArray *incidentViewArray = [[NSBundle mainBundle] loadNibNamed:@"IncidentView" owner:self options:nil];
//        IncidentView *incident = [incidentViewArray objectAtIndex:0];
        UIButton *incidentButton = [[UIButton alloc] init];
        
        UIView *newIncident = [[UIView alloc] initWithFrame:CGRectMake(10, yPoint, self.popupView.frame.size.width-20, 40)];
        [incidentButton setTitle:[self.incidentDictionary valueForKey:currentIncident] forState:UIControlStateNormal];
        
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,
                                       [[UIColor blueColor] CGColor]);
        //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [incidentButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [incidentButton setBackgroundImage:img forState:UIControlStateSelected];
        [incidentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [incidentButton sizeToFit];
        incidentButton.layer.cornerRadius = 5;
        incidentButton.clipsToBounds = YES;
        
        incidentButton.frame = CGRectMake(incidentButton.frame.origin.x, incidentButton.frame.origin.y, incidentButton.frame.size.width+12, incidentButton.frame.size.height);
        incidentButton.center = CGPointMake(newIncident.center.x, incidentButton.center.y);

        [newIncident addSubview:incidentButton];
        
//        incident.incidentLabel.frame = CGRectMake(40, 4, self.popupView.frame.size.width-40, 32);
//        [newIncident addSubview:incident.incidentLabel];
        
//        incident.incidentLabel.text = [self.incidentDictionary valueForKey:currentIncident];
        
        [incidentButton addTarget:self action:@selector(incidentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [incidentButton setTag:[currentIncident intValue]];
        
        i++;
        
        [self.popupView addSubview:newIncident];
        
        yPoint = yPoint + 40;
    }
    
    self.popupView.frame = CGRectMake(self.popupView.frame.origin.x, self.popupView.frame.origin.y, self.popupView.frame.size.width, yPoint+48);
    
    self.popupView.center = self.view.center;
    [self.doneButton setEnabled:NO];
    
    if (self.authorizationLevel != 2)
    {
        self.createNewIncidentButton.hidden = YES;
    }
    
    [self.view addSubview:self.incidentView];
    
    self.incidentView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.incidentView.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.incidentView.alpha = 1;
        self.incidentView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSString *returnString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    if ([returnString isEqualToString:@"empty"] == NO)
    {
        NSArray *components = [returnString componentsSeparatedByString:@":"];
        
        if ([components[0] isEqualToString:@"incidents"] == YES)
        {
            NSString *incidents = components[1];
            NSArray *incidentArray = [incidents componentsSeparatedByString:@","];
            
            for(NSString *currentIncident in incidentArray)
            {
                if (currentIncident.length > 0)
                {
                    NSArray *incidentDetails = [currentIncident componentsSeparatedByString:@"."];
                    NSDictionary *currentIncidentDictionary = [NSDictionary dictionaryWithObjectsAndKeys:incidentDetails[1], incidentDetails[0], nil];
                    
                    [self.incidentDictionary addEntriesFromDictionary:currentIncidentDictionary];
                }
            }
        
            [self showIncidentSelector];
        }
        else if ([components[0] isEqualToString:@"incidentCreated"] == YES)
        {
            self.incidentID = [components[1] integerValue];
            self.incidentLabel.text = [NSString stringWithFormat:@"Incident Location:%@",self.locationName];
        }
    }
    else
    {
        UIAlertView *alert;
        
        if (self.authorizationLevel == 2)
        {
            alert = [[UIAlertView alloc] initWithTitle:@"No Incident Found"
                                               message:@"There are no active incidents. \nDo you want to create one?"
                                              delegate:self
                                     cancelButtonTitle:@"Yes"
                                     otherButtonTitles:@"No",nil];
        }
        else
        {
            alert = [[UIAlertView alloc] initWithTitle:@"No Incident Found"
                                               message:@"There are no active incidents."
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
        }
        
        [alert show];
    }
    
    [self removeProgress];

}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Incident Found"
                                                    message:@"There are no active incidents."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    [self removeProgress];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0 && [[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"])
    {
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        [self showCreateIncident];
    }
    else
    {
        [self performSegueWithIdentifier:@"logout" sender:self];
    }
}

- (void)showCreateIncident
{
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"createIncident" owner:self options:nil];
    self.createIncidentView = [subviewArray objectAtIndex:0];
    
    self.createIncidentView.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    self.createIncidentView.center = self.view.center;
    self.createIncidentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
    
    [self.incidentContentsView layer].cornerRadius = 5;
    [self.incidentContentsView layer].shadowOpacity = 0.8;
    [self.incidentContentsView layer].shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    [self.view addSubview:self.createIncidentView];
    
    self.locationTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.locationTextView.layer.borderWidth = 1.0f;
    self.locationTextView.delegate = self;
    self.createIncidentButton.enabled = NO;
    
    self.createIncidentView.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.createIncidentView.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.createIncidentView.alpha = 1;
        self.createIncidentView.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
    [self.view bringSubviewToFront:self.incidentView];
}

- (void)removeAnimate
{
    if ([[self.view subviews] containsObject:self.createIncidentView])
    {
        [UIView animateWithDuration:.25 animations:^{
            self.createIncidentView.transform = CGAffineTransformMakeScale(1.3, 1.3);
            self.createIncidentView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self.createIncidentView removeFromSuperview];
            }
        }];
    }
    else if ([[self.view subviews] containsObject:self.incidentView])
    {
        [UIView animateWithDuration:.25 animations:^{
            self.incidentView.transform = CGAffineTransformMakeScale(1.3, 1.3);
            self.incidentView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self.incidentView removeFromSuperview];
            }
        }];
    }
}

- (IBAction)incidentButtonClicked:(id)sender
{
    for (id currentItem in [self.popupView subviews])
    {
        if([currentItem isKindOfClass:[UIView class]])
        {
            for (id currentSubItem in [currentItem subviews])
            {
                if([currentSubItem isKindOfClass:[UIButton class]])
                {
                    if ([currentSubItem isSelected] == YES && currentItem != sender)
                    {
                        [currentSubItem setSelected:NO];
                    }
                }
            }
        }
    }
    
    [self.doneButton setEnabled:YES];
    
    self.incidentID = [sender tag];
    self.locationName = [self.incidentDictionary valueForKey:[NSString stringWithFormat:@"%ld",[sender tag]]];
    
    [sender setSelected:YES];
    
}

- (IBAction)createNewIncident:(id)sender
{
    [self removeAnimate];
    
    [self showCreateIncident];
}

- (IBAction)done:(id)sender
{
    [self removeAnimate];
    self.incidentLabel.text = [NSString stringWithFormat:@"Incident Location:%@",self.locationName];
}


- (IBAction)logout:(id)sender
{
    [self performSegueWithIdentifier:@"logout" sender:self];
}

- (IBAction)createIncident:(id)sender
{
    [self.locationTextView resignFirstResponder];
    self.locationName = self.locationTextView.text;
    
    NSString *post = [NSString stringWithFormat:@"reqtype=createIncident&location=%@&creatorID=%ld",self.locationName,self.userID];
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
    
    [self performSelector:@selector(removeAnimate) withObject:nil afterDelay:0.2];
}

- (void)startProgress
{
    self.waitingView = [[UIView alloc] initWithFrame:self.view.frame];
    UIActivityIndicatorView *progressBar = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.center.x-25, self.view.center.y-2, 50, 4)];
    
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

- (void)removeProgress
{
    [self.waitingView removeFromSuperview];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == self.locationTextView && textView.text.length > 0)
    {
        self.createIncidentButton.enabled = YES;
    }
    
    return YES;
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
    CGRect contentsViewFrame = [self.view convertRect:self.incidentContentsView.frame toView:nil];
    
    CGFloat incidentLocation = contentsViewFrame.origin.y + contentsViewFrame.size.height;
    
    newFrame.origin.y = 0;
    
    CGFloat keyboardHeight = MIN(keyboardFrameBegin.size.height,keyboardFrameBegin.size.width);
    
    NSLog(@"Incident:%f\nKeyboardHeight:%f\nFrame Height:%f", incidentLocation, keyboardHeight, newFrame.size.height);
    
    if (incidentLocation > (newFrame.size.height - keyboardHeight))
    {
        CGFloat difference = newFrame.size.height - keyboardHeight - incidentLocation;
        
        newFrame.origin.y += difference;
    }

    self.view.frame = newFrame;
    
    [UIView commitAnimations];
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
