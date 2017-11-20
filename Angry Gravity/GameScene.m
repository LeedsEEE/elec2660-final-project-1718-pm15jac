//
//  GameScene.m
//  Angry Gravity
//
//  Created by Joshua Colton [pm15jac] on 14/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
    SKSpriteNode *_rock;
    SKSpriteNode *_arrow;
    SKSpriteNode *_gravityField;
    SKFieldNode *_radGravity;
    SKSpriteNode *_coin;
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    _gravityField = [SKSpriteNode spriteNodeWithImageNamed:@"circle.png"];
    _gravityField.position = CGPointMake(100,100);
    _gravityField.size =CGSizeMake(300, 300);
    /*
    gravityField.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:gravityField.size.width/2];
    gravityField.physicsBody.dynamic = NO;
    gravityField.physicsBody.collisionBitMask =0b0000;
     */
    [self addChild: _gravityField];
    
    
    _coin = [SKSpriteNode spriteNodeWithImageNamed:@"coin.png"];
    _coin.position = CGPointMake(150,100);
    _coin.size =CGSizeMake(20, 20);
    _coin.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_coin.size.width/2];
    _coin.physicsBody.dynamic = NO;

    [self addChild: _coin];

    
    
    
    
    
    
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
    
    _arrow.physicsBody.velocity = CGVectorMake(100, 0);
    _arrow.physicsBody.dynamic = YES;
    //[arrow.physicsBody applyImpulse: CGVectorMake(100, 0)];
    
    [self addChild: _arrow];
    
    
    
    
    
    
    
    [_rock runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI/14 duration:1]]];
    
    // Get label node from scene and store it for use later
    _label = (SKLabelNode *)[self childNodeWithName:@"//helloLabel"];
    
    _label.alpha = 0.0;
    [_label runAction:[SKAction fadeInWithDuration:2.0]];
    
    CGFloat w = (self.size.width + self.size.height) * 0.05;
    
    // Create shape node to use during mouse interaction
    _spinnyNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(w, w) cornerRadius:w * 0.3];
    _spinnyNode.lineWidth = 2.5;
    
    [_spinnyNode runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI duration:1]]];
    [_spinnyNode runAction:[SKAction sequence:@[
                                                [SKAction waitForDuration:0.5],
                                                [SKAction fadeOutWithDuration:0.5],
                                                [SKAction removeFromParent],
  
                                                ]]];
}

-(bool)coinContact{
    float Ax=_arrow.position.x;
    float Ay=_arrow.position.y;
    float Rx=_coin.position.x;
    float Ry=_coin.position.y;
    float r=(_coin.size.width/2)+12;
    if (powf(powf(Ay-Ry, 2)+powf(Ax-Rx, 2), 0.5)<=r){
        return 1;
        
    }
    else{
        return 0;
    }

    
   /*
    NSArray *contact = _arrow.physicsBody.allContactedBodies;
    NSArray *contactCoin = (0);
    
    int length = contact.count;
    
    if (length ==1){
        if ([contact[0] isEqual:@"_coin"]){
            return YES;
        }
        else{
            return NO;
        }
    }
    else if (length ==2){
        if ([contact[0] isEqual:@"_coin"] || [contact[1] isEqual:@"_coin"]){
            return YES;
        }
        else{
            return NO;
        }
    }
    
    else{
        return YES;
    }
*/
    
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
        [SKAction waitForDuration: 2];
        //[NSThread sleepForTimeInterval:1];
        //_arrow.physicsBody.dynamic =false;
        [SKView ]
        
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
