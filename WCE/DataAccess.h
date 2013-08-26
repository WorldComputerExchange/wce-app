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
#import "Partner.h"

@interface DataAccess : NSObject
{
    
}
-(NSString *)getDatabasePath; //return database path in application

//Partner access methods
-(NSMutableArray *)getPartnersForLocationName:(NSString *)name;
-(BOOL)insertPartner:(Partner *) partner;
-(BOOL)updatePartner:(Partner *) partner; //needs updated partner object with a valid id
-(BOOL)deletePartner:(Partner *) partner;

//Location access methods
-(NSMutableArray *)getLocations;
-(Location *)getLocationForName:(NSString *)name;
-(NSInteger)getLocationIdForName:(NSString *)name;
-(BOOL)insertLocation:(Location *) location;
-(BOOL)updateLocation:(Location *) location;
-(BOOL)updateLocation:(Location *) location withName:(NSString *)name; //needs updated location object and the OLD location name
-(BOOL)deleteLocation:(Location *) location;

@end
