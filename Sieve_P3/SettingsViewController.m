//
//  SettingsViewController.m
//  Sieve_P3
//
//  Created by Jordan Sieve on 11/18/14.
//  Copyright (c) 2014 Jordan Sieve. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsModel.h"

@interface SettingsViewController () <SettingsDelegate, UIAlertViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickDifficulty;
@property (nonatomic, strong) SettingsModel *model;
@property (nonatomic) NSArray *difficultySettings;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up model delegate
    _model = [[SettingsModel alloc] init];
    [_model setDelegate: self];
    
    // Fill in difficult grid settings
    _difficultySettings = [[NSArray alloc] init];
    _difficultySettings = @[@"Easy 2x2", @"Medium 4x4", @"Hard 6x6"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Settings Save Picker View Methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _difficultySettings.count;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_difficultySettings objectAtIndex: row];
}

-(void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
{
    // Have picker show medium by default
    if ([_pickDifficulty selectedRowInComponent:0] != 1) {
        [_pickDifficulty selectRow:1 inComponent:0 animated:YES];
    }
}

#pragma mark - Settings Save Button Pressed Method

- (IBAction)saveSettingsPressed:(id)sender
{
    // Pass value to model to save in User Defaults
    [_model saveUserDifficulty: (int)[_pickDifficulty selectedRowInComponent:0]];
    
    // Alert the user that the settings were saved
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Settings saved!" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}



@end
