//
//  CardCell.m
//  Sieve_P3
//
//  Created by Jordan Sieve on 11/21/14.
//  Copyright (c) 2014 Jordan Sieve. All rights reserved.
//

#import "CardCell.h"
#import "CardBack.h"
#import "CardFront.h"
#import "MatchCardsModel.h"

@interface CardCell()

@property (weak, nonatomic) IBOutlet UIView *cardCellImage;
@property (strong, nonatomic) CardFront *cardFrontView;
@property (strong, nonatomic) CardBack *cardBackView;
@property (nonatomic, strong) MatchCardsModel *model;
@property (nonatomic) BOOL isFlipped;
@property (nonatomic) int iterator;

@end

@implementation CardCell

- (void) setCellCardContents: (NSString *) gameCardFaces
{
    
    // Reset settings if game is completed
    if (_model.gameCompleted) {
        _model.gameCompleted = NO;
        _iterator = 0;
    }
    
    // Correctly size the frame
    _cardCellImage.frame = self.bounds;
    
    // Create layers and add them to the uiview
    _cardFrontView = [[CardFront alloc] initWithFrame:self.bounds];
    [_cardCellImage addSubview: _cardFrontView];
    [_cardFrontView setHidden:NO];
    
    _cardBackView = [[CardBack alloc] initWithFrame:self.bounds];
    [_cardCellImage addSubview: _cardBackView];
    [_cardBackView setHidden:NO];

    for (UIView *subView in self.cardCellImage.subviews) {
        if ([subView isKindOfClass:[CardBack class]]) {
        }
        else if ([subView isKindOfClass:[CardFront class]]) {
            [_cardFrontView setCardFrontValue:gameCardFaces];
            _iterator++;
        }
    }
}

- (void) flipCellCard
{
    // Correctly size the frame
    _cardCellImage.frame = self.bounds;
    
    // Flip card animation
    [UIView transitionWithView:_cardCellImage duration:0.5
                       options:_isFlipped ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [_cardFrontView setHidden: _isFlipped];
                        [_cardBackView setHidden: !_isFlipped];
                        _isFlipped = !_isFlipped;
                    } completion:nil];
}

@end
