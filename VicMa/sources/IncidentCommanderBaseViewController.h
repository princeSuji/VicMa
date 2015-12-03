//
//  IncidentCommanderBaseViewController.h
//  VicMa
//
//  Created by Sujith Achuthan on 8/5/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncidentCommanderViewController.h"

@interface IncidentCommanderBaseViewController : UIViewController

@property (assign)NSInteger incidentID;
@property (assign)NSInteger userID;
@property (strong)IncidentCommanderViewController *incidentCommanderView;

@end
