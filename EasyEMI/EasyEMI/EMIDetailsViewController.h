//
//  EMIDetailsViewController.h
//  EasyEMI
//
//  Created by karthik on 05/09/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"


@interface EMIDetailsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic) double tenureInMonths;
@property(nonatomic) double tenureInYears;
@property(nonatomic) double rateOfInterest;
@property(nonatomic) double rateOfInterestTxt;
@property(nonatomic) double loanAmt;
@property(nonatomic) double emiAmount;
@property(nonatomic) double totalAmount;
@property(nonatomic) double totalInterest;
@property(nonatomic,strong) NSMutableArray *array;
@property(nonatomic,strong) NSMutableArray *sectionTitles;
@property(nonatomic,strong) NSArray *monthTitleArray;
@property(nonatomic,strong) NSDate *curDate;
@property (weak, nonatomic) IBOutlet UITableView *tableViewIB;

- (IBAction)pdfAction:(id)sender;

@end
