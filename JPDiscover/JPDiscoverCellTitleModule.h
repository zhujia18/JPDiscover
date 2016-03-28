//
//  JPDiscoverCellTitleView.h
//  JPDiscover
//
//  Created by Jasper on 16/3/25.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "JPDiscoverCellBaseModule.h"

@interface JPDiscoverCellTitleModule : JPDiscoverCellBaseModule

@property (nonatomic, copy) JPDiscoverTapBlock tapHeadBlock;

- (id)initWithWidth:(CGFloat)widthTemp;

- (void)setDataWithModel:(JPDiscoverTitleModel *)model;

@end
