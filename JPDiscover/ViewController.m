//
//  ViewController.m
//  JPDiscover
//
//  Created by Jasper on 16/3/25.
//  Copyright © 2016年 Jasper. All rights reserved.
//

#import "ViewController.h"
#import "JPDiscoverFullStyleTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import <MJRefresh.h>

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,JPDiscoverTableViewCellDataSource,JPDiscoverTableViewCellDelegate>

@property (nonatomic, strong) UITableView *listTable;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dataSource = [[NSMutableArray alloc] init];
    
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 20) style:UITableViewStylePlain];
    _listTable.dataSource = self;
    _listTable.delegate = self;
    [_listTable setBackgroundColor:[UIColor clearColor]];
    [_listTable setShowsHorizontalScrollIndicator:NO];
    [_listTable setShowsVerticalScrollIndicator:NO];
    _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listTable];
    
    _listTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    _listTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [_listTable.mj_header beginRefreshing];
}

#pragma mark 数据

- (void)headerRereshing {
    [_dataSource removeAllObjects];
    for (int i = 0; i < 10; i+=1) {
        [_dataSource addObject:[JPDiscoverModel getTestModel]];
    }
    [_listTable.mj_header endRefreshing];
    [_listTable reloadData];
}

- (void)loadMoreData {
    for (int i = 0; i < 10; i+=1) {
        [_dataSource addObject:[JPDiscoverModel getTestModel]];
    }
    [_listTable.mj_footer endRefreshing];
    [_listTable reloadData];
}

#pragma mark Cell-Delegate

- (void)groupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell loadImageView:(UIImageView *)imageView imageUrl:(NSString *)imageUrl placeholderImage:(NSString *)placeholderImageName {
    if (imageUrl.length != 0) {
        [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:placeholderImageName]];
    }else {
        imageView.image = nil;
    }
}

- (void)groupTableViewCellTapPraiseButton:(JPDiscoverBaseTableViewCell *)tableViewCell {
    NSIndexPath *indexPath = [_listTable indexPathForCell:tableViewCell];
    JPDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    BOOL willBePraised = YES;
    if (cellModel.commentsModel.isPraised) {
        //取消赞
        willBePraised = NO;
    }else {
        //赞
        willBePraised = YES;
    }
    if (willBePraised) {
        cellModel.commentsModel.isPraised = YES;
        cellModel.commentsModel.praiseCount++;
    }else {
        cellModel.commentsModel.isPraised = NO;
        cellModel.commentsModel.praiseCount--;
    }
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [_listTable reloadRowsAtIndexPaths:indexPaths withRowAnimation:NO];
}

#pragma mark Cell-datasource

- (JPDiscoverTitleModel *)titleDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath {
    JPDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.titleModel;
}

- (JPDiscoverContentModel *)contentDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath {
    JPDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.contentModel;
}

- (JPDiscoverImageModel *)imageDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath {
    JPDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.imageModel;
}

- (JPDiscoverShareModel *)shareDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath {
    JPDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.shareModel;
}

- (JPDiscoverVideoModel *)videoDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath {
    JPDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.videoModel;
}

- (JPDiscoverCommentsModel *)commentsDataForGroupTableViewCell:(JPDiscoverBaseTableViewCell *)tableViewCell indexPath:(NSIndexPath *)indexPath {
    JPDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    return cellModel.commentsModel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    JPDiscoverModel *cellModel = [_dataSource objectAtIndex:indexPath.row];
    CGFloat totalHeight = [JPDiscoverFullStyleTableViewCell countHeightWithGroupCellModel:cellModel width:CGRectGetWidth(self.view.frame)];
    return totalHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"JPDiscoverFullStyleTableViewCell";
    JPDiscoverFullStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[JPDiscoverFullStyleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID width:CGRectGetWidth(self.view.frame)];
        [cell setBackgroundColor:UIColorRGB(242, 242, 242)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.dataSource = self;
        cell.delegate = self;
    }
    [cell loadDataSourceWithIndexPath:indexPath];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
