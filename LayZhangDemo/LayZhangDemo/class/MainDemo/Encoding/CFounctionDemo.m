//
//  CFounctionDemo.m
//  LayZhangDemo
//
//  Created by Lay on 2019/4/30.
//  Copyright © 2019 Zhanglei. All rights reserved.
//

#import "CFounctionDemo.h"
#import <JavaScriptCore/JavaScriptCore.h>

#if CGFLOAT_IS_DOUBLE
#define CGFloatValue doubleValue
#define numberWithCGFloat numberWithDouble
#else
#define CGFloatValue floatValue
#define numberWithCGFloat numberWithFloat
#endif

@interface NSObject(EncodeExtention)

@property (nonatomic, assign) void *cPointer;

@end

@implementation CFounctionDemo

// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
+ (id)objectWithCValue:(void *)src forType:(const char *)typeString
{
#define JP_FFI_RETURN_CASE(_typeString, _type, _selector)\
case _typeString:{\
_type v = *(_type *)src;\
return [NSNumber _selector:v];\
}

    switch (typeString[0]) {
            JP_FFI_RETURN_CASE('c', unsigned char, numberWithChar)   // 'c' -> char
            JP_FFI_RETURN_CASE('C', unsigned char, numberWithUnsignedChar) // 'C' -> unsignedChar
            JP_FFI_RETURN_CASE('s', short, numberWithShort) // 's' -> short
            JP_FFI_RETURN_CASE('S', unsigned short, numberWithUnsignedShort) // 'S' -> UnsignedShort
            JP_FFI_RETURN_CASE('i', int, numberWithInt) // 'i' -> int
            JP_FFI_RETURN_CASE('I', unsigned int, numberWithUnsignedInt) // 'I' -> unsignedInt
            JP_FFI_RETURN_CASE('l', long, numberWithLong)
            JP_FFI_RETURN_CASE('L', unsigned long, numberWithUnsignedLong)
            JP_FFI_RETURN_CASE('q', long long, numberWithLongLong)
            JP_FFI_RETURN_CASE('Q', unsigned long long, numberWithUnsignedLongLong)
            JP_FFI_RETURN_CASE('f', float, numberWithFloat) // 'f' -> float
            JP_FFI_RETURN_CASE('F', CGFloat, numberWithCGFloat) // 'F' -> double
            JP_FFI_RETURN_CASE('d', double, numberWithDouble) // 'd' -> double
            JP_FFI_RETURN_CASE('B', BOOL, numberWithBool) // 'B' -> Bool
        case '^': { //  c 指针
            NSObject *object = [NSObject new];
            object.cPointer = (*(void**)src);
            return object;
        }
        case '@': // @encode(NSObject *)
        case '#': { // class @encode(typeof([NSObject class]))
            return (__bridge id)(*(void**)src);
        }
        case '{': { // 结构体
            NSString *structName = [NSString stringWithCString:typeString encoding:NSASCIIStringEncoding];
            NSUInteger end = [structName rangeOfString:@"}"].location;
            if (end != NSNotFound) {
                structName = [structName substringWithRange:NSMakeRange(1, end - 1)];
                return structName;
//                NSDictionary *structDefine = [JPExtension registeredStruct][structName];
//                id dict = [JPExtension getDictOfStruct:src structDefine:structDefine];
//                id ret = [JSValue valueWithObject:dict inContext:[JPEngine context]];
//                return ret;
            }
        }
        default:
            return nil;
    }
    return nil;
}

//+ (NSDictionary *)getDictOfStruct:(void *)structData structDefine:(NSDictionary *)structDefine
//{
//    NSMutableDictionary *dict = @{}.mutableCopy;
//    NSArray *itemKeys = structDefine[@"keys"];
//    const char *structTypes = [structDefine[@"types"] cStringUsingEncoding:NSUTF8StringEncoding];
//    int position = 0;
//
//    for (NSString *itemKey in itemKeys) {
//        switch(*structTypes) {
//#define JP_STRUCT_DICT_CASE(_typeName, _type)   \
//case _typeName: { \
//size_t size = sizeof(_type); \
//_type *val = malloc(size);   \
//memcpy(val, structData + position, size);   \
//[dict setObject:@(*val) forKey:itemKey];    \
//free(val);  \
//position += size;   \
//break;  \
//}
//                JP_STRUCT_DICT_CASE('c', char)
//                JP_STRUCT_DICT_CASE('C', unsigned char)
//                JP_STRUCT_DICT_CASE('s', short)
//                JP_STRUCT_DICT_CASE('S', unsigned short)
//                JP_STRUCT_DICT_CASE('i', int)
//                JP_STRUCT_DICT_CASE('I', unsigned int)
//                JP_STRUCT_DICT_CASE('l', long)
//                JP_STRUCT_DICT_CASE('L', unsigned long)
//                JP_STRUCT_DICT_CASE('q', long long)
//                JP_STRUCT_DICT_CASE('Q', unsigned long long)
//                JP_STRUCT_DICT_CASE('f', float)
//                JP_STRUCT_DICT_CASE('F', CGFloat)
//                JP_STRUCT_DICT_CASE('N', NSInteger)
//                JP_STRUCT_DICT_CASE('U', NSUInteger)
//                JP_STRUCT_DICT_CASE('d', double)
//                JP_STRUCT_DICT_CASE('B', BOOL)
//
//            case '*':
//            case '^': {
//                size_t size = sizeof(void *);
//                void *val = malloc(size);
//                memcpy(val, structData + position, size);
//                [dict setObject:[JPBoxing boxPointer:val] forKey:itemKey];
//                position += size;
//                break;
//            }
//            case '{': {
//                NSString *subStructName = [NSString stringWithCString:structTypes encoding:NSASCIIStringEncoding];
//                NSUInteger end = [subStructName rangeOfString:@"}"].location;
//                if (end != NSNotFound) {
//                    subStructName = [subStructName substringWithRange:NSMakeRange(1, end - 1)];
//                    NSDictionary *subStructDefine = [JPExtension registeredStruct][subStructName];
//                    int size = sizeOfStructTypes(subStructDefine[@"types"]);
//                    NSDictionary *subDict = getDictOfStruct(structData + position, subStructDefine);
//                    [dict setObject:subDict forKey:itemKey];
//                    position += size;
//                    structTypes += end;
//                    break;
//                }
//            }
//        }
//        structTypes ++;
//    }
//}



@end
