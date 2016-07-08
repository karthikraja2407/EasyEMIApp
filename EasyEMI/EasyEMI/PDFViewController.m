//
//  PDFViewController.m
//  EasyEMI
//
//  Created by Karthik on 1/10/14.
//  Copyright (c) 2014 karthik. All rights reserved.
//

#import "PDFViewController.h"
#import "YearInfo.h"
#import "MonthInfo.h"
#import <CoreText/CoreText.h>
#import <MessageUI/MessageUI.h>
//#import "APLPrintPageRenderer.h"


#define kPadding 20

@interface PDFViewController (){

    CGSize _pageSize;

}

@property(nonatomic,strong) UIWebView *webView;

@end

@implementation PDFViewController

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
    self.title = @"PDF";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionClicked:)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.webView];
    
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion >= 7.0)
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil)  style:UIBarButtonItemStyleDone target:self action:@selector(doneBtnAction:)];
    
    self.navigationItem.leftBarButtonItem = doneBtn;
    
    [self drawText];
   
    
}





-(void)viewDidAppear:(BOOL)animated{

    
    
   /* [self createEMIData];
    
    NSString* fileName = @"Invoice.PDF";
    
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
    
    NSURL *url = [NSURL fileURLWithPath:pdfFileName];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];*/
    
    [self createPdf];
    
}


#pragma mark -- custom methods

-(void) doneBtnAction:(id) sender {

    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)drawText
{
    
    //[self savePDFFile:self];
  /*  NSString* fileName = @"Invoice.PDF";
    
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
    
    NSString* textToDraw = @"Hello World Hello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello World Hello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello World Hello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello World Hello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello World Hello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello World Hello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello World Hello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello World Hello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello World Hello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello World Hello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello WorldHello World";
    CFStringRef stringRef = (__bridge CFStringRef)textToDraw;
    
    // Prepare the text using a Core Text Framesetter.
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, stringRef, NULL);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
    
    CGRect frameRect = CGRectMake(0, 0, 612, 100);
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    // Get the frame that will do the rendering.
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    // Create the PDF context using the default page size of 612 x 792.
    UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil);
    
    // Mark the beginning of a new page.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    // Get the graphics context.
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, 100);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    CFRelease(frameRef);
    CFRelease(stringRef);
    CFRelease(framesetter);
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();*/
    
}


- (IBAction)savePDFFile:(id)sender
{
   
    
  /*  // Prepare the text using a Core Text Framesetter.
  
//    CGRect text_rect = { 200, 400, 100, 50 };
//    UIFont *font1 = [UIFont systemFontOfSize:12];
//    NSString * str = @"Added foo bar";
//    [str drawInRect:text_rect withFont:font1];
    
    NSString* fileName = @"Invoice.PDF";
    
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
    
    //CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, (CFStringRef)self.textStr, NULL);
    
    
    CFMutableAttributedStringRef attrStr =  CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CFAttributedStringReplaceString (attrStr, CFRangeMake(0, 0), (CFStringRef) self.textStr);

    
    //    create font
    CTFontRef font = CTFontCreateWithName(CFSTR("Times New Roman"), 30, NULL);
    
    //    create paragraph style and assign text alignment to it
    CTTextAlignment alignment = kCTJustifiedTextAlignment;
    CTParagraphStyleSetting _settings[] = {    {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment} };
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(_settings, sizeof(_settings) / sizeof(_settings[0]));
    
    //    set paragraph style attribute
    CFAttributedStringSetAttribute(attrStr, CFRangeMake(0, CFAttributedStringGetLength(attrStr)), kCTParagraphStyleAttributeName, paragraphStyle);
    
    //    set font attribute
    CFAttributedStringSetAttribute(attrStr, CFRangeMake(0, CFAttributedStringGetLength(attrStr)), kCTFontAttributeName, font);
    

    
    //    release paragraph style and font
    CFRelease(paragraphStyle);
    CFRelease(font);
    
    
    
    
    if (attrStr) {
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrStr);
        if (framesetter) {
            
           // NSString *pdfFileName = pdfFileName;//[self getPDFFileName];
            // Create the PDF context using the default page size of 612 x 792.
            UIGraphicsBeginPDFContextToFile(pdfFileName, CGRectZero, nil);
            
            CFRange currentRange = CFRangeMake(0, 0);
            NSInteger currentPage = 0;
            BOOL done = NO;
            
            do {
                // Mark the beginning of a new page.
                UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
                
                // Draw a page number at the bottom of each page.
                currentPage++;
                [self drawPageNumber:currentPage];
                
                currentRange = [self renderPage:1 withTextRange:currentRange andFramesetter:framesetter];
                
                if (currentRange.location == CFAttributedStringGetLength((CFAttributedStringRef)attrStr))
                    done = YES;
            } while (!done);
            
            UIGraphicsEndPDFContext();
            CFRelease(framesetter);
            
        } else {
            NSLog(@"Could not create the framesetter needed to lay out the atrributed string.");
        }
        CFRelease(attrStr);
    } else {
        NSLog(@"Could not create the attributed string for the framesetter");
    }*/
}


// Use Core Text to draw the text in a frame on the page.
- (CFRange)renderPage:(NSInteger)pageNum withTextRange:(CFRange)currentRange
       andFramesetter:(CTFramesetterRef)framesetter
{
    // Get the graphics context.
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    // Create a path object to enclose the text. Use 72 point
    // margins all around the text.
    CGRect    frameRect = CGRectMake(72, 72, 468, 648);
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    // Get the frame that will do the rendering.
    // The currentRange variable specifies only the starting point. The framesetter
    // lays out as much text as will fit into the frame.
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, 792);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    // Update the current range based on what was drawn.
    currentRange = CTFrameGetVisibleStringRange(frameRef);
    currentRange.location += currentRange.length;
    currentRange.length = 0;
    CFRelease(frameRef);
    
    return currentRange;
}

- (void)drawPageNumber:(NSInteger)pageNum
{
    NSString *pageString = [NSString stringWithFormat:@"%@ %d", NSLocalizedString(@"Page", nil), pageNum];
    UIFont *theFont = [UIFont systemFontOfSize:12];
    CGSize maxSize = CGSizeMake(612, 72);
    
    CGSize pageStringSize = [pageString sizeWithFont:theFont
                                   constrainedToSize:maxSize
                                       lineBreakMode:UILineBreakModeClip];
    CGRect stringRect = CGRectMake(((612.0 - pageStringSize.width) / 2.0),
                                   720.0 + ((72.0 - pageStringSize.height) / 2.0),
                                   pageStringSize.width,
                                   pageStringSize.height);
    
    [pageString drawInRect:stringRect withFont:theFont];
}


-(void) createEMIData{
    //self.array = [[NSMutableArray alloc] init];

//    NSArray *monthTitleArray = [NSArray arrayWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];

    NSString *str = @"";
    
    for (int section = 0; section < self.array.count; section++) {
        YearInfo *yearInfo = (YearInfo*)self.array[section];
        
        for (int row = 0; row < yearInfo.months.count; row++) {
            
            MonthInfo *monthsInfo = (MonthInfo*) yearInfo.months[row];

            
            NSString *tempStr = [NSString stringWithFormat:@"%@\t\t%@\t\t%@\t\t%@\n",monthsInfo.month,monthsInfo.principal,monthsInfo.interest,monthsInfo.balance];
            
            str = [str stringByAppendingString:tempStr];
            
            
        }
        
       
    }
    
    self.textStr = str;
    
        [self savePDFFile:self];
   
    
 
}


-(void) createPdf{

   
    int pageWidth = 850;
    int pageHeight = 1100;
    int width = 150;
    int height = 40;
    int ygap = 40;
    int xgap = 190;
    int xpadding = 60;
    int ypadding = 40;
    float fontSize = 34.0;
    int max_row_count = 15;
    int count = 0;
    
    [self setupPDFDocumentNamed:@"NewPDF" Width:pageWidth Height:pageHeight];
    [self beginPDFPage];

    UIColor *defaultTextColor = [UIColor blackColor];
    UIColor *defaultBgColor = [UIColor whiteColor];
    
    UIColor *highlightedTextColor = [UIColor whiteColor];
    UIColor *highlightedBgColor = [UIColor blackColor];
    
    CGRect textRect = CGRectMake(xpadding, ypadding, pageWidth, height);
    
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    
    NSString *theDate = [dateFormat stringFromDate:self.curDate];
    
    NSString *date = [NSString stringWithFormat:@"%@ :%@",NSLocalizedString(@"Date", nil), theDate];
    NSString *loanAmt = [NSString stringWithFormat:@"%@ :%.2f",NSLocalizedString(@"Loan Amount", nil), self.loanAmt];
    NSString *interestRate = [NSString stringWithFormat:@"%@ :%.2f%%",NSLocalizedString(@"Interest Rate", nil), self.rateOfInterestTxt];
    NSString *loanTenure = [NSString stringWithFormat:@"%@ :%.2f",NSLocalizedString(@"Loan tenure", nil), self.tenureInMonths];
    NSString *emi = [NSString stringWithFormat:@"%@ :%.2f",NSLocalizedString(@"EMI", nil), self.emiAmount];
    NSString *totalInterest = [NSString stringWithFormat:@"%@ :%.2f",NSLocalizedString(@"Total Interest", nil), self.totalInterest];
    NSString *totalPayment = [NSString stringWithFormat:@"%@ :%.2f",NSLocalizedString(@"Total Payment", nil), self.totalAmount];
    
    textRect = [self addText:date
                   withFrame:textRect fontSize:fontSize textColor:defaultTextColor backgroudColor:defaultBgColor];

    textRect = CGRectMake(xpadding, textRect.origin.y + ygap, pageWidth, height);
    
    textRect = [self addText:loanAmt
                   withFrame:textRect fontSize:fontSize textColor:defaultTextColor backgroudColor:defaultBgColor];
textRect = CGRectMake(xpadding, textRect.origin.y + ygap, pageWidth, height);
    textRect = [self addText:interestRate
                   withFrame:textRect fontSize:fontSize textColor:defaultTextColor backgroudColor:defaultBgColor];
textRect = CGRectMake(xpadding, textRect.origin.y + ygap, pageWidth, height);
    textRect = [self addText:loanTenure
                   withFrame:textRect fontSize:fontSize textColor:defaultTextColor backgroudColor:defaultBgColor];
   textRect = CGRectMake(xpadding, textRect.origin.y + ygap, pageWidth, height);
    textRect = [self addText:emi
                   withFrame:textRect fontSize:fontSize textColor:defaultTextColor backgroudColor:defaultBgColor];
 textRect = CGRectMake(xpadding, textRect.origin.y + ygap, pageWidth, height);
    textRect = [self addText:totalInterest
                   withFrame:textRect fontSize:fontSize textColor:defaultTextColor backgroudColor:defaultBgColor];
 textRect = CGRectMake(xpadding, textRect.origin.y + ygap, pageWidth, height);
    textRect = [self addText:totalPayment
                   withFrame:textRect fontSize:fontSize textColor:defaultTextColor backgroudColor:defaultBgColor];
  textRect = CGRectMake(xpadding, textRect.origin.y + ygap, pageWidth, height);
    
    for (int section = 0; section < self.array.count; section++) {
        
        if (textRect.origin.y + height + ygap >= pageHeight) {
            count = 0;
            [self beginPDFPage];
            textRect = CGRectMake(xpadding, ypadding, width, height);
        }else{
            count++;
            textRect = CGRectMake(xpadding, textRect.origin.y + ygap, width, height);
        }
        
        
        
        YearInfo *yearInfo = (YearInfo*)self.array[section];
        
        
       
       
        CGContextSetFillColorWithColor(currentContext, [UIColor blackColor].CGColor );
        CGContextFillRect(currentContext, CGRectMake(0, textRect.origin.y, _pageSize.width, height));
        
        textRect = [self addText:yearInfo.year
                       withFrame:textRect fontSize:fontSize textColor:highlightedTextColor backgroudColor:highlightedBgColor];
        
        textRect = CGRectMake(textRect.origin.x + xgap, textRect.origin.y, width, height);
        textRect = [self addText:yearInfo.total_principal
                       withFrame:textRect fontSize:fontSize textColor:highlightedTextColor backgroudColor:highlightedBgColor];
        textRect = CGRectMake(textRect.origin.x + xgap, textRect.origin.y, width, height);
        
        textRect = [self addText:yearInfo.total_interest
                       withFrame:textRect fontSize:fontSize textColor:highlightedTextColor backgroudColor:highlightedBgColor];
        
        textRect = CGRectMake(textRect.origin.x + xgap, textRect.origin.y, width, height);
        
        textRect = [self addText:yearInfo.total_balance
                       withFrame:textRect fontSize:fontSize textColor:highlightedTextColor backgroudColor:highlightedBgColor];
        
        textRect = CGRectMake(xpadding, textRect.origin.y + textRect.size.height + 2, _pageSize.width - xpadding * 2, 2);
        
//        textRect = [self addLineWithFrame:textRect
//                                           withColor:[UIColor blackColor]];
        
        
        
        for (int row = 0; row < yearInfo.months.count; row++) {
            
            if (textRect.origin.y + height + ygap >= pageHeight) {
                count = 0;
                [self beginPDFPage];
                textRect = CGRectMake(xpadding, ypadding, width, height);
            }else{
                count++;
                textRect = CGRectMake(xpadding, textRect.origin.y+ygap, width, height);
            }
            
            
            MonthInfo *monthsInfo = (MonthInfo*) yearInfo.months[row];
            
            
           // NSString *tempStr = [NSString stringWithFormat:@"%@\t\t%@\t\t%@\t\t%@\n",monthsInfo.month,monthsInfo.principal,monthsInfo.interest,monthsInfo.balance];
            
            
            
            
            textRect = [self addText:monthsInfo.month
                           withFrame:textRect fontSize:fontSize textColor:defaultTextColor backgroudColor:defaultBgColor];
            textRect = CGRectMake(textRect.origin.x + xgap, textRect.origin.y, width, height);
            
            textRect = [self addText:monthsInfo.principal
                           withFrame:textRect fontSize:fontSize textColor:defaultTextColor backgroudColor:defaultBgColor];
            
            textRect = CGRectMake(textRect.origin.x + xgap, textRect.origin.y, width, height);
            
            textRect = [self addText:monthsInfo.interest
                           withFrame:textRect fontSize:fontSize textColor:defaultTextColor backgroudColor:defaultBgColor];
            textRect = CGRectMake(textRect.origin.x + xgap, textRect.origin.y, width, height);
            textRect = [self addText:monthsInfo.balance
                           withFrame:textRect fontSize:fontSize textColor:defaultTextColor backgroudColor:defaultBgColor];
            textRect = CGRectMake(xpadding, textRect.origin.y + textRect.size.height , _pageSize.width - xpadding * 2, 2);;
            
            textRect = [self addLineWithFrame:textRect
                                    withColor:[UIColor blackColor]];
            
            //str = [str stringByAppendingString:tempStr];
            
            
        }
        
        
    }
    
    
    
    /*CGRect blueLineRect = [self addLineWithFrame:CGRectMake(kPadding, textRect.origin.y + textRect.size.height + kPadding, _pageSize.width - kPadding*2, 4)
                                       withColor:[UIColor blueColor]];

    UIImage *anImage = [UIImage imageNamed:@"tree.jpg"];
    CGRect imageRect = [self addImage:anImage
                              atPoint:CGPointMake((_pageSize.width/2)-(anImage.size.width/2), blueLineRect.origin.y + blueLineRect.size.height + kPadding)];

    [self addLineWithFrame:CGRectMake(kPadding, imageRect.origin.y + imageRect.size.height + kPadding, _pageSize.width - kPadding*2, 4)
                 withColor:[UIColor redColor]];*/
    
    [self finishPDF];
    
    [self didClickOpenPDF];
    
    
}

- (void)beginPDFPage {
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, _pageSize.width, _pageSize.height), nil);
}


- (CGRect)addText:(NSString*)text withFrame:(CGRect)frame fontSize:(float)fontSize textColor:(UIColor*)textColor backgroudColor:(UIColor*) backgroundColor{

    UIFont *font = [UIFont systemFontOfSize:fontSize];
//    CGSize stringSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(_pageSize.width - 2*20-2*20, _pageSize.height - 2*20 - 2*20) lineBreakMode:UILineBreakModeWordWrap];
//    
//    float textWidth = frame.size.width;
//    
//    if (textWidth < stringSize.width)
//        textWidth = stringSize.width;
//    if (textWidth > _pageSize.width)
//        textWidth = _pageSize.width - frame.origin.x;
//    
//    CGRect renderingRect = CGRectMake(frame.origin.x, frame.origin.y, textWidth, stringSize.height);
    
    /*[text drawInRect:frame
            withFont:font
       lineBreakMode:UILineBreakModeWordWrap
           alignment:UITextAlignmentLeft];*/
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjects:
                                @[font, textColor,backgroundColor]
                                                           forKeys:
                                @[NSFontAttributeName, NSForegroundColorAttributeName,NSBackgroundColorAttributeName]];
    
    [text drawInRect:frame withAttributes:attributes];

    
    
    frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    return frame;
    

    
}

-   (CGRect)addLineWithFrame:(CGRect)frame withColor:(UIColor*)color {
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(currentContext, color.CGColor);
    
    CGContextSetLineWidth(currentContext, frame.size.height);
    
    CGPoint startPoint = frame.origin;
    CGPoint endPoint = CGPointMake(frame.origin.x + frame.size.width, frame.origin.y);
    
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(currentContext, endPoint.x, endPoint.y);
    
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    return frame;
    
    

}

- (CGRect)addImage:(UIImage*)image atPoint:(CGPoint)point {
    
    CGRect imageFrame = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [image drawInRect:imageFrame];
    return imageFrame;

}

- (void)setupPDFDocumentNamed:(NSString*)name Width:(float)width Height:(float)height {

    _pageSize = CGSizeMake(width, height);
    NSString *newPDFName = [NSString stringWithFormat:@"%@.pdf", name];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pdfPath = [documentsDirectory stringByAppendingPathComponent:newPDFName];
    UIGraphicsBeginPDFContextToFile(pdfPath, CGRectZero, nil);
    UIGraphicsBeginPDFContextToFile(pdfPath, CGRectZero, nil);
    
}

- (void)finishPDF {
    UIGraphicsEndPDFContext();
}


- (void)didClickOpenPDF {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pdfPath = [documentsDirectory stringByAppendingPathComponent:@"NewPDF.pdf"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:pdfPath]) {
        
        NSURL *url = [NSURL fileURLWithPath:pdfPath];
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
       
    }
}


-(void) actionClicked : (id) sender {
    
    UIActionSheet *activity = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Options", nil)  delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Send an E-Mail", nil) ,NSLocalizedString(@"Print the PDF", nil) , nil];
    [activity showInView:self.view];
    
}






-(void) emailPdf{
    [self sendMail];
}

-(void) sendMail{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
            
		}
		else
		{
			//[self launchMailAppOnDevice];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"Please Configure your mail account", nil)  delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles: nil];
            [alert show];
            
            
		}
	}
	else
	{
		//[self launchMailAppOnDevice];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"Please Configure your mail account", nil)  delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", nil) otherButtonTitles: nil];
        [alert show];
	}
    
}



#pragma mark - UIActionSheet delegates
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 2) {
        return;
    }
    else if (buttonIndex == 0) {
        [self emailPdf];
    }else if (buttonIndex == 1){
        [self printWebPage];
        
    }
    
    
}

#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields.
-(void)displayComposerSheet
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:NSLocalizedString(@"EMI", nil)];
	
    
	// Set up recipients
    //	NSArray *toRecipients = [NSArray arrayWithObject:@"karthikraja.r@calsoftlabs.com"];
    //	NSArray *ccRecipients = [NSArray arrayWithObjects:@"george@calsoftlabs.com", @"jana@calsoftlabs.com", nil];
    //	NSArray *bccRecipients = [NSArray arrayWithObject:@"satish@calsoftlabs.com"];
	
    //	[picker setToRecipients:toRecipients];
    //	[picker setCcRecipients:ccRecipients];
    //	[picker setBccRecipients:bccRecipients];
	
	// Attach an image to the email
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pdfPath = [documentsDirectory stringByAppendingPathComponent:@"NewPDF.pdf"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:pdfPath]) {
        
          NSData *myData = [NSData dataWithContentsOfFile:pdfPath];
         [picker addAttachmentData:myData mimeType:nil fileName:@"EMI PDF"];
        
    }

    
	NSString *emailBody = @"EMI";
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentViewController:picker animated:YES completion:nil];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:{
			NSString *text = @"Result: canceled";
            NSLog(@"text:%@",text);
			break;
        }
		case MFMailComposeResultSaved:{
			NSString *text = @"Result: saved";
            NSLog(@"text:%@",text);
			break;
        }
		case MFMailComposeResultSent:{
			NSString *text = @"Result: sent";
            NSLog(@"text:%@",text);
			break;
        }
		case MFMailComposeResultFailed:{
			NSString *text = @"Result: failed";
            NSLog(@"text:%@",text);
			break;
        }
		default:{
			NSString *text = @"Result: not sent";
            NSLog(@"text:%@",text);
			break;
        }
	}
	[self dismissModalViewControllerAnimated:YES];
}



#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
/*-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from Calsoft!";
	NSString *body = @"&body=It is raining in sunny California!";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}*/


#pragma mark - Printing


- (void)printWebPage
{
    UIPrintInteractionController *controller = [UIPrintInteractionController sharedPrintController];
    if(!controller){
        NSLog(@"Couldn't get shared UIPrintInteractionController!");
        return;
    }
    
    UIPrintInteractionCompletionHandler completionHandler =
    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if(!completed && error){
            NSLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
        }
    };
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pdfPath = [documentsDirectory stringByAppendingPathComponent:@"NewPDF.pdf"];
    
    
    if([[NSFileManager defaultManager] fileExistsAtPath:pdfPath]) {
        
        NSData *myData = [NSData dataWithContentsOfFile:pdfPath];
        controller.printingItem = myData;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [controller presentAnimated:YES completionHandler:completionHandler];
           // [controller presentFromRect:printButton.frame inView:printButton.superview
                               //animated:YES completionHandler:completionHandler];
        } else {
            [controller presentAnimated:YES completionHandler:completionHandler];
        }
        
        
    }
    

    
    
    
    
    
    
    // Obtain a printInfo so that we can set our printing defaults.
  /*  UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    // This application produces General content that contains color.
    printInfo.outputType = UIPrintInfoOutputGeneral;
    // We'll use the URL as the job name.
    printInfo.jobName = @"Sample Job";
    // Set duplex so that it is available if the printer supports it. We are
    // performing portrait printing so we want to duplex along the long edge.
    printInfo.duplex = UIPrintInfoDuplexLongEdge;
    // Use this printInfo for this print job.
    controller.printInfo = printInfo;
    
    // Be sure the page range controls are present for documents of > 1 page.
    controller.showsPageRange = YES;
    
    // This code uses a custom UIPrintPageRenderer so that it can draw a header and footer.
    APLPrintPageRenderer *myRenderer = [[APLPrintPageRenderer alloc] init];
    // The APLPrintPageRenderer class provides a jobtitle that it will label each page with.
    myRenderer.jobTitle = printInfo.jobName;
    // To draw the content of each page, a UIViewPrintFormatter is used.
    UIViewPrintFormatter *viewFormatter = [self.webView viewPrintFormatter];
    
#if SIMPLE_LAYOUT*/
    /*
     For the simple layout we simply set the header and footer height to the height of the
     text box containing the text content, plus some padding.
     
     To do a layout that takes into account the paper size, we need to do that
     at a point where we know that size. The numberOfPages method of the UIPrintPageRenderer
     gets the paper size and can perform any calculations related to deciding header and
     footer size based on the paper size. We'll do that when we aren't doing the simple
     layout.
     */
  /*  UIFont *font = [UIFont fontWithName:@"Helvetica" size:HEADER_FOOTER_TEXT_HEIGHT];
    CGSize titleSize = [myRenderer.jobTitle sizeWithFont:font];
    myRenderer.headerHeight = myRenderer.footerHeight = titleSize.height + HEADER_FOOTER_MARGIN_PADDING;
#endif
    [myRenderer addPrintFormatter:viewFormatter startingAtPageAtIndex:0];
    // Set our custom renderer as the printPageRenderer for the print job.
    controller.printPageRenderer = myRenderer;*/
    
    /*
     The method we use to present the printing UI depends on the type of UI idiom that is currently executing. Once we invoke one of these methods to present the printing UI, our application's direct involvement in printing is complete. Our custom printPageRenderer will have its methods invoked at the appropriate time by UIKit.
     */
    /*if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //        [controller presentFromBarButtonItem:self.printButton animated:YES completionHandler:completionHandler];  // iPad
    }
    else {
        [controller presentAnimated:YES completionHandler:completionHandler];  // iPhone
    }*/
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
