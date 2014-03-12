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
 Get path of database in the app
 **/
-(NSString *)getDatabasePath{
    WCEAppDelegate *appDelegate = (WCEAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSString *dbPath = [appDelegate databasePath];
    
    return dbPath;
}

//Location Access Methods
//location names are enforced as unique so a name can be used as an id

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
        
        NSInteger nsi = 1;
        int i = [results intForColumn:@"id"];
        nsi = i;
        
        curLocation.locationId = nsi;
        
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

/**
 return a location for a given name
 **/
-(Location *)getLocationForName:(NSString *)name{
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    //wrap in try catch blocks!!
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM location WHERE name = ?", name];
    
    Location *curLocation = [[Location alloc] init];
    
    if([results next]){
        
        NSInteger nsi = 1;
        int i = [results intForColumn:@"id"];
        nsi = i;
        
        curLocation.locationId = nsi;
        
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

/**
 get a locationId for a given name
 **/
-(NSInteger)getLocationIdForName:(NSString *)name{
    Location *cur = [self getLocationForName:name];
    
    return cur.locationId;
}


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


//Partner access methods
//partner names are not guaranteed to be unique so partnerId must be used as an id
//partners also need a location id in order to show up in the application
/**
 return partners for a given location name
 **/
-(NSMutableArray *)getPartnersForLocationName:(NSString *)name{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM partner WHERE locationId = (SELECT id FROM location WHERE name=?)", name];
    
    NSMutableArray *partners = [[NSMutableArray alloc] init];
    
    while([results next]){
        Partner *curPartner = [[Partner alloc] init];
        curPartner.partnerId = [results intForColumn:@"id"];
        curPartner.locationId = [results intForColumn:@"locationId"];
        curPartner.name = [results stringForColumn:@"name"];
        [partners addObject:curPartner];
    }
    
    [db close];
    
    return partners;
}


/**
 Insert partner into database
 A partner NEEDS a valid location id in order to show up in the application
 use getLocationIdForPartner to obtain it
 **/
-(BOOL)insertPartner:(Partner *) partner{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    BOOL success =  [db executeUpdate:@"INSERT INTO partner (name, locationId) VALUES (?, ?);", partner.name, [NSNumber numberWithInteger:partner.locationId], nil];
    
    [db close];
    
    return success;
}


/**
 Use this method to update a partner 
 needs a valid partner id for updating
 **/
-(BOOL)updatePartner:(Partner *) partner {
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    BOOL success = [db executeUpdate:@"UPDATE partner SET name = ? WHERE id= ?;", partner.name, [NSNumber numberWithInteger:partner.partnerId]];
    
    if (!success){
        NSLog(@"%@", [db lastErrorMessage]);
    }
    [db close];
    
    return success;
}


/**
 Delete a given partner in the database
 needs a valid partner id
 **/
-(BOOL)deletePartner:(Partner *) partner{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    BOOL success = [db executeUpdate:@"DELETE FROM partner WHERE id=?;", [NSNumber numberWithInteger:partner.partnerId]];
    
    if (!success){
        NSLog(@"%@", [db lastErrorMessage]);
    }
    [db close];
    
    
    return success;
}


/**Form Access Methods**/


//COVER SHEET
/**
Get a cover sheet for a given partner
 **/
-(CoverSheet *)getCoverSheetForPartner:(Partner *)partner{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM coverSheet WHERE partnerId = ?", [NSNumber numberWithInteger:partner.partnerId]];
    
    CoverSheet *curCoverSheet = [[CoverSheet alloc] init];
    
    if([results next]){
        curCoverSheet.partnerId = [results intForColumn:@"partnerid"];
        curCoverSheet.coverSheetId = [results intForColumn:@"id"];
        curCoverSheet.q1 = [results stringForColumn:@"q1"];
        curCoverSheet.q2 = [results stringForColumn:@"q2"];
        curCoverSheet.q3 = [results stringForColumn:@"q3"];
        curCoverSheet.q4 = [results stringForColumn:@"q4"];
        curCoverSheet.q5 = [results stringForColumn:@"q5"];
        curCoverSheet.q6 = [results stringForColumn:@"q6"];
        curCoverSheet.q7 = [results stringForColumn:@"q7"];
        curCoverSheet.q8 = [results stringForColumn:@"q8"];
        curCoverSheet.q9 = [results stringForColumn:@"q9"];
        curCoverSheet.q10 = [results stringForColumn:@"q10"];
        curCoverSheet.q11 = [results stringForColumn:@"q11"];
        curCoverSheet.q12 = [results stringForColumn:@"q12"];
        curCoverSheet.q13 = [results stringForColumn:@"q13"];
        curCoverSheet.q14 = [results stringForColumn:@"q14"];
        curCoverSheet.q15 = [results stringForColumn:@"q15"];
        curCoverSheet.q16 = [results stringForColumn:@"q16"];
        curCoverSheet.q17 = [results stringForColumn:@"q17"];
    }
    
    [db close];
    
    return curCoverSheet;
}

-(NSInteger)getCoverSheetIdForPartner:(Partner *)partner{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM coverSheet WHERE partnerId = ?", [NSNumber numberWithInteger:partner.partnerId]];
    
    NSInteger partnerId = 0;
    
    if([results next]){
        partnerId = [results intForColumn:@"partnerid"];
    }
    
    [db close];
    
    return partnerId;
}

/**
 Insert cover sheet into database
 A cover sheet NEEDS a valid partner id in order to show up in the application
 **/
-(BOOL)insertCoverSheet:(CoverSheet *)coverSheet{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    //@"INSERT INTO partner (name, locationId) VALUES (?, ?);"
    BOOL success =  [db executeUpdate:@"INSERT INTO coverSheet (partnerid, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);",
                     [NSNumber numberWithInteger:coverSheet.partnerId], coverSheet.q1,
                     coverSheet.q2, coverSheet.q3, coverSheet.q4, coverSheet.q5,
                     coverSheet.q6, coverSheet.q7, coverSheet.q8, coverSheet.q9,
                     coverSheet.q10, coverSheet.q11, coverSheet.q12, coverSheet.q13,
                     coverSheet.q14, coverSheet.q15, coverSheet.q16, coverSheet.q17, nil];
    
    if(!success){
        NSLog(@"%@", [db lastErrorMessage]);
    }
    
    [db close];
    
    return success;
}

/**
 Use this method to update a coverSheet
 needs a valid coverSheet id for updating
 **/
-(BOOL)updateCoverSheet:(CoverSheet *)coverSheet{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    BOOL success = [db executeUpdate:@"UPDATE coverSheet SET q1 = ?, q2 = ?, q3 = ?, \
                                        q4 = ?, q5 = ?, q6 = ?, q7 = ?, q8 = ?, q9 = ?, \
                                        q10 = ?, q11 = ?, q12 = ?, q13 = ?, q14 = ?, \
                                        q15 = ?, q16 = ?, q17 = ?, partnerid = ? \
                                        WHERE id= ?;",
                                        coverSheet.q1, coverSheet.q2, coverSheet.q3,
                                        coverSheet.q4, coverSheet.q5, coverSheet.q6,
                                        coverSheet.q7, coverSheet.q8, coverSheet.q9,
                                        coverSheet.q10, coverSheet.q11, coverSheet.q12,
                                        coverSheet.q13, coverSheet.q14, coverSheet.q15,
                                        coverSheet.q16, coverSheet.q17,
                                        [NSNumber numberWithInteger:coverSheet.partnerId],
                                        [NSNumber numberWithInteger:coverSheet.coverSheetId]];
    
    if (!success){
        NSLog(@"%@", [db lastErrorMessage]);
    }
    [db close];
    
    return success;
}


//EVAL FORM
/**
 Get an Eval Form for a given location
 **/
-(Evaluation *)getEvalForLocation:(Location *)location{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM evalForm WHERE locationid = ?", [NSNumber numberWithInteger:location.locationId]];
    
    Evaluation *curEvalForm = [[Evaluation alloc] init];
    
    if([results next]){
        curEvalForm.locationId = [results intForColumn:@"locationid"];
        curEvalForm.evalId = [results intForColumn:@"id"];
        curEvalForm.q1 = [results stringForColumn:@"q1"];
        curEvalForm.q2 = [results stringForColumn:@"q2"];
        curEvalForm.q3 = [results stringForColumn:@"q3"];
        curEvalForm.q4 = [results stringForColumn:@"q4"];
        curEvalForm.q5 = [results stringForColumn:@"q5"];
        curEvalForm.q6 = [results stringForColumn:@"q6"];
        curEvalForm.q7 = [results stringForColumn:@"q7"];
        curEvalForm.q8 = [results stringForColumn:@"q8"];
        curEvalForm.q9 = [results stringForColumn:@"q9"];
        curEvalForm.q10 = [results stringForColumn:@"q10"];
        curEvalForm.q11 = [results stringForColumn:@"q11"];
        curEvalForm.q12 = [results stringForColumn:@"q12"];
        curEvalForm.q13 = [results stringForColumn:@"q13"];
        curEvalForm.q14 = [results stringForColumn:@"q14"];
        curEvalForm.q15 = [results stringForColumn:@"q15"];
        curEvalForm.q16 = [results stringForColumn:@"q16"];
        curEvalForm.q17 = [results stringForColumn:@"q17"];
        curEvalForm.q18 = [results stringForColumn:@"q18"];
        curEvalForm.q19 = [results stringForColumn:@"q19"];
        curEvalForm.q20 = [results stringForColumn:@"q20"];
        curEvalForm.q21 = [results stringForColumn:@"q21"];
        curEvalForm.q22 = [results stringForColumn:@"q22"];
        curEvalForm.q23 = [results stringForColumn:@"q23"];
        curEvalForm.q24 = [results stringForColumn:@"q24"];
        curEvalForm.q25 = [results stringForColumn:@"q25"];
        curEvalForm.q26 = [results stringForColumn:@"q26"];
        curEvalForm.q27 = [results stringForColumn:@"q27"];
        curEvalForm.q28 = [results stringForColumn:@"q28"];
    }
    
    [db close];
    
    return curEvalForm;
}

/**
 Insert Evaluation Form into database
 An Evaluation NEEDS a valid locationId in order to show up in the application
 **/
-(BOOL)insertEval:(Evaluation *)eval{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    BOOL success =  [db executeUpdate:@"INSERT INTO evalForm (locationid, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24,q25, q26, q27, q28) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);", [NSNumber numberWithInteger:eval.locationId], eval.q1, eval.q2, eval.q3, eval.q4, eval.q5, eval.q6, eval.q7,
                     eval.q8, eval.q9, eval.q10, eval.q11, eval.q12, eval.q13, eval.q14, eval.q15, eval.q16,
                     eval.q17, eval.q18, eval.q19, eval.q20, eval.q21, eval.q22, eval.q23, eval.q24,
                     eval.q25, eval.q26, eval.q27, eval.q28, nil];
    
    if(!success){
        NSLog(@"%@", [db lastErrorMessage]);
    }
    
    [db close];
    
    return success;
}

/**
 Use this method to update an Evaluation Form
 needs a valid evalId for updating
 **/
-(BOOL)updateEval:(Evaluation *)eval{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    BOOL success = [db executeUpdate:@"UPDATE evalForm SET q1 = ?, q2 = ?, q3 = ?, q4 = ?, q5 = ?, q6 = ?, q7 = ?, q8 = ?, q9 = ?, q10 = ?, q11 = ?, q12 = ?, q13 = ?, q14 = ?, q15 = ?, q16 = ?, q17 = ?, q18 = ?, q19 = ?, q20 = ?, q21 = ?, q22 = ?, q23 = ?, q24 = ?, q25 = ?, q26 = ?, q27 = ?, q28 = ? WHERE id= ?;",eval.q1, eval.q2, eval.q3, eval.q4, eval.q5, eval.q6, eval.q7, eval.q8, eval.q9, eval.q10, eval.q11, eval.q12, eval.q13, eval.q14, eval.q15, eval.q16, eval.q17, eval.q18, eval.q19, eval.q20, eval.q21, eval.q22, eval.q23, eval.q24, eval.q25, eval.q26, eval.q27, eval.q28, [NSNumber numberWithInteger:eval.evalId], nil];
    
    if (!success){
        NSLog(@"%@", [db lastErrorMessage]);
    }
    [db close];
    
    return success;
}


//IMPLEMENTATION QUESTIONS
/**
 Get an Implementation Questions Form for a given partner
 **/
-(ImpQuestions *)getImpForPartner:(Partner *)partner{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM impQuestions WHERE partnerid = ?", [NSNumber numberWithInteger:partner.partnerId]];
    
    ImpQuestions *curImpQues = [[ImpQuestions alloc] init];
    
    if([results next]){
        curImpQues.partnerId = [results intForColumn:@"partnerid"];
        curImpQues.impId = [results intForColumn:@"id"];
        curImpQues.q1 = [results stringForColumn:@"q1"];
        curImpQues.q2 = [results stringForColumn:@"q2"];
        curImpQues.q3 = [results stringForColumn:@"q3"];
        curImpQues.q4 = [results stringForColumn:@"q4"];
        curImpQues.q5 = [results stringForColumn:@"q5"];
        curImpQues.q6 = [results stringForColumn:@"q6"];
        curImpQues.q7 = [results stringForColumn:@"q7"];
        curImpQues.q8 = [results stringForColumn:@"q8"];
        curImpQues.q9 = [results stringForColumn:@"q9"];
        curImpQues.q10 = [results stringForColumn:@"q10"];
        curImpQues.q11 = [results stringForColumn:@"q11"];
        curImpQues.q12 = [results stringForColumn:@"q12"];
        curImpQues.q13 = [results stringForColumn:@"q13"];
        curImpQues.q14 = [results stringForColumn:@"q14"];
        curImpQues.q15 = [results stringForColumn:@"q15"];
        curImpQues.q16 = [results stringForColumn:@"q16"];
        curImpQues.q17 = [results stringForColumn:@"q17"];
        curImpQues.q18 = [results stringForColumn:@"q18"];
        curImpQues.q19 = [results stringForColumn:@"q19"];
        curImpQues.q20 = [results stringForColumn:@"q20"];
        curImpQues.q21 = [results stringForColumn:@"q21"];
        curImpQues.q22 = [results stringForColumn:@"q22"];
        curImpQues.q23 = [results stringForColumn:@"q23"];
        curImpQues.q24 = [results stringForColumn:@"q24"];
        curImpQues.q25 = [results stringForColumn:@"q25"];
    }
    
    [db close];
    
    return curImpQues;
}


/**
 Insert Implementation Questions into database
 An ImpQuestions NEEDS a valid partnerId in order to show up in the application
 **/
-(BOOL)insertImp:(ImpQuestions *)impQues{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    BOOL success =  [db executeUpdate:@"INSERT INTO impQuestions (partnerid, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);", [NSNumber numberWithInteger:impQues.partnerId], impQues.q1, impQues.q2, impQues.q3, impQues.q4, impQues.q5, impQues.q6, impQues.q7, impQues.q8, impQues.q9, impQues.q10, impQues.q11, impQues.q12, impQues.q13, impQues.q14, impQues.q15, impQues.q16, impQues.q17, impQues.q18, impQues.q19, impQues.q20, impQues.q21, impQues.q22, impQues.q23, impQues.q24, impQues.q25, nil];
    
    if(!success){
        NSLog(@"%@", [db lastErrorMessage]);
    }
    
    [db close];
    
    return success;
}


/**
 Use this method to update Implementation Questions
 needs a valid impId for updating
 **/
-(BOOL)updateImp:(ImpQuestions *)impQues{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    BOOL success = [db executeUpdate:@"UPDATE impQuestions SET q1 = ?, q2 = ?, q3 = ?, q4 = ?, q5 = ?, q6 = ?, q7 = ?, q8 = ?, q9 = ?, q10 = ?, q11 = ?, q12 = ?, q13 = ?, q14 = ?, q15 = ?, q16 = ?, q17 = ?, q18 = ?, q19 = ?, q20 = ?, q21 = ?, q22 = ?, q23 = ?, q24 = ?, q25 = ? WHERE id= ?;", impQues.q1, impQues.q2, impQues.q3, impQues.q4, impQues.q5, impQues.q6, impQues.q7, impQues.q8, impQues.q9, impQues.q10, impQues.q11, impQues.q12, impQues.q13, impQues.q14, impQues.q15, impQues.q16, impQues.q17, impQues.q18, impQues.q19, impQues.q20, impQues.q21, impQues.q22, impQues.q23, impQues.q24, impQues.q25, [NSNumber numberWithInteger:impQues.impId], nil];
    
    if (!success){
        NSLog(@"%@", [db lastErrorMessage]);
    }
    [db close];
    
    return success;
}


//ORDER FORM
/**
 Get an Order Form for a given partner
 **/

-(Order *)getOrderForPartner:(Partner *)partner{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM orderForm WHERE partnerid = ?", [NSNumber numberWithInteger:partner.partnerId]];
    
    Order *curOrder = [[Order alloc] init];
    
    if([results next]){
        curOrder.partnerId = [results intForColumn:@"partnerid"];
        curOrder.orderId = [results intForColumn:@"id"];
        curOrder.q1 = [results stringForColumn:@"q1"];
        curOrder.q2_1 = [results stringForColumn:@"q2_1"];
        curOrder.q2_2 = [results stringForColumn:@"q2_2"];
        curOrder.q2_3 = [results stringForColumn:@"q2_3"];
        curOrder.q3 = [results stringForColumn:@"q3"];
        curOrder.q4_1 = [results stringForColumn:@"q4_1"];
        curOrder.q4_2 = [results stringForColumn:@"q4_2"];
        curOrder.q4_3 = [results stringForColumn:@"q4_3"];
        curOrder.q5_1 = [results stringForColumn:@"q5_1"];
        curOrder.q5_2 = [results stringForColumn:@"q5_2"];
        curOrder.q5_3 = [results stringForColumn:@"q5_3"];
        curOrder.q6_1 = [results stringForColumn:@"q6_1"];
        curOrder.q6_2 = [results stringForColumn:@"q6_2"];
        curOrder.q6_3 = [results stringForColumn:@"q6_3"];
        curOrder.q6_4 = [results stringForColumn:@"q6_4"];
        curOrder.q7_1 = [results stringForColumn:@"q7_1"];
        curOrder.q7_2 = [results stringForColumn:@"q7_2"];
        curOrder.q8 = [results stringForColumn:@"q8"];
        curOrder.q9 = [results stringForColumn:@"q9"];
        curOrder.q10 = [results stringForColumn:@"q10"];
        curOrder.q11 = [results stringForColumn:@"q11"];
        curOrder.q12 = [results stringForColumn:@"q12"];
        curOrder.q13_1 = [results stringForColumn:@"q13_1"];
        curOrder.q13_2 = [results stringForColumn:@"q13_2"];
        curOrder.q14 = [results stringForColumn:@"q14"];
        curOrder.q15 = [results stringForColumn:@"q15"];
    }
    
    [db close];
    
    return curOrder;
}


/**
 Insert Order Form into database
 An Order Form NEEDS a valid partnerId in order to show up in the application
 **/
-(BOOL)insertOrder:(Order *)order{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    /**
     CREATE TABLE orderForm(partnerid INTEGER references partner, id INTEGER PRIMARY KEY, q1 varchar(5), q2 varchar(5),  q2_1 varchar(5), q2_2 varchar(5), q2_3 varchar(5), q3 varchar(5),  q4_1 varchar(5), q4_2 varchar(5), q4_3 varchar(5), q5_1 varchar(5),  q5_2 varchar(5), q5_3 varchar(5), q6_1 varchar(5), q6_2 varchar(5),  q6_3 varchar(5), q6_4 varchar(5), q7_1 varchar(5), q7_2 varchar(5),  q8 varchar(30), q9 varchar(5), q10 varchar(5), q11 varchar(5),  q12 varchar(5), q13_1 varchar(5), q13_2 varchar(500), q14 varchar(5),  q15 varchar(5))
     **/
    
    BOOL success =
    [db executeUpdate:@"INSERT INTO orderForm (partnerid, q1, q2_1, q2_2, q2_3, q3, q4_1, q4_2, q4_3, q5_1, q5_2, q5_3, q6_1, q6_2, q6_3, q6_4, q7_1, q7_2, q8, q9, q10, q11, q12, q13_1, q13_2, q14, q15) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);", [NSNumber numberWithInteger:order.partnerId], order.q1, order.q2_1, order.q2_2, order.q2_3, order.q3, order.q4_1, order.q4_2, order.q4_3, order.q5_1, order.q5_2, order.q5_3, order.q6_1, order.q6_2, order.q6_3, order.q6_4, order.q7_1, order.q7_2, order.q8, order.q9, order.q10, order.q11, order.q12, order.q13_1, order.q13_2, order.q14, order.q15, nil];
    
    if(!success){
        NSLog(@"%@", [db lastErrorMessage]);
    }
    
    [db close];
    
    return success;
}


/**
 Use this method to update an Order Form
 needs a valid orderId for updating
 **/
-(BOOL)updateOrder:(Order *)order{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDatabasePath]];
    
    [db open];
    
    BOOL success = [db executeUpdate:@"UPDATE orderForm SET q1 = ?, q2_1 = ?, q2_2 = ?, q2_3 = ?, q3 = ?, q4_1 = ?, q4_2 = ?, q4_3 = ?, q5_1 = ?, q5_2 = ?, q5_3 = ?, q6_1 = ?, q6_2 = ?, q6_3 = ?, q6_4 = ?, q7_1 = ?, q7_2 = ?, q8 = ?, q9 = ?, q10 = ?, q11 = ?, q12 = ?, q13 = ?, q14 = ?, q15 = ? WHERE id= ?;", order.q1, order.q2_1, order.q2_2, order.q2_3, order.q3, order.q4_1, order.q4_2, order.q4_3, order.q5_1, order.q5_2, order.q5_3, order.q6_1, order.q6_2, order.q6_3, order.q6_4, order.q7_1, order.q7_2, order.q8, order.q9, order.q10, order.q11, order.q12, order.q13_1, order.q13_2, order.q14, [NSNumber numberWithInteger:order.orderId], nil];
    
    if (!success){
        NSLog(@"%@", [db lastErrorMessage]);
    }
    [db close];
    
    return success;
}




@end



