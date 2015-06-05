//
//  CardBack.m
//  Sieve_P3
//
//  Created by Jordan Sieve on 11/20/14.
//  Copyright (c) 2014 Jordan Sieve. All rights reserved.
//

#import "CardBack.h"

@interface CardBack()

@property (nonatomic) BOOL isFlipped;

@end

@implementation CardBack

- (void) drawRect:(CGRect)rect
{
    [self.rotationLayer setFrame:self.bounds];
    [self.layer addSublayer: self.rotationLayer];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.rotationLayer = [[CardLayer alloc] init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.rotationLayer = [[CardLayer alloc] init];
    }
    return self;
}


@end
