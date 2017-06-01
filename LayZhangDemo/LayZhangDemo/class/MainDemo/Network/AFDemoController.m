////
////  AFDemoController.m
////  LayZhangDemo
////
////  Created by LayZhang on 2017/5/19.
////  Copyright © 2017年 Zhanglei. All rights reserved.
////
//
//#import "AFDemoController.h"
//#import "AFURLRequestSerialization.h"
//
//// base64 
//NSString * AFBase64EncodedStringFromString(NSString *string) {
//    NSData *data = [NSData dataWithBytes:[string UTF8String] length:[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
//    NSUInteger length = [data length];
//    NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
//    
//    uint8_t *input = (uint8_t *)[data bytes];
//    uint8_t *output = (uint8_t *)[mutableData mutableBytes];
//    
//    for (NSUInteger i = 0; i < length; i += 3) {
//        NSUInteger value = 0;
//        for (NSUInteger j = i; j < (i + 3); j++) {
//            value <<= 8;
//            if (j < length) {
//                value |= (0xFF & input[j]);
//            }
//        }
//        
//        static uint8_t const kAFBase64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
//        
//        NSUInteger idx = (i / 3) * 4;
//        output[idx + 0] = kAFBase64EncodingTable[(value >> 18) & 0x3F];
//        output[idx + 1] = kAFBase64EncodingTable[(value >> 12) & 0x3F];
//        output[idx + 2] = (i + 1) < length ? kAFBase64EncodingTable[(value >> 6)  & 0x3F] : '=';
//        output[idx + 3] = (i + 2) < length ? kAFBase64EncodingTable[(value >> 0)  & 0x3F] : '=';
//    }
//    
//    return [[NSString alloc] initWithData:mutableData encoding:NSASCIIStringEncoding];
//}
//
//@interface AFDemoController ()
//
//@end
//
//@implementation AFDemoController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    NSString *string = AFBase64EncodedStringFromString(@"123");
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
