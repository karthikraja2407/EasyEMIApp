//
//  MasterViewController.m
//  EasyEMI
//
//  Created by karthik on 01/07/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import "EMIViewController.h"
#import "EMIDetailsViewController.h"
#import "DatePickerController.h"







@interface EMIViewController () {
    NSMutableArray *_objects;
}
@end



@implementation EMIViewController

/*- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 7.0)
    {
        
        self.navigationController.navigationBar.translucent = NO;
        
    }
    
    NSString *bgImage = @"bg-img.jpg";
    if (IS_IPHONE_5) {
        bgImage = @"bg-img.jpg";
    }
    

    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:theDate style:UIBarButtonItemStylePlain target:self action:@selector(dateChangeAction:)];
    
	//self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:bgImage]];
   
    viewCenterFrame = self.view.center;

    
    
    
    [self createEMIAccessoryView];
    [self.loanAmtTxt setInputAccessoryView:_inputAccessoryView];
    [self.interestTxt setInputAccessoryView:_inputAccessoryView];
    [self.tenureTxt setInputAccessoryView:_inputAccessoryView];
    //self.calculationContainerView.backgroundColor = [UIColor colorWithRed:32/255 green:32/255 blue:32/255 alpha:0.8];
    
    [self initData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];    
    
    

}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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


-(void)createEMIAccessoryView {
    
    _inputAccessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
    _inputAccessoryView.barStyle = UIBarStyleBlackTranslucent;
    [_inputAccessoryView sizeToFit];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:nil
                                                                              action:nil];
    
    self.prevButton = [[UIBarButtonItem alloc]  initWithTitle:NSLocalizedString(@"Prev", nil)   style:UIBarButtonItemStyleBordered target:self action:@selector(prevButtonAction:) ];
    self.nextButton = [[UIBarButtonItem alloc]  initWithTitle: NSLocalizedString(@"Next", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(nextButtonAction:) ];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) 
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self action:@selector(dismissKeyBoard:)];
    
    NSArray *items = [NSArray arrayWithObjects:self.prevButton,self.nextButton,flexItem,doneItem, nil];
    [_inputAccessoryView setItems:items animated:YES];
}



//-(void) addBannerToView{
//    self.adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
//    self.adView.frame = CGRectOffset(self.adView.frame, 0, -50);
//    self.adView.delegate=self;
//    [self.view addSubview:self.adView];
//
//}

/*- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
    
    if ( !IS_IPHONE_5 && calculationShiftedDown) {
        calculationShiftedDown = NO;
        [UIView beginAnimations: @"ViewShiftUp" context: nil];
        [UIView setAnimationDuration: 0.5];
        CGRect frame = self.calculationContainerView.frame;
        frame.origin.y =     frame.origin.y - 50;
        self.calculationContainerView.frame = frame;
        [UIView commitAnimations];
    }
    self.iAdBanner.hidden = NO;
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    self.iAdBanner.hidden = YES;
    
    if (!IS_IPHONE_5 && !calculationShiftedDown) {
        calculationShiftedDown = YES;
        [UIView beginAnimations: @"ViewShiftDown" context: nil];
        [UIView setAnimationDuration: 0.5];
        CGRect frame = self.calculationContainerView.frame;
        frame.origin.y =     frame.origin.y + 50;
        self.calculationContainerView.frame = frame;
        [UIView commitAnimations];
    }

}*/


-(void) dismissKeyBoard:(id)sender{
    
    [self.loanAmtTxt resignFirstResponder];
    [self.interestTxt resignFirstResponder];
    [self.tenureTxt resignFirstResponder];
    
    [self calculateLoan];
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
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSDate *object = [NSDate date];
        EMIDetailsViewController *emiDetailsViewController = [segue destinationViewController];
        emiDetailsViewController.tenureInYears = [self.tenureTxt.text intValue];
        double interest = [[self.interestTxt text] floatValue];
        double r = interest /(100 * 12);
        emiDetailsViewController.loanAmt = [[self.loanAmtTxt text] floatValue];
        emiDetailsViewController.rateOfInterest = r;
        emiDetailsViewController.rateOfInterestTxt = interest;
        emiDetailsViewController.emiAmount = emi;
        emiDetailsViewController.curDate = self.curDate;
        emiDetailsViewController.totalInterest = [[self.totalInterestLbl text] floatValue];
        emiDetailsViewController.totalAmount = [[self.totalAmtLbl text] floatValue];
        
       // [[segue destinationViewController] setDetailItem:object];
    }
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
    self.curDate = [NSDate date];
    [self setDate];
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
   // [self calculateLoan];
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
  //  [self calculateLoan];
}

- (IBAction)tenureSliderAction:(id)sender {
    UISlider *slider = (UISlider*)sender;
    float sliderValue = [slider value] * MAX_TENURE;
    [self.tenureTxt setText:[NSString stringWithFormat:@"%d",(int)sliderValue]];
    [self calculateLoan]; 
}

- (IBAction)tenureSliderTouchUpInside:(id)sender {
   // [self calculateLoan];
}


-(void) setDate{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    
    NSString *theDate = [dateFormat stringFromDate:self.curDate];
    [self.dateChangeBtn setTitle:theDate forState:UIControlStateNormal];
    
}

- (IBAction)dateChangeAction:(id)sender {
    DatePickerController *datePickerController = [[DatePickerController alloc] init];
    datePickerController.delegate = self;
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:datePickerController];
    [self presentViewController:navCtrl animated:YES completion:nil];
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

#pragma mark -- DatePickerController Delegate

- (void) datePickerController:(DatePickerController *)controller didPickDate:(NSDate *)date{
    self.curDate = date;
    [self setDate];
    
}


- (void)viewDidUnload {
    [self setScrollView:nil];
    [super viewDidUnload];
}
@end
