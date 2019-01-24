
#import <Foundation/Foundation.h>
#import <EntityExchangeProtocolObjC/EEPOEntity.h>


NS_ASSUME_NONNULL_BEGIN

@interface EEPOStorage : NSObject
@property (nonatomic, readonly) NSArray<NSString *> *collections;

- (void)insertInto:(NSString *)collection entity:(EEPOEntity *)entity;
- (void)deleteFrom:(NSString *)collection withFilter:(NSDictionary<NSString *, id> *)filter;
- (void)replaceFrom:(NSString *)collection withFilter:(NSDictionary<NSString *, id> *)filter entity:(EEPOEntity *)entity;

@end

NS_ASSUME_NONNULL_END
