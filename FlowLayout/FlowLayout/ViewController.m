//
//  ViewController.m
//  FlowLayout
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 apple 公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    NSMutableArray *_datalist;
    NSIndexPath *_indexPath;
    //BOOL is;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datalist = [NSMutableArray array];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    
    flowLayout.minimumInteritemSpacing = 4;
    flowLayout.minimumLineSpacing = 4;
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    
    for (int i = 0; i<301; i++) {
       
        [_datalist addObject:@0];
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_datalist count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if([_datalist[indexPath.row]isEqual:@0]){
        
        cell.backgroundColor = [UIColor orangeColor];
    }else{
        
        cell.backgroundColor = [UIColor redColor];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath *indexpathl = [NSIndexPath indexPathForItem:indexPath.row inSection:0];
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexpathl];
    cell.backgroundColor = [UIColor redColor];
    _datalist[indexpathl.row] = @1;
    
    NSInteger count = [_datalist count]/4*4;
    
    NSInteger a = indexPath.row/4;
    
    //如果是最后的一行不足四个的
    if (a*4 == count) {
        
        return;
    }
    BOOL is = YES;
    for (int i = 0; i<4; i++) {
        
        if ([_datalist[a*4+i] isEqualToNumber:@0]) {
            
            is = NO;
        }
    }
    
    if (is == YES) {
        for (int i = 0; i<4; i++) {
            
            [_datalist removeObjectAtIndex:a*4];
            NSLog(@"%d",i);
             NSIndexPath *indexPathll = [NSIndexPath indexPathForRow:a*4 inSection:0];
            [collectionView deleteItemsAtIndexPaths:@[indexPathll]];
        }
    }
    [_collectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
