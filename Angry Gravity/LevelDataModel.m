//
//  LevelDataModel.m
//  Angry Gravity
//
//  Created by Joshua Colton [pm15jac] on 24/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "LevelDataModel.h"

@implementation LevelDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.LevelData = [NSMutableArray array];
        model *levelOne = [[model alloc]init];
        levelOne.rockAmount =1;
        levelOne.gravSize=300;
        levelOne.rock1Pos=CGPointMake(100, 100);
        levelOne.coinPos=CGPointMake(150, 100);
        [self.LevelData addObject:levelOne];
        
        model*levelTwo=[[model alloc]init];
        levelTwo.rockAmount =2;
        levelTwo.gravSize=200;
        levelTwo.rock1Pos=CGPointMake(100, 100);
        levelTwo.rock2Pos=CGPointMake(100, -50);
        levelTwo.coinPos=CGPointMake(220, 120);
        [self.LevelData addObject:levelTwo];
        


       
        
    }
    return self;
}



@end
