//
//  JPDiscoverCellBaseView.m
//  JPDiscover
//
//  Created by Jasper on 16/3/25.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "JPDiscoverCellBaseModule.h"

@implementation JPDiscoverCellBaseModule

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

+ (CGFloat)countHeightWithModel:(JPDiscoverModel *)model width:(CGFloat)width {
    return 0;
}

@end
