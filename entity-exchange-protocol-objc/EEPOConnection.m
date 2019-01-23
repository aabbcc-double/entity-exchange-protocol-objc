
#import "EEPOConnection.h"
#import "EEPOConnection+Private.h"

@implementation EEPOConnection
- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _status = EEPOConnectionStatusDisconnected;
    }
    return self;
}
@end
