//
//  WaterFallFlowLayout.h
//  WaterFall
//
//  Created by zhengna on 15/6/29.
//  Copyright (c) 2015年 zhengna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFallFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) id<UICollectionViewDelegateFlowLayout> delegate;

@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic, copy) NSMutableArray *colArr; //retain the height of columns
@property (nonatomic, copy) NSMutableDictionary *attributeDict; //retain the position of cell


@end
