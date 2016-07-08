//
//  PDFViewController.h
//  EasyEMI
//
//  Created by Karthik on 1/10/14.
//  Copyright (c) 2014 karthik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFViewController : UIViewController

@property(nonatomic) double tenureInMonths;
@property(nonatomic) double rateOfInterest;
@property(nonatomic) double loanAmt;
@property(nonatomic) double emiAmount;
@property(nonatomic) double rateOfInterestTxt;
@property(nonatomic) double totalAmount;
@property(nonatomic) double totalInterest;
@property(nonatomic,strong) NSDate *curDate;
@property(nonatomic,strong) NSMutableArray *array;
@property(nonatomic,strong) NSString *textStr;
@end
