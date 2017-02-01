//
//  BoardManager.m
//  Lines(Taguhi)
//
//  Created by Taguhi Abgaryan on 8/20/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "BoardManager.h"
#import "GameConstants.h"
#import "Ball.h"
#import "ThemeManager.h"

@interface BoardManager ()

@property NSMutableArray* matrix;
@property NSMutableArray* freeCellsPointsArray;
@property NSMutableArray* ballsPointsArray;
@property NSMutableArray* upcomingBallViewColors;

@end

@implementation BoardManager

+ (id)sharedBoardManager {
    static BoardManager* sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (instancetype)init {
    if(self = [super init]) {
        self.amountOfRows = defaultAmountOfRows;
        self.amountOfFields = defaultAmountOfFields;
        self.amountOfUpcomingBalls = defaultAmountOfUpcomingBalls;
        self.amountOfBallsToExplode = defaultAmountOfBallsToExplode;
        self.amountOfBallsWhenGameBegins = defaultAmountOfBallsWhenGameBegins;
        self.matrix = [[NSMutableArray alloc] init];
        self.freeCellsPointsArray = [[NSMutableArray alloc] init];
        self.ballsPointsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSMutableArray*)arrayOfUpcomingBallsWithAmountOfBalls:(NSInteger)amountOfBalls {
    NSMutableArray* arrayOfBalls = [[NSMutableArray alloc] init];
    if (self.amountOfUpcomingBalls <= [self.freeCellsPointsArray count]) {
        for (NSInteger index = 0; index < self.amountOfUpcomingBalls; index++) {
            Ball* ball = [[Ball alloc] init];
            NSInteger amountOfFreeCells = [self.freeCellsPointsArray count];
            NSInteger indexOfRandomFreeCellPoint = arc4random() % amountOfFreeCells;
            [ball setOrigin:[[self.freeCellsPointsArray objectAtIndex:indexOfRandomFreeCellPoint] CGPointValue]];
            // remove cell from array of free cells
            [self.freeCellsPointsArray removeObjectAtIndex:indexOfRandomFreeCellPoint];
            // decide random color of ball
            [ball setColorIndex:((arc4random() % (amountOfBalls - 1)) + 1)];
            // fill in matrix color of ball
            [[self.matrix objectAtIndex:ball.origin.x] replaceObjectAtIndex:ball.origin.y withObject:[NSNumber numberWithInteger:ball.colorIndex]];
            // add ball origin to array of balls
            [self.ballsPointsArray addObject:[NSValue valueWithCGPoint:ball.origin]];
            // add ball to array of first balls
            [arrayOfBalls addObject:ball];
        }
    }
    return arrayOfBalls;
}

- (NSMutableArray*)pointsOfBallsToExplodeStartingFromPoint:(CGPoint)point
{
    if ([[BoardManager sharedBoardManager] amountOfBallsToExplode] == 1) {
        NSMutableArray* array = [[NSMutableArray alloc] init];
        [array addObject:[NSValue valueWithCGPoint:point]];
        return array;
    }
    NSInteger amountOfRows = [[BoardManager sharedBoardManager] amountOfRows];
    NSInteger amountOfColumns = [[BoardManager sharedBoardManager] amountOfFields];    
    NSMutableArray* horizontal = [[NSMutableArray alloc] init];
    NSMutableArray* vertical = [[NSMutableArray alloc] init];
    NSMutableArray* firstDiagonal = [[NSMutableArray alloc] init];
    NSMutableArray* secondDiagonal = [[NSMutableArray alloc] init];
    
    // horizontal (to left)
    NSInteger newXCoordinate = point.x;
    NSInteger newYCoordinate = point.y - 1;
    while (newYCoordinate >= 0 && [(self.matrix[newXCoordinate][newYCoordinate]) isEqualToNumber:self.matrix[(long)point.x][(long)point.y]]) {
        [horizontal addObject:[NSValue valueWithCGPoint:CGPointMake(newXCoordinate, newYCoordinate)]];
        newYCoordinate--;
    }
    // horizontal (to right)
    newXCoordinate = point.x;
    newYCoordinate = point.y + 1;
    while (newYCoordinate < amountOfColumns && [(self.matrix[newXCoordinate][newYCoordinate]) isEqualToNumber:self.matrix[(long)point.x][(long)point.y]]) {
        [horizontal addObject:[NSValue valueWithCGPoint:CGPointMake(newXCoordinate, newYCoordinate)]];
        newYCoordinate++;
    }
    // vertical (to up)
    newXCoordinate = point.x - 1;
    newYCoordinate = point.y;
    while (newXCoordinate >= 0 && [(self.matrix[newXCoordinate][newYCoordinate]) isEqualToNumber:self.matrix[(long)point.x][(long)point.y]]) {
        [vertical addObject:[NSValue valueWithCGPoint:CGPointMake(newXCoordinate, newYCoordinate)]];
        newXCoordinate--;
    }
    // vertical (to down)
    newXCoordinate = point.x + 1;
    newYCoordinate = point.y;
    while (newXCoordinate < amountOfRows && [(self.matrix[newXCoordinate][newYCoordinate]) isEqualToNumber:self.matrix[(long)point.x][(long)point.y]]) {
        [vertical addObject:[NSValue valueWithCGPoint:CGPointMake(newXCoordinate, newYCoordinate)]];
        newXCoordinate++;
    }
    // first diagonal (to up-left)
    newXCoordinate = point.x - 1;
    newYCoordinate = point.y - 1;
    while (newYCoordinate >= 0 && newXCoordinate >= 0 && [(self.matrix[newXCoordinate][newYCoordinate]) isEqualToNumber:self.matrix[(long)point.x][(long)point.y]]) {
        [firstDiagonal addObject:[NSValue valueWithCGPoint:CGPointMake(newXCoordinate, newYCoordinate)]];
        newXCoordinate--;
        newYCoordinate--;
    }
    // first diagonal (to down-right)
    newXCoordinate = point.x + 1;
    newYCoordinate = point.y + 1;
    while (newYCoordinate < amountOfColumns && newXCoordinate < amountOfRows && [(self.matrix[newXCoordinate][newYCoordinate]) isEqualToNumber:self.matrix[(long)point.x][(long)point.y]]) {
        [firstDiagonal addObject:[NSValue valueWithCGPoint:CGPointMake(newXCoordinate, newYCoordinate)]];
        newXCoordinate++;
        newYCoordinate++;
    }
    // second diagonal (to up-right)
    newXCoordinate = point.x - 1;
    newYCoordinate = point.y + 1;
    while (newYCoordinate < amountOfColumns && newXCoordinate >= 0 && [(self.matrix[newXCoordinate][newYCoordinate]) isEqualToNumber:self.matrix[(long)point.x][(long)point.y]]) {
        [secondDiagonal addObject:[NSValue valueWithCGPoint:CGPointMake(newXCoordinate, newYCoordinate)]];
        newXCoordinate--;
        newYCoordinate++;
    }
    // second diagonal (to down-left)
    newXCoordinate = point.x + 1;
    newYCoordinate = point.y - 1;
    while (newYCoordinate >= 0 && newXCoordinate < amountOfRows && [(self.matrix[newXCoordinate][newYCoordinate]) isEqualToNumber:self.matrix[(long)point.x][(long)point.y]]) {
        [secondDiagonal addObject:[NSValue valueWithCGPoint:CGPointMake(newXCoordinate, newYCoordinate)]];
        newXCoordinate++;
        newYCoordinate--;
    }
    
    NSMutableArray* ballsArray = [[NSMutableArray alloc] init];
    if ([horizontal count] >= [[BoardManager sharedBoardManager] amountOfBallsToExplode] - 1)
        // add horizontal to balls array
        for (NSInteger index = 0; index < [horizontal count]; index++)
            [ballsArray addObject:[horizontal objectAtIndex:index]];
    if ([vertical count] >= [[BoardManager sharedBoardManager] amountOfBallsToExplode] - 1)
        // add vertical to balls array
        for (NSInteger index = 0; index < [vertical count]; index++)
            [ballsArray addObject:[vertical objectAtIndex:index]];
    if ([firstDiagonal count] >= [[BoardManager sharedBoardManager] amountOfBallsToExplode] - 1)
        // add firstDiagonal to balls array
        for (NSInteger index = 0; index < [firstDiagonal count]; index++)
            [ballsArray addObject:[firstDiagonal objectAtIndex:index]];
    if ([secondDiagonal count] >= [[BoardManager sharedBoardManager] amountOfBallsToExplode] - 1)
        // add secondDiagonal to balls array
        for (NSInteger index = 0; index < [secondDiagonal count]; index++)
            [ballsArray addObject:[secondDiagonal objectAtIndex:index]];
    
    // if balls array is not empty
    if ([ballsArray count] != 0) {
        // add starting point to array
        [ballsArray addObject:[NSValue valueWithCGPoint:point]];
        // update score
        self.currentScore += [ballsArray count];
        if (self.highestScore < self.currentScore)
            self.highestScore = self.currentScore;
        // update matrix
        for (NSInteger index = 0; index < [ballsArray count]; index++) {
            CGPoint point = [[ballsArray objectAtIndex:index] CGPointValue];
            self.matrix[(long)point.x][(long)point.y] = @0;
        }
    }
    return ballsArray;
}

- (void)setupMatrixAndArrays
{
    [self.matrix removeAllObjects];
    // fill matrix with zeroes
    for (NSInteger rowIndex = 0; rowIndex < self.amountOfRows; ++rowIndex)
    {
        NSMutableArray* currentRow = [[NSMutableArray alloc] init];
        for (NSInteger columnIndex = 0; columnIndex < self.amountOfFields; ++columnIndex)
            [currentRow addObject:[NSNumber numberWithInteger:0]];
        [self.matrix addObject:currentRow];
    }
    [self.freeCellsPointsArray removeAllObjects];
    // fill array of free cells
    for (NSInteger rowIndex = 0; rowIndex < [self.matrix count]; ++rowIndex)
        for (NSInteger columnIndex = 0; columnIndex < [[self.matrix objectAtIndex:rowIndex] count]; ++columnIndex) {
            CGPoint point = CGPointMake(rowIndex, columnIndex);
            [self.freeCellsPointsArray addObject:[NSValue valueWithCGPoint:point]];
        }
    [self.ballsPointsArray removeAllObjects];
}

- (NSMutableArray*)arrayOfFirstBallsWithAmountOfBalls:(NSInteger)amountOfBalls
{
    [self setupMatrixAndArrays];
    NSMutableArray* arrayOfBalls = [[NSMutableArray alloc] init];
    
    for (NSInteger index = 0; index < self.amountOfBallsWhenGameBegins; index++) {
        Ball* ball = [[Ball alloc] init];
        NSInteger amountOfFreeCells = [self.freeCellsPointsArray count];
        NSInteger indexOfRandomFreeCellPoint = arc4random() % amountOfFreeCells;
        [ball setOrigin:[[self.freeCellsPointsArray objectAtIndex:indexOfRandomFreeCellPoint] CGPointValue]];
        // remove cell from array of free cells
        [self.freeCellsPointsArray removeObjectAtIndex:indexOfRandomFreeCellPoint];
        // decide random color of ball
        [ball setColorIndex:((arc4random() % (amountOfBalls - 1)) + 1)];
        // fill in matrix color of ball
        [[self.matrix objectAtIndex:ball.origin.x] replaceObjectAtIndex:ball.origin.y withObject:[NSNumber numberWithInteger:ball.colorIndex]];
        // add ball origin to array of balls
        [self.ballsPointsArray addObject:[NSValue valueWithCGPoint:ball.origin]];
        // add ball to array of first balls
        [arrayOfBalls addObject:ball];
    }
    return arrayOfBalls;
}

- (void)moveBallfromSourcePoint:(CGPoint)sourcePoint toDestinationPoint:(CGPoint)destinationPoint
{
    // set values of source point and destination point in matrix
    NSNumber *sourcePointValue = self.matrix[(long)sourcePoint.x][(long)sourcePoint.y];
    self.matrix[(long)sourcePoint.x][(long)sourcePoint.y] = @0;
    self.matrix[(long)destinationPoint.x][(long)destinationPoint.y] = sourcePointValue;
    // remove destination point from free cells array
    for (NSInteger index = 0; index < [self.freeCellsPointsArray count]; index++) {
        CGPoint point = [self.freeCellsPointsArray[index] CGPointValue];
        if (point.x == destinationPoint.x && point.y == destinationPoint.y)
        {
            [self.freeCellsPointsArray removeObjectAtIndex:index];
            break;
        }
    }
    // add source point to free cells array
    [self.freeCellsPointsArray addObject:[NSValue valueWithCGPoint:sourcePoint]];
    // remove source point from balls point array
    for (NSInteger index = 0; index < [self.ballsPointsArray count]; index++) {
        CGPoint point = [self.ballsPointsArray[index] CGPointValue];
        if (point.x == sourcePoint.x && point.y == sourcePoint.y)
        {
            [self.ballsPointsArray removeObjectAtIndex:index];
            break;
        }
    }
    // add destination point to balls points array
    [self.ballsPointsArray addObject:[NSValue valueWithCGPoint:destinationPoint]];
}

- (NSMutableArray*)pathFromSourcePoint:(CGPoint)source toDestinationPoint:(CGPoint)destination {
    NSInteger rows = [[BoardManager sharedBoardManager] amountOfRows];
    NSInteger columns = [[BoardManager sharedBoardManager] amountOfFields];
    
    // create new matrix
    NSMutableArray* matrix = [[NSMutableArray alloc] init];
    // fill matrix with zeroes and obstacles
    NSInteger emptyValue = 0;
    NSInteger obstacleValue = rows * columns;
    for (NSInteger rowIndex = 0; rowIndex < rows; rowIndex++) {
        NSMutableArray* currentRow = [[NSMutableArray alloc] init];
        for (NSInteger columnIndex = 0; columnIndex < columns; columnIndex++)
            // if current element of matrix is equal to 0
            if ([(self.matrix[rowIndex][columnIndex]) isEqualToNumber:[NSNumber numberWithInteger:0]])
                [currentRow addObject:[NSNumber numberWithInteger:emptyValue]];
            else
                [currentRow addObject:[NSNumber numberWithInteger:obstacleValue]];
        [matrix addObject:currentRow];
    }
    
    NSMutableArray* coordArray = [[NSMutableArray alloc] init];
    [coordArray addObject:[NSValue valueWithCGPoint:source]];
    NSInteger startValue = 1;
    [[matrix objectAtIndex:source.x] replaceObjectAtIndex:source.y withObject:[NSNumber numberWithInteger:startValue]];
    
    // while coordArray is not empty
    while ([coordArray count] != 0) {
        CGPoint current = [[coordArray objectAtIndex:0] CGPointValue];
        NSMutableArray* adjacencies = [[NSMutableArray alloc] init];
        
        if (current.x > 0)
            [adjacencies addObject:[NSValue valueWithCGPoint:CGPointMake(current.x - 1, current.y)]];
        if (current.x + 1 < rows)
            [adjacencies addObject:[NSValue valueWithCGPoint:CGPointMake(current.x + 1, current.y)]];
        if (current.y > 0)
            [adjacencies addObject:[NSValue valueWithCGPoint:CGPointMake(current.x, current.y - 1)]];
        if (current.y + 1 < columns)
            [adjacencies addObject:[NSValue valueWithCGPoint:CGPointMake(current.x, current.y + 1)]];
        
        for (NSInteger index = 0; index < adjacencies.count; index++) {
            CGPoint adjacency = [[adjacencies objectAtIndex:index] CGPointValue];
            if (([[[matrix objectAtIndex:adjacency.x] objectAtIndex:adjacency.y] isEqualToNumber:[NSNumber numberWithInteger:emptyValue]])) {
                CGPoint coordArrayFirstPoint = [[coordArray objectAtIndex:0] CGPointValue];
                [[matrix objectAtIndex:adjacency.x] replaceObjectAtIndex:adjacency.y withObject:[NSNumber numberWithInteger:([[[matrix objectAtIndex:coordArrayFirstPoint.x] objectAtIndex:coordArrayFirstPoint.y] integerValue] + 1) ]];
                [coordArray addObject:[NSValue valueWithCGPoint:adjacency]];
            }
        }
        [coordArray removeObjectAtIndex:0];
    }
    
    NSInteger backTrackValue = [[[matrix objectAtIndex:destination.x] objectAtIndex:destination.y] integerValue];
    CGPoint backTrackPoint = destination;
    NSMutableArray* path = [[NSMutableArray alloc] init];
    
    // backtracking the path
    if (backTrackValue != emptyValue) {
        [path addObject:[NSValue valueWithCGPoint:destination]];
        
        while (!(backTrackPoint.x == source.x && backTrackPoint.y == source.y)) {
            if (backTrackPoint.x - 1 >= 0 && ([[[matrix objectAtIndex:(backTrackPoint.x - 1)] objectAtIndex:(backTrackPoint.y)] integerValue] == backTrackValue - 1)) {
                backTrackValue--;
                backTrackPoint = CGPointMake(backTrackPoint.x - 1, backTrackPoint.y);
                [path addObject:[NSValue valueWithCGPoint:backTrackPoint]];
            } else if (backTrackPoint.x + 1 < rows && ([[[matrix objectAtIndex:(backTrackPoint.x + 1)] objectAtIndex:(backTrackPoint.y)] integerValue] == backTrackValue - 1)) {
                backTrackValue--;
                backTrackPoint = CGPointMake(backTrackPoint.x + 1, backTrackPoint.y);
                [path addObject:[NSValue valueWithCGPoint:backTrackPoint]];
            } else if (backTrackPoint.y - 1 >= 0 && ([[[matrix objectAtIndex:(backTrackPoint.x)] objectAtIndex:(backTrackPoint.y - 1)] integerValue] == backTrackValue - 1)) {
                backTrackValue--;
                backTrackPoint = CGPointMake(backTrackPoint.x, backTrackPoint.y - 1);
                [path addObject:[NSValue valueWithCGPoint:backTrackPoint]];
            } else if (backTrackPoint.y + 1 < columns && ([[[matrix objectAtIndex:(backTrackPoint.x)] objectAtIndex:(backTrackPoint.y + 1)] integerValue] == backTrackValue - 1)) {
                backTrackValue--;
                backTrackPoint = CGPointMake(backTrackPoint.x, backTrackPoint.y + 1);
                [path addObject:[NSValue valueWithCGPoint:backTrackPoint]];
            }        
        }
    }
    
    // reverse path
    NSMutableArray* reversed = [[[path reverseObjectEnumerator] allObjects] mutableCopy];
    return reversed;
}

@end
