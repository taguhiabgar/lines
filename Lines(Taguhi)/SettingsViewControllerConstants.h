//
//  SettingsVoewControllerConstants.h
//  Lines(Taguhi)
//
//  Created by Taguhi Abgaryan on 8/20/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

// free space between theme buttons in SettingsViewController
static CGFloat settingsViewControllerFreeSpaceBetweenThemeButtons = 10;

// theme buttons height in SettingsViewController
static CGFloat settingsViewControllerThemeButtonsHeight = 40;

// themesTextLabel text in SettingsViewController
static NSString* settingsViewControllerThemesTextLabelText = @"Themes";

// SettingsViewController navigationBar title
static NSString* settingsViewControllerNavigationBarTitleString = @"Settings";

// size of labels in SettingsViewController
static CGFloat settingsViewControllerLabelsHeight = 30;
static CGFloat settingsViewControllerLabelsWidth = 100;

// texts of labels in SettingsViewController
static NSString* settingsViewControllerRowsLabelText = @"Rows: ";
static NSString* settingsViewControllerFieldsLabelText = @"Fields: ";

// increase/decrease buttons in SettingsViewController
static CGFloat settingsViewControllerIncreaseDecreaseButtonsHeight = 30;
static CGFloat settingsViewControllerIncreaseDecreaseButtonsWidth = 30;
static NSString* settingsViewControllerIncreaseButtonsTitleString = @"+";
static NSString* settingsViewControllerDecreaseButtonsTitleString = @"-";

// free space from right, left and top in SettingsViewController
static CGFloat settingsViewControllerFreeSpaceFromLeft = 20;
static CGFloat settingsViewControllerFreeSpaceFromRight = 20;
static CGFloat settingsViewControllerFreeSpaceFromTop = 40;
static CGFloat settingsViewControllerFreeSpaceVertically = 20;
static CGFloat settingsViewControllerFreeSpaceBetweenIncreaseDecreaseButtons = 5;

// labels corner radius in SettingsViewController
static CGFloat settingsViewControllerLabelsCornerRadius = 10.0f;

// labels alpha component in SettingsViewController
static CGFloat settingsViewControllerLabelsBackgroundColorAlphaComponent = 0.6f;

// buttons corner radius in SettingsViewController
static CGFloat settingsViewControllerButtonsCornerRadius = 10.0f;

// buttons alpha component in SettingsViewController
static CGFloat settingsViewControllerButtonsBackgroundColorAlphaComponent = 0.6f;

// amount of rows and fields in single increase/decrease action
static NSInteger increaseAbsoluteValue = 1;
static NSInteger decreaseAbsoluteValue = 1;

// highest/lowest values of riws and fields
static NSInteger amountOfRowsLowestValue = 3;
static NSInteger amountOfRowsHighestValue = 15;
static NSInteger amountOfFieldsLowestValue = 3;
static NSInteger amountOfFieldsHighestValue = 15;
