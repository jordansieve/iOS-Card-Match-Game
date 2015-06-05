//
//  SettingsModel.h
//  Sieve_P3
//
//  Created by Jordan Sieve on 11/21/14.
//  Copyright (c) 2014 Jordan Sieve. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SettingsDelegate <NSObject>

@end

@interface SettingsModel : NSObject

@property (nonatomic, weak) id<SettingsDelegate> delegate;
-(void) saveUserDifficulty: (int) inputPickerValue;

@end
