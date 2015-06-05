//
//  MatchCardsModel.h
//  Sieve_P3
//
//  Created by Jordan Sieve on 11/20/14.
//  Copyright (c) 2014 Jordan Sieve. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MatchCardsDelegate <NSObject>

@end

@interface MatchCardsModel : NSObject

@property (nonatomic, weak) id <MatchCardsDelegate> delegate;
@property (nonatomic) NSMutableArray *gameCardFaces;
@property (nonatomic) NSMutableArray *cardComparison;
@property (nonatomic) NSMutableArray *removeMatchedCards;
@property (nonatomic) BOOL counterStarted;
@property (nonatomic) int cardCounter;
@property (nonatomic) BOOL gameCompleted;
-(void)startGameTimer;
- (NSMutableArray *) createRandomCardFaceArray;

@end
