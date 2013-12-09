
#import "XINBlockTimer.h"
#import <QuartzCore/QuartzCore.h>

@implementation XINBlockTimer

+ (NSTimeInterval) timeBlock:(void (^)(void))block;
{
    return [self timeBlock:block withName:nil silent:NO repeat:1];
}

+ (NSTimeInterval) timeBlock:(void (^)(void))block withName:(NSString*)name;
{
    return [self timeBlock:block withName:name silent:NO repeat:1];
}

+ (NSTimeInterval) timeBlock:(void (^)(void))block withName:(NSString*)name silent:(BOOL)isSilent repeat:(NSInteger)numberOfTimes;
{
	double startTime = CACurrentMediaTime();

    for (NSInteger i=0; i<numberOfTimes; i++) {
        block();
    }
    
	double diff = CACurrentMediaTime() - startTime;
    NSString *repeatString = (numberOfTimes > 1 ? [NSString stringWithFormat:@" (%dx)", numberOfTimes] : @"");
    
    if (isSilent == NO) {
        NSString *nameOrClassName = (name ? name : NSStringFromClass(self));
        NSLog(@"%@: %f sec%@", nameOrClassName, diff, repeatString);
    }
    return diff;
}

+ (void) compareTimeInterval:(NSTimeInterval)t1 withTimeInterval:(NSTimeInterval)t2;
{
    double insignificantDifference = 0.00001;
    double diff = fabs(t1-t2);
    if (diff < insignificantDifference) {
        NSLog(@"Difference between intervals is insignificant: %f", diff);
        return;
    }
    
    NSString *firstOrSecond = (t1 < t2 ? @"First" : @"Second");
    double multiple = (t1 > t2 ? t1/t2 : t2/t1);
    NSLog(@"%@ interval is %fx faster", firstOrSecond, multiple);
}

@end
