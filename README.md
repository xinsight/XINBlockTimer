XINBlockTimer
=============

Time blocks of code to identify performance bottlenecks.

## Usage

Wrap the code you want to time in `+[XINBlockTimer timeBlock:]`.

```objc

#import "XINBlockTimer.h"

[XINBlockTimer timeBlock:^{

	// For example: time creating an attributed string with HTML //
    NSString *html = @"<style>p {font: 12px HelveticaNeue; text-align: center;}</style><p>This is some <b>bold</b> text.</p>";
                                     
    NSAttributedString *text = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                          NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                                          documentAttributes:nil
                                                                          error:nil];
                                     
    label2.attributedText = text;
                
} withName:@"attributed string from HTML"];
```

Output via `NSLog`:

```
attributed string from HTML: 0.174494 sec
```

If you track the returned `NSTimeInterval`, you can pass them to a reporting method that summarizes your findings.

```objc


NSTimeInterval t1 = [XINBlockTimer timeBlock:^{ ... }];
NSTimeInterval t2 = [XINBlockTimer timeBlock:^{ ... }];

[XINBlockTimer compareTimeInterval:t1 withTimeInterval:t2];
```

Sample Output:

```
First interval is 100.520548x faster
Difference between intervals is insignificant: 0.000002
```

See the enclosed example project for more usage examples.

## License

XINBlockTimer is available under the MIT license. See the LICENSE file for more info.
