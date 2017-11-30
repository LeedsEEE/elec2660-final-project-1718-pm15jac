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
        
        model *levelOne = [[model alloc]init];    //init the first level
        levelOne.rockAmount =1;                   //define the amount of rocks
        levelOne.gravSize=300;                    //define the size of gravity fields
        levelOne.rock1Pos=CGPointMake(100, 100);  //define rock position
        levelOne.coinPos=CGPointMake(180, 100);   //define coin position
        [self.LevelData addObject:levelOne];      //add level one to data model
        
        model*levelTwo=[[model alloc]init];
        levelTwo.rockAmount =2;
        levelTwo.gravSize=200;
        levelTwo.rock1Pos=CGPointMake(100, 100);
        levelTwo.rock2Pos=CGPointMake(100, -50);  //define position of the second rock
        levelTwo.coinPos=CGPointMake(220, -120);
        [self.LevelData addObject:levelTwo];
        
        model*levelThree=[[model alloc]init];
        levelThree.rockAmount =2;
        levelThree.gravSize=200;
        levelThree.rock1Pos=CGPointMake(150, 120);
        levelThree.rock2Pos=CGPointMake(200, -70);
        levelThree.coinPos=CGPointMake(300, -60);
        
        //levelThree.ellipseA=CGPointMake(180, 10);
        levelThree.ellipseA=CGPointMake(220, 30);   //define first and second ellipse focal point
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
        
        model*levelFive=[[model alloc]init];
        levelFive.rockAmount =2;
        levelFive.gravSize=300;
        levelFive.rock1Pos=CGPointMake(100, 150);
        levelFive.rock2Pos=CGPointMake(100, -150);
        levelFive.coinPos=CGPointMake(150, 0);
        
        levelFive.antiGravity=CGPointMake(80, 0);   //define anti gravity location
        [self.LevelData addObject:levelFive];
        
        model*levelSix=[[model alloc]init];
        levelSix.rockAmount =3;
        levelSix.gravSize=300;
        levelSix.rock1Pos=CGPointMake(50, 40);
        levelSix.rock2Pos=CGPointMake(182, -150);
        levelSix.rock3Pos=CGPointMake(285, 40);   //define position of third rock
        levelSix.coinPos=CGPointMake(170, -20);
        [self.LevelData addObject:levelSix];
        
        model*levelSeven=[[model alloc]init];
        levelSeven.rockAmount =3;
        levelSeven.gravSize=300;
        levelSeven.rock1Pos=CGPointMake(50, 40);
        levelSeven.rock2Pos=CGPointMake(182, -150);
        levelSeven.rock3Pos=CGPointMake(285, 40);
        levelSeven.coinPos=CGPointMake(170, -20);
        
        levelSeven.antiGravity=CGPointMake(170, -20);
        [self.LevelData addObject:levelSeven];
        
        model*levelEight=[[model alloc]init];
        levelEight.rockAmount =3;
        levelEight.gravSize=300;
        levelEight.rock1Pos=CGPointMake(50, 40);
        levelEight.rock2Pos=CGPointMake(182, -150);
        levelEight.rock3Pos=CGPointMake(285, 40);
        levelEight.coinPos=CGPointMake(170, -20);
        
        levelEight.vortex=CGPointMake(170, 100);   //define vortex position
        levelEight.antiGravity=CGPointMake(60, -100);
        [self.LevelData addObject:levelEight];
        


       
        
    }
    return self; //return data model array
}



@end
