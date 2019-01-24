
#import <XCTest/XCTest.h>
#import <EntityExchangeProtocolObjC/EntityExchangeProtocolObjc.h>
#import <OCMockito/OCMockito.h>
#import <OCHamcrest/OCHamcrest.h>

@protocol MasterAndConnectionDelegate <EEPOConnectionDelegate, EEPOMasterDelegate>
@end

@interface MasterTests : XCTestCase
@property (nonatomic) EEPOMaster *master;
@end

@implementation MasterTests
- (void)setUp {
    self.master = [[EEPOMaster alloc] initWithPort:9033];
}

- (void)tearDown {

}

- (void)testConnectingSlave {
    id<EEPOMasterDelegate> delegate = mockProtocol(@protocol(MasterAndConnectionDelegate));
    self.master.delegate = delegate;

    EEPOSlave *slave = [[EEPOSlave alloc] initWithHost:@"localhost" port:9033];

    XCTestExpectation *expectation = [self expectationWithDescription:@"Expect sockets to connect"];
    [expectation setInverted:YES];
    [self waitForExpectations:@[expectation] timeout:5];

    [verify(delegate) connection:self.master didUpdateConnectionStatus:EEPOConnectionStatusConnected];
    [verify(delegate) master:self.master didConnectClientWithMetaInfo:@{
                                                                        @"version": @"v1.0",
                                                                        @"impl": @"EntityExchangeProtocolObjC v1.0.0"
                                                                        }];

}
@end
