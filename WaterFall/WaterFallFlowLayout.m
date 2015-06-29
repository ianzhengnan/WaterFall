//
//  WaterFallFlowLayout.m
//  WaterFall
//
//  Created by zhengna on 15/6/29.
//  Copyright (c) 2015年 zhengna. All rights reserved.
//

#import "WaterFallFlowLayout.h"

CGFloat const colCount = 3;

@implementation WaterFallFlowLayout

//set the layout of cell
//prepare for the setting of layout
- (void)prepareLayout{
    
    [super prepareLayout];
    _colArr = [NSMutableArray array];
    _attributeDict = [NSMutableDictionary dictionary];
    self.delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    _cellCount = [self.collectionView numberOfItemsInSection:0];
    
    if(_cellCount == 0){
        return;
    }
    float top = 0;
    for (int i = 0; i < colCount; i++) {
        [_colArr addObject:[NSNumber numberWithFloat:top]];
    }
    for (int i = 0; i < _cellCount; i++) {
        [self layoutItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
    }
}

//set layout for cells
- (void)layoutItemAtIndexPath:(NSIndexPath *)indexPath{
    //get the padding of cells through invoking delegate methods
    UIEdgeInsets edgeInsets = [self.delegate collectionView:self.collectionView layout:self
                                     insetForSectionAtIndex:indexPath.row];
    
    //get the size of every items
    CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    
    //find the minimun height
    float col = 0;
    float shortHeight = [[_colArr objectAtIndex:col] floatValue];
    for (int i = 0; i < _colArr.count; i++) {
        float height = [[_colArr objectAtIndex:i] floatValue];
        if(height < shortHeight){
            shortHeight = height;
            col = i;
        }
    }
    float top = [[_colArr objectAtIndex:col] floatValue];
    //set the frame value of cell
    CGRect frame = CGRectMake(edgeInsets.left + col * (edgeInsets.left + itemSize.width), top + edgeInsets.top, itemSize.width, itemSize.height);
    //update the height of column
    [_colArr replaceObjectAtIndex:col withObject:[NSNumber numberWithFloat:top + edgeInsets.top + itemSize.height]];
    
    //save the indexPath of cell to dictronary
    [_attributeDict setObject:indexPath forKey:NSStringFromCGRect(frame)];
}

- (NSArray *)indexPathsOfItem:(CGRect)rect{

    NSMutableArray *array = [NSMutableArray array];
    for (NSString *rectStr in _attributeDict) {
        CGRect cellRect = CGRectFromString(rectStr);
        //
        if (CGRectIntersectsRect(cellRect, rect)) {
            NSIndexPath *indexPath = _attributeDict[rectStr];
            [array addObject:indexPath];
        }
    }
    return array;
}
//get the layout info
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{

    NSMutableArray * muArr = [NSMutableArray array];
    //according the param of frame to calcute the which cell should be appear
    NSArray *indexPaths = [self indexPathsOfItem:rect];
    for (NSIndexPath *indexPath in indexPaths) {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [muArr addObject:attribute];
    }
    return muArr;
}

//calcute the size of collection view's content
- (CGSize)collectionViewContentSize{
    //get the heightest height
    CGSize size = self.collectionView.frame.size;
    float maxHeight = [[_colArr objectAtIndex:0] floatValue];
    for (int i = 0; i < _colArr.count; i++) {
        float colHeight = [[_colArr objectAtIndex:i] floatValue];
        if (colHeight > maxHeight) {
            maxHeight = colHeight;
        }
    }
    size.height = maxHeight;
    return size;
}

@end
