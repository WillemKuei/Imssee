//
//  UITableView+Wave.m
//  imssee
//
//  Created by imsseeios3 on 15/2/11.
//  Copyright (c) 2015年 鑫易. All rights reserved.
//

#import "UITableView+Wave.h"

@implementation UITableView (Wave)

- (void)reloadDataAnimateWithWave:(WaveAnimation)animation
{
    [self setContentOffset:self.contentOffset animated:NO];
    [UIView animateWithDuration:.2 animations:^{
        [self setHidden:YES];
        [self reloadData];
    } completion:^(BOOL finished) {
        [self setHidden:NO];
        [self visibleRowsBeginAnimation:animation];
    }];
}

- (void)visibleRowsBeginAnimation:(WaveAnimation)animation
{
    NSArray *array = [self indexPathsForVisibleRows];
    for (int i = 0; i < array.count; i++) {
        NSIndexPath *indexPath = array[i];
        UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
        cell.hidden = YES;
        NSArray *array = @[indexPath,[NSNumber numberWithInteger:animation]];
        [self performSelector:@selector(animationStart:) withObject:array afterDelay:0.15*i];
    }
}

- (void)animationStart:(NSArray *)array
{
    NSIndexPath *indexPath = array[0];
    float i = [((NSNumber *)array[1]) floatValue];
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    CGPoint originPoint = cell.center;
    cell.center = CGPointMake(cell.frame.size.width * i, originPoint.y);
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         cell.center = CGPointMake(originPoint.x - i * kBOUNCE_DISTANCE, originPoint.y);
                         cell.hidden = NO;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              cell.center = CGPointMake(originPoint.x + i * kBOUNCE_DISTANCE, originPoint.y);
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.1
                                                                    delay:0
                                                                  options:UIViewAnimationOptionCurveEaseIn
                                                               animations:^{
                                                                   cell.center = originPoint;
                                                               }
                                                               completion:NULL];
                                          }];
                     }];
}

@end
