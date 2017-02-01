//
//  Theme.h
//  Lines(Taguhi)
//
//  Created by Taguhi Abgaryan on 8/16/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Theme : NSObject

@property NSString* cellBackgroundImageName;
@property NSMutableArray* ballBackgroundImageNamesArray;
@property NSString* mainViewBackgroundImageName;
@property NSString* themeTitle;
@property UIColor* textsColor;
@property UIColor* buttonsBackgroundColor;

- (instancetype) init;
- (void)setValuesWithCellBackgroundImageName:(NSString*)cellBackgroundImage andMainViewBackgroundImageName:(NSString*)mainViewBackgroundImage andThemeTitle:(NSString*)title andTextsColor:(UIColor*)textColor andButtonsBackgroundColor:(UIColor*)buttonBackgroundColor;

@end
