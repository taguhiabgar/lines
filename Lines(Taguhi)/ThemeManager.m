//
//  ThemeManager.m
//  Lines(Taguhi)
//
//  Created by Taguhi Abgaryan on 8/20/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager

+ (id)sharedThemeManager
{
    static ThemeManager* sharedInstance = nil;
    if (sharedInstance == nil)
    {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (instancetype)init{
    if(self = [super init]){
        // initialize arrayOfThemes
        self.arrayOfThemes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setupThemes{
    // define text colors for each theme
    UIColor* simpleThemeTextColor = [UIColor darkGrayColor];
    UIColor* chinaThemeTextColor = [UIColor darkGrayColor];
    UIColor* eastThemeTextColor = [UIColor darkGrayColor];
    UIColor* stylishThemeTextColor = [UIColor purpleColor];
    
    // define buttons background colors for each theme
    UIColor* simpleThemeButtonsBackgroundColor = [UIColor whiteColor];
    UIColor* chinaThemeButtonsBackgroundColor = [UIColor whiteColor];
    UIColor* eastThemeButtonsBackgroundColor = [UIColor whiteColor];
    UIColor* stylishThemeButtonsBackgroundColor = [UIColor whiteColor];
    
    // create all themes
    
    // -- "Simple" theme
    // create "Simple" theme
    Theme* simpleTheme = [[Theme alloc] init];
    // define all balls of "Simple" theme
    
    NSArray* simpleBallsArray = [[NSArray alloc] initWithObjects:@"Ball1", @"Ball2", @"Ball3", @"Ball4", @"Ball5", @"Ball6", nil];
    [[simpleTheme ballImageNamesArray] addObjectsFromArray:simpleBallsArray];
    // setup all values for "Simple" theme
    [simpleTheme setValuesBackgroundImageName:@"BackgroundBall2"
                                cellImageName:@"cell1"
                                   themeTitle:@"Simple"
                                   textsColor:simpleThemeTextColor
                       buttonsBackgroundColor:simpleThemeButtonsBackgroundColor];
    
    // -- "China" theme
    // create "China" theme
    Theme* chinaTheme = [[Theme alloc] init];
    // define all balls of "China" theme
    NSArray* chinaBallsArray = [[NSArray alloc] initWithObjects:@"China1", @"China2", @"China3", @"China4", @"China5", @"China6", @"China7", nil];
    [[chinaTheme ballImageNamesArray] addObjectsFromArray:chinaBallsArray];
    // setup all values for "China" theme
    [chinaTheme setValuesBackgroundImageName:@"BackgroundChina1"
                               cellImageName:@"cell1"
                                  themeTitle:@"China"
                                  textsColor:chinaThemeTextColor
                      buttonsBackgroundColor:chinaThemeButtonsBackgroundColor];
    
    // -- "East" theme
    // create "East" theme
    Theme* eastTheme = [[Theme alloc] init];
    // define all balls of "East" theme
    NSArray* eastBallsArray = [[NSArray alloc] initWithObjects:@"East1", @"East2", @"East3", @"East4", @"East5", @"East6", @"East7", nil];
    [[eastTheme ballImageNamesArray] addObjectsFromArray:eastBallsArray];
    // setup all values for "East" theme
    [eastTheme setValuesBackgroundImageName:@"BackgroundEast1"
                              cellImageName:@"cell1"
                                 themeTitle:@"East"
                                 textsColor:eastThemeTextColor
                     buttonsBackgroundColor:eastThemeButtonsBackgroundColor];
    
    // -- "Stylish" theme
    // create "Stylish" theme
    Theme* stylishTheme = [[Theme alloc] init];
    // define all balls of "Stylish" theme
    NSArray* stylishBallsArray = [[NSArray alloc] initWithObjects:@"StylishBall1", @"StylishBall2", @"StylishBall3", @"StylishBall4", @"StylishBall5", @"StylishBall6", @"StylishBall7", nil];
    [[stylishTheme ballImageNamesArray] addObjectsFromArray:stylishBallsArray];
    // setup all values for "Stylish" theme
    [stylishTheme setValuesBackgroundImageName:@"BackgroundStylish4"
                                 cellImageName:@"cell1"
                                    themeTitle:@"Stylish"
                                    textsColor:stylishThemeTextColor
                        buttonsBackgroundColor:stylishThemeButtonsBackgroundColor];
    
    // --add all themes to the sharedManager
    NSArray* themes = [[NSArray alloc] initWithObjects:stylishTheme, simpleTheme, eastTheme, chinaTheme, nil];
    [[[ThemeManager sharedThemeManager] arrayOfThemes] addObjectsFromArray: themes];
    
    // --define which theme is default in the shared manager
    [[ThemeManager sharedThemeManager] setCurrentTheme:stylishTheme];
}

@end
