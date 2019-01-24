
#import <EntityExchangeProtocolObjC/EEPOEntity.h>

NS_ASSUME_NONNULL_BEGIN

@interface EEPOMutableEntity : EEPOEntity
@property (nonatomic, readwrite) NSMutableDictionary<NSString *, id> *data;
@property (nonatomic, readwrite, nullable) NSDate *lastLocalEditDate;
@property (nonatomic, readwrite, nullable) NSDate *lastRemoteEditDate;
@property (nonatomic, readwrite) BOOL isDeleted;
@end

NS_ASSUME_NONNULL_END
