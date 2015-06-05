//
//  CardCell.h
//  Sieve_P3
//
//  Created by Jordan Sieve on 11/21/14.
//  Copyright (c) 2014 Jordan Sieve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCell : UICollectionViewCell

@property (nonatomic) int flippedCardCounter;
- (void) setCellCardContents: (NSString *) gameCardFaces;
- (void) flipCellCard;

@end
