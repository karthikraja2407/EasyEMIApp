//
//  EMIDetailsViewController.m
//  EasyEMI
//
//  Created by karthik on 05/09/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import "EMIDetailsViewController.h"
#import "EMIDetailCell.h"
#import "YearInfo.h"
#import "MonthInfo.h"
#import "PDFViewController.h"


#define NO_OF_MONTHS_IN_YEAR 12

@interface EMIDetailsViewController ()

@end

@implementation EMIDetailsViewController

#pragma mark - view life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    

    NSString *bgImage = @"bg.png";
    if (IS_IPHONE_5) {
        bgImage = @"bg-568.png";
    }
   // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:bgImage]];
    self.tenureInMonths = self.tenureInYears * NO_OF_MONTHS_IN_YEAR;
    
    
    
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [self createEMIData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    YearInfo *yearInfo = (YearInfo*)self.array[section];    
    return yearInfo.months.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    EMIDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self configureCell:cell forIndexPath:indexPath];
            
    return cell;
}


-(void) configureCell:(EMIDetailCell*) cell forIndexPath:(NSIndexPath*)indexPath{
    YearInfo *yearInfo = (YearInfo*)self.array[indexPath.section];
    MonthInfo *monthsInfo = (MonthInfo*) yearInfo.months[indexPath.row];
    cell.dateLbl.text  = monthsInfo.month;
    cell.principalLbl.text = monthsInfo.principal;
    cell.interestLbl.text = monthsInfo.interest;
    cell.balanceLbl.text = monthsInfo.balance;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YearInfo *yearInfo = (YearInfo*) self.array[section];
    UILabel *yearLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 40, 20)];
    yearLbl.backgroundColor = [UIColor clearColor];
    yearLbl.text = yearInfo.year;
    yearLbl.font = [UIFont fontWithName:@"Helvetica Bold" size:12];
    yearLbl.textColor = [UIColor whiteColor];

    UILabel *principalLbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 2, 70, 20)];
    principalLbl.backgroundColor = [UIColor clearColor];
    principalLbl.text = yearInfo.total_principal;
    principalLbl.font = [UIFont fontWithName:@"Helvetica Bold" size:12];
    principalLbl.textColor = [UIColor whiteColor];
    
    UILabel *interestLbl = [[UILabel alloc] initWithFrame:CGRectMake(130, 2, 70, 20)];
    interestLbl.backgroundColor = [UIColor clearColor];
    interestLbl.text = yearInfo.total_interest;
    interestLbl.font = [UIFont fontWithName:@"Helvetica Bold" size:12];
    interestLbl.textColor = [UIColor whiteColor];
    
    UILabel *balanceLbl = [[UILabel alloc] initWithFrame:CGRectMake(205, 2, 100, 20)];
    balanceLbl.backgroundColor = [UIColor clearColor];
    balanceLbl.text = yearInfo.total_balance;
    balanceLbl.font = [UIFont fontWithName:@"Helvetica Bold" size:12];
    balanceLbl.textColor = [UIColor whiteColor];

    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, 320, 44)];
    sectionView.backgroundColor = [UIColor colorWithRed:66/255 green:92/255 blue:150/255 alpha:0.6];
    [sectionView addSubview:yearLbl];
    [sectionView addSubview:principalLbl];
    [sectionView addSubview:interestLbl];
    [sectionView addSubview:balanceLbl];
    
    return sectionView;

}

- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
       return self.sectionTitles;

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
            
}





#pragma mark - custom methods

-(void) createEMIData{
    self.array = [[NSMutableArray alloc] init];
    self.sectionTitles = [[NSMutableArray alloc] init];
    
    
    
    self.monthTitleArray = [NSArray arrayWithObjects:NSLocalizedString(@"Jan", nil),NSLocalizedString(@"Feb", nil),NSLocalizedString(@"Mar", nil),NSLocalizedString(@"Apr", nil),NSLocalizedString(@"May", nil),NSLocalizedString(@"Jun", nil),NSLocalizedString(@"Jul", nil),NSLocalizedString(@"Aug", nil),NSLocalizedString(@"Sep", nil),NSLocalizedString(@"Oct", nil),NSLocalizedString(@"Nov", nil),NSLocalizedString(@"Dec", nil), nil];
    NSDate *curDate = self.curDate;
    //NSLog(@"date:%@",curDate);
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:curDate];
    //NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    double total_month_count = self.tenureInMonths;
    YearInfo *yearInfo = [[YearInfo alloc]init];
    yearInfo.year = [[NSString alloc] initWithFormat:@"%d",year];
    yearInfo.months = [[NSMutableArray alloc] init];
    [self.sectionTitles addObject:yearInfo.year];
    [self.array addObject:yearInfo];
    double principal = self.loanAmt;
    double interest = self.rateOfInterest;
    double emi = self.emiAmount;
    double totalPrincipal = 0;
    double totalInterest = 0;
    for (int i = 0; i < total_month_count; i++) {
        
        if (month > 12) {
            yearInfo.total_principal = [NSString stringWithFormat:@"%.f",roundf(totalPrincipal)];
            yearInfo.total_interest = [NSString stringWithFormat:@"%.f",roundf(totalInterest)];
            yearInfo.total_balance = [NSString stringWithFormat:@"%.f",roundf(principal)];
            totalInterest = 0;
            totalPrincipal = 0;
            month = 1;
            year = year + 1;
            yearInfo = [[YearInfo alloc]init];
            yearInfo.year = [[NSString alloc] initWithFormat:@"%d",year];
            yearInfo.months = [[NSMutableArray alloc] init];
            [self.sectionTitles addObject:yearInfo.year];
            [self.array addObject:yearInfo];
            
        }

        double interestForMonth =  principal * interest;
        totalInterest = totalInterest + interestForMonth;
        double monthlyPrincipal = emi - interestForMonth;
        totalPrincipal = totalPrincipal + monthlyPrincipal;
        principal = principal - monthlyPrincipal;
        MonthInfo *monthInfo = [[MonthInfo alloc] init];
        monthInfo.month = self.monthTitleArray[month - 1];
        monthInfo.principal = [NSString stringWithFormat:@"%.f",roundf(monthlyPrincipal)];
        monthInfo.interest = [NSString stringWithFormat:@"%.f",roundf(interestForMonth)];
        monthInfo.balance = [NSString stringWithFormat:@"%.f",roundf(principal)];
        [yearInfo.months addObject:monthInfo];
        month ++;
        
        if (i == total_month_count - 1) {
            yearInfo.total_principal = [NSString stringWithFormat:@"%.f",roundf(totalPrincipal)];
            yearInfo.total_interest = [NSString stringWithFormat:@"%.f",roundf(totalInterest)];
            yearInfo.total_balance = [NSString stringWithFormat:@"%.f",roundf(principal)];
        }

    }
    
    
    
    /*for (int i = 0; i < self.array.count; i++) {
        YearInfo *yearInfo = (YearInfo*) self.array[i];
        NSLog(@"year : %@",yearInfo.year);
        
        for (int i = 0; i < yearInfo.months.count; i ++) {
            MonthInfo *month = (MonthInfo*) yearInfo.months[i];
            NSLog(@"month: %@ , principal : %@ , interest : %@ , balance :%@",month.month,month.principal,month.interest,month.balance);
        }
    }*/
    [self.tableViewIB reloadData];
}






#pragma mark - Events handlers

- (IBAction)pdfAction:(id)sender {
    
    PDFViewController *pDFViewController = [[PDFViewController alloc] init];
    pDFViewController.array = self.array;
    pDFViewController.tenureInMonths = self.tenureInMonths;
    pDFViewController.rateOfInterest = self.rateOfInterest;
    pDFViewController.loanAmt = self.loanAmt;
    pDFViewController.emiAmount = self.emiAmount;
    pDFViewController.totalAmount = self.totalAmount;
    pDFViewController.totalInterest = self.totalInterest;
    pDFViewController.curDate = self.curDate;
    pDFViewController.rateOfInterestTxt = self.rateOfInterestTxt;
    
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:pDFViewController];
    
    [self presentViewController:navCtrl animated:YES completion:nil];
    
}




@end
