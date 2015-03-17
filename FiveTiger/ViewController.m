//
//  ViewController.m
//  FiveTiger
//
//  Created by Netiger on 3/14/15.
//  Copyright (c) 2015 Netiger. All rights reserved.
//

#import "ViewController.h"
#import "ChessBoardView.h"
#import "ChessPieceView.h"
#import "Chess.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ChessBoardView *chessBoardView;
@property (strong, nonatomic) NSMutableArray * chessPieces;//of Chess
@property (weak, nonatomic) IBOutlet UILabel *whitePoints;
@property (weak, nonatomic) IBOutlet UILabel *redPoints;

@end

@implementation ViewController
@synthesize redWhiteFlag;

- (NSMutableArray *)chessPieces {
    if (! _chessPieces) {
        _chessPieces = [[NSMutableArray alloc] init];
    }
    return _chessPieces;
}

- (void)setChessRecord:(NSMutableArray *)chesses {
    _chessPieces = chesses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.redWhiteFlag = false;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear is called.");
    
    NSLog(@"Chessview's width is %f.", self.chessBoardView.bounds.size.width);
    NSLog(@"Chessview's height is %f.", self.chessBoardView.bounds.size.height);
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear is called.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Game controller

- (Chess *)isLeagalPoint:(CGPoint)point {
    float gridLength = self.chessBoardView.chessGridLength;
    int corx = point.x / gridLength;
    int cory = point.y / gridLength;
    
    UIView *hitView = [self.chessBoardView hitTest:point withEvent:NULL];
    if ([hitView superview] == self.chessBoardView) {
        //[hitView removeFromSuperview];
        return nil;
    }
    
    if (fabs(point.x-(corx+0.5)*gridLength)<self.chessBoardView.chessR && fabs(point.y-(cory+0.5)*gridLength)<self.chessBoardView.chessR) {
        enum Kind k;
        if (redWhiteFlag)
            k = Red;
        else
            k = White;
        redWhiteFlag = !redWhiteFlag;
        return [[Chess alloc] initWithX:corx Y:cory Kind:k];
    } else {
        return nil;
    }
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.chessBoardView];
    NSLog(@"x: %f, y: %f.", point.x, point.y);
    Chess *che = [self isLeagalPoint:point];
    if (che) {
        NSLog(@"will put a chess.");

        [self.chessPieces addObject:che];
        UIColor *color = che.kind == Red ? [UIColor redColor] : [UIColor whiteColor];
        ChessPieceView *newChessPiece = [[ChessPieceView alloc] initWithFrame:CGRectMake((che.row+0.5)*self.chessBoardView.chessGridLength -self.chessBoardView.chessR, (che.col+0.5)*self.chessBoardView.chessGridLength-self.chessBoardView.chessR, self.chessBoardView.chessR*2, self.chessBoardView.chessR*2) Color:color];
        [self.chessBoardView addSubview:newChessPiece];
        
        [self pointsCalculation];
    }
}

- (void)back {
    if ([self.chessPieces count]) {
        Chess *chess = [self.chessPieces lastObject];
        CGPoint point = CGPointMake((chess.row+0.5)*self.chessBoardView.chessGridLength,
                                    (chess.col+0.5)*self.chessBoardView.chessGridLength);
        UIView *hitView = [self.chessBoardView hitTest:point withEvent:NULL];
        if (hitView) {
            [hitView removeFromSuperview];
        }
        
        redWhiteFlag = !redWhiteFlag;
        
        [self.chessPieces removeLastObject];
    }
}

- (IBAction)backOneStep:(UIButton *)sender {
    [self back];
    [self pointsCalculation];
}
- (IBAction)clearAll:(UIButton *)sender {
    while ([self.chessPieces count]) {
        [self back];
    }
    self.whitePoints.text = [NSString stringWithFormat:@"%d", 0];
    self.redPoints.text = [NSString stringWithFormat:@"%d", 0];
}


#pragma mark Points Calculation
- (int)pointsForKind:(enum Kind)kind {
    int ret = 0;
    int board[5][5] = {0};
    for (Chess *chess in self.chessPieces) {
        board[chess.row][chess.col] = chess.kind==kind ? 1 : 0;
    }
    //Horizontally
    for (int i=0; i<5; i++) {
        bool flag = true;
        for (int j=0; j<5; j++) {
            if (board[i][j]==0) {
                flag = false;
                break;
            }
        }
        if (flag) ret += 5;
    }
    //Vertically
    for (int j=0; j<5; j++) {
        bool flag = true;
        for (int i=0; i<5; i++) {
            if (board[i][j]==0) {
                flag = false;
                break;
            }
        }
        if (flag) ret += 5;
    }
    //
    bool flag = true;
    for (int i=0; i<5; i++) {
        if (board[i][i]==0) {
            flag = false;
            break;
        }
    }
    if (flag) ret += 5;
    
    flag = true;
    for (int i=0; i<5; i++) {
        if (board[4-i][i]==0) {
            flag = false;
            break;
        }
    }
    if (flag) ret += 5;
    
    //five stars
    for (int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
            if( (board[i][j] + board[i][j+2] + board[i+1][j+1] + board[i+2][j] + board[i+2][j+2]) == 5 )
                ret += 5;
        }
    }
    
    //big five
    if (board[0][0] + board[0][4] + board[4][0] + board[2][2] + board[4][4] == 5 ) {
        ret += 10;
    }
    
    //3 points
    if (board[2][0] + board[1][1] + board[0][2] == 3) ret += 3;
    if (board[2][0] + board[1][3] + board[2][4] == 3) ret += 3;
    if (board[2][0] + board[3][1] + board[4][2] == 3) ret += 3;
    if (board[4][2] + board[3][3] + board[2][4] == 3) ret += 3;
    
    //4 points
    if (board[1][0] + board[2][1] + board[3][2] + board[4][3] == 4) ret += 4;
    if (board[0][1] + board[1][2] + board[2][3] + board[3][4] == 4) ret += 4;
    if (board[3][0] + board[2][1] + board[1][2] + board[0][3] == 4) ret += 4;
    if (board[4][1] + board[3][2] + board[2][3] + board[1][4] == 4) ret += 4;
    
    //1 points
    for (int i=0; i<4; i++) {
        for (int j=0; j<4; j++) {
            if (board[i][j]+board[i+1][j]+board[i][j+1]+board[i+1][j+1]==4) ret += 1;
        }
    }
    return ret;
}
- (void)pointsCalculation {
    int whiteScore = [self pointsForKind:White];
    int redScore = [self pointsForKind:Red];
    self.whitePoints.text = [NSString stringWithFormat:@"%d", whiteScore];
    self.redPoints.text = [NSString stringWithFormat:@"%d", redScore];
}

@end
