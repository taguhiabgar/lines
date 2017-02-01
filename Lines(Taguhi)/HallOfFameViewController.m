//
//  HallOfFameViewController.m
//  Lines(Taguhi)
//
//  Created by Taguhi Abgaryan on 8/16/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "HallOfFameViewController.h"
#import "HallOfFameViewControllerConstants.h"
#import "ThemeManager.h"
#import "BoardManager.h"

@interface HallOfFameViewController ()

@property UIImageView* backgroundImageView;
@property UILabel* scoreLabel;

@end

@implementation HallOfFameViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    [self updateView];    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateView];
}

- (void)updateView {
    // set title of navigation bar
    [self setTitleOfNavigationBar];
    // setup backgroundImageView
    [self setupBackgroundImageView];
    // setup scoreLabel
    [self setupScoreLabel];
}

- (void)setupScoreLabel {
    // initialize scoreLabel
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - hallOfFameViewControllerScoreLabelWidth) / 2, (self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - hallOfFameViewControllerScoreLabelHeight) / 2, hallOfFameViewControllerScoreLabelWidth, hallOfFameViewControllerScoreLabelHeight)];
    // set text to scoreLabel    
    [self.scoreLabel setText: [NSString stringWithFormat:@"%ld",(long)[[BoardManager sharedBoardManager] highestScore]]];
    // set text alignment to center
    [self.scoreLabel setTextAlignment:NSTextAlignmentCenter];
    // set text color
    [self.scoreLabel setTextColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor]];
    // set background color with alpha component
    [self.scoreLabel setBackgroundColor:[[[[ThemeManager sharedThemeManager] currentTheme] buttonsBackgroundColor] colorWithAlphaComponent:hallOfFameViewControllerScoreLabelBackgroundColorAlphaComponent]];
    // set font size of scoreLabel
    [self.scoreLabel setFont:[self.scoreLabel.font fontWithSize:hallOfFameViewControllerScoreLabelTextFontSize]];
    // add scoreLabel to main view
    [self.view addSubview:self.scoreLabel];
}

- (void)setupBackgroundImageView {
    // initialize backgroundImageView
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    // set background image of main view
    [self.backgroundImageView setImage:[UIImage imageNamed:[[[ThemeManager sharedThemeManager] currentTheme] mainViewBackgroundImageName]]];    
    // add backgroundImageView to main view
    [self.view addSubview:self.backgroundImageView];
}

- (void)setTitleOfNavigationBar {
    [self.navigationItem setTitle:hallOfFameViewControllerNavigationBarTitleString];
}

@end
