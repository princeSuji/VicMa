//
//  Victim.m
//  VicMa
//
//  Created by Sujith Achuthan on 7/6/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import "Victim.h"

@implementation Victim

-(id)copyWithZone:(NSZone *)zone
{
    Victim *copy = [[Victim allocWithZone: zone] init];
    
    copy.victimID = self.victimID;
    copy.category = self.category;
    copy.incidentID = self.incidentID;
    copy.stagingArea = self.stagingArea;
    copy.injuryDetails = self.injuryDetails;
    copy.notes = self.notes;
    copy.enRoute = self.enRoute;
    
    return copy;
}

@end
