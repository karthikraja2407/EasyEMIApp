//
//  EMIViewController_ipadViewController.m
//  EasyEMI
//
//  Created by karthik on 29/09/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import "EMIViewController_ipad.h"
#import "EMIDetailCell.h"
#import "YearInfo.h"
#import "MonthInfo.h"

#define NO_OF_MONTHS_IN_YEAR 12

@interface EMIViewController_ipad ()

@end

@implementation EMIViewController_ipad

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self createEMIAccessoryView];
    [self.loanAmtTxt setInputAccessoryView:_inputAccessoryView];
    [self.interestTxt setInputAccessoryView:_inputAccessoryView];
    [self.tenureTxt setInputAccessoryView:_inputAccessoryView];
    self.tenureInMonths = self.tenureInYears * NO_OF_MONTHS_IN_YEAR;
    [self initData];
}

-(void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillShowNotification
                                                  object: nil];
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillHideNotification
                                                  object: nil];
    
    //registring for notification after deleting if it was already done.
    //This is to fix a bug of viewwillappear not firing in ios 4.3.
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(shiftViewUpForKeyboard:)
                                                 name: UIKeyboardWillShowNotification
                                               object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(shiftViewDownAfterKeyboard)
                                                 name: UIKeyboardWillHideNotification
                                               object: nil];
    
    
    [self createEMIData];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillShowNotification
                                                  object: nil];
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillHideNotification
                                                  object: nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createEMIAccessoryView {
    
    _inputAccessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
    _inputAccessoryView.barStyle = UIBarStyleBlackTranslucent;
    [_inputAccessoryView sizeToFit];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:nil
                                                                              action:nil];
    
    self.prevButton = [[UIBarButtonItem alloc]  initWithTitle:NSLocalizedString(@"Prev", nil)  style:UIBarButtonItemStyleBordered target:self action:@selector(prevButtonAction:) ];
    self.nextButton = [[UIBarButtonItem alloc]  initWithTitle:NSLocalizedString(@"Next", nil)  style:UIBarButtonItemStyleBordered target:self action:@selector(nextButtonAction:) ];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil)
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self action:@selector(dismissKeyBoard:)];
    
    NSArray *items = [NSArray arrayWithObjects:self.prevButton,self.nextButton,flexItem,doneItem, nil];
    [_inputAccessoryView setItems:items animated:YES];
}



-(void) dismissKeyBoard:(id)sender{
    
    [self.loanAmtTxt resignFirstResponder];
    [self.interestTxt resignFirstResponder];
    [self.tenureTxt resignFirstResponder];
    
    [self calculateLoan];
    [self createEMIData];
}


-(void) prevButtonAction: (id) sender {
    if ([self.interestTxt isFirstResponder]) {
        [self.loanAmtTxt becomeFirstResponder];
        
    }else if ([self.tenureTxt isFirstResponder]) {
        [self.interestTxt becomeFirstResponder];
    }
}

- (void) nextButtonAction : (id) sender{
    if ([self.loanAmtTxt isFirstResponder]) {
        [self.interestTxt becomeFirstResponder];
        
    }else if ([self.interestTxt isFirstResponder]) {
        [self.tenureTxt becomeFirstResponder];
    }
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}


#pragma mark - tableview delegate


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    // NSLog(@"textFieldDidBeginEditing");
    if ([self.loanAmtTxt isFirstResponder]) {
        self.nextButton.enabled = YES;
        self.prevButton.enabled = NO;
    }else if ([self.interestTxt isFirstResponder]) {
        self.nextButton.enabled = YES;
        self.prevButton.enabled = YES;
    }else if([self.tenureTxt isFirstResponder]) {
        self.nextButton.enabled = NO;
        self.prevButton.enabled = YES;
    }
    
    
    self.responsdingTextField = textField;
    
    [self shiftView];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //[self shiftViewDownAfterKeyboard];
    
    if ([textField.text isEqualToString:@""]) {
        textField.text = [NSString stringWithFormat:@"%d",0];
        
    }
    if (textField.tag == 100) {
        float txtFieldValue = [textField.text floatValue];
        float sliderValue = txtFieldValue/DEFAULT_LOAN_VARIATION;
        [self.loanAmtSlider setValue:sliderValue];
    }else if (textField.tag == 200) {
        float txtFieldValue = [textField.text floatValue];
        float sliderValue = txtFieldValue/MAX_INTEREST;
        [self.interestSlider setValue:sliderValue];
    }else if(textField.tag == 300) {
        float txtFieldValue = [textField.text floatValue];
        float sliderValue = txtFieldValue/MAX_TENURE;
        [self.tenureSlider setValue:sliderValue];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    // NSLog(@"range:%d",range.length);
    NSString *txt = [textField text];
    if(textField.tag == 300){
        if ([string isEqualToString:@"."]) {
            return NO;
        }
        if (textField.text.length >= 2) {
            if (range.length == 0) {
                return NO;
            }
        }
        
    }
    
    if ([string isEqualToString:@"."]) {
        if ([txt rangeOfString:@"."].location == NSNotFound) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - custom methods

-(void) initData{
    float initialLoanAmt = DEFAULT_LOAN_SLIDER * DEFAULT_LOAN_VARIATION;
    [self.loanAmtSlider setValue:DEFAULT_LOAN_SLIDER];
    float initialInterest = DEFAULT_INTEREST_SLIDER * MAX_INTEREST;
    [self.interestSlider setValue:DEFAULT_INTEREST_SLIDER];
    float initialTenure = DEFAULT_TENURE_SLIDER * MAX_TENURE;
    [self.tenureSlider setValue:DEFAULT_INTEREST_SLIDER];
    self.loanAmtTxt.text = [NSString stringWithFormat:@"%.2f",initialLoanAmt];
    self.interestTxt.text = [NSString stringWithFormat:@"%.1f",initialInterest];
    self.tenureTxt.text = [NSString stringWithFormat:@"%d",(int)initialTenure];
    [self calculateLoan];
}

-(void) calculateLoan{
    double p = [[self.loanAmtTxt text] floatValue];
    double interest = [[self.interestTxt text] floatValue];
    double tenure = [[self.tenureTxt text] floatValue];
    if (p == 0 || interest == 0 || tenure == 0) {
        self.monthlyPayLbl.text = @"0.00";
        self.totalAmtLbl.text = @"0.00";
        self.totalInterestLbl.text = @"0.00";
    }else{
        int tenureInMonths = tenure * 12;
        double r = interest /(100 * 12);
        emi =  (p * r * pow(1+r, tenureInMonths))/ (pow(1 + r, tenureInMonths) - 1);
        self.monthlyPayLbl.text = [NSString stringWithFormat:@"%.f",roundf(emi)];
        double totalAmt = emi * tenureInMonths;
        self.totalAmtLbl.text = [NSString stringWithFormat:@"%.f",roundf(totalAmt)];
        double totalInterest = totalAmt - p;
        self.totalInterestLbl.text = [NSString stringWithFormat:@"%.f",roundf(totalInterest)];
    }
    
    
}


- (IBAction)loanAmtSlider:(id)sender {
    UISlider *slider = (UISlider*)sender;
    float temp = floorf(slider.value) * DEFAULT_LOAN_VARIATION;// / 100;
    float sliderValue = temp;//temp * MAX_LOAN;
    [self.loanAmtTxt setText:[NSString stringWithFormat:@"%d",(int)sliderValue]];
    [self calculateLoan];
}

- (IBAction)loanAmtSliderTouchUpInside:(id)sender {
     [self createEMIData];
}

- (IBAction)interestSliderAction:(id)sender {
    UISlider *slider = (UISlider*)sender;
    //NSLog(@"interest value:%f",slider.value);
    float sliderValue = [slider value] * MAX_INTEREST;
    int intsliderValue = (int) sliderValue ;
    float decimalvalue = sliderValue - intsliderValue;
    float roundedValue = 0;
    if (decimalvalue > 0 && decimalvalue <= 0.25)
        roundedValue = 0.25;
    else if(decimalvalue > .25 && decimalvalue <= 0.5)
        roundedValue = 0.5;
    else if(decimalvalue > .5 && decimalvalue <= 0.75)
        roundedValue = 0.75;
    else if (decimalvalue > .75 && decimalvalue <= 1.0)
        roundedValue = 1;
    float finalSliderValue = intsliderValue + roundedValue;
    [self.interestTxt setText:[NSString stringWithFormat:@"%.2f",finalSliderValue]];
    [self calculateLoan];
}

- (IBAction)interestSliderTouchUpInside:(id)sender {
      [self createEMIData];
}

- (IBAction)tenureSliderAction:(id)sender {
    UISlider *slider = (UISlider*)sender;
    float sliderValue = [slider value] * MAX_TENURE;
    [self.tenureTxt setText:[NSString stringWithFormat:@"%d",(int)sliderValue]];
    [self calculateLoan];
}

- (IBAction)tenureSliderTouchUpInside:(id)sender {
     [self createEMIData];
}

- (void) shiftViewUpForKeyboard: (NSNotification*) theNotification
{
    //CGRect keyboardFrame;
    NSDictionary* userInfo = theNotification.userInfo;
    keyboardSlideDuration = [[userInfo objectForKey: UIKeyboardAnimationDurationUserInfoKey] floatValue];
    keyboardFrame = [[userInfo objectForKey: UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    //viewShiftedForKeyboard = [self shiftView];
    
    
}


-(void) shiftView{
    if([self.loanAmtTxt isFirstResponder]){
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if ([self.interestTxt isFirstResponder]) {
        if (IS_IPHONE_5) {
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }else{
            [self.scrollView setContentOffset:CGPointMake(0, 70) animated:YES];
        }
    }else if ([self.tenureTxt isFirstResponder]){
        if (IS_IPHONE_5) {
            [self.scrollView setContentOffset:CGPointMake(0, 70) animated:YES];
        }else{
            [self.scrollView setContentOffset:CGPointMake(0, 150) animated:YES];
        }
    }
    
    
    //    [UIView beginAnimations: @"ShiftUp" context: nil];
    //    [UIView setAnimationDuration: keyboardSlideDuration];
    //    self.view.center = CGPointMake(self.view.center.x, keyboardShiftAmount);
    //    [UIView commitAnimations];
    //return true;
    
}

- (void) shiftViewDownAfterKeyboard
{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    //        [UIView beginAnimations: @"ShiftUp" context: nil];
    //        [UIView setAnimationDuration: keyboardSlideDuration];
    //        self.view.center = viewCenterFrame;//CGPointMake(self.view.center.x, self.view.center.y + keyboardShiftAmount/1.8);
    //        [UIView commitAnimations];
    //        viewShiftedForKeyboard = FALSE;
    
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
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"MM.dd.yy"];
    NSString *dateString = [format stringFromDate:date];
    
    
    YearInfo *yearInfo = (YearInfo*)self.array[indexPath.section];
    MonthInfo *monthsInfo = (MonthInfo*) yearInfo.months[indexPath.row];
    cell.dateLbl.text  = monthsInfo.month;
    cell.principalLbl.text = monthsInfo.principal;
    cell.interestLbl.text = monthsInfo.interest;
    cell.balanceLbl.text = monthsInfo.balance;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    YearInfo *yearInfo = (YearInfo*) self.array[section];
    UILabel *yearLbl = [[UILabel alloc] initWithFrame:CGRectMake(52, 2, 40, 20)];
    yearLbl.backgroundColor = [UIColor clearColor];
    yearLbl.text = yearInfo.year;
    yearLbl.font = [UIFont fontWithName:@"Helvetica Bold" size:12];
    yearLbl.textColor = [UIColor whiteColor];
    
    UILabel *principalLbl = [[UILabel alloc] initWithFrame:CGRectMake(145, 2, 70, 20)];
    principalLbl.backgroundColor = [UIColor clearColor];
    principalLbl.text = yearInfo.total_principal;
    principalLbl.font = [UIFont fontWithName:@"Helvetica Bold" size:12];
    principalLbl.textColor = [UIColor whiteColor];
    
    UILabel *interestLbl = [[UILabel alloc] initWithFrame:CGRectMake(244, 2, 70, 20)];
    interestLbl.backgroundColor = [UIColor clearColor];
    interestLbl.text = yearInfo.total_interest;
    interestLbl.font = [UIFont fontWithName:@"Helvetica Bold" size:12];
    interestLbl.textColor = [UIColor whiteColor];
    
    UILabel *balanceLbl = [[UILabel alloc] initWithFrame:CGRectMake(335, 2, 100, 20)];
    balanceLbl.backgroundColor = [UIColor clearColor];
    balanceLbl.text = yearInfo.total_balance;
    balanceLbl.font = [UIFont fontWithName:@"Helvetica Bold" size:12];
    balanceLbl.textColor = [UIColor whiteColor];
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
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
    self.tenureInYears = [self.tenureTxt.text intValue];
    double interest = [[self.interestTxt text] floatValue];
    double r = interest /(100 * 12);
    self.loanAmt = [[self.loanAmtTxt text] floatValue];
    self.rateOfInterest = r;
    self.emiAmount = emi;
    self.tenureInMonths = self.tenureInYears * NO_OF_MONTHS_IN_YEAR;
    
    
    
    self.array = [[NSMutableArray alloc] init];
    self.sectionTitles = [[NSMutableArray alloc] init];
    self.monthTitleArray = [NSArray arrayWithObjects:NSLocalizedString(@"Jan", nil),NSLocalizedString(@"Feb", nil),NSLocalizedString(@"Mar", nil),NSLocalizedString(@"Apr", nil),NSLocalizedString(@"May", nil),NSLocalizedString(@"Jun", nil),NSLocalizedString(@"Jul", nil),NSLocalizedString(@"Aug", nil),NSLocalizedString(@"Sep", nil),NSLocalizedString(@"Oct", nil),NSLocalizedString(@"Nov", nil),NSLocalizedString(@"Dec", nil), nil];

    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
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
    interest  = self.rateOfInterest;
    
    emi = self.emiAmount;
    double totalPrincipal = 0;
    double totalInterest = 0;
    
   // NSLog(@"emi :%f , principal : %f, total month : %f",emi,principal,total_month_count);
    
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
    
    
    [self.tableViewIB reloadData];
}


- (void)viewDidUnload {
    [self setScrollView:nil];
    [super viewDidUnload];
}

@end
