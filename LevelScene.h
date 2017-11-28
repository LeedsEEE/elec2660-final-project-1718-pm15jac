//
//  LevelTwoScene.h
//  Angry Gravity
//
//  Created by Joshua Colton [pm15jac] on 23/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LevelDataModel.h"
#import  "GameScene.h"
//#import <SKPhysicsBody/SKPhysicsBody.h>

@interface LevelScene : SKScene
@property(nonatomic) NSInteger preferredFramesPerSecond;
@property NSUInteger gravitySituation;
@property float angel;
@property NSDate* start;
@property NSTimeInterval delay;
@property NSTimeInterval now;
@property int lives;
@property int level;
@property BOOL trigger1;
@property BOOL trigger2;


@property float ellipseConst;
@property CGPoint ellipseA;
@property CGPoint ellipseB;
@property int finalLevel;

@property (strong, nonatomic) LevelDataModel *data;

@end
