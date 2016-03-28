//
//  JPDiscoverCellVideoModule.h
//  JPDiscover
//
//  Created by Jasper on 16/3/25.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "JPDiscoverCellBaseModule.h"

@interface JPDiscoverCellVideoModule : JPDiscoverCellBaseModule

@property (nonatomic, copy) JPDiscoverTapBlock playVideoBlock;

- (id)initWithWidth:(CGFloat)widthTemp;

- (void)setDataWithModel:(JPDiscoverVideoModel *)model;

@end
