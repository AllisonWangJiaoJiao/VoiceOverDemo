//
//  TestCell.m
//  VoiceOverDemo
//
//  Created by Allison on 2022/8/3.
//

#import "TestCell.h"

static NSString * const UICollectionViewCellID = @"UICollectionViewCellID";

@interface TestCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,assign)CGFloat selectIndex;
@end

@implementation TestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    self.selectIndex = 0;
    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
    self.collectionView.frame = CGRectMake(0, 0, kWidth, 200);
}


#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:UICollectionViewCellID forIndexPath:indexPath];
    //cell.backgroundColor = [self randomColor];
    //UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    //    imageView.image = [UIImage imageNamed:@"new_guide_btn"];
    //[cell addSubview:imageView];
    UILabel *label = [[UILabel alloc]initWithFrame:cell.bounds];
    label.text = [NSString stringWithFormat:@"第%@卡片",@(indexPath.row)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [self randomColor];
    [cell addSubview:label];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
}

//返回每一项的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(cellWidth, 200);
}


- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //flowLayout.minimumLineSpacing = 8;
        //flowLayout.minimumInteritemSpacing = 8;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.isAccessibilityElement = YES;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:UICollectionViewCellID];
        [self.contentView addSubview:_collectionView];
        
    }
    return _collectionView;
}

- (BOOL)accessibilityScroll:(UIAccessibilityScrollDirection)direction{
    if (direction == UIAccessibilityScrollDirectionLeft) {
        if (self.selectIndex < 4 ) {
            self.selectIndex = self.selectIndex+1;            
            [self scrollToIndex:self.selectIndex];
            [self accessibilityScrollPage:self.selectIndex];
            return YES;
        }
    }else if (direction == UIAccessibilityScrollDirectionRight) {
        if (self.selectIndex != 0) {
            self.selectIndex = self.selectIndex-1;
            [self scrollToIndex:self.selectIndex];
            [self accessibilityScrollPage:self.selectIndex];
            return YES;
        }
    }
    return NO;
}

- (void)scrollToIndex:(NSInteger)index {
    NSIndexPath * indexPath =  [NSIndexPath indexPathForRow:index inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)accessibilityScrollPage:(NSInteger)index {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString * msg = [NSString stringWithFormat:@"第%@页，共20页",@(index)];
        UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, msg);
    });
}

@end
