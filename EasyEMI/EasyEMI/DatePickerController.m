//
//  DatePickerController.m
//  EasyEMI
//
//  Created by Karthik on 12/10/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import "DatePickerController.h"

@interface DatePickerController ()

@end

@implementation DatePickerController

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
    self.view.backgroundColor = [UIColor blackColor];
    self.title =  NSLocalizedString(@"Select a date", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(doneBtnAction:)];
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelBtnAction:)];
    self.datePickerBgView = [[UIView alloc] init];
    self.datePickerBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.datePickerBgView];
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.tintColor = [UIColor greenColor];

    [self.view addSubview:self.datePicker];
    self.datePicker.center = self.view.center;
	// Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews{
    
    self.datePickerBgView.frame = self.datePicker.frame;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) done {

    
}

-(void) doneBtnAction :(id) sender{
    
    [self.delegate datePickerController:self didPickDate:self.datePicker.date];
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void) cancelBtnAction :(id) sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
