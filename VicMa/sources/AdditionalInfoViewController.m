//
//  AdditionalInfoViewController.m
//  VicMa
//
//  Created by Sujith Achuthan on 7/9/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import "AdditionalInfoViewController.h"

@interface AdditionalInfoViewController ()

@end

@implementation AdditionalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *currentView = self.view;
    
    [(UIButton *)[currentView viewWithTag:1] setImage:[UIImage imageNamed:@"radio_highlighted.png"] forState:UIControlStateSelected];
    [(UIButton *)[currentView viewWithTag:2] setImage:[UIImage imageNamed:@"radio_highlighted.png"] forState:UIControlStateSelected];
    [(UIButton *)[currentView viewWithTag:3] setImage:[UIImage imageNamed:@"radio_highlighted.png"] forState:UIControlStateSelected];
    [(UIButton *)[currentView viewWithTag:4] setImage:[UIImage imageNamed:@"radio_highlighted.png"] forState:UIControlStateSelected];
    [(UIButton *)[currentView viewWithTag:5] setImage:[UIImage imageNamed:@"radio_highlighted.png"] forState:UIControlStateSelected];
    [(UIButton *)[currentView viewWithTag:6] setImage:[UIImage imageNamed:@"radio_highlighted.png"] forState:UIControlStateSelected];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)perfusionButtonClicked:(id)sender
{
    NSInteger tag = [sender tag];
    if(tag == 1 && self.minusTwoButton.selected == YES)
    {
        self.minusTwoButton.selected = NO;
    }
    else if(tag == 2 && self.plusTwoButton.selected == YES)
    {
        self.plusTwoButton.selected = NO;
    }
    
    [sender setSelected:YES];
}

- (IBAction)respirationSelected:(id)sender
{
    NSInteger tag = [sender tag];
    if(tag == 3 && self.respirationNo.selected == YES)
    {
        self.respirationNo.selected = NO;
    }
    else if(tag == 4 && self.respirationYes.selected == YES)
    {
        self.respirationYes.selected = NO;
    }
    
    [sender setSelected:YES];
}

-(void)mentalStatusSelected:(id)sender
{
    NSInteger tag = [sender tag];
    if(tag == 5 && self.mentalStatusCant.selected == YES)
    {
        self.mentalStatusCant.selected = NO;
    }
    else if(tag == 6 && self.mentalStatusCan.selected == YES)
    {
        self.mentalStatusCan.selected = NO;
    }
    
    [sender setSelected:YES];
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
