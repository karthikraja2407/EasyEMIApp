//
//  SectionInfo.h
//  EasyEMI
//
//  Created by karthik on 06/09/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YearInfo : NSObject
@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSString *total_principal;
@property (strong, nonatomic) NSString *total_interest;
@property (strong, nonatomic) NSString *total_balance;
@property (strong, nonatomic) NSMutableArray *months;
@end
