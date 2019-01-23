
#import <EntityExchangeProtocolObjC/EEPOConnection.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EEPOMasterDelegate;

@interface EEPOMaster : EEPOConnection
@property (nonatomic, readonly) NSUInteger port;
@property (nonatomic, weak) id<EEPOConnectionDelegate, EEPOMasterDelegate> delegate;

- (instancetype)initWithPort:(NSUInteger)port NS_DESIGNATED_INITIALIZER;
@end

@protocol EEPOMasterDelegate
@required
- (void)master:(EEPOMaster *)master didConnectClientWithMetaInfo:(NSDictionary<NSString *, id> *)info;
@end

NS_ASSUME_NONNULL_END
