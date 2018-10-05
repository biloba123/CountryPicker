//
// Created by 吕晴阳 on 2018/10/2.
// Copyright (c) 2018 Lv Qingyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CPIndicatorBar;

@class CPIndicatorBarDelegate;

@protocol CPIndicatorBarDelegate
@required
- (void)indicatorBar:(CPIndicatorBar *)indicatorBar didSelectAtIndex:(int)index;
@end

@interface CPIndicatorBar : UIView
@property(nonatomic, copy) NSArray<NSString *> *indicators;
@property(nonatomic) CGFloat textSize;
@property(nonatomic, weak) id <CPIndicatorBarDelegate> delegate;
@end