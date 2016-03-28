//
//  JPDiscoverCellCommentView.h
//  JPDiscover
//
//  Created by Jasper on 16/3/25.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "JPDiscoverCellBaseModule.h"

@interface JPDiscoverCellCommentModule : JPDiscoverCellBaseModule

@property (nonatomic, copy) JPDiscoverTapBlock tapPraiseBlock;
@property (nonatomic, copy) JPDiscoverTapBlock tapCommentBlock;

- (id)initWithWidth:(CGFloat)widthTemp;

- (void)setDataWithModel:(JPDiscoverCommentsModel *)model;

@end
