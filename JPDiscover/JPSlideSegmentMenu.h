//
//  JPSlideSegmentMenu.h
//  JPDiscover
//
//  Created by Jasper on 16/5/3.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPSlideSegmentMenu : UIControl

@property (nonatomic, assign) NSInteger selectIndex;

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@end
