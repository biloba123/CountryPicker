//
// Created by 吕晴阳 on 2018/10/2.
// Copyright (c) 2018 Lv Qingyang. All rights reserved.
//

#import "CPIndicatorBar.h"

static const CGFloat DefaultTextSize = 12.0;
static const CGFloat DefaultSpace = 2.0;

@interface CPIndicatorBar ()
@property(nonatomic) NSDictionary<NSAttributedStringKey, id> *attrs;
@property(nonatomic) int selectedIndex;
@end

@implementation CPIndicatorBar {

}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _textSize = DefaultTextSize;
        _selectedIndex = -1;
    }

    return self;
}

- (void)drawRect:(CGRect)rect {
    NSArray *texts = self.indicators;
    if (texts != nil && texts.count != 0) {
        CGFloat textSize = self.textSize;
        NSDictionary<NSAttributedStringKey, id> *attrs = self.attrs;
        NSString *text;

        for (int i = 0, count = texts.count; i < count; i++) {
            text = texts[i];
            CGSize size = [text sizeWithAttributes:attrs];
            CGPoint point = CGPointMake(textSize / 2 - size.width / 2, (CGFloat) ((i + 0.5) * (textSize + DefaultSpace) - size.height / 2));
            [text drawAtPoint:point withAttributes:attrs];
        }
    }
}

#pragma mark -- Getter & setter

- (void)setIndicators:(NSArray<NSString *> *)indicators {
    _indicators = indicators;

    CGSize size = CGSizeMake(self.textSize + DefaultSpace, (self.textSize + DefaultSpace) * indicators.count);

    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;

    [self setNeedsDisplay];
}

- (NSDictionary<NSAttributedStringKey, id> *)attrs {
    return @{
            NSFontAttributeName: [UIFont systemFontOfSize:self.textSize]
    };
}

#pragma mark -- Touch event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self updateSelectedIndex:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self updateSelectedIndex:touches];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    self.selectedIndex = -1;
}

- (void)updateSelectedIndex:(NSSet<UITouch *> *)touches {
    CGPoint point = [touches.anyObject locationInView:self];
    int curIndex = (int) (point.y / (self.textSize + DefaultSpace));
    if (curIndex < 0) {
        curIndex = 0;
    }
    if (curIndex >= self.indicators.count) {
        curIndex = self.indicators.count - 1;
    }
    if (curIndex != self.selectedIndex) {
        self.selectedIndex = curIndex;
        [self.delegate indicatorBar:self didSelectAtIndex:curIndex];
    }
}

@end