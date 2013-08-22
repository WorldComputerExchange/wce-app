//
//  DataAccess.m
//  WCE
//
//  Created by  Brian Beckerle on 8/2/13.
//

/**
 Database access and update methods
 **/

#import "DataAccess.h"
#import "WCEAppDelegate.h"

@implementation DataAccess

/**
 Get all the locations in the database 
 Returned as an array of Location objects defined in Location.h
 **/
-(NSMutableArray *)getLocations{
    
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    //wrap in try catch blocks!!
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM location"];
    
    while([results next])
    {
        Location *curLocation = [[Location alloc] init];

        curLocation.locationId = [results intForColumn:@"id"];
        
        curLocation.name = [results stringForColumn:@"name"];
        
        curLocation.contact = [results stringForColumn:@"contact"];
        
        curLocation.phone = [results stringForColumn:@"phone"];
        
        curLocation.address = [results stringForColumn:@"address"];
        
        curLocation.city = [results stringForColumn:@"city"];
        
        curLocation.zip = [results stringForColumn:@"zip"];
        
        curLocation.country = [results stringForColumn:@"country"];
        
        curLocation.language = [results stringForColumn:@"language"];
    
        [locations addObject:curLocation];
    }

    [db close];

    return locations;

}
-(Location *)getLocationForName:(NSString *)name{
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    //wrap in try catch blocks!!
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM location WHERE locationName = ?", name];
    
    Location *curLocation = [[Location alloc] init];
    
    if([results next]){
        curLocation.locationId = [results intForColumn:@"id"];
        
        curLocation.name = [results stringForColumn:@"name"];
        
        curLocation.contact = [results stringForColumn:@"contact"];
        
        curLocation.phone = [results stringForColumn:@"phone"];
        
        curLocation.address = [results stringForColumn:@"address"];
        
        curLocation.city = [results stringForColumn:@"city"];
        
        curLocation.zip = [results stringForColumn:@"zip"];
        
        curLocation.country = [results stringForColumn:@"country"];
        
        curLocation.language = [results stringForColumn:@"language"];
    }
    
    [db close];
    
    return curLocation;
   
    
}

/*-(Location *)getLocationForId:(NSInteger *)locationId{
    
}*/

/**
 Insert location into database
 **/
-(BOOL)insertLocation:(Location *) location{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];

    [db open];

    BOOL success =  [db executeUpdate:@"INSERT INTO location (name, contact, phone, address, city, zip, country, language) VALUES (?, ?, ?, ?, ?, ?, ?, ?);", location.name, location.contact, location.phone, location.address, location.city, location.zip, location.country, location.language, nil];
    
    [db close];
    
    return success;

}

/**
 Update a given location in the database
 **/
-(BOOL)updateLocation:(Location *) location{
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];

    //wrap in try catch blocks!!
    [db open];

    BOOL success = [db executeUpdate:@"UPDATE location SET name = ?, contact = ?, phone = ?, address = ?, city = ?, zip = ?, country = ?, language = ? WHERE name = ?;", location.name, location.contact, location.phone, location.address, location.city, location.zip, location.country, location.language, location.name];
    
    if (!success){
        NSLog(@"%@", [db lastErrorMessage]);
    }

    [db close];
    
    return success;
}


/**
 Use this method to update a location with a name change
 **/
-(BOOL)updateLocation:(Location *) location withName:(NSString *)name{
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    //wrap in try catch blocks!!
    [db open];
    
    BOOL success = [db executeUpdate:@"UPDATE location SET name = ?, contact = ?, phone = ?, address = ?, city = ?, zip = ?, country = ?, language = ? WHERE name = ?;", location.name, location.contact, location.phone, location.address, location.city, location.zip, location.country, location.language, name];
    
    if (!success){
        NSLog(@"%@", [db lastErrorMessage]);
    }
    [db close];
    
    
    return success;
}

/**
 Delete a given location in the database
 **/
-(BOOL)deleteLocation:(Location *)location{
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    //wrap in try catch blocks
    [db open];
    
    BOOL success = [db executeUpdate:@"DELETE FROM location WHERE name=?;", location.name];
    
    if (!success){
        NSLog(@"%@", [db lastErrorMessage]);
    }
    [db close];
    
    
    return success;
}

/**
 Get path of database in the app
 **/
-(NSString *)getDatabasePath{
    WCEAppDelegate *appDelegate = (WCEAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *dbPath = [appDelegate databasePath];
    
    return dbPath;
}
@end



