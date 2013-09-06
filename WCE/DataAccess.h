//
//  DataAccess.h
//  WCE
//
//  Created by  Brian Beckerle on 8/2/13.
//

/**
 Database access and update methods
 
 LOCATION
 CREATE TABLE location(id INTEGER PRIMARY KEY, name varchar(30) UNIQUE, contact varchar(30), phone varchar(30), address varchar(80), city varchar(30), zip varchar(30), country varchar(30), language varchar(30))
 
 PARTNER 
 CREATE TABLE partner(locationid INTEGER references location, name varchar(30), id INTEGER PRIMARY KEY, UNIQUE(locationid, name))
 
 EVALUATION FORM
 CREATE TABLE evalForm(locationid INTEGER references location, id INTEGER PRIMARY KEY, q1 varchar(30), q2 varchar(30), q3 varchar(30), q4 varchar(30), q5 varchar(30),  q6 varchar(30), q7 varchar(30), q8 varchar(30), q9 varchar(30), q10 varchar(30), q11 varchar(30), q12 varchar(30), q13 varchar(30), q14 varchar(30), q15 varchar(30), q16 varchar(30), q17 varchar(30), q18 varchar(30), q19 varchar(500), q20 varchar(500), q21 varchar(500), q22 varchar(500), q23 varchar(500), q24 varchar(500), q25 varchar(500), q26 varchar(500), q27 varchar(500), q28 varchar(500))
 
 IMPLEMENTATION FORM
 CREATE TABLE impQuestions(partnerid INTEGER references partner, id INTEGER PRIMARY KEY, q1 varchar(5), q2 varchar(30),  q3 varchar(500), q4 varchar(500), q5 varchar(500), q6 varchar(50),  q7 varchar(5), q8 varchar(200), q9 varchar(50), q10 varchar(500),  q11 varchar(500), q12 varchar(500), q13 varchar(500), q14 varchar(500),  q15 varchar(500), q16 varchar(500), q17 varchar(500), q18 varchar(500),  q19 varchar(500), q20 varchar(500), q21 varchar(500), q22 varchar(500),  q23 varchar(500), q24 varchar(5), q25 varchar(500))

 COVER SHEET
 CREATE TABLE coverSheet(partnerid INTEGER references partner, id INTEGER PRIMARY KEY, q1 varchar(30), q2 varchar(30), q3 varchar(30), q4 varchar(30), q5 varchar(30), q6 varchar(30))
 
 ORDER FORM
 CREATE TABLE orderForm(partnerid INTEGER references partner, id INTEGER PRIMARY KEY, q1 varchar(5), q2 varchar(5),  q2_1 varchar(5), q2_2 varchar(5), q2_3 varchar(5), q3 varchar(5),  q4_1 varchar(5), q4_2 varchar(5), q4_3 varchar(5), q5_1 varchar(5),  q5_2 varchar(5), q5_3 varchar(5), q6_1 varchar(5), q6_2 varchar(5),  q6_3 varchar(5), q6_4 varchar(5), q7_1 varchar(5), q7_2 varchar(5),  q8 varchar(30), q9 varchar(5), q10 varchar(5), q11 varchar(5),  q12 varchar(5), q13_1 varchar(5), q13_2 varchar(500), q14 varchar(5),  q15 varchar(5))
 
 **/

#import <Foundation/Foundation.h>
#import "FMResultSet.h"
#import "FMDatabase.h"
#import "Location.h"
#import "Partner.h"
#import "CoverSheet.h"
#import "Evaluation.h"
#import "ImpQuestions.h"
#import "Order.h"

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

/**Form Access Methods**/

//Cover sheet access methods
-(CoverSheet *)getCoverSheetForPartner:(Partner *)partner;
-(NSInteger)getCoverSheetIdForPartner:(Partner *)partner;
-(BOOL)insertCoverSheet:(CoverSheet *)coverSheet;
-(BOOL)updateCoverSheet:(CoverSheet *)coverSheet; //needs updated coverSheet object with a valid id

//Evaluation form access methods
-(Evaluation *)getEvalForLocation:(Location *)location;
-(BOOL)insertEval:(Evaluation *)eval;
-(BOOL)updateEval:(Evaluation *)eval;

//Implementation Questions access methods
-(ImpQuestions *)getImpForPartner:(Partner *)partner;
-(BOOL)insertImp:(ImpQuestions *)impQues;
-(BOOL)updateImp:(ImpQuestions *)impQues;

//Order Form access methods
-(Order *)getOrderForPartner:(Partner *)partner;
-(BOOL)insertOrder:(Order *)order;
-(BOOL)updateOrder:(Order *)order;
@end
