
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EEPOEntity : NSObject
@property (nonatomic, readonly) NSDictionary<NSString *, id> *data;
@property (nonatomic, readonly, nullable) NSDate *lastLocalEditDate;
@property (nonatomic, readonly, nullable) NSDate *lastRemoteEditDate;
@property (nonatomic, readonly) BOOL isDeleted;
@end

NS_ASSUME_NONNULL_END
