//
//  CardLayer.m
//  Sieve_P3
//
//  Created by Jordan Sieve on 11/20/14.
//  Copyright (c) 2014 Jordan Sieve. All rights reserved.
//

#import "CardLayer.h"

@interface CardLayer()

@property (nonatomic, strong) CAGradientLayer *gradient;
@property (nonatomic, strong) UIImage *cardBack;

@end

@implementation CardLayer

+ (Class) layerClass
{
    return [CardLayer class];
}

-(void)layoutSublayers
{  
    // Gradient for card backs
    if (!self.gradient) {
        self.gradient = [CAGradientLayer new];
        self.gradient.contentsScale = [UIScreen mainScreen].scale;
        self.gradient.frame = self.bounds;
        self.gradient.colors = @[(id)[UIColor yellowColor].CGColor,
                                 (id)[UIColor orangeColor].CGColor];
        self.gradient.locations = @[@0.0f,
                                    @1.0f];
        [self addSublayer:self.gradient];
    }
}

@end
