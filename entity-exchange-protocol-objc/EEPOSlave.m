
#import "EEPOSlave.h"
#import "EEPOConnection+Private.h"
#import "EEPOCommandParser.h"

@interface EEPOSlave () <GCDAsyncSocketDelegate>
@property (nonatomic) EEPOCommandParser *parser;
@end

@implementation EEPOSlave
@dynamic delegate;

- (instancetype)initWithHost:(NSString *)host port:(NSUInteger)port {
    self = [super initPrivate];
    if (self) {
        _host = host;
        _port = port;

        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue() socketQueue:nil];
        [_socket connectToHost:host onPort:port error:nil];
        _status = EEPOConnectionStatusConnecting;
        _parser = [[EEPOCommandParser alloc] initWithVersion:EEPOProtocolVersion1];
    }
    return self;
}

- (void)enqueueNextRead {
    [_socket readDataToData:[GCDAsyncSocket ZeroData] withTimeout:-1 tag:0];
}

#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    _status = EEPOConnectionStatusConnected;
    [self.delegate connection:self didUpdateConnectionStatus:_status];

    NSData *data;
    [self.parser encode:EEPOCommandV1Meta args:@{
                                                 @"version": @"v1.0",
                                                 @"impl": @"EntityExchangeProtocolObjC v1.0.0"
                                                 } data:&data withError:nil];
    [_socket writeData:data withTimeout:-1 tag:0];
    [self enqueueNextRead];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    [self enqueueNextRead];
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    
}
@end
