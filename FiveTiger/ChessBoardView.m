//
//  ChessView.m
//  FiveTiger
//
//  Created by Netiger on 3/15/15.
//  Copyright (c) 2015 Netiger. All rights reserved.
//

#import "ChessBoardView.h"
#import "Chess.h"


@implementation ChessBoardView

@synthesize chessR;
@synthesize chessGridLength;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect is called.");
    [super drawRect:rect];
    
    self.chessR = self.bounds.size.width / 20;
    self.chessGridLength = self.bounds.size.width / 5;
    
    CGFloat gridWidthInterval = self.bounds.size.width / 5;
    CGFloat gridHeightInterval = self.bounds.size.height / 5;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [[UIColor blackColor] setFill];
    //draw lines horizonitally
    for (int i=0; i<5; i++) {
        CGPoint startPoint = CGPointMake(gridWidthInterval/2, gridHeightInterval * (i+0.5));
        CGPoint endPoint = CGPointMake(gridWidthInterval*(4+0.5), gridHeightInterval *(i+0.5));
        [path moveToPoint:startPoint];
        [path addLineToPoint:endPoint];
    }
    
    //draw lines vertically
    for (int i=0; i<5; i++) {
        CGPoint startPoint = CGPointMake(gridWidthInterval*(i+0.5), gridHeightInterval * 0.5);
        CGPoint endPoint = CGPointMake(gridWidthInterval*(i+0.5), gridHeightInterval * 4.5);
        [path moveToPoint:startPoint];
        [path addLineToPoint:endPoint];
    }
    
    [path stroke];
}

@end
