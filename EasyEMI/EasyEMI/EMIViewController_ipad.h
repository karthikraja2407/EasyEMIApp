//
//  EMIViewController_ipadViewController.h
//  EasyEMI
//
//  Created by karthik on 29/09/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface EMIViewController_ipad : UIViewController{
    BOOL viewShiftedForKeyboard;
    BOOL calculationShiftedDown;
    NSTimeInterval keyboardSlideDuration;
    CGFloat keyboardShiftAmount;
    CGRect  keyboardFrame;
    CGPoint viewCenterFrame;
    double emi;
}


@property (strong, nonatomic) UIToolbar *inputAccessoryView;
@property (strong, nonatomic)  NSNotification *notification;
@property (strong, nonatomic)  UITextField *responsdingTextField;

@property (weak, nonatomic) IBOutlet UITextField *loanAmtTxt;
@property (weak, nonatomic) IBOutlet UISlider *loanAmtSlider;
@property (weak, nonatomic) IBOutlet UITextField *interestTxt;
@property (weak, nonatomic) IBOutlet UISlider *interestSlider;
@property (weak, nonatomic) IBOutlet UITextField *tenureTxt;

@property (weak, nonatomic) IBOutlet UISlider *tenureSlider;
@property (weak, nonatomic) IBOutlet UILabel *monthlyPayLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalInterestLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalAmtLbl;


@property (weak, nonatomic) IBOutlet UIView *calculationContainerView;
@property (strong, nonatomic) UIBarButtonItem *prevButton;
@property (strong, nonatomic) UIBarButtonItem *nextButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)loanAmtSlider:(id)sender;
- (IBAction)loanAmtSliderTouchUpInside:(id)sender;

- (IBAction)interestSliderAction:(id)sender;
- (IBAction)interestSliderTouchUpInside:(id)sender;

- (IBAction)tenureSliderAction:(id)sender;
- (IBAction)tenureSliderTouchUpInside:(id)sender;


@property(nonatomic) double tenureInMonths;
@property(nonatomic) double tenureInYears;
@property(nonatomic) double rateOfInterest;
@property(nonatomic) double loanAmt;
@property(nonatomic) double emiAmount;
@property(nonatomic,strong) NSMutableArray *array;
@property(nonatomic,strong) NSMutableArray *sectionTitles;
@property(nonatomic,strong) NSArray *monthTitleArray;
@property (weak, nonatomic) IBOutlet UITableView *tableViewIB;

@end
