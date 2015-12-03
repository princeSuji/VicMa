//
//  Victim.h
//  VicMa
//
//  Created by Sujith Achuthan on 7/6/15.
//  Copyright (c) 2015 Sujith Achuthan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Victim : NSObject

@property(strong) NSString *victimID;
@property(assign) NSInteger category;
@property(assign) NSInteger incidentID;
@property(assign) NSInteger stagingArea;
@property(strong) NSDictionary *injuryDetails;
@property(strong) NSString *notes;
@property(assign) NSInteger enRoute;

-(id) copyWithZone: (NSZone *) zone;

@end
