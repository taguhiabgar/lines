//
//  Theme.m
//  Lines(Taguhi)
//
//  Created by Taguhi Abgaryan on 8/16/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "Theme.h"

@implementation Theme

- (instancetype) init {
    self = [super init];
    if (self != nil) {
        self.ballImageNamesArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setValuesBackgroundImageName:(NSString*)mainViewBackgroundImage
                       cellImageName:(NSString*)cellBackgroundImage
                          themeTitle:(NSString*)title
                          textsColor:(UIColor*)textColor
              buttonsBackgroundColor:(UIColor*)buttonBackgroundColor {
    
    [self setCellImageName:cellBackgroundImage];
    [self setBackgroundImageName:mainViewBackgroundImage];
    [self setTitle:title];
    [self setTextsColor:textColor];
    [self setButtonsColor:buttonBackgroundColor];
}

@end
