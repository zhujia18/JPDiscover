//
//  JPDiscoverCellShareModule.h
//  JPDiscover
//
//  Created by Jasper on 16/3/25.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "JPDiscoverCellBaseModule.h"

@interface JPDiscoverCellShareModule : JPDiscoverCellBaseModule

@property (nonatomic, copy) JPDiscoverTapBlock tapBlock;

- (id)initWithWidth:(CGFloat)widthTemp;

- (void)setDataWithModel:(JPDiscoverShareModel *)model;

@end
