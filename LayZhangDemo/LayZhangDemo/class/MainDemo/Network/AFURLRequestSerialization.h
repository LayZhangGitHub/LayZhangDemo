//
//  AFURLRequestSerialization.h
//  LayZhangDemo
//
//  Created by LayZhang on 2017/5/19.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AFURLRequestSerialization <NSObject, NSSecureCoding, NSCopying>

- (nullable NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                                        withParameters:(nullable id)parameters
                                                 error:(NSError * __nullable __autoreleasing *)error;
@end

@protocol AFMultipartFormData

- (BOOL)appendPartWithFileURL:(NSURL *)fileURL
                         name:(NSString *)name
                        error:(NSError * __nullable __autoreleasing *)error;

- (BOOL)appendPartWithFileURL:(NSURL *)fileURL
                         name:(NSString *)name
                     fileName:(NSString *)fileName
                     mimeType:(NSString *)mimeType
                        error:(NSError * __nullable __autoreleasing *)error;

- (void)appendPartWithInputStream:(nullable NSInputStream *)inputStream
                             name:(NSString *)name
                         fileName:(NSString *)fileName
                           length:(int64_t)length
                         mimeType:(NSString *)mimeType;

- (void)appendPartWithFileData:(NSData *)data
                          name:(NSString *)name
                      fileName:(NSString *)fileName
                      mimeType:(NSString *)mimeType;

- (void)appendPartWithFormData:(NSData *)data
                          name:(NSString *)name;

- (void)appendPartWithHeaders:(nullable NSDictionary *)headers
                         body:(NSData *)body;

- (void)throttleBandwidthWithPacketSize:(NSUInteger)numberOfBytes
                                  delay:(NSTimeInterval)delay;

@end

typedef NS_ENUM(NSUInteger, AFHTTPRequestQueryStringSerializationStyle) {
    AFHTTPRequestQueryStringDefaultStyle = 0,
};


@interface AFHTTPRequestSerializer : NSObject<AFURLRequestSerialization>

@property (nonatomic, assign) NSStringEncoding stringEncoding;

@property (nonatomic, assign) BOOL allowsCellularAccess;

@property (nonatomic, assign) NSURLRequestCachePolicy cachePolicy;

@property (nonatomic, assign) BOOL HTTPShouldHandleCookies;

@property (nonatomic, assign) BOOL HTTPShouldUsePipelining;

@property (nonatomic, assign) NSURLRequestNetworkServiceType networkServiceType;

@property (nonatomic, assign) NSTimeInterval timeoutInterval;

@property (readonly, nonatomic, strong) NSDictionary *HTTPRequestHeaders;

+ (instancetype)serializer;

- (void)setValue:(nullable NSString *)value
forHTTPHeaderField:(NSString *)field;

- (nullable NSString *)valueForHTTPHeaderField:(NSString *)field;

- (void)setAuthorizationHeaderFieldWithUsername:(NSString *)username
                                       password:(NSString *)password;

- (void)setAuthorizationHeaderFieldWithToken:(NSString *)token DEPRECATED_ATTRIBUTE;

- (void)clearAuthorizationHeader;

@property (nonatomic, strong) NSSet *HTTPMethodsEncodingParametersInURI;

- (void)setQueryStringSerializationWithStyle:(AFHTTPRequestQueryStringSerializationStyle)style;

- (void)setQueryStringSerializationWithBlock:(nullable NSString * (^)(NSURLRequest *request, id parameters, NSError * __autoreleasing *error))block;

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(id)parameters DEPRECATED_ATTRIBUTE;

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(nullable id)parameters
                                     error:(NSError * __nullable __autoreleasing *)error;

- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method
                                              URLString:(NSString *)URLString
                                             parameters:(NSDictionary *)parameters
                              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block DEPRECATED_ATTRIBUTE;

- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method
                                              URLString:(NSString *)URLString
                                             parameters:(nullable NSDictionary *)parameters
                              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                                  error:(NSError * __nullable __autoreleasing *)error;

- (NSMutableURLRequest *)requestWithMultipartFormRequest:(NSURLRequest *)request
                             writingStreamContentsToFile:(NSURL *)fileURL
                                       completionHandler:(nullable void (^)(NSError * __nullable error))handler;

@end

@interface AFJSONRequestSerializer : AFHTTPRequestSerializer

@property (nonatomic, assign) NSJSONWritingOptions writingOptions;

+ (instancetype)serializerWithWritingOptions:(NSJSONWritingOptions)writingOptions;

@end

@interface AFPropertyListRequestSerializer : AFHTTPRequestSerializer

@property (nonatomic, assign) NSPropertyListFormat format;

@property (nonatomic, assign) NSPropertyListWriteOptions writeOptions;

+ (instancetype)serializerWithFormat:(NSPropertyListFormat)format
                        writeOptions:(NSPropertyListWriteOptions)writeOptions;

@end


FOUNDATION_EXPORT NSString * const AFURLRequestSerializationErrorDomain;
FOUNDATION_EXPORT NSString * const AFNetworkingOperationFailingURLRequestErrorKey;
FOUNDATION_EXPORT NSUInteger const kAFUploadStream3GSuggestedPacketSize;
FOUNDATION_EXPORT NSTimeInterval const kAFUploadStream3GSuggestedDelay;

NS_ASSUME_NONNULL_END


