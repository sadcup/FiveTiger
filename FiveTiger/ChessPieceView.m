//
//  ChessPieceView.m
//  FiveTiger
//
//  Created by Netiger on 3/16/15.
//  Copyright (c) 2015 Netiger. All rights reserved.
//

#import "ChessPieceView.h"

@interface ChessPieceView ()
@property (strong, nonatomic) UIColor *color;
@end

@implementation ChessPieceView


- (void)setup {
    self.backgroundColor = [UIColor clearColor];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame Color:(UIColor *)color {
    self = [self initWithFrame:frame];
    self.color = color;
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat r =  MIN(self.bounds.size.width, self.bounds.size.height) / 2;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    CGPoint center = CGPointMake(self.bounds.origin.x + self.bounds.size.width/2, self.bounds.origin.y+self.bounds.size.height/2);
    [path addArcWithCenter:center radius:r-r/5 startAngle:0.0 endAngle:180 clockwise:YES];
    [[UIColor blackColor] setStroke];
    [path setLineWidth:r/5];
    [self.color setFill];
    [path stroke];
    [path fill];
    [self setNeedsDisplay];
}


@end
