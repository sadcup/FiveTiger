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

#pragma mark - game controller

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
    }
}

@end
