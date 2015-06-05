//
//  SettingsModel.m
//  Sieve_P3
//
//  Created by Jordan Sieve on 11/21/14.
//  Copyright (c) 2014 Jordan Sieve. All rights reserved.
//

#import "SettingsModel.h"

@interface SettingsModel()

@end

@implementation SettingsModel

#pragma mark - Model Save User Defaults 

-(void) saveUserDifficulty: (int) inputPickerValue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (inputPickerValue == 0) {
        [defaults setInteger:4 forKey:@"gridGameSize"];
        [defaults setInteger:120 forKey:@"cardFaceSize"];
    }
    else if (inputPickerValue == 1) {
        [defaults setInteger:16 forKey:@"gridGameSize"];
        [defaults setInteger:50 forKey:@"cardFaceSize"];
    }
    else {
        [defaults setInteger:36 forKey:@"gridGameSize"];
        [defaults setInteger:24 forKey:@"cardFaceSize"];
    }
    
    [defaults synchronize];
}

@end
