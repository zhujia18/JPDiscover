//
//  JPSlideSegmentMenu.m
//  JPDiscover
//
//  Created by Jasper on 16/5/3.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "JPSlideSegmentMenu.h"
#import "GlobalMacroDefinition.h"

@interface JPSlideSegmentMenu() {
    UIView *line;
    NSArray *titleButtons;//元素为按钮
}

@end

@implementation JPSlideSegmentMenu

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat buttonWidth = CGRectGetWidth(frame) / titles.count;
        __block CGRect btnFrame = CGRectMake(0, 0, buttonWidth, CGRectGetHeight(frame));
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        for (NSString *currTitle in titles) {
            UIButton *currButton = [UIButton buttonWithType:UIButtonTypeCustom];
            currButton.frame = btnFrame;
            [currButton setTitle:currTitle forState:UIControlStateNormal];
            [currButton setTitleColor:UIColorFromRGB(0xff6400, 1) forState:UIControlStateSelected];
            [currButton setTitleColor:UIColorFromRGB(0x4e5257, 1) forState:UIControlStateNormal];
            currButton.titleLabel.font = [UIFont systemFontOfSize:16];
            currButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 7, 0);
            [currButton addTarget:self action:@selector(menuTap:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:currButton];
            [tempArr addObject:currButton];
            btnFrame = CGRectMake(CGRectGetMaxX(currButton.frame), CGRectGetMinY(btnFrame), CGRectGetWidth(btnFrame), CGRectGetHeight(btnFrame));
        }
        titleButtons = [NSArray arrayWithArray:tempArr];
        line = [[UIView alloc] init];
        line.backgroundColor = UIColorFromRGB(0xff6400, 1);
        [self addSubview:line];
        [self initLineFrameToIndex:0];
        UIButton *fitstTitleButton = [titleButtons firstObject];
        fitstTitleButton.selected = YES;
    }
    return self;
}

- (void)menuTap:(UIButton *)button {
    _selectIndex = [titleButtons indexOfObject:button];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    [self scrollLineToIndex:_selectIndex];
    [self setButtonWithIndex:_selectIndex];
}

- (void)initLineFrameToIndex:(NSInteger)index {
    UIButton *selectButton = [titleButtons objectAtIndex:index];
    NSString *selectTitle = selectButton.titleLabel.text;
    UIFont *selectFont = selectButton.titleLabel.font;
    CGFloat titleStrWidth = [selectTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, selectFont.lineHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:selectFont} context:nil].size.width;
    CGFloat buttonWidth = CGRectGetWidth(selectButton.frame);
    CGFloat newOriginX = (buttonWidth - titleStrWidth) / 2 + index * buttonWidth;
    line.frame = CGRectMake(newOriginX, CGRectGetHeight(self.frame) - 2, titleStrWidth, 2);
}

- (void)scrollLineToIndex:(NSInteger)index {
    UIButton *selectButton = [titleButtons objectAtIndex:index];
    NSString *selectTitle = selectButton.titleLabel.text;
    UIFont *selectFont = selectButton.titleLabel.font;
    CGFloat titleStrWidth = [selectTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, selectFont.lineHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:selectFont} context:nil].size.width;
    CGFloat buttonWidth = CGRectGetWidth(selectButton.frame);
    CGFloat newOriginX = (buttonWidth - titleStrWidth) / 2 + index * buttonWidth;
    CGFloat oldOriginX = CGRectGetMinX(line.frame);
    CGFloat springX = 0;
    if (newOriginX - oldOriginX > 0) {
        springX = 4;
    }else if(newOriginX - oldOriginX < 0) {
        springX = -4;
    }
    [UIView animateWithDuration:0.3f animations:^{
        line.frame = CGRectMake(newOriginX + springX, CGRectGetHeight(self.frame) - 2, titleStrWidth, 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2f animations:^{
            line.frame = CGRectMake(newOriginX, CGRectGetHeight(self.frame) - 2, titleStrWidth, 2);
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)setButtonWithIndex:(NSInteger)index {
    UIButton *button = [titleButtons objectAtIndex:index];
    for (UIButton *currButton in titleButtons) {
        currButton.selected = NO;
    }
    button.selected = YES;
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    [self scrollLineToIndex:_selectIndex];
    [self setButtonWithIndex:_selectIndex];
}

@end
