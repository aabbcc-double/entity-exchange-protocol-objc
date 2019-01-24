
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSInteger EEPOCommandType;

typedef NS_ENUM(EEPOCommandType, EEPOCommandV1) {
    EEPOCommandV1Meta = 0,
    EEPOCommandV1Close = 1,
    EEPOCommandV1EAdd = 2,
    EEPOCommandV1EDelete = 3,
    EEPOCommandV1EModify = 4
};

typedef NS_ENUM(NSInteger, EEPOProtocolVersion) {
    EEPOProtocolVersion1 = 1
};

@interface EEPOCommandParser : NSObject
@property (nonatomic, readonly) EEPOProtocolVersion version;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithVersion:(EEPOProtocolVersion)version NS_DESIGNATED_INITIALIZER;

- (BOOL)parse:(NSData *)data into:(EEPOCommandType *)command args:(NSDictionary * __autoreleasing *)args withError:(NSError * __autoreleasing *)error;
- (BOOL)encode:(EEPOCommandType)command args:(NSDictionary *)dict data:(NSData * __autoreleasing *)data withError:(NSError * __autoreleasing *)error;
@end

NS_ASSUME_NONNULL_END
