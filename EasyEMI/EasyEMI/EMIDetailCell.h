//
//  EMIDetailCell.h
//  EasyEMI
//
//  Created by karthik on 05/09/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMIDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *principalLbl;
@property (weak, nonatomic) IBOutlet UILabel *interestLbl;
@property (weak, nonatomic) IBOutlet UILabel *balanceLbl;

@end
