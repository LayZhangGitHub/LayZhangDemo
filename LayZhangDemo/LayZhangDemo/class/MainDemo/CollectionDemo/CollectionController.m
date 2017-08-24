//
//  CollectionController.m
//  LayZhangDemo
//
//  Created by LayZhang on 2017/8/22.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "CollectionController.h"

#import "CCellA.h"
#import "CCellB.h"
#import "CCellC.h"

@interface CollectionController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation CollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBarWithTitle:@"CollectionDemo"];
    
    [self initComponent];
}

- (void)initComponent {
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 5;
    //最小两行之间的间距
    layout.minimumLineSpacing = 5;
    
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 375, 667) collectionViewLayout:layout];
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    //这个是横向滑动
    //layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[CCellA class] forCellWithReuseIdentifier:[CCellA cellIdentifier]];
    [_collectionView registerClass:[CCellA class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[CCellA cellIdentifier]];
    [_collectionView registerClass:[CCellA class]  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[CCellA cellIdentifier]];
    [_collectionView registerClass:[CCellB class] forCellWithReuseIdentifier:[CCellB cellIdentifier]];
    [_collectionView registerClass:[CCellC class] forCellWithReuseIdentifier:[CCellC cellIdentifier]];
}


#pragma mark - collection delegate
//一共有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//每一组有多少个cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
//每一个cell是什么
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CCellA *cell=[collectionView dequeueReusableCellWithReuseIdentifier:[CCellA cellIdentifier] forIndexPath:indexPath];
    cell.cellData = [NSString stringWithFormat:@"%ld",indexPath.section*100+indexPath.row];
    cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    [cell reloadData];
    return cell;
}
//头部和脚部的加载
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[CCellA cellIdentifier] forIndexPath:indexPath];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(110, 20, 100, 30)];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        label.text=@"头";
    }else{
        label.text=@"脚";
    }
    [view addSubview:label];
    return view;
}
//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
//头部试图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(50, 60);
}
//脚部试图的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(50, 60);
}
//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(115, 100);
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //cell被电击后移动的动画
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionTop];
}


@end
