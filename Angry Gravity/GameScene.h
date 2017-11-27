//
//  GameScene.h
//  Angry Gravity
//
//  Created by Joshua Colton [pm15jac] on 14/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LevelTwoScene.h"
#import "LevelDataModel.h"
//#import <SKPhysicsBody/SKPhysicsBody.h>

@interface GameScene : SKScene
@property(nonatomic) NSInteger preferredFramesPerSecond;
@property NSUInteger gravitySituation;
@property float angel;
@property NSDate* start;
@property NSTimeInterval delay;
@property NSTimeInterval now;
@property int lives;
@property int level;
@property BOOL trigger;
@property float ellipseConst;
@property CGPoint ellipseA;
@property CGPoint ellipseB;

@property (strong, nonatomic) LevelDataModel *data;

@end
