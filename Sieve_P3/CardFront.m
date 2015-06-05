//
//  CardFront.m
//  Sieve_P3
//
//  Created by Jordan Sieve on 11/20/14.
//  Copyright (c) 2014 Jordan Sieve. All rights reserved.
//

#import "CardFront.h"

@interface CardFront()

@property (nonatomic, strong) UILabel *cardFrontLabel;

@end

@implementation CardFront

- (void) setCardFrontValue: (NSString *) cardFace
{
    [self.cardFrontLabel setText: cardFace];
    
    [self setNeedsDisplay];
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];
        self.cardFrontLabel = [[UILabel alloc] initWithFrame:frame];
        [self.cardFrontLabel setTextAlignment:NSTextAlignmentCenter];
        
        // Load defaults for correct size icons
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        [self.cardFrontLabel setFont:[UIFont fontWithName:@"Helvetica" size:(int)[defaults integerForKey:@"cardFaceSize"]]];
        
        [defaults synchronize];
        
        [self addSubview:self.cardFrontLabel];
    }
    return self;
}
     
@end
