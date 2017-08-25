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

@property NSString* cellImageName;
@property NSMutableArray* ballImageNamesArray;
@property NSString* backgroundImageName;
@property NSString* title;
@property UIColor* textsColor;
@property UIColor* buttonsColor;

- (instancetype) init;
- (void)setValuesBackgroundImageName:(NSString*)mainViewBackgroundImage
                       cellImageName:(NSString*)cellBackgroundImage
                          themeTitle:(NSString*)title
                          textsColor:(UIColor*)textColor
              buttonsBackgroundColor:(UIColor*)buttonBackgroundColor;

@end
