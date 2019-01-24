
#import <EntityExchangeProtocolObjC/EEPOConnection.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EEPOSlaveDelegate;

@interface EEPOSlave : EEPOConnection
@property (nonatomic, readonly) NSString *host;
@property (nonatomic, readonly) NSUInteger port;
@property (nonatomic, weak) id<EEPOConnectionDelegate, EEPOSlaveDelegate> delegate;

- (instancetype)initWithHost:(NSString *)host port:(NSUInteger)port NS_DESIGNATED_INITIALIZER;
- (void)disconnect:(BOOL)force;
@end

@protocol EEPOSlaveDelegate
@end

NS_ASSUME_NONNULL_END
