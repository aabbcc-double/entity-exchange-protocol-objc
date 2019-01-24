
#import "EEPOEntity+Protected.h"
#import "EEPOMutableEntity.h"

@implementation EEPOEntity
- (id)copy {
    return [self mutableCopy];
}

- (id)mutableCopy {
    EEPOMutableEntity *copy = [[EEPOMutableEntity alloc] init];
    copy.data = [self.data mutableCopy];
    copy.lastLocalEditDate = self.lastLocalEditDate;
    copy.lastRemoteEditDate = self.lastRemoteEditDate;
    copy.isDeleted = self.isDeleted;
    return copy;
}
@end
