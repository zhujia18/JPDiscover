//
//  JPDiscoverCellBaseView.h
//  JPDiscover
//
//  Created by Jasper on 16/3/25.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JPDiscoverModel.h"

#define load_default_head @"load_default_head"
#define load_default_image @"load_default_image"
#define UIColorRGB(r,g,b) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1])
#define UIColorFromRGB(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@interface JPDiscoverCellBaseModule : UIView

typedef void(^JPDiscoverBeLoadImageBlock) (UIImageView *beLoadIamgeView, NSString *beLoadImageUrlStr, NSString *placeholderImageName);
typedef void(^JPDiscoverTapBlock) ();

@property(nonatomic, copy) JPDiscoverBeLoadImageBlock loadImageBlock;
@property(nonatomic, assign, readonly) CGFloat height;

+ (CGFloat)countHeightWithModel:(JPDiscoverModel *)model width:(CGFloat)width;

@end
