//
//  Theme.m
//  Lines(Taguhi)
//
//  Created by Taguhi Abgaryan on 8/16/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "Theme.h"

@implementation Theme

- (instancetype) init
{
    self = [super init];
    if (self != nil)
    {
        self.ballBackgroundImageNamesArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setValuesWithCellBackgroundImageName:(NSString*)cellBackgroundImage andMainViewBackgroundImageName:(NSString*)mainViewBackgroundImage andThemeTitle:(NSString*)title andTextsColor:(UIColor*)textColor andButtonsBackgroundColor:(UIColor*)buttonBackgroundColor
{
    [self setCellBackgroundImageName:cellBackgroundImage];
    [self setMainViewBackgroundImageName:mainViewBackgroundImage];
    [self setThemeTitle:title];
    [self setTextsColor:textColor];
    [self setButtonsBackgroundColor:buttonBackgroundColor];
}

@end
