//
//  BoardManager.h
//  Lines(Taguhi)
//
//  Created by Taguhi Abgaryan on 8/20/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BoardManager : NSObject

+ (id)sharedBoardManager;

@property NSUInteger amountOfRows;
@property NSUInteger amountOfFields;
@property NSInteger amountOfUpcomingBalls;
@property NSInteger amountOfBallsWhenGameBegins;
@property NSInteger amountOfBallsToExplode;
@property NSInteger highestScore;
@property NSInteger currentScore;

- (NSMutableArray*)arrayOfFirstBallsWithAmountOfBalls:(NSInteger)amountOfBalls;
- (NSMutableArray*)pathFromSourcePoint:(CGPoint)source toDestinationPoint:(CGPoint)destination;
- (NSMutableArray*)pointsOfBallsToExplodeStartingFromPoint:(CGPoint)point;
- (NSMutableArray*)arrayOfUpcomingBallsWithAmountOfBalls:(NSInteger)amountOfBalls;
- (void)moveBallfromSourcePoint:(CGPoint)sourcePoint toDestinationPoint:(CGPoint)destinationPoint;

@end
