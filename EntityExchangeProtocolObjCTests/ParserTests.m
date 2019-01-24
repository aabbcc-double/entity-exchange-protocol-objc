
#import <XCTest/XCTest.h>
#import "../entity-exchange-protocol-objc/EEPOCommandParser.h"

@interface ParserTests : XCTestCase
@property (nonatomic) EEPOCommandParser *parser;
@end

@implementation ParserTests
- (void)setUp {
    self.parser = [[EEPOCommandParser alloc] initWithVersion:EEPOProtocolVersion1];
}

- (void)tearDown {

}

- (void)testParsingMetaCommand {
    EEPOCommandV1 command;
    NSDictionary<NSString *, id> *dict;
    NSError *error;

    NSData *data = [@"META {\"version\": \"v1\"}\0" dataUsingEncoding:NSUTF8StringEncoding];

    XCTAssertTrue([self.parser parse:data into:&command args:&dict withError:&error]);
    XCTAssertEqual(command, EEPOCommandV1Meta);
    XCTAssertNil(error);
    XCTAssertEqualObjects(dict, @{@"version": @"v1"});
}

- (void)testParsingCloseCommand {
    EEPOCommandV1 command;
    NSDictionary<NSString *, id> *dict;
    NSError *error;

    NSData *data = [@"CLOSE {\"reason\": \"user initiated\"}\0" dataUsingEncoding:NSUTF8StringEncoding];

    XCTAssertTrue([self.parser parse:data into:&command args:&dict withError:&error]);
    XCTAssertEqual(command, EEPOCommandV1Close);
    XCTAssertNil(error);
    XCTAssertEqualObjects(dict, @{@"reason": @"user initiated"});
}

- (void)testParsingEAddCommand {
    EEPOCommandV1 command;
    NSDictionary<NSString *, id> *dict;
    NSError *error;

    NSData *data = [@"EADD {\"some_data\": null, \"number\": 1234 }\0" dataUsingEncoding:NSUTF8StringEncoding];

    XCTAssertTrue([self.parser parse:data into:&command args:&dict withError:&error]);
    XCTAssertEqual(command, EEPOCommandV1EAdd);
    XCTAssertNil(error);
    id expected = @{
                    @"some_data": [NSNull null],
                    @"number": @(1234)
                    };
    XCTAssertEqualObjects(dict, expected);
}

- (void)testParsingEDeleteCommand {
    EEPOCommandV1 command;
    NSDictionary<NSString *, id> *dict;
    NSError *error;

    NSData *data = [@"EDELETE {\"some_data\": null, \"number\": 1234 }\0" dataUsingEncoding:NSUTF8StringEncoding];

    XCTAssertTrue([self.parser parse:data into:&command args:&dict withError:&error]);
    XCTAssertEqual(command, EEPOCommandV1EDelete);
    XCTAssertNil(error);
    id expected = @{
                    @"some_data": [NSNull null],
                    @"number": @(1234)
                    };
    XCTAssertEqualObjects(dict, expected);
}

- (void)testParsingEReplaceCommand {
    EEPOCommandV1 command;
    NSDictionary<NSString *, id> *dict;
    NSError *error;

    NSData *data = [@"EREPLACE {\"some_data\": null, \"number\": 1234 }\0" dataUsingEncoding:NSUTF8StringEncoding];

    XCTAssertTrue([self.parser parse:data into:&command args:&dict withError:&error]);
    XCTAssertEqual(command, EEPOCommandV1EReplace);
    XCTAssertNil(error);
    id expected = @{
                    @"some_data": [NSNull null],
                    @"number": @(1234)
                    };
    XCTAssertEqualObjects(dict, expected);
}

- (void)testEncodingMetaCommand {
    NSError *error;
    NSData *data;

    XCTAssertTrue([self.parser encode:EEPOCommandV1Meta args:@{@"reason": @"user"} data:&data withError:&error]);
    XCTAssertNil(error);
    XCTAssertNotNil(data);

    EEPOCommandV1 command;
    NSDictionary<NSString *, id> *dict;

    XCTAssertTrue([self.parser parse:data into:&command args:&dict withError:&error]);
    XCTAssertEqual(command, EEPOCommandV1Meta);
    XCTAssertNil(error);
    XCTAssertEqualObjects(dict, @{@"reason": @"user"});
}
@end
