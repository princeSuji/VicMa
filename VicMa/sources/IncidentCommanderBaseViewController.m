//
//  IncidentCommanderBaseViewController.m
//  VicMa
//
//  Created by Sujith Achuthan on 8/5/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import "IncidentCommanderBaseViewController.h"

@interface IncidentCommanderBaseViewController ()

@end

@implementation IncidentCommanderBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [UIView animateWithDuration:.1 animations:^{
//        [[UIDevice currentDevice] setValue:
//         [NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight]
//                                    forKey:@"orientation"];
//    } completion:^(BOOL finished) {
//        if (finished) {
//            [self performSelector:@selector(addView) withObject:nil afterDelay:1];
//        }
//    }];
//}

- (void)addView
{
    self.incidentCommanderView = [[IncidentCommanderViewController alloc] init];
    
    self.incidentCommanderView.incidentID = self.incidentID;
    self.incidentCommanderView.userID = self.userID;
    
    self.incidentCommanderView.view.frame = CGRectMake(self.view.frame.origin.x+12, self.view.frame.origin.y+64, self.view.frame.size.width-12, self.view.frame.size.height-64);
    
    [self.view addSubview:self.incidentCommanderView.view];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
