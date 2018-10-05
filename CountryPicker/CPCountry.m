//
// Created by 吕晴阳 on 2018/9/29.
// Copyright (c) 2018 Lv Qingyang. All rights reserved.
//

#import "CPCountry.h"


@implementation CPCountry {

}
- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.en=%@", self.en];
    [description appendFormat:@", self.zh=%@", self.zh];
    [description appendFormat:@", self.locale=%@", self.locale];
    [description appendFormat:@", self.code=%i", self.code];
    [description appendString:@">"];
    return description;
}

+ (instancetype)countryWithEn:(NSString *)en zh:(NSString *)zh locale:(NSString *)locale code:(int)code {
    CPCountry *country = [CPCountry new];
    country.en = en;
    country.zh = zh;
    country.locale = locale;
    country.code = code;
    return country;
}


@end