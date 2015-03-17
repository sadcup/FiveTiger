//
//  Chess.m
//  FiveTiger
//
//  Created by Netiger on 3/16/15.
//  Copyright (c) 2015 Netiger. All rights reserved.
//

#import "Chess.h"

@implementation Chess
@synthesize row;
@synthesize col;
@synthesize kind;

- (id)init {
    self = [super init];
    if (self) {
        self.row = 0;
        self.col = 0;
        self.kind = Red;
    }
    return self;
}

- (id)initWithX:(int)x Y:(int)y Kind:(enum Kind)k {
    self = [super init];
    if (self) {
        self.row = x;
        self.col = y;
        self.kind = k;
    }
    return self;
}
@end
