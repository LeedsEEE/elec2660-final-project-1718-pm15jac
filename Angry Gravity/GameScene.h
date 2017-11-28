//
//  GameScene.h
//  Angry Gravity
//
//  Created by Joshua Colton [pm15jac] on 14/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LevelDataModel.h"
#import "LevelScene.h"
//#import <SKPhysicsBody/SKPhysicsBody.h>

@interface GameScene : SKScene


@property (strong, nonatomic) LevelDataModel *data;
@property BOOL trigger;


@end
