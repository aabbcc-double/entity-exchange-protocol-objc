
#import "EEPOCommandParser.h"

@implementation EEPOCommandParser
- (instancetype)initWithVersion:(EEPOProtocolVersion)version {
    self = [super init];
    if (self) {
        _version = version;
    }
    return self;
}

- (NSString *)commandStrForCommandV1:(EEPOCommandV1)command {
    switch (command) {
        case EEPOCommandV1Meta:
            return @"META";
        case EEPOCommandV1Close:
            return @"CLOSE";
        case EEPOCommandV1EDelete:
            return @"EDELETE";
        case EEPOCommandV1EModify:
            return @"EMODIFIED";
        case EEPOCommandV1EAdd:
            return @"EADD";
    }
}

- (BOOL)encode:(EEPOCommandType)command args:(NSDictionary *)dict data:(NSData *__autoreleasing *)data withError:(NSError * _Nullable __autoreleasing *)error {
    NSData *cmdData = [[self commandStrForCommandV1:command] dataUsingEncoding:NSUTF8StringEncoding];
    if (!dict) {
        dict = @{};
    }

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:error];

    NSMutableData *result = [NSMutableData data];
    [result appendData:cmdData];
    [result appendBytes:" " length:1];
    [result appendData:jsonData];
    [result appendBytes:"\0" length:1];

    *data = result;
    return YES;
}

- (BOOL)parse:(NSData *)data into:(EEPOCommandType *)command args:(NSDictionary *__autoreleasing *)args withError:(NSError * _Nullable __autoreleasing *)error {
    {
        char lastByte;
        [data getBytes:&lastByte range:NSMakeRange(data.length - 1, 1)];

        if (lastByte != 0) {
            *error = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{
                                                                                    NSLocalizedDescriptionKey: @"Last byte of the input is not equal to NUL"
                                                                                    }];

            return NO;
        }
    }

    NSString * __block commandStr;
    unsigned char *buffer = calloc(data.length, sizeof(unsigned char));
    NSAssert(buffer != NULL, @"Couldn't allocate enough memory");
    size_t __block argsOffset = 0;
    [data enumerateByteRangesUsingBlock:^(const void * _Nonnull bytes, NSRange byteRange, BOOL * _Nonnull stop) {
        unsigned char const *bytesP = bytes;

        for (size_t i = 0; i < byteRange.length; i++) {
            if (bytesP[i] == 0x20 && commandStr == nil) {
                commandStr = [NSString stringWithUTF8String:(const char *)buffer];
                memset(buffer, 0, data.length);
                argsOffset = i + 1;
                continue;
            } else if (bytesP[i] == 0x00) {
                NSAssert(*args == nil, @"Expected only one NUL terminator");

                NSString *jsonBuffer = [NSString stringWithUTF8String:(const char *)buffer];
                *args = [NSJSONSerialization JSONObjectWithData:[jsonBuffer dataUsingEncoding:NSUTF8StringEncoding] options:0 error:error];
            }

            buffer[byteRange.location + i - argsOffset] = bytesP[i];
        }
    }];
    free(buffer);

    if ([commandStr isEqualToString:@"META"]) {
        *command = EEPOCommandV1Meta;
    } else if ([commandStr isEqualToString:@"CLOSE"]) {
        *command = EEPOCommandV1Close;
    } else if ([commandStr isEqualToString:@"REFRESH"]) {

    } else if ([commandStr isEqualToString:@"EADD"]) {
        *command = EEPOCommandV1EAdd;
    } else if ([commandStr isEqualToString:@"EDELETE"]) {
        *command = EEPOCommandV1EDelete;
    } else if ([commandStr isEqualToString:@"EMODIFIED"]) {
        *command = EEPOCommandV1EModify;
    }

    return YES;
}
@end
