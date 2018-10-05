//
// Created by 吕晴阳 on 2018/9/29.
// Copyright (c) 2018 Lv Qingyang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CPCountry : NSObject
@property(nonatomic, copy) NSString *en;
@property(nonatomic, copy) NSString *zh;
@property(nonatomic, copy) NSString *locale;
@property(nonatomic) int code;

- (NSString *)description;

+ (instancetype)countryWithEn:(NSString *)en zh:(NSString *)zh locale:(NSString *)locale code:(int)code;
@end