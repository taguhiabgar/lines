//
//  HomeViewController.m
//  Lines(Taguhi)
//
//  Created by Taguhi Abgaryan on 8/16/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "HomeViewController.h"
#import "PlayViewController.h"
#import "SettingsViewController.h"
#import "HallOfFameViewController.h"
#import "HomeViewControllerConstants.h"
#import "Theme.h"
#import "ThemeManager.h"
#import "BoardManager.h"

@interface HomeViewController ()

@property UIButton* playButton;
@property UIButton* settingsButton;
@property UIButton* hallOfFameButton;
@property UIButton* rulesButton;
@property UIImageView* backgroundImageView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // setup all themes and choose default theme
    [[ThemeManager sharedThemeManager] setupThemes];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[BoardManager sharedBoardManager] setCurrentScore:0];
    [self updateView];
}

- (void)updateView {
    [self setTitleOfNavigationBar];
    [self setupBackgroundImageView];
    [self setupPlayButton];
    [self setupSettingsButton];
    [self setupHallOfFameButton];
    // setup navigationBar
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[[[ThemeManager sharedThemeManager] currentTheme] textsColor]}];
}

- (void)setupBackgroundImageView {
    // initialize backgroundImageView
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    // set background image of main view
    [self.backgroundImageView setImage:[UIImage imageNamed:[[[ThemeManager sharedThemeManager] currentTheme] backgroundImageName]]];
    // add backgroundImageView to main view
    [self.view addSubview:self.backgroundImageView];
}

- (void)setupPlayButton {
    // decide origin to bring playButton to center horizontally
    CGPoint playButtonOrigin = CGPointMake((self.view.frame.size.width - homeViewControllerButtonsWidth) / 2,(self.view.frame.size.height - homeViewControllerButtonsHeight) / 2);
    // set position of playButton
    self.playButton = [[UIButton alloc] initWithFrame:CGRectMake(playButtonOrigin.x, playButtonOrigin.y - (homeViewControllerButtonsHeight + homeViewControllerSpaceBetweenButtons), homeViewControllerButtonsWidth, homeViewControllerButtonsHeight)];
    // handle playButton touch up inside action event
    [self.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    // set title of playButton
    [self.playButton setTitle:playButtonTitleString forState:UIControlStateNormal];
    // set corner radius of playButton
    [[self.playButton layer] setCornerRadius:homeViewControllerButtonsCornerRadius];
    // set playButton background color with alpha component
    [self.playButton setBackgroundColor:[[[[ThemeManager sharedThemeManager] currentTheme] buttonsColor] colorWithAlphaComponent:homeViewControllerButtonsBackgroundColorAlphaComponent]];
    // set playButton title color
    [self.playButton setTitleColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor] forState:UIControlStateNormal];
    //add playButton to main view
    [self.view addSubview:self.playButton];
}

- (void)setupSettingsButton {
    // decide origin to bring settingsButton to center horizontally
    CGPoint settingsButtonOrigin = CGPointMake((self.view.frame.size.width - homeViewControllerButtonsWidth) / 2, (self.view.frame.size.height - homeViewControllerButtonsHeight) / 2);
    // set position of settingsButton
    self.settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(settingsButtonOrigin.x, settingsButtonOrigin.y, homeViewControllerButtonsWidth, homeViewControllerButtonsHeight)];
    // handle settingsButton touch up inside action event
    [self.settingsButton addTarget:self action:@selector(settingsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    // set title of settingsButton
    [self.settingsButton setTitle:settingsButtonTitleString forState:UIControlStateNormal];
    // set corner radius of settingsButton
    [[self.settingsButton layer] setCornerRadius:homeViewControllerButtonsCornerRadius];
    // set settingsButton background color with alpha component
    [self.settingsButton setBackgroundColor:[[[[ThemeManager sharedThemeManager] currentTheme] buttonsColor] colorWithAlphaComponent:homeViewControllerButtonsBackgroundColorAlphaComponent]];
    // set settingsButton title color
    [self.settingsButton setTitleColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor] forState:UIControlStateNormal];
    //add settingsButton to main view
    [self.view addSubview:self.settingsButton];
}

- (void)setupHallOfFameButton {
    // decide origin to bring hallOfFameButton to center horizontally
    CGPoint hallOfFameButtonOrigin = CGPointMake((self.view.frame.size.width - homeViewControllerButtonsWidth) / 2, (self.view.frame.size.height - homeViewControllerButtonsHeight) / 2);
    // set position of hallOfFameButton
    self.hallOfFameButton = [[UIButton alloc] initWithFrame:CGRectMake(hallOfFameButtonOrigin.x, hallOfFameButtonOrigin.y + (homeViewControllerSpaceBetweenButtons + homeViewControllerButtonsHeight), homeViewControllerButtonsWidth, homeViewControllerButtonsHeight)];
    // handle hallOfFameButton touch up inside action event
    [self.hallOfFameButton addTarget:self action:@selector(hallOfFameButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    // set title of hallOfFameButton
    [self.hallOfFameButton setTitle:hallOfFameButtonTitleString forState:UIControlStateNormal];
    // set corner radius of hallOfFameButton
    [[self.hallOfFameButton layer] setCornerRadius:homeViewControllerButtonsCornerRadius];
    // set hallOfFameButton background color with alpha component
    [self.hallOfFameButton setBackgroundColor:[[[[ThemeManager sharedThemeManager] currentTheme] buttonsColor] colorWithAlphaComponent:homeViewControllerButtonsBackgroundColorAlphaComponent]];
    // set hallOfFameButton title color
    [self.hallOfFameButton setTitleColor:[[[ThemeManager sharedThemeManager] currentTheme] textsColor] forState:UIControlStateNormal];
    //add hallOfFameButton to main view
    [self.view addSubview:self.hallOfFameButton];
}

- (void)playButtonAction:(id)sender {
    PlayViewController* playViewController = [[PlayViewController alloc] init];
    // show PlayViewController
    [self.navigationController pushViewController:playViewController animated:YES];    
}

- (void)settingsButtonAction:(id)sender {
    SettingsViewController* settingsViewController = [[SettingsViewController alloc] init];
    // show SettingsViewController
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

- (void)hallOfFameButtonAction:(id)sender {
    HallOfFameViewController* hallOfFameViewController = [[HallOfFameViewController alloc] init];
    // show HallOfFameViewController
    [self.navigationController pushViewController:hallOfFameViewController animated:YES];
}

- (void)setTitleOfNavigationBar {
    [self.navigationItem setTitle:homeViewControllerNavigationBarTitleString];
}

@end
