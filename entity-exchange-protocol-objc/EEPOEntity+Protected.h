
#import "EEPOEntity.h"

@interface EEPOEntity () {
@protected
    NSDictionary<NSString *, id> *_data;
    NSDate * _Nullable _lastLocalEditDate;
    NSDate * _Nullable _lastRemoteEditDate;
    BOOL _isDeleted;
}
@end
