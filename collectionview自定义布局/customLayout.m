//
//  customLayout.m
//  collectionview自定义布局
//
//  Created by zhn on 15/12/17.
//  Copyright © 2015年 zhn. All rights reserved.
//

#import "customLayout.h"

@interface customLayout()

@property (nonatomic,strong) NSMutableArray * layoutsArray;


@property (nonatomic,assign) NSInteger height;
@end



@implementation customLayout

- (NSMutableArray *)layoutsArray{
    
    if (_layoutsArray == nil) {
        _layoutsArray = [NSMutableArray array];
    }
    return _layoutsArray;
}

- (void)prepareLayout{

    [super prepareLayout];
    NSMutableArray * yoffset1 = [NSMutableArray array];
    NSMutableArray * yoffset2 = [NSMutableArray array];
    
    CGFloat padding = 10 ;
    CGFloat itemsWidth = ([UIScreen mainScreen].bounds.size.width - 30) / 2 ;
    CGFloat xoffset1 = 10;
    CGFloat xoffset2 = 20 + itemsWidth;
    
    int itemsNumber = (int)[self.collectionView numberOfItemsInSection:0];;
    for (int index = 0; index < itemsNumber; index++) {
        
        int section = index % 2;
        CGFloat x = 0;
        
        if (section == 0) {
            x = xoffset1;
        }else{
            x = xoffset2;
        }
        
        NSInteger height =  [self.heightAry[index] integerValue];
        CGFloat y;
        if (section == 0) {
            y = [[yoffset1 lastObject]integerValue] + padding;
            [yoffset1 addObject:@(y + height)];
        }else{
            y = [[yoffset2 lastObject]integerValue] + padding;
            [yoffset2 addObject:@(y + height)];
        }
        
        CGRect rect = CGRectMake(x, y, itemsWidth, height);
        NSIndexPath * path = [NSIndexPath indexPathForItem:index inSection:0];
       UICollectionViewLayoutAttributes * attibutes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
        attibutes.frame = rect;
        
        [self.layoutsArray addObject:attibutes];
    }
    
    self.height = [yoffset1 lastObject] > [yoffset2 lastObject] ? [[yoffset1 lastObject]integerValue]:[[yoffset2 lastObject]integerValue];
    
}

- (CGSize)collectionViewContentSize{

    return CGSizeMake([UIScreen mainScreen].bounds.size.width, self.height);

}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    NSMutableArray * tempArray = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes * attribus in self.layoutsArray) {
        if (CGRectIntersectsRect(attribus.frame, rect)) {
            [tempArray addObject:attribus];
        }
    }
    return tempArray;
}


@end
