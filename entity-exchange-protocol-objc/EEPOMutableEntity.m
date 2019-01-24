
#import "EEPOMutableEntity.h"
#import "EEPOEntity+Protected.h"

@implementation EEPOMutableEntity
@dynamic data;
@dynamic lastLocalEditDate;
@dynamic lastRemoteEditDate;
@dynamic isDeleted;

- (void)setData:(NSMutableDictionary<NSString *,id> *)data {
    _data = data;
}

- (void)setLastLocalEditDate:(NSDate *)lastLocalEditDate {
    _lastLocalEditDate = lastLocalEditDate;
}

- (void)setLastRemoteEditDate:(NSDate *)lastRemoteEditDate {
    _lastRemoteEditDate = lastRemoteEditDate;
}

- (void)setIsDeleted:(BOOL)isDeleted {
    _isDeleted = isDeleted;
}

- (id)copy {
    return [self mutableCopy];
}
@end
