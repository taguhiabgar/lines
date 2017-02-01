//
//  SettingsViewController.m
//  Lines(Taguhi)
//
//  Created by Taguhi Abgaryan on 8/16/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsViewControllerConstants.h"
#import "ThemeManager.h"
#import "BoardManager.h"

@interface SettingsViewController ()

@property UIImageView* backgroundImageView;
@property UILabel* themesTextLabel;
@property UILabel* rowsTextLabel;
@property UIButton* increaseRowsButton;
@property UIButton* decreaseRowsButton;
@property UILabel* fieldsTextLabel;
@property UIButton* increaseFieldsButton;
@property UIButton* decreaseFieldsButton;

@end

@implementation SettingsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateView];
}

- (void) updateView{
    [self setupBackgroundImageView];
    [self setTitleOfNavigationBar];
    [self setupRowsAndFields];
    [self setupThemesTextLabel];
    [self setupAllThemesButtons];
}

- (void)setupRowsAndFields{
    [self setupRowsTextLabel];
    [self setupIncreaseRowsButton];
    [self setupDecreaseRowsButton];
    [self setupFieldsTextLabel];
    [self setupIncreaseFieldsButton];
    [self setupDecreaseFieldsButton];
}

- (void)setupAllThemesButtons{
    // calculate theme buttons height and width
    CGFloat themeButtonsWidth = (self.view.frame.size.width - settingsViewControllerFreeSpaceFromLeft - settingsViewControllerFreeSpaceFromRight - ([[[ThemeManager sharedThemeManager] arrayOfThemes] count] - 1) * settingsViewControllerFreeSpaceBetweenThemeButtons) / ([[[ThemeManager sharedThemeManager] arrayOfThemes] count]);
    CGFloat themeButtonsHeight = settingsViewControllerThemeButtonsHeight;    
    for (NSInteger currentThemeIndex = 0; currentThemeIndex < [[[ThemeManager sharedThemeManager] arrayOfThemes] count]; currentThemeIndex++) {
        // -- setup current themeButton
        // initialize current themeButton
        UIButton* themeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        // set frame of current themeButton
        themeButton.frame = CGRectMake(settingsViewControllerFreeSpaceFromLeft + currentThemeIndex * (themeButtonsWidth + settingsViewControllerFreeSpaceBetweenThemeButtons), self.themesTextLabel.frame.origin.y + self.themesTextLabel.frame.size.height + settingsViewControllerFreeSpaceBetweenIncreaseDecreaseButtons + settingsViewControllerFreeSpaceVertically, themeButtonsWidth, themeButtonsHeight);
        // set title of current themeButton
        [themeButton setTitle:[[[[ThemeManager sharedThemeManager] arrayOfThemes] objectAtIndex:currentThemeIndex] themeTitle] forState:UIControlStateNormal];
        // set background color of current themeButton
        [themeButton setBackgroundColor:[[[[ThemeManager sharedThemeManager] currentTheme] buttonsBackgroundColor] colorWithAlphaComponent:settingsViewControllerLabelsBackgroundColorAlphaComponent]];
        // set corner radius of current themeButton
        [[themeButton layer] setCornerRadius:settingsViewControllerButtonsCornerRadius];
        // set title color of current themeButton
        [themeButton setTitleColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor] forState:UIControlStateNormal];
        // set tag of current themeButton
        [themeButton setTag:currentThemeIndex];
        // add target to current themeButton
        [themeButton addTarget:self action:@selector(themeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        // add current themeButton to main view
        [self.view addSubview:themeButton];
    }
}

- (void)themeButtonAction:(id)sender{
    [[ThemeManager sharedThemeManager] setCurrentTheme:[[[ThemeManager sharedThemeManager] arrayOfThemes] objectAtIndex:[sender tag]]];
    [self updateView];
}

- (void)setupThemesTextLabel{
    // initialize themesTextLabel
    self.themesTextLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - settingsViewControllerLabelsWidth) / 2, self.rowsTextLabel.frame.origin.y + self.rowsTextLabel.frame.size.height + settingsViewControllerFreeSpaceVertically + settingsViewControllerFreeSpaceVertically, settingsViewControllerLabelsWidth, settingsViewControllerLabelsHeight)];
    // set corner radius of themesTextLabel
    [[self.themesTextLabel layer] setCornerRadius:settingsViewControllerLabelsCornerRadius];
    // set background color of label with alpha component
    [self.themesTextLabel setBackgroundColor:[[[[ThemeManager sharedThemeManager] currentTheme] buttonsBackgroundColor] colorWithAlphaComponent:settingsViewControllerButtonsBackgroundColorAlphaComponent]];
    // set text of themesTextLabel
    [self.themesTextLabel setText:settingsViewControllerThemesTextLabelText];
    // set text color of rowsTextLabel
    [self.themesTextLabel setTextColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor]];
    // set themesTextLabel text alignment to center
    [self.themesTextLabel setTextAlignment:NSTextAlignmentCenter];
    // add themesTextLabel to main view
    [self.view addSubview:self.themesTextLabel];
}

- (void)increaseRowsButtonAction:sender
{
    if ([[BoardManager sharedBoardManager] amountOfRows] < amountOfRowsHighestValue){
        // increase amount of rows in shared manager
        [[BoardManager sharedBoardManager] setAmountOfRows:[[BoardManager sharedBoardManager] amountOfRows] + increaseAbsoluteValue];
        // set text of rowsTextLabel
        NSString* rowsTextLabelText = [settingsViewControllerRowsLabelText stringByAppendingString:[NSString stringWithFormat:@"%lu", (unsigned long)[[BoardManager sharedBoardManager] amountOfRows]]];
        [self.rowsTextLabel setText:rowsTextLabelText];
    }
}

- (void)decreaseRowsButtonAction:sender
{
    if ([[BoardManager sharedBoardManager] amountOfRows] > amountOfRowsLowestValue){
        // decrease amount of rows in shared manager
        [[BoardManager sharedBoardManager] setAmountOfRows:[[BoardManager sharedBoardManager] amountOfRows] - decreaseAbsoluteValue];
        // set text of rowsTextLabel
        NSString* rowsTextLabelText = [settingsViewControllerRowsLabelText stringByAppendingString:[NSString stringWithFormat:@"%lu", (unsigned long)[[BoardManager sharedBoardManager] amountOfRows]]];
        [self.rowsTextLabel setText:rowsTextLabelText];
    }
}

- (void)increaseFieldsButtonAction:sender{
    if ([[BoardManager sharedBoardManager] amountOfFields] < amountOfFieldsHighestValue){
        // increase amount of fields in shared manager
        [[BoardManager sharedBoardManager] setAmountOfFields:[[BoardManager sharedBoardManager] amountOfFields] + increaseAbsoluteValue];
        // set text of fieldsTextLabel
        NSString* fieldsTextLabelText = [settingsViewControllerFieldsLabelText stringByAppendingString:[NSString stringWithFormat:@"%lu", (unsigned long)[[BoardManager sharedBoardManager] amountOfFields]]];
        [self.fieldsTextLabel setText:fieldsTextLabelText];
    }
}

- (void)decreaseFieldsButtonAction:sender{
    if ([[BoardManager sharedBoardManager] amountOfFields] > amountOfFieldsLowestValue){
        // decrease amount of fields in shared manager
        [[BoardManager sharedBoardManager] setAmountOfFields:[[BoardManager sharedBoardManager] amountOfFields] - decreaseAbsoluteValue];
        // set text of fieldsTextLabel
        NSString* fieldsTextLabelText = [settingsViewControllerFieldsLabelText stringByAppendingString:[NSString stringWithFormat:@"%lu", (unsigned long)[[BoardManager sharedBoardManager] amountOfFields]]];
        [self.fieldsTextLabel setText:fieldsTextLabelText];
    }
}

- (void)setupRowsTextLabel{
    // initialize rowsTextLabel
    self.rowsTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(settingsViewControllerFreeSpaceFromLeft, self.navigationController.navigationBar.frame.size.height + settingsViewControllerFreeSpaceFromTop, settingsViewControllerLabelsWidth, settingsViewControllerLabelsHeight)];
    // set corner radius of rowsTextLabel
    [[self.rowsTextLabel layer] setCornerRadius:settingsViewControllerLabelsCornerRadius];
    // set background color of label with alpha component
    [self.rowsTextLabel setBackgroundColor:[[[[ThemeManager sharedThemeManager] currentTheme] buttonsBackgroundColor] colorWithAlphaComponent:settingsViewControllerButtonsBackgroundColorAlphaComponent]];
    // set text of rowsTextLabel
    NSString* rowsTextLabelText = [settingsViewControllerRowsLabelText stringByAppendingString:[NSString stringWithFormat:@"%lu", (unsigned long)[[BoardManager sharedBoardManager] amountOfRows]]];
    [self.rowsTextLabel setText:rowsTextLabelText];
    // set text color of rowsTextLabel
    [self.rowsTextLabel setTextColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor]];
    // add rowsTextLabel to main view
    [self.view addSubview:self.rowsTextLabel];
}

- (void)setupIncreaseRowsButton{
    // initialize increaseRowsButton
    self.increaseRowsButton = [[UIButton alloc] initWithFrame:CGRectMake(self.rowsTextLabel.frame.origin.x + self.rowsTextLabel.frame.size.width + settingsViewControllerFreeSpaceBetweenIncreaseDecreaseButtons, self.rowsTextLabel.frame.origin.y, settingsViewControllerIncreaseDecreaseButtonsWidth, settingsViewControllerIncreaseDecreaseButtonsHeight)];
    // set corner radius of increaseRowsButton
    [[self.increaseRowsButton layer] setCornerRadius:settingsViewControllerLabelsCornerRadius];
    // set background color with alpha component of increaseRowsButton
    [self.increaseRowsButton setBackgroundColor:[[[[ThemeManager sharedThemeManager] currentTheme] buttonsBackgroundColor] colorWithAlphaComponent:settingsViewControllerButtonsBackgroundColorAlphaComponent]];
    // set title of increaseRowsButton
    [self.increaseRowsButton setTitle:settingsViewControllerIncreaseButtonsTitleString forState:UIControlStateNormal];
    // set title color of increaseRowsButton
    [self.increaseRowsButton setTitleColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor] forState:UIControlStateNormal];
    // add target to increaseRowsButton
    [self.increaseRowsButton addTarget:self action:@selector(increaseRowsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    // add increaseRowsButton to main view
    [self.view addSubview:self.increaseRowsButton];
}

- (void)setupDecreaseRowsButton{
    // initialize decreaseRowsButton
    self.decreaseRowsButton = [[UIButton alloc] initWithFrame:CGRectMake(self.increaseRowsButton.frame.origin.x + self.increaseRowsButton.frame.size.width + settingsViewControllerFreeSpaceBetweenIncreaseDecreaseButtons, self.rowsTextLabel.frame.origin.y, settingsViewControllerIncreaseDecreaseButtonsWidth, settingsViewControllerIncreaseDecreaseButtonsHeight)];
    // set corner radius of decreaseRowsButton
    [[self.decreaseRowsButton layer] setCornerRadius:settingsViewControllerLabelsCornerRadius];
    // set background color with alpha component of decreaseRowsButton
    [self.decreaseRowsButton setBackgroundColor:[[[[ThemeManager sharedThemeManager] currentTheme] buttonsBackgroundColor] colorWithAlphaComponent:settingsViewControllerButtonsBackgroundColorAlphaComponent]];
    // set title of decreaseRowsButton
    [self.decreaseRowsButton setTitle:settingsViewControllerDecreaseButtonsTitleString forState:UIControlStateNormal];
    // set title color of decreaseRowsButton
    [self.decreaseRowsButton setTitleColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor] forState:UIControlStateNormal];
    // add target to decreaseRowsButton
    [self.decreaseRowsButton addTarget:self action:@selector(decreaseRowsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    // add decreaseRowsButton to main view
    [self.view addSubview:self.decreaseRowsButton];
}

- (void)setupFieldsTextLabel{
    // initialize fieldsTextLabel
    self.fieldsTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - settingsViewControllerFreeSpaceFromRight - settingsViewControllerIncreaseDecreaseButtonsWidth - settingsViewControllerFreeSpaceBetweenIncreaseDecreaseButtons - settingsViewControllerIncreaseDecreaseButtonsWidth - settingsViewControllerFreeSpaceBetweenIncreaseDecreaseButtons - settingsViewControllerLabelsWidth, self.rowsTextLabel.frame.origin.y, settingsViewControllerLabelsWidth, settingsViewControllerLabelsHeight)];
    // set corner radius of fieldsTextLabel
    [[self.fieldsTextLabel layer] setCornerRadius:settingsViewControllerLabelsCornerRadius];
    // set background color of label with alpha component
    [self.fieldsTextLabel setBackgroundColor:[[[[ThemeManager sharedThemeManager] currentTheme] buttonsBackgroundColor] colorWithAlphaComponent:settingsViewControllerButtonsBackgroundColorAlphaComponent]];
    // set text of fieldsTextLabel
    NSString* fieldsTextLabelText = [settingsViewControllerFieldsLabelText stringByAppendingString:[NSString stringWithFormat:@"%lu", (unsigned long)[[BoardManager sharedBoardManager] amountOfFields]]];
    [self.fieldsTextLabel setText:fieldsTextLabelText];
    // set text color of fieldsTextLabel
    [self.fieldsTextLabel setTextColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor]];
    // add fieldsTextLabel to main view
    [self.view addSubview:self.fieldsTextLabel];
}

- (void)setupIncreaseFieldsButton{
    // initialize increaseFieldsButton
    self.increaseFieldsButton = [[UIButton alloc] initWithFrame:CGRectMake(self.fieldsTextLabel.frame.origin.x + self.fieldsTextLabel.frame.size.width + settingsViewControllerFreeSpaceBetweenIncreaseDecreaseButtons, self.rowsTextLabel.frame.origin.y, settingsViewControllerIncreaseDecreaseButtonsWidth, settingsViewControllerIncreaseDecreaseButtonsHeight)];
    // set corner radius of increaseFieldsButton
    [[self.increaseFieldsButton layer] setCornerRadius:settingsViewControllerLabelsCornerRadius];
    // set background color with alpha component of increaseFieldsButton
    [self.increaseFieldsButton setBackgroundColor:[[[[ThemeManager sharedThemeManager] currentTheme] buttonsBackgroundColor] colorWithAlphaComponent:settingsViewControllerButtonsBackgroundColorAlphaComponent]];
    // set title of increaseFieldsButton
    [self.increaseFieldsButton setTitle:settingsViewControllerIncreaseButtonsTitleString forState:UIControlStateNormal];
    // set title color of increaseFieldsButton
    [self.increaseFieldsButton setTitleColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor] forState:UIControlStateNormal];
    // add target to increaseFieldsButton
    [self.increaseFieldsButton addTarget:self action:@selector(increaseFieldsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    // add increaseFieldsButton to main view
    [self.view addSubview:self.increaseFieldsButton];
}

- (void)setupDecreaseFieldsButton{
    // initialize decreaseFieldsButton
    self.decreaseFieldsButton = [[UIButton alloc] initWithFrame:CGRectMake(self.increaseFieldsButton.frame.origin.x + self.increaseFieldsButton.frame.size.width + settingsViewControllerFreeSpaceBetweenIncreaseDecreaseButtons, self.rowsTextLabel.frame.origin.y, settingsViewControllerIncreaseDecreaseButtonsWidth, settingsViewControllerIncreaseDecreaseButtonsHeight)];
    // set corner radius of decreaseFieldsButton
    [[self.decreaseFieldsButton layer] setCornerRadius:settingsViewControllerLabelsCornerRadius];
    // set background color with alpha component of decreaseFieldsButton
    [self.decreaseFieldsButton setBackgroundColor:[[[[ThemeManager sharedThemeManager] currentTheme] buttonsBackgroundColor] colorWithAlphaComponent:settingsViewControllerButtonsBackgroundColorAlphaComponent]];
    // set title of decreaseFieldsButton
    [self.decreaseFieldsButton setTitle:settingsViewControllerDecreaseButtonsTitleString forState:UIControlStateNormal];
    // set title color of decreaseFieldsButton
    [self.decreaseFieldsButton setTitleColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor] forState:UIControlStateNormal];
    // add target to decreaseFieldsButton
    [self.decreaseFieldsButton addTarget:self action:@selector(decreaseFieldsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    // add decreaseFieldsButton to main view
    [self.view addSubview:self.decreaseFieldsButton];
}

- (void)setTitleOfNavigationBar{
    [self.navigationItem setTitle:settingsViewControllerNavigationBarTitleString];
}

- (void)setupBackgroundImageView{
    // initialize backgroundImageView
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    // set background image of main view
    [self.backgroundImageView setImage:[UIImage imageNamed:[[[ThemeManager sharedThemeManager] currentTheme] mainViewBackgroundImageName]]];
    // add backgroundImageView to main view
    [self.view addSubview:self.backgroundImageView];
}

@end
