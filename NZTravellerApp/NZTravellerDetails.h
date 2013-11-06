//
//  NZTravellerDetails.h
//  NZTravellerApp
//
//  Created by Frederike Schmitz on 06.11.13.
//  Copyright (c) 2013 Frederike Schmitz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NZTravellerPOI;

@interface NZTravellerDetails : NSManagedObject

@property (nonatomic, retain) NSString * descrText;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * photoName;
@property (nonatomic, retain) NZTravellerPOI *info;

@end
