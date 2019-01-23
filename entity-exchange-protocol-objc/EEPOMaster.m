
#import "EEPOMaster.h"
#import "EEPOConnection+Private.h"
#import "EEPOCommandParser.h"

@interface EEPOMaster() <GCDAsyncSocketDelegate>
@property (nonatomic) EEPOCommandParser *parser;
@end

@implementation EEPOMaster
@dynamic delegate;

- (instancetype)initWithPort:(NSUInteger)port {
    self = [super initPrivate];
    if (self) {
        _port = port;
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue() socketQueue:nil];
        _parser = [[EEPOCommandParser alloc] initWithVersion:EEPOProtocolVersion1]; // Always start parser with v1 to obtain slave's version
        [_socket acceptOnPort:port error:nil];
    }
    return self;
}

- (void)enqueueNextRead {
    [_socket readDataToData:[GCDAsyncSocket ZeroData] withTimeout:-1 tag:0];
}

#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    [self enqueueNextRead];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {

}

- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    _status = EEPOConnectionStatusConnected;
    [self.delegate connection:self didUpdateConnectionStatus:_status];
    [self enqueueNextRead];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    _status = EEPOConnectionStatusDisconnected;
    [_socket disconnect];
    [self.delegate connection:self didUpdateConnectionStatus:_status];
}
@end
