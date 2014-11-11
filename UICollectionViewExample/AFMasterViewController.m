//
//  AFMasterViewController.m
//  UICollectionViewExample
//
//  Created by Deepak K on 07/11/14.
//  Copyright (c) 2014 221B. All rights reserved.
//

#import "AFMasterViewController.h"
#import "AFCollectionViewCell.h"

static NSString *CellIdentifier = @"AFCollectionViewCell";

@implementation AFMasterViewController
{
    NSMutableArray *valueArray;
    NSMutableArray *indexArray;
    NSMutableArray *finalArray;
    int d;
    int v;
    int index;
    int reloadIndex;
}

-(void)setDimension:(int)dimen
{
    d = dimen;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    v= 1;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Spiral Square";
    
 
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat width = (self.view.frame.size.width - 2*d)/(d);
    CGFloat height;
    if (width > 20) {
        if (width > 100) {
            width = 40;
        }
    }
    height = width;
    
    flow.itemSize = CGSizeMake(width, height);
//    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumInteritemSpacing = 1;
    flow.minimumLineSpacing = 2;
    self.collectionView.collectionViewLayout = flow;
    
    
    valueArray = [[NSMutableArray alloc]initWithCapacity:(d*d)];
    indexArray = [[NSMutableArray alloc]init];
    finalArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < (d*d) ; i++) {
        [valueArray insertObject:@"" atIndex:i];
        [finalArray insertObject:@"" atIndex:i];

    }
    [self createValueArray];
    [self reloadCollectionViewAppropriately];
}

- (void)reloadCollectionViewAppropriately
{
    reloadIndex = 0;
    [self addValueAndReloadCollection];
}

-(void)addValueAndReloadCollection
{
    if (reloadIndex >= d*d) {
        return;
    }
    NSNumber *indexValue = [indexArray objectAtIndex:reloadIndex];
    [finalArray replaceObjectAtIndex:[indexValue integerValue] withObject:[NSString stringWithFormat:@"%d",reloadIndex + 1]];
     reloadIndex++;
     [self.collectionView reloadData];
    
    [self performSelector:@selector(addValueAndReloadCollection) withObject:nil afterDelay:0.3];
}

- (void)createValueArray
{
    [self goRight];
}

- (void)goRight
{
    for (int i = 0; i < d; i++) {
        if (index == d-1 || [[valueArray objectAtIndex:index] length]) {
            if (v > d*d) {
                break;
            }
            if (index == d-1) {
                [valueArray replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%d",v]];
                [indexArray addObject:[NSNumber numberWithInt:index]];
            }else{
                v--;
                index--;
            }
            if (d== 1)
                return;
            
            v++;
            index = index + d;
            [self goDown];
            break;
        }
        [valueArray replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%d",v]];
        [indexArray addObject:[NSNumber numberWithInt:index]];

        v++;
        index++;
    }
}
- (void)goDown
{
    for (int i = 0; i < d; i++) {
        if (index == d*d - 1 || [[valueArray objectAtIndex:index] length]) {
            if (v > d*d) {
                break;
            }
            if (index == d*d - 1) {
            [valueArray replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%d",v]];
                [indexArray addObject:[NSNumber numberWithInt:index]];

            }else{
                v--;
                index = index - d;
            }
            index--;
            v++;
            [self goLeft];
            break;
        }
        [valueArray replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%d",v]];
        [indexArray addObject:[NSNumber numberWithInt:index]];

        v++;
        index = index + d;
    }
}

- (void)goLeft
{
    for (int i = 0; i < d; i++) {
        if (index == d*(d-1) || [[valueArray objectAtIndex:index] length]) {
            if (v > d*d) {
                break;
            }
            if (index == d*(d-1) ) {
                [valueArray replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%d",v]];
                [indexArray addObject:[NSNumber numberWithInt:index]];

            }else{
                v--;
                index++;
            }
            v++;
            index = index - d;
            [self goUp];
            break;
        }
        [valueArray replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%d",v]];
        [indexArray addObject:[NSNumber numberWithInt:index]];

        v++;
        index--;
    }
}

- (void)goUp
{
    for (int i = 0; i < d; i++) {
        if (index == d || [[valueArray objectAtIndex:index] length]) {
            if (v > d*d) {
                break;
            }
            if (index == d) {
                [valueArray replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%d",v]];
                [indexArray addObject:[NSNumber numberWithInt:index]];

            }else{
                v--;
                index = index + d;
            }
            index++;
            v++;
            [self goRight];
            break;
        }
        [valueArray replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%d",v]];
        [indexArray addObject:[NSNumber numberWithInt:index]];

        v++;
        index = index - d;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return d;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return d;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AFCollectionViewCell *cell = (AFCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell setTitle:[finalArray objectAtIndex:indexPath.section * d + indexPath.row]];
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

@end
