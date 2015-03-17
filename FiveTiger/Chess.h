//
//  Chess.h
//  FiveTiger
//
//  Created by Netiger on 3/16/15.
//  Copyright (c) 2015 Netiger. All rights reserved.
//

#import <Foundation/Foundation.h>
enum Kind{Red, White};
@interface Chess : NSObject

@property (nonatomic) int row;
@property (nonatomic) int col;
@property (nonatomic) enum Kind kind;


- (id)initWithX:(int)x Y:(int)y Kind:(enum Kind)k;

@end
