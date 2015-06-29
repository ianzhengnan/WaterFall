//
//  ViewController.m
//  WaterFall
//
//  Created by zhengna on 15/6/28.
//  Copyright (c) 2015年 zhengna. All rights reserved.
//

#import "ViewController.h"
#import "WaterFallCollectionViewCell.h"
#import "WaterFallFlowLayout.h"

CGFloat const kImgCount = 17;

static NSString *identifier = @"collectionView";

@interface ViewController ()

@property (nonatomic, copy) NSArray *imgArr;


@end


@implementation ViewController

//lazy load
- (NSArray *)imgArr{
    if(!_imgArr){
    
        NSMutableArray *muArr = [NSMutableArray array];
        for (int i = 0; i < kImgCount; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"huoying%d",i + 1]];
            [muArr addObject:image];
        }
        _imgArr = muArr;
    }
    return _imgArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //create collection view layout first
    WaterFallFlowLayout *flowLayout = [[WaterFallFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                             collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor yellowColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //register cell
    [self.collectionView registerClass:[WaterFallCollectionViewCell class] forCellWithReuseIdentifier:identifier];
   
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.imgArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WaterFallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[WaterFallCollectionViewCell alloc] init];
    }
    cell.image = self.imgArr[indexPath.item];
    return cell;
}

- (float)imgHeight:(float)height width:(float)width{
    /*
        height/width = compressed height/ compressed width * 100
     */
    float newHeight = height / width * 100;
    return newHeight;
}

#pragma mark - UICollectionView delegate flowLayout
// set the new size of images
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIImage *image = self.imgArr[indexPath.item];
    float height = [self imgHeight:image.size.height width:image.size.width];
    return CGSizeMake(100, height);
}
//set the margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    UIEdgeInsets edgeInsets = {5,5,5,5};
    return edgeInsets;
    
}



@end
