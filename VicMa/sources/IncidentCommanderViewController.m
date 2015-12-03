//
//  IncidentCommanderViewController.m
//  VicMa
//
//  Created by Sujith Achuthan on 8/4/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import "IncidentCommanderViewController.h"
#import "InjuryView.h"

@interface IncidentCommanderViewController ()

@end

@implementation IncidentCommanderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[UIDevice currentDevice] setValue:
//     [NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight]
//                                forKey:@"orientation"];
    
    [self startProgress];
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChangeNotification:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [UIView animateWithDuration:0.3 animations:^{
           self.mainScrollView.contentSize = CGSizeMake(1000, 1000);
    }];
    
    NSTimer* timer = [NSTimer timerWithTimeInterval:500.0f target:self selector:@selector(loadData) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)loadData
{
    self.victimCategoryData = [[NSMutableDictionary alloc] init];
    
    self.itemsLoaded = 0;
    self.filters = [[NSMutableArray alloc] init];
    self.selectedVictims = [[NSMutableArray alloc] init];
    
    [self getVictimCategoryData];
    [self getVehicleCountData];
    [self getIncidentBodyParts];
    [self getIncidentInjuries];
    [self getIncidentVictims];
}

//Data to get victim information

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)deviceOrientationDidChangeNotification:(NSNotification*)note
{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         CGRect superViewFrame = self.view.superview.frame;
                         self.view.frame = CGRectMake(superViewFrame.origin.x+12, superViewFrame.origin.y+64, superViewFrame.size.width, superViewFrame.size.height);
                         self.mainScrollView.frame = CGRectMake(0, 0, superViewFrame.size.width, superViewFrame.size.height);
                         self.mainScrollView.contentSize = CGSizeMake(1000, 1000);
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)getVictimCategoryData
{
    NSString *post = [NSString stringWithFormat:@"reqtype=getVictimCategories&incidentID=%ld",(long)self.incidentID];
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

- (void)getVehicleCountData
{
    NSString *post = [NSString stringWithFormat:@"reqtype=getVehicleCount&incidentID=%ld",(long)self.incidentID];
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

-(void)getIncidentBodyParts
{
    NSString *post = [NSString stringWithFormat:@"reqtype=getIncidentBodyParts&incidentID=%ld",(long)self.incidentID];
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

-(void)getIncidentVictims
{
    NSString *post = [NSString stringWithFormat:@"reqtype=getIncidentVictims&incidentID=%ld",(long)self.incidentID];
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

-(void)getIncidentInjuries
{
    NSString *post = [NSString stringWithFormat:@"reqtype=getIncidentInjuries&incidentID=%ld",(long)self.incidentID];
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
    
    if ([identity[0] isEqualToString:@"getVictimCategories"])
    {
        self.itemsLoaded++;
        
        NSArray *categories = [identity[1] componentsSeparatedByString:@","];
        
        if (categories.count > 1)
        {
            for (NSString *currentCategory in categories)
            {
                if (currentCategory.length > 0)
                {
                    NSArray *categoryCountArray = [currentCategory componentsSeparatedByString:@"."];
                    NSDictionary *statusCount = [NSDictionary dictionaryWithObjectsAndKeys:categoryCountArray[1],categoryCountArray[0], nil];
                
                    [self.victimCategoryData addEntriesFromDictionary:statusCount];
                }
            }
            
            NSArray *categoryArray = @[@"Expectant", @"Immediate", @"Delayed", @"Minor"];
            NSArray *colors = @[[UIColor blackColor],
                                [UIColor redColor],
                                [UIColor yellowColor],
                                [UIColor greenColor]];
            NSMutableArray *legends = [[NSMutableArray alloc] init];
            NSMutableArray *data = [[NSMutableArray alloc] init];
            NSMutableArray *colorsArray = [[NSMutableArray alloc] init];
            
            for (NSString *currentStatus in [self.victimCategoryData allKeys])
            {
                [legends addObject:[categoryArray objectAtIndex:[currentStatus intValue]-1]];
                [colorsArray addObject:[colors objectAtIndex:[currentStatus intValue]-1]];
                [data addObject:[self.victimCategoryData valueForKey:currentStatus]];
            }
            
            [self.victimCountChart renderInLayer:self.victimCountChart dataArray:data legendsArray:legends andColorsArray:colorsArray];
            self.victimCountChart.delegate = self;
        }
        
    }
    else if([identity[0] isEqualToString:@"getVehicleCount"])
    {
        self.itemsLoaded++;
        
        NSArray *categories = [identity[1] componentsSeparatedByString:@","];
        self.vehicleCategoryData = [[NSMutableDictionary alloc] init];
        self.vehicleCountData = [[NSMutableDictionary alloc] init];
        
        if (categories.count > 1)
        {
            for (NSString *currentCategory in categories)
            {
                if (currentCategory.length > 0)
                {
                    NSArray *categoryCountArray = [currentCategory componentsSeparatedByString:@"."];
                    NSDictionary *vehicleCount = [NSDictionary dictionaryWithObjectsAndKeys:categoryCountArray[2],categoryCountArray[0], nil];
                    NSDictionary *vehicleCategory = [NSDictionary dictionaryWithObjectsAndKeys:categoryCountArray[1],categoryCountArray[0], nil];
                    
                    [self.vehicleCountData addEntriesFromDictionary:vehicleCount];
                    [self.vehicleCategoryData addEntriesFromDictionary:vehicleCategory];
                }
            }
            
            NSMutableArray *temp = [NSMutableArray array];
            int i=0;
            
            for (NSString *currentVehcileID in [self.vehicleCountData allKeys])
            {
                NSString *vehicleType = [self.vehicleCategoryData valueForKey:currentVehcileID];
                NSString *vehicleCount = [self.vehicleCountData valueForKey:currentVehcileID];
                EColumnDataModel *eColumnDataModel = [[EColumnDataModel alloc] initWithLabel:[NSString stringWithFormat:@"%@", vehicleType] value:[vehicleCount integerValue] index:i unit:@""];
                [temp addObject:eColumnDataModel];
                
                i++;
            }
            
            self.vehicleChartData = [NSArray arrayWithArray:temp];
            
           self.vehicleCountChart = [[EColumnChart alloc] initWithFrame:CGRectMake(0, 0, self.vehicleCountChartHolder.frame.size.width, self.vehicleCountChartHolder.frame.size.height)];

            [self.vehicleCountChart setShowHorizontalLabelsWithInteger:YES];
            [self.vehicleCountChart setColumnsIndexStartFromLeft:YES];
            [self.vehicleCountChart setDataSource:self];
            [self.vehicleCountChart setShowHighAndLowColumnWithColor:NO];
            
            [self.vehicleCountChartHolder addSubview:self.vehicleCountChart];
            [self.vehicleCountChart setDelegate:self];
        }

    }
    else if([identity[0] isEqualToString:@"getIncidentBodyParts"])
    {
        self.itemsLoaded++;
        
        self.incidentBodyParts = [[NSMutableDictionary alloc] init];
        self.selectedBodyParts = [[NSMutableArray alloc] init];
        NSArray *details = [identity[1] componentsSeparatedByString:@","];
        
        if (details.count > 1)
        {
            for (NSString *currentItem in details)
            {
                NSArray *items = [currentItem componentsSeparatedByString:@"."];
                if (items.count >= 2)
                {
                    NSDictionary *tempDictionary = [NSDictionary dictionaryWithObjectsAndKeys:items[1],items[0], nil];
                    
                    [self.incidentBodyParts addEntriesFromDictionary:tempDictionary];
                }
            }
            
            [self setBodyPartSelected];
        }
    }
    else if([identity[0] isEqualToString:@"getIncidentInjuries"])
    {
        self.itemsLoaded++;
        
        self.incidentInjuries = [[NSMutableDictionary alloc] init];
        self.selectedInjuries = [[NSMutableArray alloc] init];
        NSArray *details = [identity[1] componentsSeparatedByString:@","];
        
        if (details.count > 1)
        {
            for (NSString *currentItem in details)
            {
                NSArray *items = [currentItem componentsSeparatedByString:@"."];
                
                if (items.count >= 2)
                {
                    NSDictionary *tempDictionary = [NSDictionary dictionaryWithObjectsAndKeys:items[1],items[0], nil];
                    
                    [self.incidentInjuries addEntriesFromDictionary:tempDictionary];
                }
            }
        }
        [self loadInjuriesToView];
        
    }
    
    else if([identity[0] isEqualToString:@"getIncidentVictims"])
    {
        self.itemsLoaded++;
        
        self.incidentInjuries = [[NSMutableDictionary alloc] init];
        self.selectedInjuries = [[NSMutableArray alloc] init];
        NSString *xml = identity[1];
//        NSLog(@"%@",xml);
        
        NSData *xmlData = [xml dataUsingEncoding:NSASCIIStringEncoding];;
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
        
        [xmlParser setDelegate:self];
        
        [xmlParser parse];
        
    }
    else if ([identity[0] isEqualToString:@"getHospital"])
    {
        NSArray *categories = [identity[1] componentsSeparatedByString:@","];
        
        if (categories.count > 1)
        {
            self.hospitalDetails = [[NSMutableDictionary alloc] init];
            self.hospitalVacancy = [[NSMutableDictionary alloc] init];
            
            for (NSString *currentCategory in categories)
            {
                if (currentCategory.length > 0)
                {
                    NSArray *hospitalTempArray = [currentCategory componentsSeparatedByString:@"."];
                    NSDictionary *hospitalDetails = [NSDictionary dictionaryWithObjectsAndKeys:hospitalTempArray[1],hospitalTempArray[0], nil];
                    NSDictionary *hospitalVacancyDetails = [NSDictionary dictionaryWithObjectsAndKeys:hospitalTempArray[2],hospitalTempArray[0], nil];
                    
                    [self.hospitalDetails addEntriesFromDictionary:hospitalDetails];
                    [self.hospitalVacancy addEntriesFromDictionary:hospitalVacancyDetails];
                }
            }
            
            [self showHospitalDetails];
        }
        
    }
    
    if (self.itemsLoaded == 4)
    {
        self.mainScrollView.contentSize = CGSizeMake(1000, 1000);
        [self removeProgress];
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if ( [elementName isEqualToString:@"Victim"])
    {
        self.incidentVictims = [[NSMutableArray alloc] init];
    }
    else if ([elementName isEqualToString:@"New_Victim"])
    {
        self.currentVictim = [[Victim alloc] init];
    }
    else if ([elementName isEqualToString:@"InjuryTypes"])
    {
        self.currentVictim.injuryDetails = [[NSDictionary alloc] init];
        self.bodyPart = @"";
        self.injuries = [[NSMutableArray alloc] init];
        self.bodyInjuryDictionary = [[NSMutableDictionary alloc] init];
    }
    
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"Victim_ID"])
    {
        self.currentVictim.victimID = self.xmlValue;
    }
    else if ([elementName isEqualToString:@"Status"])
    {
        self.currentVictim.category = [self.xmlValue integerValue];
    }
    else if ([elementName isEqualToString:@"notes"])
    {
        self.currentVictim.notes = self.xmlValue;
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
    else if ([elementName isEqualToString:@"Incident_ID"])
    {
        self.currentVictim.incidentID = [self.xmlValue integerValue];
    }
    else if ([elementName isEqualToString:@"Staging_Area"])
    {
        self.currentVictim.stagingArea = [self.xmlValue integerValue];
    }
    else if ([elementName isEqualToString:@"enroute"])
    {
        self.currentVictim.enRoute = [self.xmlValue integerValue];
    }
    else if ([elementName isEqualToString:@"InjuryTypes"])
    {
        self.currentVictim.injuryDetails = self.bodyInjuryDictionary;
    }
    else if ([elementName isEqualToString:@"New_Victim"])
    {
        [self.incidentVictims addObject:[self.currentVictim copy]];
    }
    else if ([elementName isEqualToString:@"Victim"])
    {
        self.originalVictimsData = self.incidentVictims;
        [self finishedParsingVictims];
    }
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    self.xmlValue = string;
}

- (void)finishedParsingVictims
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.mycollectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    
    [self.mycollectionView setDataSource:self];
    [self.mycollectionView setDelegate:self];
    
    [self.mycollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [self.mycollectionView setBackgroundColor:[UIColor clearColor]];
    
    [self.victimHolderView addSubview:self.mycollectionView];
}

- (void)setBodyPartSelected
{
    for (NSString *currentBodyPart in [self.incidentBodyParts allKeys])
    {
        [UIView animateWithDuration:0.1 animations:^{
            [(UIButton*)[self.view viewWithTag:[currentBodyPart integerValue]] setEnabled:YES];
        }];
    }
}

- (void)loadInjuriesToView
{
    CGFloat yPoint = 10;
    int i=1;
        
    for (NSString *currentInjury in [self.incidentInjuries allKeys])
    {
        NSArray *injuryArray = [[NSBundle mainBundle] loadNibNamed:@"InjuryView" owner:self options:nil];
        InjuryView *injury = [injuryArray objectAtIndex:0];
        
        UIView *newInjury = [[UIView alloc] initWithFrame:CGRectMake(10, yPoint, self.injuriesScrollView.frame.size.width-20, 40)];
        injury.injuryButton.frame = CGRectMake(0, 4, 32, 32);
        [newInjury addSubview:injury.injuryButton];
        
        injury.injuryLabel.frame = CGRectMake(40, 4, self.injuriesScrollView.frame.size.width-40, 32);
        [newInjury addSubview:injury.injuryLabel];
        
        injury.injuryLabel.text = [self.incidentInjuries valueForKey:currentInjury];
        
        [injury.injuryButton addTarget:self action:@selector(injuryCheckBoxClicked:) forControlEvents:UIControlEventTouchUpInside];
        [injury.injuryButton setTag:[currentInjury intValue]];
        
        i++;
        
        [self.injuriesScrollView addSubview:newInjury];
        [self.selectedInjuries addObject:currentInjury];
        
        yPoint = yPoint + 40;
    }

    [UIView animateWithDuration:.25 animations:^{
        self.injuriesScrollView.contentSize = CGSizeMake(self.injuriesScrollView.frame.size.width, yPoint+60);
    }];
}

- (void)injuryCheckBoxClicked:(id)sender
{
    if([sender isSelected] == YES)
    {
        [self.selectedInjuries removeObject:[NSString stringWithFormat:@"%ld",[sender tag]]];
        [sender setSelected:NO];
    }
    else
    {
        [self.selectedInjuries addObject:[NSString stringWithFormat:@"%ld",[sender tag]]];
        [sender setSelected:YES];
    }
    
    [self filterVicims];
    
}

- (void)bodyPartClicked:(id)sender
{
    if([sender isSelected] == YES)
    {
        [self.selectedBodyParts removeObject:[NSString stringWithFormat:@"%ld",[sender tag]]];
        [sender setSelected:NO];
    }
    else
    {
        [self.selectedBodyParts addObject:[NSString stringWithFormat:@"%ld",[sender tag]]];
        [sender setSelected:YES];
    }
    
    [self filterVicims];
}

#pragma -mark- Filters

- (void)filterWithBodyPart
{
    NSMutableArray *objectsToRemove = [[NSMutableArray alloc] init];
    for (NSString *currentBodyPart in self.selectedBodyParts)
    {
        for (Victim *currentVictim in self.originalVictimsData)
        {
            if ([[[currentVictim injuryDetails] allKeys] containsObject:currentBodyPart] == NO)
            {
                [objectsToRemove addObject:currentVictim];
            }
            else
            {
                if ([objectsToRemove containsObject:currentVictim])
                {
                    [objectsToRemove removeObject:currentVictim];
                }
            }
        }
    }
    
    if (objectsToRemove.count > 0)
    {
        [self.incidentVictims removeObjectsInArray:objectsToRemove];
    }
}

- (void)filterWithPredicates
{
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:self.filters];
    self.incidentVictims=[[NSMutableArray alloc] initWithArray:[self.incidentVictims filteredArrayUsingPredicate:andPredicate]];
}

- (void)filterWithInjuries
{
    NSMutableArray *objectsToRemove = [[NSMutableArray alloc] init];
    for (NSString *currentInjury in self.selectedInjuries)
    {
        for (Victim *currentVictim in self.originalVictimsData)
        {
            BOOL bodypartFound = NO;
            
            for (NSString *currentBodyPart in currentVictim.injuryDetails.allKeys)
            {
                if ([[currentVictim.injuryDetails objectForKey:currentBodyPart] containsObject:currentInjury] == YES)
                {
                    bodypartFound = YES;
                    break;
                }
            }
            
            if (bodypartFound == NO)
            {
                [objectsToRemove addObject:currentVictim];
            }
        }
    }
    
    if (objectsToRemove.count > 0)
    {
        [self.incidentVictims removeObjectsInArray:objectsToRemove];
    }
}

- (void)filterVicims
{
    self.incidentVictims = [[NSMutableArray alloc] initWithArray:self.originalVictimsData];
    
    [self filterWithPredicates];
    [self filterWithBodyPart];
    [self filterWithInjuries];
    [self.mycollectionView reloadData];
}

- (IBAction)pickerCancelClicked:(id)sender
{
   
}

- (IBAction)pickerDoneClicked:(id)sender
{
    self.selectedHospital = self.currentHospitalSelection;
    NSString *hospitalName = [self.hospitalDetails valueForKey:[NSString stringWithFormat:@"%ld",self.selectedHospital]];
    
    [self.pickerShowButton setTitle:hospitalName forState:UIControlStateNormal];
}

- (IBAction)hospitalPickerClicked:(id)sender
{
    NSString *post = [NSString stringWithFormat:@"reqtype=getHospital"];
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

- (IBAction)dispatch:(id)sender
{
    if (self.selectedVehicle == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Data"
                                                        message:@"Please select a vehicle type!!!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    else if (self.selectedHospital == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Data"
                                                        message:@"Please select a hospital!!!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    else if (self.selectedVictims.count == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Missing Data"
                                                        message:@"Please select atleast one victim!!!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

        return;
    }
    
    for(NSString *currentVictim in self.selectedVictims)
    {
        NSLog(@"%@ is sent to %ld using %ld", currentVictim, self.selectedHospital, self.selectedVehicle);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", error.domain);
    
}

#pragma -mark- PieChart Delegates

- (void)pieChart:(DLPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    self.selectedCategory = [self.victimCategoryData.allKeys[index] integerValue];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %ld",self.selectedCategory];
    
//    [self.categoryPredicateArray addObject:predicate];
    [self.filters addObject:predicate];
    
    [self filterVicims];
}

- (void)pieChart:(DLPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %ld",[self.victimCategoryData.allKeys[index] integerValue]];
//    [self.categoryPredicateArray removeObject:predicate];
    [self.filters removeObject:predicate];
    
    self.selectedCategory = 0;
    
    [self filterVicims];
}

//- (BOOL)shouldAutorotate
//{
//    return YES;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscape;
//}


#pragma -mark- EColumnChartDataSource

- (NSInteger)numberOfColumnsInEColumnChart:(EColumnChart *)eColumnChart
{
    return [self.vehicleChartData count];
}

- (NSInteger)numberOfColumnsPresentedEveryTime:(EColumnChart *)eColumnChart
{
    return 3;
}

- (EColumnDataModel *)highestValueEColumnChart:(EColumnChart *)eColumnChart
{
    EColumnDataModel *maxDataModel = nil;
    float maxValue = -FLT_MIN;
    for (EColumnDataModel *dataModel in self.vehicleChartData)
    {
        if (dataModel.value > maxValue)
        {
            maxValue = dataModel.value;
            maxDataModel = dataModel;
        }
    }
    return maxDataModel;
}

- (EColumnDataModel *)eColumnChart:(EColumnChart *)eColumnChart valueForIndex:(NSInteger)index
{
    if (index >= [self.vehicleChartData count] || index < 0) return nil;
    return [self.vehicleChartData objectAtIndex:index];
}

- (UIColor *) colorForEColumn:(EColumn *)eColumn
{
    return [UIColor blueColor];
}

#pragma -mark- EColumnChartDelegate
- (void)eColumnChart:(EColumnChart *)eColumnChart
     didSelectColumn:(EColumn *)eColumn
{
    NSLog(@"Index: %ld  Value: %f", (long)eColumn.eColumnDataModel.index, eColumn.eColumnDataModel.value);
    
    if (self.eColumnSelected)
    {
        self.eColumnSelected.barColor = self.tempColor;
    }
    
    if (self.eColumnSelected == eColumn)
    {
        self.selectedVehicle = 0;
        self.eColumnSelected = nil;
    }
    else
    {
        self.eColumnSelected = eColumn;
        self.tempColor = eColumn.barColor;
        eColumn.barColor = [UIColor redColor];
        self.selectedVehicle = [[[self.vehicleCountData allKeys] objectAtIndex:self.eColumnSelected.eColumnDataModel.index] integerValue];
    }
}

- (void)eColumnChart:(EColumnChart *)eColumnChart
fingerDidEnterColumn:(EColumn *)eColumn
{
    /**The EFloatBox here, is just to show an example of
     taking adventage of the event handling system of the Echart.
     You can do even better effects here, according to your needs.*/
    NSLog(@"Finger did enter %ld", (long)eColumn.eColumnDataModel.index);
    CGFloat eFloatBoxX = eColumn.frame.origin.x + eColumn.frame.size.width;
    CGFloat eFloatBoxY = eColumn.frame.origin.y + eColumn.frame.size.height * (1-eColumn.grade);
    if (self.eFloatBox)
    {
        [self.eFloatBox removeFromSuperview];
        self.eFloatBox.frame = CGRectMake(eFloatBoxX, eFloatBoxY, self.eFloatBox.frame.size.width, _eFloatBox.frame.size.height);
        [self.eFloatBox setValue:eColumn.eColumnDataModel.value];
        [eColumnChart addSubview:self.eFloatBox];
    }
    else
    {
        self.eFloatBox = [[EFloatBox alloc] initWithPosition:CGPointMake(eFloatBoxX, eFloatBoxY) value:eColumn.eColumnDataModel.value unit:@"" title:@"Count"];
        self.eFloatBox.alpha = 0.0;
        [eColumnChart addSubview:_eFloatBox];
        
    }
    eFloatBoxY -= (self.eFloatBox.frame.size.height + eColumn.frame.size.width * 0.25);
    self.eFloatBox.frame = CGRectMake(eFloatBoxX, eFloatBoxY, self.eFloatBox.frame.size.width, self.eFloatBox.frame.size.height);
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.eFloatBox.alpha = 1.0;
        
    } completion:^(BOOL finished) {
    }];
    
}

- (void)eColumnChart:(EColumnChart *)eColumnChart
fingerDidLeaveColumn:(EColumn *)eColumn
{
    NSLog(@"Finger did leave %ld", (long)eColumn.eColumnDataModel.index);
    
}

- (void)fingerDidLeaveEColumnChart:(EColumnChart *)eColumnChart
{
    if (_eFloatBox)
    {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            self.eFloatBox.alpha = 0.0;
            self.eFloatBox.frame = CGRectMake(self.eFloatBox.frame.origin.x, self.eFloatBox.frame.origin.y + self.eFloatBox.frame.size.height, self.eFloatBox.frame.size.width, self.eFloatBox.frame.size.height);
        } completion:^(BOOL finished) {
            [self.eFloatBox removeFromSuperview];
            self.eFloatBox = nil;
        }];
        
    }
    
}

#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.incidentVictims.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    VictimCollectionViewCell *cell=(VictimCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
//    NSArray *colorsArray = @[[UIColor blackColor],
//                             [UIColor redColor],
//                             [UIColor greenColor],
//                             [UIColor yellowColor]];
//    
//    cell.victimIdLabel.text = [NSString stringWithFormat:@"%@",[self.incidentVictims[indexPath.row] victimID]];
//    cell.selectedImage.hidden = YES;
//    
//    NSInteger status = [(Victim*)[self.incidentVictims objectAtIndex:indexPath.row] category];
//    cell.backgroundColor = colorsArray[status-1];
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UILabel *idLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 40, 20)];
    idLabel.text = [NSString stringWithFormat:@"%@",[self.incidentVictims[indexPath.row] victimID]];
    [idLabel sizeToFit];
    [cell.contentView addSubview:idLabel];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(idLabel.frame.origin.x+idLabel.frame.size.width+8, 10, 14, 14)];
    imgView.image = [UIImage imageNamed:@"tickmark.png"];
    imgView.hidden = YES;
    
    [cell.contentView addSubview:imgView];
    
    NSArray *colorsArray = @[[UIColor blackColor],
                             [UIColor redColor],
                             [UIColor yellowColor],
                             [UIColor greenColor]];
    
    NSInteger status = [(Victim*)[self.incidentVictims objectAtIndex:indexPath.row] category];
    cell.backgroundColor = colorsArray[status-1];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 36);
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell= (UICollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSString *victimID = [(UILabel*)[cell.contentView.subviews objectAtIndex:0] text];
    
    if ([[cell.contentView.subviews objectAtIndex:1] isHidden] == YES)
    {
        [[cell.contentView.subviews objectAtIndex:1] setHidden:NO];
        [self.selectedVictims addObject:victimID];
    }
    else
    {
        [[cell.contentView.subviews objectAtIndex:1] setHidden:YES];
        [self.selectedVictims removeObject:victimID];
    }
    
}

#pragma  -mark- HospitalDetails

- (void)showHospitalDetails
{
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"HospitalPickerView" owner:self options:nil];
    
    self.hospitalPicker = [subviewArray objectAtIndex:0];
    
    self.hospitalPicker.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
//    self.hospitalPicker.center = self.view.center;
    self.hospitalPicker.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
    
    NSLog(@"%fx%f", self.hospitalPicker.frame.size.width, self.hospitalPicker.frame.size.height);
    NSLog(@"%f:%f", self.hospitalPicker.frame.origin.x, self.hospitalPicker.frame.origin.y);
    
    [(UIView *)self.popupView layer].cornerRadius = 5;
    [(UIView *)self.popupView layer].shadowOpacity = 0.8;
    self.popupView.center = self.hospitalPicker.center;
    [(UIView *)self.popupView layer].shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    CGFloat yPoint = 40;
    
    for (NSString *currentHospital in [self.hospitalDetails allKeys])
    {
        UIButton *hospitalButton = [[UIButton alloc] init];
        
        UIView *newHospital = [[UIView alloc] initWithFrame:CGRectMake(10, yPoint, self.popupView.frame.size.width-20, 40)];
        [hospitalButton setTitle:[self.hospitalDetails valueForKey:currentHospital] forState:UIControlStateNormal];
        
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,
                                       [[UIColor blueColor] CGColor]);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [hospitalButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [hospitalButton setBackgroundImage:img forState:UIControlStateSelected];
        [hospitalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [hospitalButton sizeToFit];
        hospitalButton.layer.cornerRadius = 5;
        hospitalButton.clipsToBounds = YES;
        
        hospitalButton.frame = CGRectMake(hospitalButton.frame.origin.x, hospitalButton.frame.origin.y, hospitalButton.frame.size.width+12, hospitalButton.frame.size.height);
        hospitalButton.center = CGPointMake(newHospital.center.x, hospitalButton.center.y);
        
        [newHospital addSubview:hospitalButton];
        
        [hospitalButton addTarget:self action:@selector(hospitalSelected:) forControlEvents:UIControlEventTouchUpInside];
        [hospitalButton setTag:[currentHospital intValue]];
        
        [self.popupView addSubview:newHospital];
        
        yPoint = yPoint + 40;
    }
    
    self.popupView.frame = CGRectMake(self.popupView.frame.origin.x, self.popupView.frame.origin.y, self.popupView.frame.size.width, yPoint);
    
    self.popupView.center = self.view.center;
    
    self.hospitalPicker.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.hospitalPicker.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        
        NSLog(@"After\n%fx%f", self.hospitalPicker.frame.size.width, self.hospitalPicker.frame.size.height);
        NSLog(@"%f:%f", self.hospitalPicker.frame.origin.x, self.hospitalPicker.frame.origin.y);
        [self.view addSubview:self.hospitalPicker];
            
        self.hospitalPicker.alpha = 1;
        self.hospitalPicker.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (IBAction)hospitalSelected:(id)sender
{
    [self removeAnimate];
    
    self.selectedHospital = [sender tag];
    [self.pickerShowButton setTitle:[self.hospitalDetails valueForKey:[NSString stringWithFormat:@"%ld", self.selectedHospital]] forState:UIControlStateNormal];
}

#pragma -mark- Miscelleneous

- (void)removeAnimate
{
    if ([[self.view subviews] containsObject:self.hospitalPicker])
    {
        [UIView animateWithDuration:.25 animations:^{
            self.hospitalPicker.transform = CGAffineTransformMakeScale(1.3, 1.3);
            self.hospitalPicker.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self.hospitalPicker removeFromSuperview];
            }
        }];
    }
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
        self.waitingView.alpha = .75;
        self.waitingView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeProgress
{
    [self.waitingView removeFromSuperview];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
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
