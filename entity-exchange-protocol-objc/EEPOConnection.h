
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EEPOConnectionDelegate;

typedef NS_ENUM(NSInteger, EEPOConnectionStatus) {
    EEPOConnectionStatusConnecting,
    EEPOConnectionStatusConnected,
    EEPOConnectionStatusDisconnected,
    EEPOConnectionStatusClosed
};

@interface EEPOConnection : NSObject
@property (nonatomic, readonly) EEPOConnectionStatus status;
@property (nonatomic, weak) id<EEPOConnectionDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;
@end

@protocol EEPOConnectionDelegate

@optional
- (void)connection:(EEPOConnection *)connection didUpdateConnectionStatus:(EEPOConnectionStatus)status;
@end

NS_ASSUME_NONNULL_END
