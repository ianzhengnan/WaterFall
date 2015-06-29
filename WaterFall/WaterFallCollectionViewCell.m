//
//  WaterFallCollectionViewCell.m
//  WaterFall
//
//  Created by zhengna on 15/6/29.
//  Copyright (c) 2015年 zhengna. All rights reserved.
//

#import "WaterFallCollectionViewCell.h"

@implementation WaterFallCollectionViewCell

- (void)setImage:(UIImage *)image{

    if(!_image != image){
        _image = image;
    }
    [self setNeedsDisplay];
}

// draw the picture to the view
-(void)drawRect:(CGRect)rect{

    float newHeight = _image.size.height / _image.size.width * 100;
    [_image drawInRect:CGRectMake(0, 0, 100, newHeight)];
    
}


@end
