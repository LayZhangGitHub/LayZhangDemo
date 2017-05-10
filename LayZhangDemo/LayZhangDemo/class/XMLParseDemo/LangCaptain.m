//
//  LangCaptain.m
//  ZhangleiIOSProject
//
//  Created by Allone on 16/8/8.
//  Copyright © 2016年 zhanglei. All rights reserved.
//

#import "LangCaptain.h"
#import "GDataXMLNode.h"

static LangCaptain *_langCaptainInstance = nil;

@interface LangCaptain()

@property (nonatomic, strong) NSMutableDictionary *errMap;
@property (nonatomic, strong) NSMutableDictionary *langMap;

@end

@implementation LangCaptain

+ (LangCaptain *)getInstance {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _langCaptainInstance = [[self alloc] init];
    });
    return _langCaptainInstance;
}

- (id)init {
    if (self = [super init]) {
        _errMap = [[NSMutableDictionary alloc] init];
        _langMap = [[NSMutableDictionary alloc] init];
        [self parse];
    }
    return self;
}

- (void)parse {
    [self parseErrMessageConfig];
    [self parseLangConfig];
}

- (void)parseErrMessageConfig{
    //获取工程目录的xml文件
    NSString *path = [NSString stringWithFormat:@"MessageErr"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:@"xml"];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    //使用NSData对象初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData error:nil];
    
    //获取根节点（resources）
    GDataXMLElement *rootElement = [doc rootElement];
    
    //获取根节点下的节点（Item）
    NSArray * items = [rootElement elementsForName:@"item"];
    [self parseElements:items atDictionary:_errMap];
}

- (void)parseLangConfig{
    //获取工程目录的xml文件
    NSString *path = [NSString stringWithFormat:@"MessageLang"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:@"xml"];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    //使用NSData对象初始化
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData error:nil];
    
    //获取根节点（resources）
    GDataXMLElement *rootElement = [doc rootElement];
    
    //获取根节点下的节点（Item）
    NSArray * items = [rootElement elementsForName:@"item"];
    [self parseElements:items atDictionary:_langMap];
}

- (void) parseElements:(NSArray *) items atArray:(NSMutableArray *)array {
    if(items && items.count > 0){
        for (GDataXMLElement * item in items){
            NSString *value = [item stringValue];
            [array addObject:value];
        }
    }
}

- (void) parseElements:(NSArray *) items atDictionary:(NSMutableDictionary *)dic {
    if(items && items.count > 0){
        for (GDataXMLElement * item in items){
            NSString *name = [[item attributeForName:@"name"] stringValue];
            NSString *value = [item stringValue];
            [dic setObject:value forKey:name];
        }
    }
}

#pragma getLang
- (NSString *)getLangByCode:(NSString *)code {
    return ([_langMap objectForKey:code] == nil) ? code : [_langMap objectForKey:code];
}

- (NSString *)getErrMessageByCode:(NSString *)code {
    return ([_errMap objectForKey:code] == nil) ? code : [_errMap objectForKey:code];
}

@end
