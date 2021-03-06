//
//  CollectionViewController.m
//  6. Rearrangeable Collection View (Exchange)
//
//  Created by Stephen Fortune on 21/12/2014.
//  Copyright (c) 2014 IceCube Software Ltd. All rights reserved.
//

#import "CollectionViewController.h"
#import <BetweenKit/I3GestureCoordinator.h>


static NSString* DequeueReusableCell = @"DequeueReusableCell";


@interface CollectionViewController()

@property (nonatomic, strong) I3GestureCoordinator *dragCoordinator;

@property (nonatomic, strong) NSMutableArray *data;

@end


@implementation CollectionViewController


-(void) viewDidLoad{
    
    [super viewDidLoad];
    
    self.data = [NSMutableArray arrayWithArray:@[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor yellowColor], [UIColor orangeColor], [UIColor purpleColor]]];
    self.dragCoordinator = [I3GestureCoordinator basicGestureCoordinatorFromViewController:self withCollections:@[self.collectionView] withRecognizer:[[UILongPressGestureRecognizer alloc] init]];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:DequeueReusableCell];
    
}


-(void) didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate


-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:DequeueReusableCell forIndexPath:indexPath];
    
    cell.backgroundColor = self.data[indexPath.item];
    
    return cell;
}


#pragma mark - I3DragDataSource


-(BOOL) canItemBeDraggedAt:(NSIndexPath *)at inCollection:(UIView<I3Collection> *)collection{
    return YES;
}


-(BOOL) canItemFrom:(NSIndexPath *)from beRearrangedWithItemAt:(NSIndexPath *)to inCollection:(UIView<I3Collection> *)collection{
    return YES;
}


-(void) rearrangeItemAt:(NSIndexPath *)from withItemAt:(NSIndexPath *)to inCollection:(UIView<I3Collection> *)collection{
    
    [self.data exchangeObjectAtIndex:to.row withObjectAtIndex:from.row];
    [self.collectionView reloadItemsAtIndexPaths:@[to, from]];
    
}


@end
