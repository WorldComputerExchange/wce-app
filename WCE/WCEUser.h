//
//  WCEUser.h
//  WCE
//
//  Created by Ying on 2/18/13.
//  Copyright (c) 2013  Brian Beckerle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCEUser : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *username;
@property (readwrite, nonatomic) BOOL registered;

@end
