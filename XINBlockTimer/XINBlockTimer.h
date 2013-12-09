
//
// XINBlockTimer
// - runs blocks of code to identify performance bottlenecks
//

#import <Foundation/Foundation.h>

@interface XINBlockTimer : NSObject

+ (NSTimeInterval) timeBlock:(void (^)(void))block;

+ (NSTimeInterval) timeBlock:(void (^)(void))block withName:(NSString*)name;

+ (NSTimeInterval) timeBlock:(void (^)(void))block withName:(NSString*)name silent:(BOOL)isSilent repeat:(NSInteger)numberOfTimes;

/// sample NSLog output: "First interval is 501.730068x faster"
+ (void) compareTimeInterval:(NSTimeInterval)t1 withTimeInterval:(NSTimeInterval)t2;

@end
