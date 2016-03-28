//
//  JPDiscoverModel.m
//  JPDiscover
//
//  Created by Jasper on 16/3/25.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "JPDiscoverModel.h"

@implementation JPDiscoverModel

+ (JPDiscoverModel *)getTestModel {
    JPDiscoverModel *testModel = [[JPDiscoverModel alloc] init];
    testModel.titleModel = [JPDiscoverTitleModel getTestModel];
    testModel.contentModel = [JPDiscoverContentModel getTestModel];
    
    int modelSwitch = (arc4random() % 3);
    switch (modelSwitch) {
        case 0:
        {
            testModel.imageModel = [JPDiscoverImageModel getTestModel];
        }
            break;
        case 1:
        {
            testModel.shareModel = [JPDiscoverShareModel getTestModel];
        }
            break;
        case 2:
        {
            testModel.videoModel = [JPDiscoverVideoModel getTestModel];
        }
            break;
            
        default: {
            
        }
            break;
    }
    
    testModel.commentsModel = [JPDiscoverCommentsModel getTestModel];
    return testModel;
}

@end

#pragma mark 标题模块model

@implementation JPDiscoverTitleModel

+ (JPDiscoverTitleModel *)getTestModel {
    JPDiscoverTitleModel *testModel = [[JPDiscoverTitleModel alloc] init];
    testModel.headIconUrl = @"http://m.tiebaimg.com/timg?wapp&quality=80&size=b150_150&subsize=20480&cut_x=0&cut_w=0&cut_y=0&cut_h=0&sec=1369815402&srctrace&di=5b2d5a29c3f1ab5014e713cc77165363&wh_rate=null&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fpic%2Fitem%2Fac4bd11373f08202c7f1eb4c48fbfbedab641b65.jpg";
    testModel.username = @"Jasper";
    testModel.time = @"2016-3-27";
    return testModel;
}

@end

#pragma mark 文本主题模块model

@implementation JPDiscoverContentModel

+ (JPDiscoverContentModel *)getTestModel {
    JPDiscoverContentModel *testModel = [[JPDiscoverContentModel alloc] init];
    testModel.content = @"这个是一个类似朋友圈、发现页等Feed的样式效果 + 网易新闻的侧滑效果（暂未更新上来），实现方式是我自己设计的，之前很多人群里问过我类似的效果怎么实现，每次我都是光用嘴说给大家听，想想这次项目中正好用到这个需求，于是便自己做了一个，之后从项目中重构出来一份Demo给大家，精力有限，其他功能陆续更新上来，也会陆续完善注释、框架图等等，大家看个乐呵就好，互相交流交流思路，作为新手，写的不好请轻喷，如果有写错的地方，请issue~谢谢！";
    return testModel;
}

@end

#pragma mark 图片模块model

@implementation JPDiscoverImageModel

+ (JPDiscoverImageModel *)getTestModel {
    JPDiscoverImageModel *testModel = [[JPDiscoverImageModel alloc] init];
    NSMutableArray *imageLib = [NSMutableArray arrayWithObjects:@"http://i9.download.fd.pchome.net/g1/M00/12/1C/ooYBAFbpI0mICtMaAAOO40OgNKEAAC4CAPum6AAA477169.jpg",
                                @"http://i4.download.fd.pchome.net/g1/M00/0F/0D/ooYBAFU_PFyIGi8eAAPotewjNYoAACcOgI_fFgAA-jN703.jpg",
                                @"http://i5.download.fd.pchome.net/g1/M00/0C/1E/ooYBAFR-sMmIPII9AAQ44H7d-mkAACIYAFCbLMABDj4877.jpg",
                                @"http://i4.download.fd.pchome.net/g1/M00/0C/1E/oYYBAFR-sOeIF8DvAALddopx87EAACIYAGfCF0AAt2O799.jpg",
                                @"http://i2.download.fd.pchome.net/g1/M00/12/05/oYYBAFZX48CIZvN4AAdCTLqK6OEAACyRANW6YIAB0Jk130.jpg",
                                @"http://i9.download.fd.pchome.net/g1/M00/10/0F/ooYBAFWVBg2IPOHiAAQCRrcQQhQAACkqQNHyk4ABAJe933.jpg",
                                @"http://i6.download.fd.pchome.net/g1/M00/0E/01/oYYBAFTRvsWIWgGrAB0ClZt8mJgAACRUwCT534AHQKt428.jpg",
                                @"http://i2.download.fd.pchome.net/g1/M00/0D/1A/oYYBAFTAw-yIPJ7QABQEd17ze4kAACPnQEZdIYAFASP791.jpg",
                                @"http://i9.download.fd.pchome.net/g1/M00/0C/15/oYYBAFRuldCID7I_AAW9FwJLAHoAACGQQLxMdAABb0v093.jpg", nil];
    
    int imageCount = arc4random() % 10;//生成图片个数
    NSMutableArray *beReturnImageArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageCount; i+=1) {
        int imageIndex = (arc4random() % imageLib.count);//生成随机插入图片的下标
        NSString *imageUrl = [imageLib objectAtIndex:imageIndex];
        [beReturnImageArr addObject:imageUrl];
        [imageLib removeObjectAtIndex:imageIndex];
    }
    
    if (beReturnImageArr.count == 1) {
        int modelSwitch = arc4random() % 2;
        switch (modelSwitch) {
            case 0:
            {
                testModel.sizeArr = [NSArray arrayWithObjects:@"800x600", nil];
            }
                break;
            case 1:
            {
                testModel.sizeArr = [NSArray arrayWithObjects:@"1080x1920", nil];
            }
                break;
            default: {
                
            }
                break;
        }
    }
    testModel.imageUrlArr = beReturnImageArr;
    return testModel;
}

@end

#pragma mark 分享模块model

@implementation JPDiscoverShareModel

+ (JPDiscoverShareModel *)getTestModel {
    JPDiscoverShareModel *testModel = [[JPDiscoverShareModel alloc] init];
    testModel.thumImageUrl = @"http://imgsrc.baidu.com/forum/w%3D580/sign=c27bcbac00082838680ddc1c8899a964/c98ce00e7bec54e7d3d57aadbe389b504ec26af8.jpg";
    testModel.title = @"一个iOS入门程序猿";
    testModel.summary = @"弱弱的打个广告QQ群：151853771。博客：http://zasper.net";
    return testModel;
}

@end

#pragma mark 视频模块model

@implementation JPDiscoverVideoModel

+ (JPDiscoverVideoModel *)getTestModel {
    JPDiscoverVideoModel *testModel = [[JPDiscoverVideoModel alloc] init];
    int modelSwitch = arc4random() % 2;
    switch (modelSwitch) {
        case 0:
        {
            testModel.thumImageUrl = @"http://imgsrc.baidu.com/baike/pic/item/948bcfc8794b0e5b7e3e6f3f.jpg";
            testModel.width = 800;
            testModel.height = 452;
        }
            break;
        case 1:
        {
            testModel.thumImageUrl = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1459132936&di=904bf099ce60bb2aaa231b15d9b1fa93&src=http://img1.mtime.cn/pi/d/2007/44/200710300364.61434255.jpg";
            testModel.width = 500;
            testModel.height = 753;
        }
            break;
        default: {
            
        }
            break;
    }
    return testModel;
}

@end

#pragma mark 评论点赞模块model

@implementation JPDiscoverCommentsModel

+ (JPDiscoverCommentsModel *)getTestModel {
    JPDiscoverCommentsModel *testModel = [[JPDiscoverCommentsModel alloc] init];
    testModel.praiseCount = (arc4random() % 500) + 1;
    testModel.commentCount = (arc4random() % 500) + 1;
    return testModel;
}

@end
