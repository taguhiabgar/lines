//
//  GameResultViewController.m
//  Lines(Taguhi)
//
//  Created by Taguhi Abgaryan on 8/26/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResultViewControllerConstants.h"
#import "BoardManager.h"
#import "ThemeManager.h"

@interface GameResultViewController ()

@property UIImageView* backgroundImageView;
@property UILabel* scoreLabel;

@end

@implementation GameResultViewController

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
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - gameResultViewControllerScoreLabelWidth) / 2, (self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - gameResultViewControllerScoreLabelHeight) / 2, gameResultViewControllerScoreLabelWidth, gameResultViewControllerScoreLabelHeight)];
    // set text to scoreLabel
    [self.scoreLabel setText: [NSString stringWithFormat:@"%ld",(long)[[BoardManager sharedBoardManager] currentScore]]];
    // set text alignment to center
    [self.scoreLabel setTextAlignment:NSTextAlignmentCenter];
    // set text color
    [self.scoreLabel setTextColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor]];
    // set background color with alpha component
    [self.scoreLabel setBackgroundColor:[[[[ThemeManager sharedThemeManager] currentTheme] buttonsColor] colorWithAlphaComponent:gameResultViewControllerScoreLabelBackgroundColorAlphaComponent]];
    // set font size of scoreLabel
    [self.scoreLabel setFont:[self.scoreLabel.font fontWithSize:gameResultViewControllerScoreLabelTextFontSize]];
    // add scoreLabel to main view
    [self.view addSubview:self.scoreLabel];
}

- (void)setupBackgroundImageView {
    // initialize backgroundImageView
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    // set background image of main view
    [self.backgroundImageView setImage:[UIImage imageNamed:[[[ThemeManager sharedThemeManager] currentTheme] backgroundImageName]]];
    // add backgroundImageView to main view
    [self.view addSubview:self.backgroundImageView];
}

- (void)setTitleOfNavigationBar {
    [self.navigationItem setTitle:gameResultViewControllerNavigationBarTitleString];
}

@end
