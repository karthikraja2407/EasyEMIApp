//
//  Constant.h
//  EasyEMI
//
//  Created by karthik on 16/09/13.
//  Copyright (c) 2013 karthik. All rights reserved.
//


#define MAX_LOAN 2000000
#define MAX_INTEREST 30
#define MAX_TENURE 30
#define DEFAULT_LOAN_SLIDER 30
#define DEFAULT_LOAN_VARIATION 50000
#define DEFAULT_INTEREST_SLIDER 0.5
#define DEFAULT_TENURE_SLIDER 0.5
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)