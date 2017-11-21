//
//  GameScene.m
//  Angry Gravity
//
//  Created by Joshua Colton [pm15jac] on 14/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene { //creating nodes in the scene
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
    SKSpriteNode *_rock;
    SKSpriteNode *_arrow;
    SKSpriteNode *_gravityField;
    SKFieldNode *_radGravity;
    SKSpriteNode *_coin;
    SKSpriteNode *_dial;
    SKSpriteNode *_arrowCannon;
    SKSpriteNode *_LaunchButton; //Sprite from: https://goo.gl/LucRLq

}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    [self initLevelOne]; //initialize and configure the first level
    
    
}

- (void)sceneDidLoad: (SKScene*) newScene{
    // Setup your scene here
    
    [self initLevelOne]; //initialize and configure the first level
    
    
}

-(bool)coinContact{
    float Ax=_arrow.position.x;
    float Ay=_arrow.position.y;
    float Rx=_coin.position.x;
    float Ry=_coin.position.y;
    float r=(_coin.size.width)+5;
    if (powf(powf(Ay-Ry, 2)+powf(Ax-Rx, 2), 0.5)<=r){
        return 1;
        
    }
    else{
        return 0;
    }

    
}



-(int)gravityFind{
    float Ax=_arrow.position.x;
    float Ay=_arrow.position.y;
    float Rx=_rock.position.x;
    float Ry=_rock.position.y;
    float r=_gravityField.size.width/2;
    if (powf(powf(Ay-Ry, 2)+powf(Ax-Rx, 2), 0.5)<=r){
        return 1;
    
    }
    else{
        return 0;
    }
    
    
}

-(void)initLevelOne{
    _gravityField = [SKSpriteNode spriteNodeWithImageNamed:@"circle.png"];
    _gravityField.position = CGPointMake(100,100);
    _gravityField.size =CGSizeMake(300, 300);
    /*
     gravityField.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:gravityField.size.width/2];
     gravityField.physicsBody.dynamic = NO;
     gravityField.physicsBody.collisionBitMask =0b0000;
     */
    [self addChild: _gravityField];
    
    
    _arrowCannon = [SKSpriteNode spriteNodeWithImageNamed:@"arrowCanon.png"];
    _arrowCannon.position = CGPointMake(-300,150);
    _arrowCannon.size =CGSizeMake(30, 20);
    
    
    [self addChild: _arrowCannon];

    
    
    _coin = [SKSpriteNode spriteNodeWithImageNamed:@"coin.png"];
    _coin.position = CGPointMake(150,100);
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
    

    
    _rock = [SKSpriteNode spriteNodeWithImageNamed:@"0.png"];
    _rock.position = CGPointMake(100,100);
    _rock.size =CGSizeMake(70, 70);
    _rock.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_rock.size.width/2];
    _rock.physicsBody.dynamic = NO;
    [self addChild: _rock];
    
    
    _radGravity =[SKFieldNode radialGravityField];
    _radGravity.strength = 1;
    _radGravity.falloff =1;
    [_rock addChild:_radGravity];
    
    _radGravity.enabled=false;
    
    
    
    
    
    _arrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrowReal.png"];
    _arrow.position = CGPointMake(-200,10);
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
    
    [_rock runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI/14 duration:1]]];
    
}






- (float)touchMovedToPoint:(CGPoint)pos {
    float Ax=pos.x;
    float Ay=pos.y;
    float Rx=_dial.position.x;
    float Ry=_dial.position.y;
    float r=(_dial.size.width/2);
    
    
  
    
    
    
    if (powf(powf(Ay-Ry, 2)+powf(Ax-Rx, 2), 0.5)<=r){
        _angel = atanf((Ay-Ry)/(Ax-Rx));
        if (Ax-Rx<=0){
            _angel = atanf((Ay-Ry)/(Ax-Rx))+M_PI;
        }
        _dial.zRotation=_angel;
        _arrowCannon.zRotation=_angel;
        
    }
    return _angel;

}

- (void)touchUpAtPoint:(CGPoint)pos {
    float Ax=pos.x;
    float Ay=pos.y;
    float Rx=_LaunchButton.position.x;
    float Ry=_LaunchButton.position.y;
    float r=(_LaunchButton.size.width/2);
    if (powf(powf(Ay-Ry, 2)+powf(Ax-Rx, 2), 0.5)<=r){
        _arrow.physicsBody.velocity = CGVectorMake(100*cosf(_angel), 100*sinf(_angel));
        
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self]];}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}




- (void)nextLevel
{
    //[self runAction: self.buttonPressAnimation];
    SKTransition *reveal = [SKTransition doorwayWithDuration:3];
    SKScene *newScene = [[SKScene alloc] initWithSize: CGSizeMake(1024,768)];
    [self.scene.view presentScene: newScene transition: reveal];

}

-(void)update:(CFTimeInterval)currentTime {

    if ([self gravityFind] ==1){
        _radGravity.enabled=true;

    }
    else if ([self gravityFind] ==0){
        _radGravity.enabled=false;

    
    }
    
    if ([self coinContact] ==YES){
        _coin.physicsBody.dynamic = YES;
        [_coin runAction:[SKAction fadeOutWithDuration:2.0]];
        [_coin runAction:[SKAction scaleTo:2.0 duration:2.0]];


        double delayInSeconds = 4.0; //The following 3 lines that create a delay in time were copied from this online source:
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self nextLevel];
        });
        
        
    }
    else if ([self coinContact] ==NO){
        //_coin.physicsBody.dynamic = NO;
        
        
    }
    

    _arrow.physicsBody.mass=1;
    _arrow.physicsBody.friction=1;
    _arrow.physicsBody.restitution=0.5;
    _arrow.physicsBody.linearDamping=0;
    _arrow.physicsBody.angularDamping=0;
    
    
    

    




}
@end
