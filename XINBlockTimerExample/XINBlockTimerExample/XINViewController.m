//
//  XINViewController.m
//  XINBlockTimerExample
//
//  Created by Jason Moore on 12/9/2013.
//  Copyright (c) 2013 Jason Moore. All rights reserved.
//

#import "XINViewController.h"
#import "XINBlockTimer.h"

@interface XINViewController ()
@end

@implementation XINViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat fontSize = 12;
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    CGFloat labelHeight = fontSize * 2;
 
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, h/2-labelHeight, w, labelHeight)];
    [self.view addSubview:label];

    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, h/2+labelHeight, w, labelHeight)];
    [self.view addSubview:label2];

    // create attributed string manually and with HTML, results are output via NSLog
    
    NSTimeInterval t1 = [XINBlockTimer timeBlock:^{

        NSString *rawText = @"This is some bold text.";
        
        NSRange range = [rawText rangeOfString:@"bold"];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
        NSMutableAttributedString *text;
        text = [[NSMutableAttributedString alloc] initWithString:rawText attributes:attributes];
        [text addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:fontSize] range:range];
        
        label.attributedText = text;

    }];
    
    // create with HTML
    NSTimeInterval t2 = [XINBlockTimer timeBlock:^{

        NSString *html = @"<style>p {font: 12px HelveticaNeue; text-align: center;}</style><p>This is some <b>bold</b> text.</p>";
                                         
        NSAttributedString *text = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF8StringEncoding]
                                                                    options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                              NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                                              documentAttributes:nil
                                                                              error:nil];
                                         
        label2.attributedText = text;
        
        
    } withName:@"attributed string from HTML"];
    

    [XINBlockTimer compareTimeInterval:t1 withTimeInterval:t2];
    
}

@end
