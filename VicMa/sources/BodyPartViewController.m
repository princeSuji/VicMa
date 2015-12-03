//
//  BodyPartViewController.m
//  VicMa
//
//  Created by Sujith Achuthan on 7/8/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import "BodyPartViewController.h"
#import "InjuryView.h"

@interface BodyPartViewController ()

@end

@implementation BodyPartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *currentView = self.view;
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(submitButtonClicked:)];
    self.navigationItem.rightBarButtonItems = @[nextButton];
    self.frontShown = YES;
    
    for (int i=1; i<=21; i++)
    {
        [(UIButton *)[currentView viewWithTag:i] setImage:[UIImage imageNamed:[NSString stringWithFormat: @"R%d.jpeg",i]] forState:UIControlStateSelected];
    }
    
    self.imageView.center = self.view.center;
    
    self.checkBoxes = [[NSMutableArray alloc] init];
    self.injuries = [[NSMutableDictionary alloc] init];
    self.bodyParts = [[NSMutableDictionary alloc] init];
    
    if (self.victim.injuryDetails == nil)
    {
        self.victim.injuryDetails = [[NSDictionary alloc] init];
    }
    
    self.bodyInjuryDictionary = [[NSMutableDictionary alloc] initWithDictionary:self.victim.injuryDetails];
    
    [self getbodyParts];
    [self getInjuries];
    
//    self.bodyPartArray = @[@"",@"",@"Head",@"",@"Left Shoulder",@"Chest",@"Right Shoulder",@"Left Forearm", @"Abdomen", @"Right Forearm", @"Left Palm", @"Waist", @"Right Palm", @"Left Thigh", @"", @"Right Thigh", @"Left Leg", @"", @"Right Leg", @"Left Leg", @"", @"Right Leg"];
    
    //code to fetch all injury details
//    self.injuryDetails = @[@"Burn",@"Bullet Entry", @"Cut", @"Scratch", @"Bone Broken", @"Boil", @"Severed"];
    // Do any additional setup after loading the view.
    
    CGFloat height = 44;
    
    for (id currentItem in self.mainScrollView.subviews)
    {
        if ([currentItem isKindOfClass:[UIView class]])
        {
            height += [currentItem frame].size.height;
        }
    }
    
    height += 1000;
    
    self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.contentSize.width, height);
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
    [UIView animateWithDuration:.25 animations:^{
        self.waitingView.alpha = .5;
        self.waitingView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeProgress
{
    [self.waitingView removeFromSuperview];
    [self updateCurrentlySelected];
}

- (void)updateCurrentlySelected
{
    for (NSString *currentBodyPart in [self.victim.injuryDetails allKeys])
    {
        UIButton *bodyPartButton = (UIButton*)[self.view viewWithTag:[currentBodyPart integerValue]];
        
        [bodyPartButton setSelected:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonClicked:(id)sender
{
    if(![(UIButton*)sender isSelected])
    {
        self.bodyPart = [NSString stringWithFormat:@"%ld",[sender tag]];
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"InjuryViewController" owner:self options:nil];
        
        self.injuryView = [subviewArray objectAtIndex:0];
        
        self.injuryView.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
        self.injuryView.center = self.view.center;
        self.injuryView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
        
        [(UIView *)self.popUpView layer].cornerRadius = 5;
        [(UIView *)self.popUpView layer].shadowOpacity = 0.8;
        self.popUpView.center = self.injuryView.center;
        [(UIView *)self.popUpView layer].shadowOffset = CGSizeMake(0.0f, 0.0f);
        
        CGFloat yPoint = 10;
        int i=1;
        
        for (NSString *currentInjury in [self.injuries allKeys])
        {
            NSArray *injuryArray = [[NSBundle mainBundle] loadNibNamed:@"InjuryView" owner:self options:nil];
            InjuryView *injury = [injuryArray objectAtIndex:0];
            
            UIView *newInjury = [[UIView alloc] initWithFrame:CGRectMake(10, yPoint, self.popUpView.frame.size.width-20, 40)];
            injury.injuryButton.frame = CGRectMake(0, 4, 32, 32);
            [newInjury addSubview:injury.injuryButton];
            
            injury.injuryLabel.frame = CGRectMake(40, 4, self.popUpView.frame.size.width-40, 32);
            [newInjury addSubview:injury.injuryLabel];
            
            injury.injuryLabel.text = [self.injuries valueForKey:currentInjury];

            [injury.injuryButton addTarget:self action:@selector(checkboxButton:) forControlEvents:UIControlEventTouchUpInside];
            [injury.injuryButton setTag:[currentInjury intValue]];
            
            i++;
            
            [self.popUpView addSubview:newInjury];
            
            yPoint = yPoint + 40;
        }
        
        self.popUpView.frame = CGRectMake(self.popUpView.frame.origin.x, self.popUpView.frame.origin.y, self.popUpView.frame.size.width, yPoint+48);
        self.doneButton.frame = CGRectMake(self.doneButton.frame.origin.x, yPoint+8, self.doneButton.frame.size.width, self.doneButton.frame.size.height);
        
        [self.view addSubview:self.injuryView];
        
        self.injuryView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.injuryView.alpha = 0;
        [UIView animateWithDuration:.25 animations:^{
            self.injuryView.alpha = 1;
            self.injuryView.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }
    else
    {
        [self.bodyInjuryDictionary removeObjectForKey:[NSString stringWithFormat:@"%ld",[sender tag]]];
        self.victim.injuryDetails = [[NSDictionary alloc] initWithDictionary:self.bodyInjuryDictionary];
    }
    
    [(UIButton*)sender setSelected:![(UIButton*)sender isSelected]];
}

- (IBAction)flipButtonClicked:(id)sender
{
    if (self.frontShown == YES)
    {
        UIView *currentView = self.view;
        self.frontShown = NO;
        
        for (int i=1; i<=21; i++)
        {
            [(UIButton *)[currentView viewWithTag:i] setImage:[UIImage imageNamed:[NSString stringWithFormat: @"B%d.jpeg",i]] forState:UIControlStateNormal];
//            [(UIButton *)[currentView viewWithTag:i] setImage:[UIImage imageNamed:[NSString stringWithFormat: @"BR%d.jpeg",i]] forState:UIControlStateSelected];
        }
    }
    else
    {
        UIView *currentView = self.view;
        self.frontShown = YES;
        
        for (int i=1; i<=21; i++)
        {
            [(UIButton *)[currentView viewWithTag:i] setImage:[UIImage imageNamed:[NSString stringWithFormat: @"%d.jpeg",i]] forState:UIControlStateNormal];
            [(UIButton *)[currentView viewWithTag:i] setImage:[UIImage imageNamed:[NSString stringWithFormat: @"R%d.jpeg",i]] forState:UIControlStateSelected];
        }
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

- (void)submitButtonClicked:(id)sender
{
    //code to insert/update all
    
    NSString *xmlString = [self createXMLString];
    
    NSString *post = [NSString stringWithFormat:@"reqtype=addVictim&xmlString=%@",xmlString];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)checkboxButton:(id)sender
{
    if([sender isSelected] == NO)
    {
        [self.checkBoxes addObject:[NSString stringWithFormat:@"%ld", [sender tag]]];
        [sender setSelected:YES];
    }
    else
    {
        [self.checkBoxes removeObject:[NSString stringWithFormat:@"%ld", [sender tag]]];
        [sender setSelected:NO];
    }
    
}

- (void)done:(id)sender
{
    [self removeAnimate];
    
    NSMutableArray *currentInjuryArray = [[NSMutableArray alloc] init];
    
    if (self.checkBoxes.count>0)
    {
        for (NSString *currentInjury in self.checkBoxes)
        {
            [currentInjuryArray addObject:currentInjury];
        }
        
        NSDictionary *newInury = [[NSDictionary alloc] initWithObjectsAndKeys:currentInjuryArray,self.bodyPart, nil];
        
        [self.bodyInjuryDictionary addEntriesFromDictionary:newInury];
        [self.checkBoxes removeAllObjects];
    }
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.injuryView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.injuryView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.injuryView removeFromSuperview];
        }
    }];
}

-(NSString*)createXMLString
{
    NSMutableString *returnString = [NSMutableString stringWithString:@"<?xml version='1.0' encoding='UTF-8'?>\n<Victim>\n"];
    
    [returnString appendString:[NSString stringWithFormat:@"<Incident>%ld</Incident>\n", self.victim.incidentID]];
    [returnString appendString:[NSString stringWithFormat:@"<Victim_ID>%@</Victim_ID>\n", self.victim.victimID]];
    [returnString appendString:[NSString stringWithFormat:@"<Status>%ld</Status>\n", self.victim.category]];
    [returnString appendString:@"<InjuryTypes>\n"];
    
    for(NSString* currentBodyPart in [self.bodyInjuryDictionary allKeys])
    {
        [returnString appendString:@"<BodyInjury>\n"];
        [returnString appendString:[NSString stringWithFormat:@"<BodyPart>%@</BodyPart>\n", currentBodyPart]];
        
        for(NSString *injury in [self.bodyInjuryDictionary objectForKey:currentBodyPart])
        {
            [returnString appendString:[NSString stringWithFormat:@"<Injury>%@</Injury>\n", injury]];
        }
        
        [returnString appendString:@"</BodyInjury>\n"];
    }
    
    [returnString appendString:@"</InjuryTypes>\n"];
    [returnString appendString:[NSString stringWithFormat:@"<Notes>%@</Notes>\n", self.victim.notes]];
    [returnString appendString:@"</Victim>\n"];
    
    return returnString;
}

- (void)getInjuries
{
    NSString *post = [NSString stringWithFormat:@"reqtype=getInjuries"];
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
//        NSLog(@"Connection Successful");
    }
}

- (void)getbodyParts
{
    NSString *post = [NSString stringWithFormat:@"reqtype=getBodyParts"];
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
//        NSLog(@"Connection Successful");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSArray *identity = [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] componentsSeparatedByString:@":"];
    NSArray *details = [identity[1] componentsSeparatedByString:@","];
    
    if ([identity[0] isEqualToString:@"bodyparts"])
    {
        for (NSString *currentItem in details)
        {
            NSArray *items = [currentItem componentsSeparatedByString:@"."];
            if (items.count >= 2)
            {
                NSDictionary *tempDictionary = [NSDictionary dictionaryWithObjectsAndKeys:items[1],items[0], nil];
            
                [self.bodyParts addEntriesFromDictionary:tempDictionary];
            }
        }
    }
    else if([identity[0] isEqualToString:@"injuries"])
    {
        for (NSString *currentItem in details)
        {
            NSArray *items = [currentItem componentsSeparatedByString:@"."];
            
            if (items.count >= 2)
            {
                NSDictionary *tempDictionary = [NSDictionary dictionaryWithObjectsAndKeys:items[1],items[0], nil];
            
                [self.injuries addEntriesFromDictionary:tempDictionary];
            }

            
        }
    }
    else if([identity[0] isEqualToString:@"updated"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Victim Updated"
                                                        message:@"The victim details were updated!!!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    [self removeProgress];
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
