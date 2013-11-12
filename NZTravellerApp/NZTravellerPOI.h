//
//  NZTravellerPOI.h
//  NZTravellerApp
//
//  Created by Frederike Schmitz on 12.11.13.
//  Copyright (c) 2013 Frederike Schmitz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NZTravellerDetails;

@interface NZTravellerPOI : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * xLoc;
@property (nonatomic, retain) NSNumber * xOff;
@property (nonatomic, retain) NSNumber * yLoc;
@property (nonatomic, retain) NSNumber * yOff;
@property (nonatomic, retain) NZTravellerDetails *details;

@end
