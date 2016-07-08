//
//  DatePickerController.h
//  EasyEMI
//
//  Created by Karthik on 12/10/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DatePickerController;

@protocol DatePickerControllerDelegate
- (void) datePickerController:(DatePickerController *)controller didPickDate:(NSDate *)date;
@end

@interface DatePickerController : UIViewController {
    UIDatePicker *datePicker;
    NSObject <DatePickerControllerDelegate> *delegate;
}

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *datePickerBgView;
@property (nonatomic, weak) id <DatePickerControllerDelegate> delegate;
@end
