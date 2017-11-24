//
//  LevelTwoScene.m
//  Angry Gravity
//
//  Created by Joshua Colton [pm15jac] on 23/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "LevelTwoScene.h"

@implementation LevelTwoScene { //creating nodes in the scene
    SKSpriteNode *_rockHigh;
    SKSpriteNode *_rockLow;
    SKSpriteNode *_arrow;
    SKSpriteNode *_gravityFieldHigh;
    SKSpriteNode *_gravityFieldLow;
    SKFieldNode *_radGravityHigh;
    SKFieldNode *_radGravityLow;
    SKSpriteNode *_coin;
    SKSpriteNode *_dial;
    SKSpriteNode *_arrowCannon;
    SKSpriteNode *_LaunchButton; //Sprite from: https://goo.gl/LucRLq
    SKSpriteNode *_arrowFire;
    SKSpriteNode *_powerBar;
    SKSpriteNode *_cursor;
    SKLabelNode *_LivesLabel;
    
}

- (void)didMoveToView:(SKView *)view {
    

    _lives =5;
    
    
    _gravityFieldHigh = [SKSpriteNode spriteNodeWithImageNamed:@"circle.png"];
    _gravityFieldHigh.position = CGPointMake(100,100);
    _gravityFieldHigh.size =CGSizeMake(200, 200);
    /*
     gravityField.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:gravityField.size.width/2];
     gravityField.physicsBody.dynamic = NO;
     gravityField.physicsBody.collisionBitMask =0b0000;
     */
    [self addChild: _gravityFieldHigh];
    
    _gravityFieldLow =[_gravityFieldHigh copy];
    _gravityFieldLow.position = CGPointMake(100,-50);
    [self addChild: _gravityFieldLow];
    
    
    _arrowCannon = [SKSpriteNode spriteNodeWithImageNamed:@"arrowCanon.png"];
    _arrowCannon.position = CGPointMake(-300,150);
    _arrowCannon.size =CGSizeMake(30, 20);
    
    
    [self addChild: _arrowCannon];
    
    
    
    _coin = [SKSpriteNode spriteNodeWithImageNamed:@"coin.png"];
    _coin.position = CGPointMake(220,120);
    _coin.size =CGSizeMake(20, 20);
    _coin.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_coin.size.width/2];
    _coin.physicsBody.dynamic = NO;
    
    [self addChild: _coin];
    
    
    _dial = [SKSpriteNode spriteNodeWithImageNamed:@"dial.png"];
    _dial.position = CGPointMake(-250,-100);
    _dial.size =CGSizeMake(200, 200);
    //_dial.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_coin.size.width/2];
    //_dial.physicsBody.dynamic = NO;
    
    [self addChild: _dial];
    
    _LaunchButton = [SKSpriteNode spriteNodeWithImageNamed:@"red-circle.png"];
    _LaunchButton.position = CGPointMake(-100,-130);
    _LaunchButton.size =CGSizeMake(50, 50);
    //_dial.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_coin.size.width/2];
    //_dial.physicsBody.dynamic = NO;
    
    [self addChild: _LaunchButton];
    
    
    
    _rockHigh = [SKSpriteNode spriteNodeWithImageNamed:@"0.png"];
    _rockHigh.position = CGPointMake(100,100);
    _rockHigh.size =CGSizeMake(70, 70);
    _rockHigh.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_rockHigh.size.width/2];
    _rockHigh.physicsBody.dynamic = NO;
    [self addChild: _rockHigh];
    
    
    _radGravityHigh =[SKFieldNode radialGravityField];
    _radGravityHigh.strength = 1;
    _radGravityHigh.falloff =1;
    [_rockHigh addChild:_radGravityHigh];
    
    _radGravityHigh.enabled=false;
    
    
    _rockLow =[_rockHigh copy];
    _rockLow.position = CGPointMake(100,-50);

    [self addChild: _rockLow];
    
    
    _radGravityLow =[_radGravityHigh copy];
    [_rockLow addChild:_radGravityLow];
    
    _radGravityLow.enabled=false;
    
    
    
    
    
    _arrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrowReal.png"];
    _arrow.position = CGPointMake(400,400);
    _arrow.size =CGSizeMake(50, 10);
    _arrow.zRotation =M_PI;
    //_arrow.physicsBody.velocity = self.physicsBody.velocity;
    
    //arrow.physicsBody.collisionBitMask =0b0011;
    _arrow.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: CGSizeMake(_arrow.size.width,
                                                                            _arrow.size.height)];
    
    //_arrow.physicsBody.velocity = CGVectorMake(100, 0); //uncomment this code to test
    _arrow.physicsBody.dynamic = YES;
    //[arrow.physicsBody applyImpulse: CGVectorMake(100, 0)];
    
    [self addChild: _arrow];
    
    _powerBar = [SKSpriteNode spriteNodeWithImageNamed:@"powerGrad.png"];
    _powerBar.position = CGPointMake(150,-180);
    _powerBar.size =CGSizeMake(400, 30);
    
    [self addChild: _powerBar];
    
    _cursor = [SKSpriteNode spriteNodeWithImageNamed:@"cursor.png"];
    _cursor.position = CGPointMake(-50,-180);
    _cursor.size =CGSizeMake(5, 30);
    
    [self addChild: _cursor];
    
    
    _LivesLabel = [SKLabelNode labelNodeWithFontNamed:@"arial"];
    _LivesLabel.text = [NSString stringWithFormat:@"Lives: %i",_lives];
    _LivesLabel.fontSize = 20;
    _LivesLabel.fontColor = [SKColor whiteColor];
    _LivesLabel.position = CGPointMake(300, 180);
    
    [self addChild:_LivesLabel];
    
    
    [_rockHigh runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI/14 duration:1]]];
    [_rockLow runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:-M_PI/14 duration:1]]];

    
}

@end
