//
//  ThemeManager.h
//  Lines(Taguhi)
//
//  Created by Taguhi Abgaryan on 8/20/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Theme.h"

@interface ThemeManager : NSObject

+ (id)sharedThemeManager;
@property Theme* currentTheme;
@property NSMutableArray* arrayOfThemes;
- (void)setupThemes;

@end
