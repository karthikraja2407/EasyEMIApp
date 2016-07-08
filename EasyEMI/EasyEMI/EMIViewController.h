//
//  MasterViewController.h
//  EasyEMI
//
//  Created by karthik on 01/07/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "Constant.h"



@interface EMIViewController : UIViewController  <ADBannerViewDelegate>{
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
@property(nonatomic,strong) NSDate *curDate;
   
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

@property (weak, nonatomic) IBOutlet UIButton *dateChangeBtn;


- (IBAction)loanAmtSlider:(id)sender;
- (IBAction)loanAmtSliderTouchUpInside:(id)sender;

- (IBAction)interestSliderAction:(id)sender;
- (IBAction)interestSliderTouchUpInside:(id)sender;

- (IBAction)tenureSliderAction:(id)sender;
- (IBAction)tenureSliderTouchUpInside:(id)sender;

- (IBAction)dateChangeAction:(id)sender;
@end
