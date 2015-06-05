//
//  MatchCardsModel.m
//  Sieve_P3
//
//  Created by Jordan Sieve on 11/20/14.
//  Copyright (c) 2014 Jordan Sieve. All rights reserved.
//

#import "MatchCardsModel.h"

@interface MatchCardsModel()

@property (nonatomic, strong) NSTimer* gameTimer;
@property (nonatomic) int countdownTimer;
@property (nonatomic) int numberOfGameCards;
@property (nonatomic) NSMutableArray* allCardFaces;
@property (nonatomic) u_int32_t randomNumberGenerator;

@end

@implementation MatchCardsModel

- (instancetype) init
{
    self = [super init];
    if (self) {
        [self createRandomCardFaceArray];
        self.cardComparison = [[NSMutableArray alloc] init];
        self.removeMatchedCards = [[NSMutableArray alloc] init];
        self.cardCounter = 0;
    }
    return self;
}

#pragma mark - Create Random Card Face Array

- (NSMutableArray *) createRandomCardFaceArray
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _gameCardFaces = [[NSMutableArray alloc] init];
    
    // Grab array from plist
    _allCardFaces = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cardface" ofType:@"plist"]];

    // Determine number of cards per user settings
    _numberOfGameCards = (int)[defaults integerForKey:@"gridGameSize"];
    
    [defaults synchronize];
    
    // Copy the array elements from all cards into ones used for the game
    for (int i = 0; i < _numberOfGameCards / 2; i++) {
        _gameCardFaces[i] = _allCardFaces[i];
    }
    
    // Make a copy of elements so each card has one to match
    [_gameCardFaces addObjectsFromArray:_gameCardFaces];
    
    // Randomize order for game
    for (int i = 0; i < _gameCardFaces.count; i++) {
        _randomNumberGenerator = arc4random_uniform(_numberOfGameCards);
        [_gameCardFaces exchangeObjectAtIndex:i withObjectAtIndex:_randomNumberGenerator];
    }
    
    return _gameCardFaces;
}

#pragma mark - Game Timer Methods

- (void)startGameTimer
{
    _counterStarted = true;
    
    // Start the timer with 30 seconds
    _countdownTimer = 30;
    
    _gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(gameTimerStarted) userInfo:nil repeats:YES];
}
                  
- (void)gameTimerStarted
{
    _countdownTimer--;
    NSLog(@"%d", _countdownTimer);
    
    if (_countdownTimer == 0) {
        _counterStarted = false;
        [_gameTimer invalidate];
        _gameTimer = nil;
    }
}



@end
