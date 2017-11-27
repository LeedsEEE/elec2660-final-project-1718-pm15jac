//
//  LevelTwoScene.m
//  Angry Gravity
//
//  Created by Joshua Colton [pm15jac] on 23/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "LevelScene.h"

@implementation LevelScene { //creating nodes in the scene
    SKSpriteNode *_rock;
    SKSpriteNode *_gravityField;
    SKFieldNode *_radGravity;
    
    SKSpriteNode *_rock2;
    SKSpriteNode *_gravityField2;
    SKFieldNode *_radGravity2;
    
    SKSpriteNode *_rock3;
    SKSpriteNode *_gravityField3;
    SKFieldNode *_radGravity3;
    
    SKSpriteNode *_arrow;
    SKSpriteNode *_coin;
    SKSpriteNode *_dial;
    SKSpriteNode *_arrowCannon;
    SKSpriteNode *_LaunchButton; //Sprite from: https://goo.gl/LucRLq
    SKSpriteNode *_arrowFire;
    SKSpriteNode *_powerBar;
    SKSpriteNode *_cursor;
    SKLabelNode *_LivesLabel;
    SKSpriteNode *_ellipse;
    
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    _trigger=0;
    
    
    [self initLevel]; //initialize and configure the first level
    
    
}

- (void)sceneDidLoad: (SKScene*) LevelTwo{
    // Setup your scene here
    
    [self initLevel]; //initialize and configure the first level
    
    
}


-(BOOL)distanceCheck:(CGPoint)bodyA: (CGPoint)bodyB: (float)radius{
    if (powf(powf(bodyA.y-bodyB.y, 2)+powf(bodyA.x-bodyB.x, 2), 0.5)<=radius){
        return true;
    }
    else{
        return false;
    }
}

-(void)coinContact{ //method to identify if an arrow has collided with the coin (could be improved: some collisions not detected if hit with end of arrow)
    if ([self distanceCheck:_arrowFire.position :_coin.position :(_coin.size.width)+40]==true){
        
        _coin.physicsBody.dynamic = YES;
        [_coin runAction:[SKAction fadeOutWithDuration:2.0]];
        [_coin runAction:[SKAction scaleTo:2.0 duration:2.0]];
        
        
        double delayInSeconds = 4.0; //The following 3 lines that create a delay in time were copied from this online source:
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self nextLevel];
        });
        
        
    }
    
}




-(int)gravityFind{ //method to identify what gravity state the arrow is in
    
    float r=_gravityField.size.width/2;
    
    if ( [self distanceCheck:_arrowFire.position :_gravityField.position :r]==true &&
        [self distanceCheck:_arrowFire.position :_gravityField2.position :r]==true){
        return 0;
    }
    else if ([self distanceCheck:_arrowFire.position :_gravityField.position :r]==true){//identifies if the distance between arrow is less than radius
        return 1;
        
    }
    else if ([self distanceCheck:_arrowFire.position :_gravityField2.position :r]==true){
        return 2;
    }
    
    else{
        return 0;
    }
    
}



-(void)initLevel{ //initialize the first level
    self.data = [[LevelDataModel alloc] init];
    _lives =5;
    model *tempModel = [self.data.LevelData objectAtIndex:_level];
    
    _ellipseA=tempModel.ellipseA;
    _ellipseB=tempModel.ellipseB;
    
    
    
    _gravityField = [SKSpriteNode spriteNodeWithImageNamed:@"circle.png"];
    _gravityField.position = tempModel.rock1Pos;
    _gravityField.size =CGSizeMake(tempModel.gravSize, tempModel.gravSize);
    [self addChild: _gravityField];
    
    _rock = [SKSpriteNode spriteNodeWithImageNamed:@"0.png"];
    //_rock.position = CGPointMake(100,100);
    _rock.size =CGSizeMake(70, 70);
    _rock.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_rock.size.width/2];
    _rock.physicsBody.dynamic = NO;
    [_gravityField addChild: _rock];
    
    _radGravity =[SKFieldNode radialGravityField];
    _radGravity.strength = 1;
    _radGravity.falloff =1;
    [_gravityField addChild:_radGravity];
    
    _radGravity.enabled=false;
    
    
    
    
    
    
    if (tempModel.rockAmount>=2){
        _gravityField2 =[_gravityField copy];
        
        _gravityField2.position =tempModel.rock2Pos;
        
        //_rock2=[_rock copy];
        _radGravity2=[_radGravity copy];
        
        
        //[self addChild: rock2];
        [_gravityField2 addChild: _radGravity2];
        [self addChild: _gravityField2];
        
        
        
        if (tempModel.rockAmount==3){
            _gravityField3 =[_gravityField copy];
            
            _gravityField3.position =tempModel.rock3Pos;
            
            _rock3=[_rock copy];
            _radGravity3=[_radGravity copy];
            
            [self addChild: _gravityField3];
            //[self addChild: rock3];
            //[self addChild: radGravity3];
            
        }
    }
    
    [_rock2 runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:-M_PI/14 duration:1]]];
    [_rock runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI/14 duration:1]]];
    
    
    _arrowCannon = [SKSpriteNode spriteNodeWithImageNamed:@"arrowCanon.png"];
    _arrowCannon.position = CGPointMake(-300,150);
    _arrowCannon.size =CGSizeMake(30, 20);
    
    
    [self addChild: _arrowCannon];
    
    
    
    _coin = [SKSpriteNode spriteNodeWithImageNamed:@"coin.png"];
    _coin.position = tempModel.coinPos;
    _coin.size =CGSizeMake(20, 20);
    _coin.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_coin.size.width/2];
    _coin.physicsBody.dynamic = NO;
    
    [self addChild: _coin];
    
    
    _dial = [SKSpriteNode spriteNodeWithImageNamed:@"dial.png"];
    _dial.position = CGPointMake(-250,-100);
    _dial.size =CGSizeMake(200, 200);
    
    [self addChild: _dial];
    
    _LaunchButton = [SKSpriteNode spriteNodeWithImageNamed:@"red-circle.png"];
    _LaunchButton.position = CGPointMake(-100,-130);
    _LaunchButton.size =CGSizeMake(50, 50);
    
    [self addChild: _LaunchButton];
    
    
    
    _ellipseConst=1.3*(powf(powf(tempModel.ellipseB.y-tempModel.ellipseA.y, 2)+powf(tempModel.ellipseB.x-tempModel.ellipseA.x, 2), 0.5));
    
    _ellipse=[SKSpriteNode spriteNodeWithImageNamed:@"greencircle.png"];
    _ellipse.position = CGPointMake((tempModel.ellipseA.x+tempModel.ellipseB.x)/2,(tempModel.ellipseA.y+tempModel.ellipseB.y)/2);
    _ellipse.size=CGSizeMake(_ellipseConst*1.1, _ellipseConst*0.65);
    float angel = atanf((tempModel.ellipseB.y-tempModel.ellipseA.y)/(tempModel.ellipseB.x-tempModel.ellipseA.x));
    //if (Ax-Rx<=0){
    //    _angel = atanf((Ay-Ry)/(Ax-Rx))+M_PI;
    _ellipse.zRotation=angel;
    [self addChild: _ellipse];
    
    
    
    
    
    
    
    
    _arrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrowReal.png"];
    //_arrow.position = CGPointMake(400,400);
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
    
    
    
}

-(void)ellipseFind{
    float A = powf(powf(_arrowFire.position.y-_ellipseA.y, 2)+powf(_arrowFire.position.x-_ellipseA.x, 2), 0.5);
    float B =powf(powf(_arrowFire.position.y-_ellipseB.y, 2)+powf(_arrowFire.position.x-_ellipseB.x, 2), 0.5);
    if ( A+B<=_ellipseConst){
        
        //_arrowFire.physicsBody.dynamic=false;
        _arrowFire.physicsBody.linearDamping=2;
        _arrowFire.physicsBody.angularDamping=2;
    }
    else{
        //_arrowFire.physicsBody.dynamic=true;
        _arrowFire.physicsBody.linearDamping=0;
        _arrowFire.physicsBody.angularDamping=0;
    }
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
    
    NSTimeInterval timeInterval = [_start timeIntervalSinceNow]; //identify how long since the user started pushing the button.
    
    float r=(_LaunchButton.size.width/2);
    float strength = timeInterval*-150;
    
    if ([self distanceCheck:pos:_LaunchButton.position :r]==true && _lives>0){
        if (strength>=750){
            strength=750;
        }
        _arrowFire =[_arrow copy];
        _arrowFire.position=_arrowCannon.position;
        _arrowFire.zRotation=_angel+M_PI;
        [self addChild:_arrowFire];
        _arrowFire.physicsBody.velocity = CGVectorMake(strength*cosf(_angel), strength*sinf(_angel));
        _lives--;
        _LivesLabel.text = [NSString stringWithFormat:@"Lives: %i",_lives];
        
        [_cursor removeAllActions];
        _cursor.position=CGPointMake(-50, -180);
    }
}

- (void)touchDownAtPoint:(CGPoint)pos {
    
    float r=(_LaunchButton.size.width/2);
    
    if ([self distanceCheck:pos :_LaunchButton.position :r]==true && _lives>0){
        _start = [NSDate date]; //log current time to evaluate how long the user holds the button
        [_cursor runAction:[SKAction moveToX:350 duration:5.0]];
        
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *t in touches) {[self touchDownAtPoint:[t locationInNode:self]];}
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
    if(_trigger==0){
        //[self runAction: self.buttonPressAnimation];
        
        _delay=_now;
        
        _level++;
        //SKTransition *reveal = [SKTransition doorwayWithDuration:3];
        //SKScene *levelTwo = [[GameScene alloc] initWithSize: self.scene.size];
        //levelTwo.anchorPoint=CGPointMake(0.5, 0.5);
        //levelTwo.scaleMode =SKSceneScaleModeAspectFill;
        self.removeAllChildren;
        //[self.scene.view presentScene: levelTwo transition: reveal];
        [self initLevel];
        _trigger=1;
        
    }
    
    /*
     SKScene *levelTwoScene = [[LevelTwoScene alloc] initWithSize: self.scene.size];
     levelTwoScene.scaleMode =SKSceneScaleModeAspectFill;
     levelTwoScene.anchorPoint=CGPointMake(0.5, 0.5);
     [self.scene.view presentScene: levelTwoScene transition: reveal];
     */
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    [self ellipseFind];
    if ([self gravityFind] ==1){
        _radGravity.enabled=true;
        _radGravity2.enabled=false;
        
    }
    if ([self gravityFind] ==2){
        _radGravity.enabled=false;
        _radGravity2.enabled=true;
        
    }
    else if ([self gravityFind] ==0){
        _radGravity.enabled=false;
        _radGravity2.enabled=false;
        
        
    }
    
    [self coinContact];
    
    _now=currentTime;
    if (_now>=_delay+3){//ensures nextLevel only calls once per level up and not ever frame
        _trigger=0;
    }
    
    _arrow.physicsBody.mass=1;
    _arrow.physicsBody.friction=1;
    _arrow.physicsBody.restitution=0.5;
    
    _arrow.physicsBody.angularDamping=0;
    _arrow.position=CGPointMake(400, 400);
    
    self.physicsWorld.gravity=CGVectorMake(0, 0);
    
    
    
    if (_arrowFire.position.x<-360 || _arrowFire.position.x>360||_arrowFire.position.y<-230 ||_arrowFire.position.y>230){
        [_arrowFire runAction:[SKAction removeFromParent]];
    }
    
    
    
    
    
    
    
}
@end
