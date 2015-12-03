//
//  ResponderViewController.m
//  VicMa
//
//  Created by Sujith Achuthan on 7/6/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import "ResponderViewController.h"
#import "CategoryViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ResponderViewController () <AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *_session;
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureVideoPreviewLayer *_prevLayer;
    
    UIView *_highlightView;
    UIButton *_flashButton;
    UILabel *_label;
}
@end

@interface ResponderViewController ()

@end

@implementation ResponderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.victim = [[Victim alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceRotated:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    _highlightView = [[UIView alloc] init];
    _highlightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _highlightView.layer.borderColor = [UIColor redColor].CGColor;
    _highlightView.layer.borderWidth = 3;
    CGFloat boxWidth = self.view.frame.size.width/2;
    _highlightView.frame = CGRectMake(_highlightView.frame.origin.x, _highlightView.frame.origin.y, boxWidth, 80);
    _highlightView.center = self.view.center;
    [self.view addSubview:_highlightView];
//    [_highlightView sizeToFit];
    
    _label = [[UILabel alloc] init];
    _label.frame = CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40);
    _label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _label.backgroundColor = [UIColor colorWithWhite:0.15 alpha:0.65];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"";
    [self.view addSubview:_label];
    
    _session = [[AVCaptureSession alloc] init];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (_input) {
        [_session addInput:_input];
    }
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_output];
    
    _output.metadataObjectTypes = [_output availableMetadataObjectTypes];
    
    _prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _prevLayer.frame = self.view.bounds;
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:_prevLayer];
    
    _flashButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 50, 30)];
    [_flashButton setImage:[UIImage imageNamed:@"flash.png"] forState:UIControlStateNormal];
    [_flashButton addTarget:self
                 action:@selector(flashButtonClicked:)
       forControlEvents:UIControlEventTouchUpInside];
    if ([_device isTorchAvailable] && [_device isTorchModeSupported:AVCaptureTorchModeOn])
    {
        [self.view addSubview:_flashButton];
    }
    
    [_session startRunning];
    
    [self.view bringSubviewToFront:_label];
    [self.view bringSubviewToFront:_highlightView];
    
    _label.text = @"";
    
    // Do any additional setup after loading the view.
}

- (void)flashButtonClicked:(id)sender
{
    if ([_device isTorchAvailable] && [_device isTorchModeSupported:AVCaptureTorchModeOn])
    {
        BOOL success = [_device lockForConfiguration:nil];
        if (success)
        {
            if ([_device isTorchActive]) {
                [_device setTorchMode:AVCaptureTorchModeOff];
            } else {
                [_device setTorchMode:AVCaptureTorchModeOn];
            }
            [_device unlockForConfiguration];
        }
    }
}

- (IBAction)editVictim:(id)sender
{
    [self removeAnimate];
    
    [self performSegueWithIdentifier:@"category" sender:self];
}

- (IBAction)moveToStaging:(id)sender
{
    [self removeAnimate];
    //Code to change tostaging to one
    
    NSString *post = [NSString stringWithFormat:@"reqtype=moveToStaging&victimID=%@",self.victim.victimID];
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

- (void)closeView:(id)sender
{
    [self removeAnimate];
    
    _label.text = @"";
    
    [self.view addSubview:_highlightView];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.victimFoundView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.victimFoundView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.victimFoundView removeFromSuperview];
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"category"])
    {
        self.succeedingController = segue.destinationViewController;
        [(CategoryViewController*)[self succeedingController] setVictim:self.victim];
    }
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)deviceRotated:(NSNotification *)note{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    CGFloat rotationAngle = 0;
    if (orientation == UIDeviceOrientationPortraitUpsideDown) rotationAngle = M_PI;
    else if (orientation == UIDeviceOrientationLandscapeLeft) rotationAngle = M_PI_2;
    else if (orientation == UIDeviceOrientationLandscapeRight) rotationAngle = -M_PI_2;
    [UIView animateWithDuration:0.5 animations:^{
        _highlightView.transform = CGAffineTransformMakeRotation(M_PI);;
    } completion:nil];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if(_label.text.length == 0)
    {
        CGRect highlightViewRect = CGRectZero;
        AVMetadataMachineReadableCodeObject *barCodeObject;
        NSString *detectionString = nil;
        NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                                  AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                                  AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
        
        for (AVMetadataObject *metadata in metadataObjects) {
            for (NSString *type in barCodeTypes) {
                if ([metadata.type isEqualToString:type])
                {
                    barCodeObject = (AVMetadataMachineReadableCodeObject *)[_prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                    highlightViewRect = barCodeObject.bounds;
                    detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                    break;
                }
            }
            
            if (detectionString != nil)
            {
                _label.text = detectionString;
                self.victim.victimID = detectionString;
                break;
            }
            else
                _label.text = @"";
        }
        
        if(_label.text.length != 0)
        {
            [self getVictim];
        }
    }
}

- (void)finishedParsingVictim
{
    [self removeProgress];
    
    if (self.victimFound == NO)
    {
        [self performSegueWithIdentifier:@"category" sender:self];
    }
    else
    {
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"VictimFoundView" owner:self options:nil];
        self.victimFoundView = [subviewArray objectAtIndex:0];
        
        self.victimFoundView.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
        self.victimFoundView.center = self.view.center;
        self.victimFoundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
        
        [(UIView *)[[self.victimFoundView subviews] objectAtIndex:0] layer].cornerRadius = 5;
        [(UIView *)[[self.victimFoundView subviews] objectAtIndex:0] layer].shadowOpacity = 0.8;
        [(UIView *)[[self.victimFoundView subviews] objectAtIndex:0] layer].shadowOffset = CGSizeMake(0.0f, 0.0f);
        
        [_highlightView removeFromSuperview];
        
        [self.view addSubview:self.victimFoundView];
        
        if (self.victim.stagingArea == 1)
        {
            self.moveToStagingButton.enabled = NO;
            [self.moveToStagingButton setTitle:@"Victim In Staging" forState:UIControlStateNormal];
        }
        
        self.victimFoundView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.victimFoundView.alpha = 0;
        [UIView animateWithDuration:.25 animations:^{
            self.victimFoundView.alpha = 1;
            self.victimFoundView.transform = CGAffineTransformMakeScale(1, 1);
        }];
        
        [self.view bringSubviewToFront:self.victimFoundView];
    }
}

- (void)getVictim
{
    NSString *post = [NSString stringWithFormat:@"reqtype=getVictim&victimID=%@",self.victim.victimID];
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

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    NSArray *componentsArray = [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] componentsSeparatedByString:@":"];
    if ([componentsArray[0] isEqualToString:@"movedToStaging"])
    {
        if ([componentsArray[1] isEqualToString:@"true"])
        {
            [self removeProgress];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Victim Shifted"
                                                            message:@"The victim has been moved to staging area!!!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Error in shifting the victim to staging area. Try Again"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
    
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
        
        [xmlParser setDelegate:self];
        
        BOOL result = [xmlParser parse];
        
        if (result == NO)
        {
            self.victimFound = NO;
            [self finishedParsingVictim];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if ( [elementName isEqualToString:@"Victim"])
    {
      self.victimFound = YES;
    }
    else if ([elementName isEqualToString:@"InjuryTypes"])
    {
        self.victim.injuryDetails = [[NSDictionary alloc] init];
        self.bodyPart = @"";
        self.injuries = [[NSMutableArray alloc] init];
        self.bodyInjuryDictionary = [[NSMutableDictionary alloc] init];
    }
    
    
}
      
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"Victim_ID"])
    {
        self.victim.victimID = self.xmlValue;
    }
    else if ([elementName isEqualToString:@"Status"])
    {
        self.victim.category = [self.xmlValue integerValue];
    }
    else if ([elementName isEqualToString:@"notes"])
    {
        self.victim.notes = self.xmlValue;
    }
    else if ([elementName isEqualToString:@"BodyInjury"])
    {
        NSDictionary *tempDictionary = [NSDictionary dictionaryWithObjectsAndKeys:self.injuries,self.bodyPart, nil];
        
        [self.bodyInjuryDictionary addEntriesFromDictionary:tempDictionary];
        self.bodyPart = @"";
        self.injuries = [[NSMutableArray alloc] init];
    }
    else if ([elementName isEqualToString:@"BodyPart"])
    {
        self.bodyPart = self.xmlValue;
    }
    else if ([elementName isEqualToString:@"Injury"])
    {
        [self.injuries addObject:self.xmlValue];
    }
    else if ([elementName isEqualToString:@"Victim"])
    {
        [self finishedParsingVictim];
    }
    else if ([elementName isEqualToString:@"Incident_ID"])
    {
        self.victim.incidentID = [self.xmlValue integerValue];
    }
    else if ([elementName isEqualToString:@"Staging_Area"])
    {
        self.victim.stagingArea = [self.xmlValue integerValue];
    }
    else if ([elementName isEqualToString:@"enroute"])
    {
        self.victim.enRoute = [self.xmlValue integerValue];
    }
    else if ([elementName isEqualToString:@"InjuryTypes"])
    {
        self.victim.injuryDetails = self.bodyInjuryDictionary;
    }
  
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    self.xmlValue = string;
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.victimFound == NO)
    {
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint touchPoint = [touch locationInView:touch.view];
        [self focus:touchPoint];
        
        if (self.camFocus)
        {
            [self.camFocus removeFromSuperview];
        }
        
        self.camFocus = [[CamFocus alloc]initWithFrame:CGRectMake(touchPoint.x-40, touchPoint.y-40, 80, 80)];
        [self.camFocus setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:self.camFocus];
        [self.camFocus setNeedsDisplay];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.5];
        [self.camFocus setAlpha:0.0];
        [UIView commitAnimations];
    }
}

- (void) focus:(CGPoint) aPoint;
{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [captureDeviceClass defaultDeviceWithMediaType:AVMediaTypeVideo];
        if([device isFocusPointOfInterestSupported] &&
           [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            double screenWidth = screenRect.size.width;
            double screenHeight = screenRect.size.height;
            double focus_x = aPoint.x/screenWidth;
            double focus_y = aPoint.y/screenHeight;
            if([device lockForConfiguration:nil]) {
                [device setFocusPointOfInterest:CGPointMake(focus_x,focus_y)];
                [device setFocusMode:AVCaptureFocusModeAutoFocus];
                if ([device isExposureModeSupported:AVCaptureExposureModeAutoExpose]){
                    [device setExposureMode:AVCaptureExposureModeAutoExpose];
                }
                [device unlockForConfiguration];
            }
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
