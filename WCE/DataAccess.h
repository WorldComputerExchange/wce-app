//
//  DataAccess.h
//  WCE
//
//  Created by  Brian Beckerle on 8/2/13.
//

/**
 Database access and update methods
 **/

#import <Foundation/Foundation.h>
#import "FMResultSet.h"
#import "FMDatabase.h"
#import "Location.h"

@interface DataAccess : NSObject
{
    
}
-(NSString *)getDatabasePath;
-(NSMutableArray *)getLocations;
-(Location *)getLocationForName:(NSString *)name;
//-(Location *)getLocationForId:(NSInteger *)locationId;
-(BOOL)insertLocation:(Location *) location;
-(BOOL)updateLocation:(Location *) location;
-(BOOL)updateLocation:(Location *) location withName:(NSString *)name;
-(BOOL)deleteLocation:(Location *) location;

@end
