
#import "EEPOConnection.h"
#import <CocoaAsyncSocket/CocoaAsyncSocket.h>

@interface EEPOConnection () {
@protected
    EEPOConnectionStatus _status;
    id __weak _delegate;
    GCDAsyncSocket *_socket;
}

- (instancetype)initPrivate;
@end
