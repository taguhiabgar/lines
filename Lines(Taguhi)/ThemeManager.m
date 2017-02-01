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
    UIColor* cakeThemeTextColor = [UIColor magentaColor];
    UIColor* stylishThemeTextColor = [UIColor purpleColor];
    
    // define buttons background colors for each theme
    UIColor* simpleThemeButtonsBackgroundColor = [UIColor whiteColor];
    UIColor* chinaThemeButtonsBackgroundColor = [UIColor whiteColor];
    UIColor* eastThemeButtonsBackgroundColor = [UIColor whiteColor];
    UIColor* cakeThemeButtonsBackgroundColor = [UIColor whiteColor];
    UIColor* stylishThemeButtonsBackgroundColor = [UIColor whiteColor];
    
    // create all themes
    
    // -- "Simple" theme
    // create "Simple" theme
    Theme* simpleTheme = [[Theme alloc] init];
    // define all balls of "Simple" theme
    [[simpleTheme ballBackgroundImageNamesArray] addObject:@"Ball1"];
    [[simpleTheme ballBackgroundImageNamesArray] addObject:@"Ball1"];
    [[simpleTheme ballBackgroundImageNamesArray] addObject:@"Ball2"];
    [[simpleTheme ballBackgroundImageNamesArray] addObject:@"Ball3"];
    [[simpleTheme ballBackgroundImageNamesArray] addObject:@"Ball6"];
    [[simpleTheme ballBackgroundImageNamesArray] addObject:@"Ball7"];
    [[simpleTheme ballBackgroundImageNamesArray] addObject:@"Ball8"];
    // setup all values for "Simple" theme
    [simpleTheme setValuesWithCellBackgroundImageName:@"cell1" andMainViewBackgroundImageName:@"BackgroundBall2" andThemeTitle:@"Simple" andTextsColor:simpleThemeTextColor andButtonsBackgroundColor:simpleThemeButtonsBackgroundColor];
    
    // -- "Cake" theme
    // create "Cake" theme
    Theme* cakeTheme = [[Theme alloc] init];
    // define all balls of "Cake" theme
    [[cakeTheme ballBackgroundImageNamesArray] addObject:@"Cake1"];
    [[cakeTheme ballBackgroundImageNamesArray] addObject:@"Cake1"];
    [[cakeTheme ballBackgroundImageNamesArray] addObject:@"Cake2"];
    [[cakeTheme ballBackgroundImageNamesArray] addObject:@"Cake3"];
    [[cakeTheme ballBackgroundImageNamesArray] addObject:@"Cake4"];
    [[cakeTheme ballBackgroundImageNamesArray] addObject:@"Cake5"];
    // setup all values for "Cake" theme
    [cakeTheme setValuesWithCellBackgroundImageName:@"cell1" andMainViewBackgroundImageName:@"BackgroundCake7" andThemeTitle:@"Candies" andTextsColor:cakeThemeTextColor andButtonsBackgroundColor:cakeThemeButtonsBackgroundColor];
    
    // -- "China" theme
    // create "China" theme
    Theme* chinaTheme = [[Theme alloc] init];
    // define all balls of "China" theme
    [[chinaTheme ballBackgroundImageNamesArray] addObject:@"China1"];
    [[chinaTheme ballBackgroundImageNamesArray] addObject:@"China1"];
    [[chinaTheme ballBackgroundImageNamesArray] addObject:@"China2"];
    [[chinaTheme ballBackgroundImageNamesArray] addObject:@"China3"];
    [[chinaTheme ballBackgroundImageNamesArray] addObject:@"China4"];
    [[chinaTheme ballBackgroundImageNamesArray] addObject:@"China5"];
    [[chinaTheme ballBackgroundImageNamesArray] addObject:@"China6"];
    [[chinaTheme ballBackgroundImageNamesArray] addObject:@"China7"];
    [[chinaTheme ballBackgroundImageNamesArray] addObject:@"China8"];
    [[chinaTheme ballBackgroundImageNamesArray] addObject:@"China9"];
    [[chinaTheme ballBackgroundImageNamesArray] addObject:@"China10"];
    [[chinaTheme ballBackgroundImageNamesArray] addObject:@"China11"];
    // setup all values for "China" theme
    [chinaTheme setValuesWithCellBackgroundImageName:@"cell1" andMainViewBackgroundImageName:@"BackgroundChina1" andThemeTitle:@"China" andTextsColor:chinaThemeTextColor andButtonsBackgroundColor:chinaThemeButtonsBackgroundColor];
    
    // -- "East" theme
    // create "East" theme
    Theme* eastTheme = [[Theme alloc] init];
    // define all balls of "East" theme
    [[eastTheme ballBackgroundImageNamesArray] addObject:@"East1"];
    [[eastTheme ballBackgroundImageNamesArray] addObject:@"East1"];
    [[eastTheme ballBackgroundImageNamesArray] addObject:@"East2"];
    [[eastTheme ballBackgroundImageNamesArray] addObject:@"East3"];
    [[eastTheme ballBackgroundImageNamesArray] addObject:@"East4"];
    [[eastTheme ballBackgroundImageNamesArray] addObject:@"East5"];
    [[eastTheme ballBackgroundImageNamesArray] addObject:@"East6"];
    [[eastTheme ballBackgroundImageNamesArray] addObject:@"East7"];
    [[eastTheme ballBackgroundImageNamesArray] addObject:@"East8"];
    [[eastTheme ballBackgroundImageNamesArray] addObject:@"East9"];
    // setup all values for "East" theme
    [eastTheme setValuesWithCellBackgroundImageName:@"cell1" andMainViewBackgroundImageName:@"BackgroundEast1" andThemeTitle:@"East" andTextsColor:eastThemeTextColor andButtonsBackgroundColor:eastThemeButtonsBackgroundColor];
    
    // -- "Stylish" theme
    // create "Stylish" theme
    Theme* stylishTheme = [[Theme alloc] init];
    // define all balls of "Stylish" theme
    [[stylishTheme ballBackgroundImageNamesArray] addObject:@"StylishBall2"];
    [[stylishTheme ballBackgroundImageNamesArray] addObject:@"StylishBall2"];
    [[stylishTheme ballBackgroundImageNamesArray] addObject:@"StylishBall3"];
    [[stylishTheme ballBackgroundImageNamesArray] addObject:@"StylishBall5"];
    [[stylishTheme ballBackgroundImageNamesArray] addObject:@"StylishBall11"];
    [[stylishTheme ballBackgroundImageNamesArray] addObject:@"StylishBall12"];
    [[stylishTheme ballBackgroundImageNamesArray] addObject:@"StylishBall16"];
    // setup all values for "Stylish" theme
    [stylishTheme setValuesWithCellBackgroundImageName:@"cell1" andMainViewBackgroundImageName:@"BackgroundStylish4" andThemeTitle:@"Stylish" andTextsColor:stylishThemeTextColor andButtonsBackgroundColor:stylishThemeButtonsBackgroundColor];
    
    // --add all themes to the sharedManager
    [[[ThemeManager sharedThemeManager] arrayOfThemes] addObject:simpleTheme];
    [[[ThemeManager sharedThemeManager] arrayOfThemes] addObject:cakeTheme];
    [[[ThemeManager sharedThemeManager] arrayOfThemes] addObject:chinaTheme];
    [[[ThemeManager sharedThemeManager] arrayOfThemes] addObject:eastTheme];
    [[[ThemeManager sharedThemeManager] arrayOfThemes] addObject:stylishTheme];
    
    // --define which theme is default in the shared manager
    [[ThemeManager sharedThemeManager] setCurrentTheme:stylishTheme];
}

@end
