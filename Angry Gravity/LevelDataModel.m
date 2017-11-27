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
        levelTwo.coinPos=CGPointMake(220, -120);
        [self.LevelData addObject:levelTwo];
        
        model*levelThree=[[model alloc]init];
        levelThree.rockAmount =2;
        levelThree.gravSize=200;
        levelThree.rock1Pos=CGPointMake(150, 120);
        levelThree.rock2Pos=CGPointMake(200, -70);
        levelThree.coinPos=CGPointMake(300, -60);
        
        //levelThree.ellipseA=CGPointMake(180, 10);
        levelThree.ellipseA=CGPointMake(220, 30);
        levelThree.ellipseB=CGPointMake(0, 0);
        [self.LevelData addObject:levelThree];
        
        model*levelFour=[[model alloc]init];
        levelFour.rockAmount =2;
        levelFour.gravSize=300;
        levelFour.rock1Pos=CGPointMake(-150, 100);
        levelFour.rock2Pos=CGPointMake(200, -80);
        levelFour.coinPos=CGPointMake(300, -130);
        
        levelFour.ellipseA=CGPointMake(-40, -100);
        levelFour.ellipseB=CGPointMake(84, 117);
        [self.LevelData addObject:levelFour];
        


       
        
    }
    return self;
}



@end
