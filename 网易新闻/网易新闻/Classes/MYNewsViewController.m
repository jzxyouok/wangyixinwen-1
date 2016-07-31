//
//  MYNewsViewController.m
//  网易新闻
//
//  Created by caohaifeng on 4/27/16.
//  Copyright © 2016 haifeng. All rights reserved.
//

#import "MYNewsViewController.h"
#import "MYChannelModel.h"
#import "MYChannelLabel.h"
#import "MYChannelCell.h"

static NSString *const reuseID  = @"MYChannelCell";

@interface MYNewsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

/** 频道数据模型 */
@property(nonatomic,strong) NSArray *channelList;

/** 频道列表 */
@property(nonatomic,strong) UIScrollView *smallScrollView;

/** 新闻视图 */
@property(nonatomic,strong) UICollectionView *bigCollectionView;

/** 下划线 */
@property(nonatomic,strong) UIView *underLine;

/** 右侧添加删除排序按钮 */
@property(nonatomic,strong) UIButton *sortButton;

/**  */

@end

@implementation MYNewsViewController

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"新闻";
        [[UINavigationBar appearance] setBarTintColor:AppColor];
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.smallScrollView];
    [self.view addSubview:self.sortButton];
    [self.view addSubview:self.bigCollectionView];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 设置频道标题 */
- (void)setupChannelLabel {
    CGFloat margin = 20.0;
    CGFloat x = 8;
    CGFloat h = _smallScrollView.bounds.size.height;
    int i = 0;
    for (MYChannelModel *model in self.channelList) {
        MYChannelLabel *label = [MYChannelLabel channelLabelWithTitle:model.tname];
        label.frame = CGRectMake(x, 0, label.width + margin, h);
        [self.smallScrollView addSubview:label];
        x += label.bounds.size.width;
        label.tag = i++;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    }
    self.smallScrollView.contentSize = CGSizeMake(x + margin + 30, 0);
}

/** 频道Label点击事件 */
- (void)labelClick:(UITapGestureRecognizer *)recognizer {
    MYChannelLabel *label = (MYChannelLabel *)recognizer.view;
    // 点击label后，让bigCollectionView滚到对应位置。
    [_bigCollectionView setContentOffset:CGPointMake(label.tag * _bigCollectionView.frame.size.width, 0)];
    // 重新调用一下滚定停止方法，让label的着色和下划线到正确的位置。
    [self scrollViewDidEndScrollingAnimation:self.bigCollectionView];
}

/**
 *  懒加载
 */

//频道数组
- (NSArray *)channelList {
    if (_channelList == nil) {
        _channelList = [MYChannelModel channels];
    }
    return _channelList;
}


//滚动的视图
- (UIScrollView *)smallScrollView {
    if (_smallScrollView == nil) {
        _smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44)];
        _smallScrollView.backgroundColor = [UIColor whiteColor];
        _smallScrollView.showsHorizontalScrollIndicator = NO;
        // 设置频道标题
        [self setupChannelLabel];
        [_smallScrollView addSubview:self.underLine];
    }
    return _smallScrollView;
}


//设置下划线
- (UIView *)underLine {
    if (_underLine == nil) {
        MYChannelLabel *firstLabel = [self getLabelArrayFromSubviews][0];
        firstLabel.textColor = AppColor;
        _underLine = [[UIView alloc] initWithFrame:CGRectMake(0, 12, firstLabel.width, 20)];
        _underLine.centerX = firstLabel.centerX;
        _underLine.backgroundColor = AppColor;
        _underLine.alpha = 0.4;
        _underLine.layer.cornerRadius = 10;
    }
    return _underLine;
}

//排序按钮
- (UIButton *)sortButton {
    if (_sortButton == nil) {
        _sortButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-44, 64, 44, 44)];
        [_sortButton setImage:[UIImage imageNamed:@"ks_home_plus"] forState:UIControlStateNormal];
        _sortButton.backgroundColor = [UIColor whiteColor];
        _sortButton.layer.shadowColor = [UIColor whiteColor].CGColor;
        _sortButton.layer.shadowOpacity = 1;
        _sortButton.layer.shadowRadius = 5;
        _sortButton.layer.shadowOffset = CGSizeMake(-10, 0);
        
        [_sortButton addTarget:self action:@selector(sortButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sortButton;
}

/** 排序按钮点击事件 */
- (void)sortButtonClick {
    NSLog(@"排序按钮");
}

//大的collectionView
- (UICollectionView *)bigCollectionView {
    if (_bigCollectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _bigCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.smallScrollView.maxY, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - self.smallScrollView.height) collectionViewLayout:flowLayout];
        _bigCollectionView.backgroundColor = [UIColor whiteColor];
        _bigCollectionView.delegate = self;
        _bigCollectionView.dataSource = self;
        [_bigCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseID];
        // 设置cell的大小和细节
        flowLayout.itemSize = _bigCollectionView.bounds.size;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _bigCollectionView.pagingEnabled = YES;
        _bigCollectionView.showsHorizontalScrollIndicator = NO;
        
    }
    return _bigCollectionView;
}

#pragma mark - UICollectionViewDataSource
//总个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channelList.count;
}

//cell的样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MYChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    MYChannelCell *channel = self.channelList[indexPath.row];
//    cell.urlString = channel.urlString;
        NSLog(@"%@",channel.urlString);
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    
    // 如果不加入响应者链，则无法利用NavController进行Push/Pop等操作。
//    [self addChildViewController:(UIViewController *)cell.newsTVC];
    return cell;

//    MYChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
//    MYChannelModel *model = self.channelList[indexPath.row];
//    NSLog(@"%@",model.urlString);
//    cell.urlString = model.urlString;
//    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
//    // 如果不加入响应者链，则无法利用NavController进行Push/Pop等操作。
//    [self addChildViewController:(UIViewController *)cell.newsTVC];
//    return cell;
}

#pragma mark - UICollectionViewDelegate
/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat value = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (value < 0) {return;} // 防止在最左侧的时候，再滑，下划线位置会偏移，颜色渐变会混乱。
    
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    if (rightIndex >= [self getLabelArrayFromSubviews].count) {  // 防止滑到最右，再滑，数组越界，从而崩溃
        rightIndex = [self getLabelArrayFromSubviews].count - 1;
    }
    
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft  = 1 - scaleRight;
    
    MYChannelLabel *labelLeft  = [self getLabelArrayFromSubviews][leftIndex];
    MYChannelLabel *labelRight = [self getLabelArrayFromSubviews][rightIndex];
    
    labelLeft.scale  = scaleLeft;
    labelRight.scale = scaleRight;

    // 点击label会调用此方法1次，会导致【scrollViewDidEndScrollingAnimation】方法中的动画失效，这时直接return。
    if (scaleLeft == 1 && scaleRight == 0) {
        return;
    }
    _underLine.centerX = labelLeft.centerX   + (labelRight.centerX   - labelLeft.centerX)   * scaleRight;
    _underLine.width   = labelLeft.textWidth + (labelRight.textWidth - labelLeft.textWidth) * scaleRight;
}

/** 获取smallScrollView中所有的MYChannelLabel，合成一个数组，因为smallScrollView.subViews中有其他非Label元素 */
- (NSArray *)getLabelArrayFromSubviews
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (MYChannelLabel *label in self.smallScrollView.subviews) {
        if ([label isKindOfClass:[MYChannelLabel class]]) {
            [arrayM addObject:label];
        }
    }
    return arrayM.copy;
}

/** 手指滑动BigCollectionView，滑动结束后调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.bigCollectionView]) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
    }
}

/** 手指点击smallScrollView */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bigCollectionView.width;
    // 滚动标题栏到中间位置
    MYChannelLabel *titleLable = [self getLabelArrayFromSubviews][index];
    CGFloat offsetx   =  titleLable.center.x - _smallScrollView.width * 0.5;
    CGFloat offsetMax = _smallScrollView.contentSize.width - _smallScrollView.width;
    // 在最左和最右时，标签没必要滚动到中间位置。
    if (offsetx < 0)		 {offsetx = 0;}
    if (offsetx > offsetMax) {offsetx = offsetMax;}
    [_smallScrollView setContentOffset:CGPointMake(offsetx, 0) animated:YES];
    
    // 先把之前着色的去色：（快速滑动会导致有些文字颜色深浅不一，点击label会导致之前的标题不变回黑色）
    for (MYChannelLabel *label in [self getLabelArrayFromSubviews]) {
        label.textColor = [UIColor blackColor];
    }
    // 下划线滚动并着色
    [UIView animateWithDuration:0.5 animations:^{
        _underLine.width = titleLable.textWidth;
        _underLine.centerX = titleLable.centerX;
        titleLable.textColor = AppColor;
    }];
}


@end
