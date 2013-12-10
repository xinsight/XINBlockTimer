XINBlockTimer
=============

Time blocks of code to identify performance bottlenecks.

## Usage

Wrap the code you want to time in `+[XINBlockTimer timeBlock:]`.

```objc

#import "XINBlockTimer.h"

// add attributed text to a label

[XINBlockTimer timeBlock:^{

  NSString *rawText = @"This is some bold text.";
  
  NSRange range = [rawText rangeOfString:@"bold"];
  
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.alignment = NSTextAlignmentCenter;
  
  NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle, 
                               NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
  NSMutableAttributedString *text;
  text = [[NSMutableAttributedString alloc] initWithString:rawText attributes:attributes];
  [text addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:fontSize] range:range];
  
  label.attributedText = text;

}];
```

You can also name each block, which shows up in the output.

```objc
[XINBlockTimer timeBlock:^{

  // For example: time creating an attributed string with HTML //
  NSString *html = @"<style>p {font: 12px HelveticaNeue; text-align: center;}</style>"
                   @"<p>This is some <b>bold</b> text.</p>";

  NSDictionary *optionsDict = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
  NSAttributedString *text = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:optionsDict
                                                     documentAttributes:nil
                                                                  error:nil];
  
  label2.attributedText = text;

} withName:@"attributed string from HTML"];
```

Output via `NSLog`:

```
XINBlockTimer: 0.000381 sec
attributed string from HTML: 0.174494 sec
```

If you keep the returned `NSTimeInterval`s, you can pass them to a reporting method that summarizes your findings.

```objc

NSTimeInterval t1 = [XINBlockTimer timeBlock:^{ ... }];
NSTimeInterval t2 = [XINBlockTimer timeBlock:^{ ... }];

[XINBlockTimer compareTimeInterval:t1 withTimeInterval:t2];
```

Sample Output:

```
First interval is 457.989501x faster
```

```
Difference between intervals is insignificant: 0.000002
```

See the enclosed example project for more usage examples.

## License

XINBlockTimer is available under the MIT license. See the LICENSE file for more info.
