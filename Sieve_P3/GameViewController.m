//
//  ViewController.m
//  Sieve_P3
//
//  Created by Jordan Sieve on 11/5/14.
//  Copyright (c) 2014 Jordan Sieve. All rights reserved.
//

#import "GameViewController.h"
#import "MatchCardsModel.h"
#import "CardFront.h"
#import "CardBack.h"
#import "CardCell.h"

@interface GameViewController () <MatchCardsDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (nonatomic) int cardCollectionViewWidth;      // Used for card sizing
@property (nonatomic) int cardCollectionViewHeight;     // Used for card sizing
@property (nonatomic, strong) MatchCardsModel *model;
@property (nonatomic) CardCell *removeCard;             // Used for removing matched cards
@property (nonatomic) BOOL twoCardsSelected;

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up the delegate
    _model = [[MatchCardsModel alloc] init];
    [_model setDelegate:self];
    
    // Set up the collection view
    [_cardCollectionView setDelegate:self];
    [_cardCollectionView setDataSource:self];
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // Set the correct number of cards
    return _model.gameCardFaces.count;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Use custom cell for card
    CardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCells" forIndexPath:indexPath];
       
    [cell setCellCardContents: _model.gameCardFaces[indexPath.row]];
    
    return cell;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Prevent more than 2 cards to be selected at once
    if (!_twoCardsSelected) {
    
        // Animate card flipping
        CardCell *cell = (CardCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell flipCellCard];
        
        // Add selected card/index to arrays to compare
        [_model.cardComparison addObject:_model.gameCardFaces[indexPath.row]];
        [_model.removeMatchedCards addObject:indexPath];
        
        // When 2 cards are added compare them
        if (_model.cardComparison.count == 2) {
            
            // Prevent more than 2 cards being picked at once
            _twoCardsSelected = YES;
        
            // Delay matching part of code to let card flip over
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
                // Check for double tapping same card
                if (_model.removeMatchedCards[0] == _model.removeMatchedCards[1]) {
                    [_model.cardComparison removeAllObjects];
                    [_model.removeMatchedCards removeAllObjects];
                }
                
                // Cards match
                else if (_model.cardComparison[0] == _model.cardComparison[1]) {
                    
                    // Disable matched cards
                    _removeCard = (CardCell *)[collectionView cellForItemAtIndexPath:_model.removeMatchedCards[0]];
                    _removeCard .userInteractionEnabled = NO;
                    
                    _removeCard = (CardCell *)[collectionView cellForItemAtIndexPath:_model.removeMatchedCards[1]];
                    _removeCard .userInteractionEnabled = NO;
                    
                    // Track number of matched cards
                    _model.cardCounter++;
                    
                    // Clear out arrays
                    [_model.cardComparison removeAllObjects];
                    [_model.removeMatchedCards removeAllObjects];
                    
                    // Display message after completing game
                    if (_model.cardCounter == (_model.gameCardFaces.count / 2)) {
                        _model.gameCompleted = YES;
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Win!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                }
                
                // Cards don't match
                else {
                    
                    // Flip cards back over
                    _removeCard = (CardCell *)[collectionView cellForItemAtIndexPath:_model.removeMatchedCards[0]];
                    [_removeCard flipCellCard];
                    _removeCard = (CardCell *)[collectionView cellForItemAtIndexPath:_model.removeMatchedCards[1]];
                    [_removeCard flipCellCard];

                    // Clear out arrays
                    [_model.cardComparison removeAllObjects];
                    [_model.removeMatchedCards removeAllObjects];
                }
                
                // Reset BOOL value
                _twoCardsSelected = NO;
            });
        }
    }
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    // Get Collection View size to determine card size
    _cardCollectionViewWidth = _cardCollectionView.bounds.size.width;
    _cardCollectionViewHeight = _cardCollectionView.bounds.size.height;
    
    // Size cards for 6x6 game
    if (_model.gameCardFaces.count == 36) {
        // Remove spacing from equation
        _cardCollectionViewWidth -= 120;
        _cardCollectionViewHeight -= 90;
        
        // Get correct card size from space
        _cardCollectionViewWidth = _cardCollectionViewWidth / 6;
        _cardCollectionViewHeight = _cardCollectionViewHeight / 6;
    }
    
    // Size cards for 4x4 game
    else if (_model.gameCardFaces.count == 16) {
        // Remove spacing from equation
        _cardCollectionViewWidth -= 100;
        _cardCollectionViewHeight -= 70;
        
        // Get correct card size from space
        _cardCollectionViewWidth = _cardCollectionViewWidth / 4;
        _cardCollectionViewHeight = _cardCollectionViewHeight / 4;
    }
    
    // Size cards for 2x2 game
    else {
        // Remove spacing from equation
        _cardCollectionViewWidth -= 60;
        _cardCollectionViewHeight -= 50;
        
        // Get correct card size from space
        _cardCollectionViewWidth = _cardCollectionViewWidth / 2;
        _cardCollectionViewHeight = _cardCollectionViewHeight / 2;
    }
    
    // Size cards using calculated figures
    CGSize gameCard = CGSizeMake(_cardCollectionViewWidth, _cardCollectionViewHeight);

    return gameCard;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    // Set gaps around edge of display
    return UIEdgeInsetsMake(20, 20, 20, 20);
}


@end
