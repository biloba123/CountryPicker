//
//  CPCountryTableViewController.h
//  CountryPicker
//
//  Created by 吕晴阳 on 2018/9/30.
//  Copyright © 2018 Lv Qingyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPCountry;
typedef void (^CountryCallback)(CPCountry *country);
NS_ASSUME_NONNULL_BEGIN

@interface CPCountryTableViewController : UIViewController
@property (nonatomic) CountryCallback callback;
+ (void)pickWithViewController:(UIViewController *)viewController callback:(void (^)(CPCountry *country)) callback;
@end

NS_ASSUME_NONNULL_END
