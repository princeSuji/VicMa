//
//  IncidentCommanderViewController.h
//  VicMa
//
//  Created by Sujith Achuthan on 8/4/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CorePlot-CocoaTouch.h>
#import "DLPieChart.h"
#import "EColumnChart.h"
#import "EFloatBox.h"
#import "Victim.h"

@interface IncidentCommanderViewController : UIViewController<DLPieChartDelegate, EColumnChartDelegate, EColumnChartDataSource, NSXMLParserDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet DLPieChart *victimCountChart;
@property (strong, nonatomic) EColumnChart *vehicleCountChart;
@property (strong, nonatomic)IBOutlet UIView *vehicleCountChartHolder;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *injuriesScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *victimHolderView;
@property (weak, nonatomic) IBOutlet UIButton *pickerShowButton;

@property (weak, nonatomic) IBOutlet UIView *popupView;


@property (strong) UIView *hospitalPicker;
@property (strong) UIView *waitingView;
@property (strong, nonatomic) UICollectionView *mycollectionView;

@property (strong) NSMutableDictionary *victimCategoryData;
@property (strong) NSMutableDictionary *vehicleCountData;
@property (strong) NSMutableDictionary *vehicleCategoryData;
@property (strong) NSMutableDictionary *incidentBodyParts;
@property (strong) NSMutableDictionary *incidentInjuries;
@property (strong) NSMutableDictionary *hospitalDetails;
@property (strong) NSMutableDictionary *hospitalVacancy;
@property (strong) NSArray *vehicleChartData;
@property (assign) NSInteger incidentID;
@property (assign) NSInteger userID;
@property (nonatomic, strong) EColumn *eColumnSelected;
@property (nonatomic, strong) EFloatBox *eFloatBox;
@property (nonatomic, strong) UIColor *tempColor;
@property (assign) NSInteger selectedCategory;
@property (assign) NSInteger selectedVehicle;
@property (assign) NSInteger selectedHospital;
@property (assign) NSInteger currentHospitalSelection;
@property (strong) NSMutableArray *selectedBodyParts;
@property (strong) NSMutableArray *selectedInjuries;
@property (strong) NSMutableArray *selectedVictims;
@property (assign) NSInteger itemsLoaded;
@property (strong) NSMutableArray *incidentVictims;
@property (strong) NSArray *originalVictimsData;
@property (strong) Victim *currentVictim;
@property (strong) NSString *bodyPart;
@property (strong) NSMutableArray *injuries;
@property (strong) NSMutableDictionary *bodyInjuryDictionary;
@property (strong) NSString *xmlValue;

//@property (strong)NSMutableArray *categoryPredicateArray;
//@property (strong)NSMutableArray *bodyPartPredicateArray;
//@property (strong)NSMutableArray *injuryPredicateArray;
@property (strong)NSMutableArray *filters;

- (IBAction)bodyPartClicked:(id)sender;
- (IBAction)hospitalPickerClicked:(id)sender;
- (IBAction)dispatch:(id)sender;
- (IBAction)hospitalSelected:(id)sender;

@end
