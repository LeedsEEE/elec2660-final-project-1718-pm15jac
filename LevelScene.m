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
    SKLabelNode *_LevelLabel;
    SKSpriteNode *_ellipse;
    
    SKSpriteNode *_gameOver;
    SKSpriteNode *_space; //sprite taken from: https://goo.gl/YTuyHV
    
    SKSpriteNode *_antiGravityField;
    SKFieldNode *_antiRadGravity;
    
    SKSpriteNode *_vortexField; //sprite taken from: https://goo.gl/HTcd3n
    SKFieldNode *_radVortex;
    
    SKSpriteNode *_victoryText;
    
    
    
}

#pragma mark - level generation

- (void)didMoveToView:(SKView *)view { //method loads after the menu takes you to the game
    
    _trigger1=0;
    _trigger2=0;
    
    [self initLevel]; //initialize and configure the first level
    
    
}

-(void)initLevel{ //initialize a level
    
    /*
     initLevel is by far the biggest and possibly most complicated method of the program. I’ve tried to simplify and organise it in a couple ways that ultimately failed and had to be abandoned. I tried to control the initialisation of a node as a very simple method that is called many times within initLevel but the process of handling sprite creation within their own method completely breaks them. I also tried to turn initLevel into its own class and breaking it up into methods. Handling sprites outside of the Scene class also seemed to break them so the result is a very large method called at the start of every level.
     
     */
    
    
    self.data = [[LevelDataModel alloc] init]; //Initialization of the dataModel which contains information describing the creation of a level
    _lives =5; //reset lives at the start of every level. I toyed with the idea of not resetting lives but thought it might make the game too hard
    model *tempModel = [self.data.LevelData objectAtIndex:_level]; //which level to take data for depends on the _level int which is ++ at the end of each level
    
    _finalLevel= self.data.LevelData.count-1; //count how many levels are in the dataModel
    //level 1 is actually level 0 so subtract by 1
    
    _rockAmount=tempModel.rockAmount; //this variable is used outside of this method so it needed to be global
    
    
    _space=[SKSpriteNode spriteNodeWithImageNamed:@"space.jpg"]; //create the background
    _space.position = CGPointMake(0,0);
    _space.size=CGSizeMake(750, 450);
    [self addChild: _space];
    
    
    _ellipseA=tempModel.ellipseA;     _ellipseB=tempModel.ellipseB;
    
    _ellipseConst=1.3*(powf(powf(tempModel.ellipseB.y-tempModel.ellipseA.y, 2)+powf(tempModel.ellipseB.x-tempModel.ellipseA.x, 2), 0.5)); //ellipse contstant is 1.3 times as great as the distance between the two points
    
    _ellipse=[SKSpriteNode spriteNodeWithImageNamed:@"greencircle.png"];
    _ellipse.position = CGPointMake((tempModel.ellipseA.x+tempModel.ellipseB.x)/2,(tempModel.ellipseA.y+tempModel.ellipseB.y)/2); //ellipse position is half way between the two points
    _ellipse.size=CGSizeMake(_ellipseConst*1.1, _ellipseConst*0.65); //size is a consistant ratio no matter where the two points are
    float angel = atanf((tempModel.ellipseB.y-tempModel.ellipseA.y)/(tempModel.ellipseB.x-tempModel.ellipseA.x)); //angel to the horizontal is evaluated from the two points
    
    _ellipse.zRotation=angel;
    _ellipse.alpha=0.7; //all fields are see through
    [self addChild: _ellipse];
    
    
    
    _gravityField = [SKSpriteNode spriteNodeWithImageNamed:@"circle.png"]; //gravityField is an indication to the user of where the arrows will be affected by gravity
    _gravityField.position = tempModel.rock1Pos;
    _gravityField.size =CGSizeMake(tempModel.gravSize, tempModel.gravSize);
    
    _gravityField.alpha=0.7;
    
    [self addChild: _gravityField];
    
    
    _rock = [SKSpriteNode spriteNodeWithImageNamed:@"0.png"];
    
    _rock.size =CGSizeMake(70, 70);
    _rock.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_rock.size.width/2]; //the rock is able to be collided with
    _rock.physicsBody.dynamic = NO; //the rock can not be affected by other physics bodies and is always fixed in place
    [_gravityField addChild: _rock]; //rock is a child of gravityField so they share the same position
    
    _radGravity =[SKFieldNode radialGravityField]; //radGravity is the actual force creating field
    _radGravity.strength = 1;
    _radGravity.falloff =1;
    [_gravityField addChild:_radGravity]; //radGravity shares the same position as rock and gravityField
    
    _radGravity.enabled=false;
    
    _gravityField2.size=CGSizeMake(1, 1); //this size is to fix a bug where the second gravity field should not be in a level but still affects gravity situations
    
    
    
    
    if (tempModel.rockAmount>=2){
        _gravityField2 =[_gravityField copy]; //create a copy of gravity field and its children only if the level has at least 2 rocks
        
        _gravityField2.position =tempModel.rock2Pos;
        _gravityField2.alpha=0.7;
        
        //_rock2=[_rock copy];
        _radGravity2=[_radGravity copy];
        
        
        //[self addChild: rock2];
        [_gravityField2 addChild: _radGravity2];
        [self addChild: _gravityField2];
        
        [_rock2 runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:-M_PI/14 duration:1]]]; //make rock2 spin forever
        
        if (tempModel.rockAmount==3){//create a third copy of gravity field and its children only if the level has 3 rocks
            _gravityField3 =[_gravityField copy];
            
            _gravityField3.position =tempModel.rock3Pos;
            _gravityField3.alpha=0.7;
            
            //_rock3=[_rock copy];
            _radGravity3=[_radGravity copy];
            
            [self addChild: _gravityField3];
            //[self addChild: rock3];
            //[self addChild: radGravity3];
            [_rock3 runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI/14 duration:1]]];
        }
    }
    
    
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
    
    _antiGravityField = [SKSpriteNode spriteNodeWithImageNamed:@"redCircle.png"];
    _antiGravityField.position = tempModel.antiGravity;
    _antiGravityField.size =CGSizeMake(150, 150);
    _antiGravityField.alpha=0.7;
    
    if (_antiGravityField.position.x!=0){ //only create antiGravity when its position has been specified
        [self addChild: _antiGravityField];
    }
    
    
    
    _antiRadGravity =[SKFieldNode electricField]; //_antiGravity acts as an electric field to allow it to push arrows away
    _antiRadGravity.strength = 1;
    _antiRadGravity.falloff =1;
    
    [_antiGravityField addChild:_antiRadGravity];
    
    _vortexField = [SKSpriteNode spriteNodeWithImageNamed:@"vortex.png"];
    _vortexField.position = tempModel.vortex;
    _vortexField.size =CGSizeMake(150, 150);
    _vortexField.alpha=0.7;
    
    if (_vortexField.position.x!=0){
        [self addChild: _vortexField];
    }
    
    
    
    _radVortex =[SKFieldNode vortexField]; //radVortex acts as a vortextField which gives physics objects a perpendicular force
    _radVortex.strength = -0.002; //very small strength is still very strong
    _radVortex.falloff =0.3;
    
    [_vortexField addChild:_radVortex];
    
    [_vortexField runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI/14 duration:1]]];
    
    
    _dial = [SKSpriteNode spriteNodeWithImageNamed:@"dialGrey.png"];
    _dial.position = CGPointMake(-250,-100);
    _dial.size =CGSizeMake(200, 200);
    
    [self addChild: _dial];
    
    _LaunchButton = [SKSpriteNode spriteNodeWithImageNamed:@"red-circle.png"];
    _LaunchButton.position = CGPointMake(-100,-130);
    _LaunchButton.size =CGSizeMake(50, 50);
    
    [self addChild: _LaunchButton];
    
    
    _arrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrowRealGrey.png"];
    _arrow.size =CGSizeMake(50, 10);
    _arrow.zRotation =M_PI;
    _arrow.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: CGSizeMake(_arrow.size.width,
                                                                            _arrow.size.height)];
    _arrow.physicsBody.dynamic = YES;
    _arrow.physicsBody.charge=0.05;
    
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
    _LivesLabel.text = [NSString stringWithFormat:@"Lives: %i",_lives]; //LivesLabel displays amount of lives remaining
    _LivesLabel.fontSize = 20;
    _LivesLabel.fontColor = [SKColor whiteColor];
    _LivesLabel.position = CGPointMake(300, 180);
    
    [self addChild:_LivesLabel];
    
    _LevelLabel = [SKLabelNode labelNodeWithFontNamed:@"arial"];
    _LevelLabel.text = [NSString stringWithFormat:@"Level: %i /%i",_level+1,_finalLevel+1]; //levelLabel displays both current level and the final level to give an indication of progress. The first level is actually 0 so they have to both be ++'d
    _LevelLabel.fontSize = 20;
    _LevelLabel.fontColor = [SKColor whiteColor];
    _LevelLabel.position = CGPointMake(-300, 180);
    
    [self addChild:_LevelLabel];
    
    
    _gameOver = [SKSpriteNode spriteNodeWithImageNamed:@"gameOver.png"];
    _gameOver.position = CGPointMake(0, 0);
    _gameOver.alpha=0; //invisible at the start of level
    [self addChild: _gameOver];
    
    _victoryText = [SKSpriteNode spriteNodeWithImageNamed:@"victoryText.png"];
    _victoryText.position = CGPointMake(0, 0);
    _victoryText.alpha=0;
    _victoryText.xScale=0.5;
    _victoryText.yScale=0.5;
    [self addChild: _victoryText];
    
    
}

#pragma mark - position verification

-(BOOL)distanceCheck:(CGPoint)bodyA: (CGPoint)bodyB: (float)radius{ //a method to determine if two nodes are further apart than a given radius
    if (powf(powf(bodyA.y-bodyB.y, 2)+powf(bodyA.x-bodyB.x, 2), 0.5)<=radius){
        return true;
    }
    else{
        return false;
    }
}

-(void)coinContact{ //method to identify if an arrow has collided with the coin (could be improved: some collisions not detected if hit with end of arrow)
    if ([self distanceCheck:_arrowFire.position :_coin.position :(_coin.size.width)+20]==true &&_level!=_finalLevel){//if arrow close to coin and not final level
        
        _coin.physicsBody.dynamic = YES; //let coin be affected by gravity and physics bodies
        [_coin runAction:[SKAction fadeOutWithDuration:2.0]]; //make the coin fade away
        [_coin runAction:[SKAction scaleTo:2.0 duration:2.0]]; //make the coin increase in size
        
        
        double delayInSeconds = 4.0; //The following 3 lines that create a delay in time were copied from this online source: https://goo.gl/WvrAoW
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self nextLevel]; //a method to pass to the next level
        });
        
        
    }
    else if ([self distanceCheck:_arrowFire.position :_coin.position :(_coin.size.width)+15]==true &&_level==_finalLevel){ //if arrow is close to coin and last level
        _coin.physicsBody.dynamic = YES;
        [_coin runAction:[SKAction fadeOutWithDuration:2.0]];
        [_coin runAction:[SKAction scaleTo:2.0 duration:2.0]];
        
        _victoryText.alpha=1; //reveal the victory text
        
        double delayInSeconds = 6.0; //The following 3 lines that create a delay in time were copied from this online source: https://goo.gl/WvrAoW
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            SKTransition *reveal = [SKTransition doorwayWithDuration:3]; //init doorwary scene transition
            SKScene *menuScene = [[GameScene alloc] initWithSize: self.scene.size]; //point to the menu class and scene
            menuScene.anchorPoint=CGPointMake(0.5, 0.5); //make (0,0) the centre of the scene
            menuScene.scaleMode =SKSceneScaleModeAspectFill; //set scaling mode of scene
            
            [self.scene.view presentScene: menuScene transition: reveal]; //switch scene with transition
        });
        
    }
    
    
    
}




-(int)gravityFind{ //method to identify what gravity state the arrow is in
    
    float r1=_gravityField.size.width/2;
    float r2=_gravityField2.size.width/2;
    float r3=_gravityField3.size.width/2;
    float r4=_antiGravityField.size.width/2;
    
    
    if ([self distanceCheck:_arrowFire.position :_antiGravityField.position :r4]==true){
        _antiRadGravity.enabled=true; //if in antiRadGravity field activate the field
    }
    else{
        _antiRadGravity.enabled=false;//otherwise deactivate the field
    }
    
    
    if ([self distanceCheck:_arrowFire.position :_vortexField.position :r4]==true){
        _radVortex.enabled=true; //if in radVortex field activate the field
        
    }
    else{
        _radVortex.enabled=false; //otherwise deactivate the field
    }
    
    if (_rockAmount==3){                                                                             //if there are 3 rocks in level
        if ( [self distanceCheck:_arrowFire.position :_gravityField.position :r1]==true &&
            [self distanceCheck:_arrowFire.position :_gravityField2.position :r2]==false &&
            [self distanceCheck:_arrowFire.position :_gravityField3.position :r3]==false){
            return 1;                                                                                //if only in gravityField activate just that field and turn the others off
        }
        else if ( [self distanceCheck:_arrowFire.position :_gravityField.position :r1]==false &&
                 [self distanceCheck:_arrowFire.position :_gravityField2.position :r2]==true &&
                 [self distanceCheck:_arrowFire.position :_gravityField3.position :r3]==false){
            return 2;//if only in gravityField2 activate just that field and turn the others off
            
        }
        else if ( [self distanceCheck:_arrowFire.position :_gravityField.position :r1]==false &&
                 [self distanceCheck:_arrowFire.position :_gravityField2.position :r2]==false &&
                 [self distanceCheck:_arrowFire.position :_gravityField3.position :r3]==true){
            return 3; //if only in gravityField3 activate just that field and turn the others off
        }
        
        else{
            return 0;//any other state, turn them all off. This includes contact with all three or any combination of two overlaps
        }
        
    }
    if(_rockAmount==2 ||1){ //if there are one or two rocks in the level
        if ( [self distanceCheck:_arrowFire.position :_gravityField.position :r1]==true &&
            [self distanceCheck:_arrowFire.position :_gravityField2.position :r2]==true){
            return 0; //no gravity if in the overlap
        }
        else if ([self distanceCheck:_arrowFire.position :_gravityField.position :r1]==true){//identifies if the distance between arrow is less than radius
            return 1; //turn on field1 if in it and turn field2 off
            
        }
        else if ([self distanceCheck:_arrowFire.position :_gravityField2.position :r2]==true){
            return 2; //turn on field2 if in it and turn field1 off
        }
        
        else{
            return 0; //otherwise there is no gravity
        }
        
    }
    else{
        return 0; //if there are an amount of rocks greater than 3 then there is no gravity
    }
    
    
}


-(void)ellipseFind{ //a method to find if the player is within the ellipse and adds damping accordingly
    float A = powf(powf(_arrowFire.position.y-_ellipseA.y, 2)+powf(_arrowFire.position.x-_ellipseA.x, 2), 0.5); //distance between arrow and point A
    float B =powf(powf(_arrowFire.position.y-_ellipseB.y, 2)+powf(_arrowFire.position.x-_ellipseB.x, 2), 0.5); //distance between arrow and point B
    if ( A+B<=_ellipseConst){ //if the total of these two distances is less than the ellipseConst then the arrow must be in the ellipse
        
        _arrowFire.physicsBody.linearDamping=2; //slow down the arrow
        _arrowFire.physicsBody.angularDamping=2; //slow down the arrow's turning
    }
    else{
        _arrowFire.physicsBody.linearDamping=0; //no damping when outside of the ellipse
        _arrowFire.physicsBody.angularDamping=0;
    }
}


#pragma mark - touch controls


- (float)touchMovedToPoint:(CGPoint)pos { //a method that runs when a touch input is moved across the screen. I use it to take inputs to the dial
    float Ax=pos.x; //pos.x & pos.y are the current position on the screen in which the user is pressing on
    float Ay=pos.y;
    float Rx=_dial.position.x;
    float Ry=_dial.position.y;
    float r=(_dial.size.width/2);
    
    if ([self distanceCheck:pos:_dial.position :r]==true){ //if touch is within the position and size of the dial
        _angle = atanf((Ay-Ry)/(Ax-Rx)); //find the angle between pos and the centre of the dial
        if (Ax-Rx<=0){
            _angle = atanf((Ay-Ry)/(Ax-Rx))+M_PI; //if touch input is left side of the dial flip the angle by 180 degrees
        }
        _dial.zRotation=_angle; //set dial & arrowCannon rotation as this angle
        _arrowCannon.zRotation=_angle;
        
    }
    return _angle;
    
}

- (void)touchUpAtPoint:(CGPoint)pos { //a method that runs when a press is released
    
    NSTimeInterval timeInterval = [_start timeIntervalSinceNow]; //identify how long since the user started pushing the button.
    
    float r=(_LaunchButton.size.width/2);
    float strength = timeInterval*-150; //strength is proportional to how long hte button was held
    
    
    if ([self distanceCheck:pos:_LaunchButton.position :r]==true && _lives>0){ //if the player releases touch on the button
        if (strength>=750){
            strength=750;//if strength is beyond the limit set it to the limit
        }
        _arrowFire =[_arrow copy]; //create a copy arrowFire of the template arrow
        _arrowFire.position=_arrowCannon.position; //place this copy at the cannon
        _arrowFire.zRotation=_angle+M_PI; //point the arrow right
        [self addChild:_arrowFire]; //create the arrowFire copy
        _arrowFire.physicsBody.velocity = CGVectorMake(strength*cosf(_angle), strength*sinf(_angle)); //give the arrow a velotiy in the direction chosen on the dial and the strength chosen by holding the button
        _lives--; //reduce the amount of lives by one
        _LivesLabel.text = [NSString stringWithFormat:@"Lives: %i",_lives]; //refresh the livesLabel with the new amount
        
        [_cursor removeAllActions]; //stop the cursor from traveling right
        _cursor.position=CGPointMake(-50, -180); //return the cursor to its initial position
    }
}

- (void)touchDownAtPoint:(CGPoint)pos { //a method that is called at the start of a touch
    NSLog(@"x:%f",pos.x); //These NSlogs were used when creating levels to find specific points
    NSLog(@"y:%f",pos.y);
    
    float r=(_LaunchButton.size.width/2);
    
    if ([self distanceCheck:pos :_LaunchButton.position :r]==true && _lives>0){
        _start = [NSDate date]; //log current time to evaluate how long the user holds the button
        [_cursor runAction:[SKAction moveToX:350 duration:5.0]]; //make the cursor move to the end of the power bar over a duration of 5 seconds
        
    }
}

#pragma mark - touch events

//the following 4 methods are necessary to handle touch events. They are a part of the default code included when you load a game in xcode

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

#pragma mark - scene control


- (void)nextLevel{ //a method to control the transition to the next level
    if(_trigger1==0){ //trigger1 used to ensure this code is only run once even
        //[self runAction: self.buttonPressAnimation];
        
        _delay=_now; //save current time as a variable
        if (_level<_finalLevel){ // to ensure that a level that doesn't exist is never attempted to load
            _level++; //increase level
        }
        
        self.removeAllChildren; //delete all nodes
        [self initLevel]; //set up level again with new level information
        _trigger1=1;//trigger1 used to ensure this code is only run once even
        
    }
    
    
    
}


-(void)gameOver{ //a method to handle a loss situation
    
    if(_lives==0){ //when no more lives
        double delayInSeconds = 4.0; //The following 3 lines that create a delay in time were copied from this online source: https://goo.gl/WvrAoW
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (_trigger1==0 && _trigger2==0){ //added if statment to avoid the user winning on their last life and still reciving a game over and allow this code to only be run once per loss
                _gameOver.alpha=1; //show game over
                _trigger2=1; //run code once
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    if(_trigger1==0){
                        SKTransition *reveal = [SKTransition doorwayWithDuration:3];
                        SKScene *menuScene = [[GameScene alloc] initWithSize: self.scene.size];
                        menuScene.anchorPoint=CGPointMake(0.5, 0.5);
                        menuScene.scaleMode =SKSceneScaleModeAspectFill;
                        
                        [self.scene.view presentScene: menuScene transition: reveal]; //return to menu after time delay
                    }
                    else{
                        _trigger2=0; //reset trigger
                    }
                });
            }
        });
    }
}


-(void)update:(CFTimeInterval)currentTime { //a method that is called every frame

    
    if ([self gravityFind] ==1){ //following if statments handle the output of the gravityFind method
        _radGravity.enabled=true;
        _radGravity2.enabled=false;
        _radGravity3.enabled=false;
        
    }
    if ([self gravityFind] ==2){
        _radGravity.enabled=false;
        _radGravity2.enabled=true;
        _radGravity3.enabled=false;
        
    }
    if ([self gravityFind] ==3){
        _radGravity.enabled=false;
        _radGravity2.enabled=false;
        _radGravity3.enabled=true;
        
    }
    else if ([self gravityFind] ==0){
        _radGravity.enabled=false;
        _radGravity2.enabled=false;
        _radGravity3.enabled=false;
        
        
    }
    [self ellipseFind]; //run the following methods every frame
    [self coinContact];
    [self gameOver];
    
    
    _now=currentTime;
    if (_now>=_delay+2){//ensures nextLevel trigger is reset before the user can finish the next level
        _trigger1=0;
    }

    _arrow.position=CGPointMake(400, 400); //keep template arrow out of frame and out of game
    
    self.physicsWorld.gravity=CGVectorMake(0, 0); //ensure that there is no linear gravity present
    
    if (_arrowFire.position.x<-360 || _arrowFire.position.x>360||_arrowFire.position.y<-230 ||_arrowFire.position.y>230){
        [_arrowFire runAction:[SKAction removeFromParent]]; //if an arrow goes out of frame; delete it
    }
    
    
    
    
    
    
    
}
@end
