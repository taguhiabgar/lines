//
//  PlayViewController.m
//  Lines(Taguhi)
//
//  Created by Taguhi Abgaryan on 8/16/16.
//  Copyright © 2016 Taguhi Abgaryan. All rights reserved.
//

#import "PlayViewController.h"
#import "PlayViewControllerConstants.h"
#import "GameResultViewController.h"
#import "ThemeManager.h"
#import "BoardManager.h"
#import "Ball.h"

static CGFloat animationDuration = 0.1;
static CGFloat delay = 0.01;

@interface PlayViewController ()

@property NSInteger currentScore;
@property CGFloat boardViewXCoordinate;
@property CGFloat boardViewYCoordinate;
@property CGFloat boardViewWidth;
@property CGFloat boardViewHeight;
@property UIImageView* backgroundImageView;
@property CGFloat cellViewWidth;
@property CGFloat cellViewHeight;
@property CGFloat freeSpaceBetweenCells;
@property CGPoint startPoint;
@property CGPoint destinationPoint;
@property BOOL startPointIsChosen;
@property UIView* ballToMove;
@property NSInteger senderTag;
@property NSMutableArray* arrayOfBallsToExplode;
@property NSMutableArray* arrayOfBallViews;

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.arrayOfBallViews = [[NSMutableArray alloc] init];
    [self updateView];
    [self addFirstBallsToBoard];
    [[BoardManager sharedBoardManager] setCurrentScore:0];
}

- (void)updateView {
    // setup backgroundImageView
    [self setupBackgroundImageView];
    // setup board
    [self setupBoard];
    // setup score
    [self setTitleOfNavigationBar];
    // setup reset button
    [self setupResetButton];
}

- (void)drawBall:(Ball*)ball {
    CGPoint origin = ball.origin;
    NSInteger colorIndex = ball.colorIndex;
    CGPoint boardOrigin = CGPointMake(self.boardViewXCoordinate, self.boardViewYCoordinate);
    CGRect ballFrame = CGRectMake(boardOrigin.x + origin.y * (self.cellViewWidth + self.freeSpaceBetweenCells), boardOrigin.y + origin.x * (self.cellViewHeight + self.freeSpaceBetweenCells), self.cellViewWidth, self.cellViewHeight);
    UIImageView* ballImageView = [[UIImageView alloc] initWithFrame:ballFrame];
    // set image of ball
    [ballImageView setImage:[UIImage imageNamed:[[[[ThemeManager sharedThemeManager] currentTheme] ballBackgroundImageNamesArray] objectAtIndex:colorIndex]]];
    // set tag
    [ballImageView setTag:(origin.x * [[BoardManager sharedBoardManager] amountOfFields] + origin.y)];
    // create tap gesture recognizer
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ballImageViewAction:)];
    // enable user interaction
    ballImageView.userInteractionEnabled = YES;
    // add tap recognizer to ball view
    [ballImageView addGestureRecognizer:tapRecognizer];
    // add ball image view to array of ball image views
    [self.arrayOfBallViews addObject:ballImageView];
    // add ball image view to main view
    [self.view addSubview:ballImageView];
}

- (void)setupResetButton {
    // create resetButton
    UIBarButtonItem *resetBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:playViewControllerResetButtonTitleString style:UIBarButtonItemStylePlain target:self action:@selector(resetButtonAction:)];
    // set resetButton as rightBarButtonItem
    self.navigationItem.rightBarButtonItem = resetBarButtonItem;
}

- (void)addFirstBallsToBoard {
    if ([[BoardManager sharedBoardManager] amountOfBallsToExplode] == 1) {
        [self showGameResultViewController];
    }
    NSMutableArray* arrayOfFirstBalls = [[NSMutableArray alloc] init];
    arrayOfFirstBalls = [[BoardManager sharedBoardManager] arrayOfFirstBallsWithAmountOfBalls:[[[[ThemeManager sharedThemeManager] currentTheme] ballBackgroundImageNamesArray] count]];
    for (NSInteger index = 0; index < [arrayOfFirstBalls count]; index++) {
        Ball* ball = [arrayOfFirstBalls objectAtIndex:index];
        // draw ball on main view
        [self drawBall:ball];
        // get array of balls to explode
        self.arrayOfBallsToExplode = [[BoardManager sharedBoardManager] pointsOfBallsToExplodeStartingFromPoint:ball.origin];
        // if there are balls to explode
        if ([self.arrayOfBallsToExplode count] != 0)
        {
            // explode balls
            [self performSelectorOnMainThread:@selector(explodeBalls) withObject:nil waitUntilDone:NO];
        }
    }
}

- (void)setupBoard {
    // calculate boardView width
    self.boardViewWidth = self.view.frame.size.width - playViewControllerFreeSpaceFromLeft - playViewControllerFreeSpaceFromRight;
    // calculate boardView  XCoordinate and YCoordinate
    self.boardViewXCoordinate = playViewControllerFreeSpaceFromLeft;
    self.boardViewYCoordinate = self.navigationController.navigationBar.frame.size.height + (self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - self.boardViewWidth) / 2;
    // calculate boardView height
    self.boardViewHeight = [[BoardManager sharedBoardManager] amountOfRows] * self.boardViewWidth / [[BoardManager sharedBoardManager] amountOfFields];    
    // make boardView frame
    CGRect boardViewFrame = CGRectMake(self.boardViewXCoordinate, self.boardViewYCoordinate, self.boardViewWidth, self.boardViewHeight);
    // some initializations
    UIImage* cellBackgroundImage = [UIImage imageNamed:[[[ThemeManager sharedThemeManager] currentTheme] cellBackgroundImageName]];
    self.freeSpaceBetweenCells = playViewControllerFreeSpaceBetweenBoardCells;
    // calculate height and width of a single cellView
    self.cellViewWidth = (boardViewFrame.size.width - (([[BoardManager sharedBoardManager] amountOfFields] + 1) * playViewControllerFreeSpaceBetweenBoardCells)) / [[BoardManager sharedBoardManager] amountOfFields];
    self.cellViewHeight = self.cellViewWidth;
    // create board
    for (NSInteger rowIndex = 0; rowIndex < [[BoardManager sharedBoardManager] amountOfRows]; rowIndex++) {
        for (NSInteger fieldIndex = 0; fieldIndex < [[BoardManager sharedBoardManager] amountOfFields]; fieldIndex++) {
            // create frame of a single cell
            CGRect cellFrame = CGRectMake(boardViewFrame.origin.x + playViewControllerFreeSpaceBetweenBoardCells + fieldIndex * (playViewControllerFreeSpaceBetweenBoardCells + self.cellViewWidth), boardViewFrame.origin.y + playViewControllerFreeSpaceBetweenBoardCells + rowIndex * (playViewControllerFreeSpaceBetweenBoardCells + self.cellViewHeight), self.cellViewWidth, self.cellViewHeight);
            // create cell image view
            UIImageView* cellImageView = [[UIImageView alloc] initWithFrame:cellFrame];
            [cellImageView setImage:cellBackgroundImage];
            [cellImageView setTag:(rowIndex * [[BoardManager sharedBoardManager] amountOfFields] + fieldIndex)];
            // create tap gesture recognizer
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellImageViewAction:)];
            [tapRecognizer setNumberOfTouchesRequired:1];
            cellImageView.userInteractionEnabled = YES;
            // add tap gesture recognizer to cell image view
            [cellImageView addGestureRecognizer:tapRecognizer];
            // add cell image view to main view
            [self.view addSubview:cellImageView];
        }
    }
    self.startPointIsChosen = NO;
}

-(void) ballImageViewAction:(id) sender {
    self.startPointIsChosen = YES;
    NSInteger xCoordinate = [[sender view] tag] / ([[BoardManager sharedBoardManager] amountOfFields]);
    NSInteger yCoordinate = [[sender view] tag] - ([[BoardManager sharedBoardManager] amountOfFields] * xCoordinate);
    self.startPoint = CGPointMake(xCoordinate, yCoordinate);
    self.ballToMove = [sender view];
}

-(void) cellImageViewAction:(id) sender {
    if (self.startPointIsChosen) {
        NSInteger xCoordinate = [[sender view] tag] / ([[BoardManager sharedBoardManager] amountOfFields]);
        NSInteger yCoordinate = [[sender view] tag] - ([[BoardManager sharedBoardManager] amountOfFields] * xCoordinate);
        self.destinationPoint = CGPointMake(xCoordinate, yCoordinate);
        // find path from start point to destination point
        NSMutableArray* pointsArrayFromSourceToDestination = [[BoardManager sharedBoardManager] pathFromSourcePoint:self.startPoint toDestinationPoint:self.destinationPoint];
        if (pointsArrayFromSourceToDestination.count != 0) {
            // set sender's tag
            self.senderTag = [[sender view] tag];
            // walk the path
            [self moveBallByPath:pointsArrayFromSourceToDestination];
        }
    }
}

- (void)moveBallByPath:(NSMutableArray*)path {
    if ([path count] > 1) {
        CGPoint firstPoint = [[path objectAtIndex:0] CGPointValue];
        CGPoint secondPoint = [[path objectAtIndex:1] CGPointValue];
        CGFloat ballXCoordinate;
        CGFloat ballYCoordinate;
        
        if (firstPoint.x == secondPoint.x) {
            ballYCoordinate = self.ballToMove.frame.origin.y;
            if (firstPoint.y < secondPoint.y) {
                // move right
                ballXCoordinate = self.ballToMove.frame.origin.x + self.cellViewWidth + self.freeSpaceBetweenCells;
            } else {
                // move left
                ballXCoordinate = self.ballToMove.frame.origin.x - self.cellViewWidth - self.freeSpaceBetweenCells;
            }
        } else {
            ballXCoordinate = self.ballToMove.frame.origin.x;
            if (firstPoint.x < secondPoint.x) {
                // move down
                ballYCoordinate = self.ballToMove.frame.origin.y + self.cellViewHeight + self.freeSpaceBetweenCells;
            } else {
                // move up
                ballYCoordinate = self.ballToMove.frame.origin.y - self.cellViewHeight - self.freeSpaceBetweenCells;
            }
        }
        // animate ball
        [UIView animateWithDuration:animationDuration delay:delay options: UIViewAnimationOptionCurveEaseOut         animations:^{
                             self.ballToMove.frame = CGRectMake(ballXCoordinate, ballYCoordinate, self.ballToMove.frame.size.width, self.ballToMove.frame.size.height);
                         } completion:^(BOOL finished) {
                             [path removeObjectAtIndex:0];
                             [self moveBallByPath:path];
                         }];
        [self.view addSubview:self.ballToMove];
    } else {
        // do additional setup
        [self doAdditionalSetupAfterAnimatingBall];
    }
}

- (void)doAdditionalSetupAfterAnimatingBall
{
    self.startPointIsChosen = NO;
    //change tag
    self.ballToMove.tag = self.senderTag;
    // tell BoardManager about changes
    [[BoardManager sharedBoardManager] moveBallfromSourcePoint:self.startPoint toDestinationPoint:self.destinationPoint];
    // get array of balls to explode
    self.arrayOfBallsToExplode = [[BoardManager sharedBoardManager] pointsOfBallsToExplodeStartingFromPoint:self.destinationPoint];
    if ([self.arrayOfBallsToExplode count] == 0) {
        // draw new balls on board
        NSMutableArray* arrayOfUpcomingBalls = [[BoardManager sharedBoardManager] arrayOfUpcomingBallsWithAmountOfBalls:[[[[ThemeManager sharedThemeManager] currentTheme] ballBackgroundImageNamesArray] count]];
        //if ([arrayOfUpcomingBalls count] == 0) {
        if ([[BoardManager sharedBoardManager] amountOfUpcomingBalls] > ([[BoardManager sharedBoardManager] amountOfRows] * [[BoardManager sharedBoardManager] amountOfFields] - self.arrayOfBallViews.count)){
            [self showGameResultViewController];
        } else {
            for (NSInteger index = 0; index < [arrayOfUpcomingBalls count]; index++) {
                Ball* currentBall = [arrayOfUpcomingBalls objectAtIndex:index];
                [self drawBall:currentBall];
                self.arrayOfBallsToExplode = [[BoardManager sharedBoardManager] pointsOfBallsToExplodeStartingFromPoint:currentBall.origin];
                // if there are balls to explode
                if ([self.arrayOfBallsToExplode count] != 0) {
                    // explode balls
                    [self performSelectorOnMainThread:@selector(explodeBalls) withObject:nil waitUntilDone:NO];
                }
                
            }
        }
    } else {
        // explode balls
        [self performSelectorOnMainThread:@selector(explodeBalls) withObject:nil waitUntilDone:NO];
    }
}

- (void)explodeBalls {
    for (NSInteger index = 0; index < [self.arrayOfBallsToExplode count]; index++) {
        CGPoint currentPoint = [[self.arrayOfBallsToExplode objectAtIndex:index] CGPointValue];
        NSInteger tagValueByPoint = ((long)currentPoint.x * [[BoardManager sharedBoardManager] amountOfFields] + (long)currentPoint.y);
        for (NSInteger indexOfBall = 0; indexOfBall < [self.arrayOfBallViews count]; indexOfBall++) {
            if ([self.arrayOfBallViews[indexOfBall] tag] == tagValueByPoint) {
                [self.arrayOfBallViews[indexOfBall] setHidden:YES];
                [self.arrayOfBallViews[indexOfBall] removeFromSuperview];
            }
        }
    }
    // update score
    [self setTitleOfNavigationBar];
}

- (void)showGameResultViewController {
    GameResultViewController* gameResultViewController = [[GameResultViewController alloc] init];
    // show GameResultViewController
    [self.navigationController pushViewController:gameResultViewController animated:YES];
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
    [self.navigationItem setTitle:[NSString stringWithFormat:@"%ld", [[BoardManager sharedBoardManager] currentScore]]];
}

- (void)resetButtonAction:(id)sender {
    [self updateView];
    [self addFirstBallsToBoard];
}

@end