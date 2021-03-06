//
//  GameScene.m
//  Angry Gravity
//
//  Created by Joshua Colton [pm15jac] on 14/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene { //creating nodes in the scene
    SKSpriteNode *_rock;
    SKFieldNode *_radGravity;
    
    
    SKSpriteNode *_aggravated; //text assets of this kind were generated on: https://cooltext.com
    SKSpriteNode *_plus;
    SKSpriteNode *_gravitated;
    SKSpriteNode *_play;
    SKSpriteNode *_instructions;
    SKSpriteNode *_exit;
    SKSpriteNode *_instructionText;
    SKSpriteNode *_space;

}

#pragma mark- Level Generate and Control

- (void)didMoveToView:(SKView *)view { //a method called at the start of the scene
    _trigger=0;
    
    
    [self initMenu]; //initialize and configure all nodes within the menu
    
    
}



-(void)initMenu{ //initialize the menu
    
    self.physicsWorld.gravity=CGVectorMake(0, 0); //ensure that there is no linear gravity present

    
    _space=[SKSpriteNode spriteNodeWithImageNamed:@"space.jpg"]; //assign an image to the _space sprite
    _space.position = CGPointMake(0,0); //set _space position to (0,0) which is the centre of the screen
    _space.size=CGSizeMake(750, 450); //set the size of the _space node
    [self addChild: _space]; //add _space to scene

    _instructionText=[SKSpriteNode spriteNodeWithImageNamed:@"instructionText.png"];
    _instructionText.position = CGPointMake(0,0);
    _instructionText.alpha=0;
    _instructionText.xScale=0.4;
    _instructionText.yScale=0.4;
    
    [self addChild: _instructionText];
    

    _rock = [SKSpriteNode spriteNodeWithImageNamed:@"0.png"];
    _rock.position = CGPointMake(-150,-80);
    _rock.size =CGSizeMake(100, 100);
    _rock.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_rock.size.width/2];
    _rock.physicsBody.dynamic = NO;
    [self addChild: _rock];
    
    [_rock runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI/14 duration:1]]]; //spin the rock forever
    
    _radGravity =[SKFieldNode radialGravityField];//add a gravity field to the scene at the same position as rock
    _radGravity.strength = 3;
    _radGravity.falloff =1;
    [_rock addChild:_radGravity];
    
    _radGravity.enabled=true;
    

    _play =[SKSpriteNode spriteNodeWithImageNamed:@"play.png"];
    _play.position=CGPointMake(200, 150);
    _play.xScale=0.3;
    _play.yScale=0.3;
    _play.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(294/3,118/3)];
    _play.physicsBody.dynamic = NO;
    
    [self addChild:_play];
    
    _instructions =[SKSpriteNode spriteNodeWithImageNamed:@"instructions.png"];
    _instructions.position=CGPointMake(200, 0);
    _instructions.xScale=0.3;
    _instructions.yScale=0.3;
    _instructions.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(859/3,118/3)];
    _instructions.physicsBody.dynamic = NO;
    
    [self addChild:_instructions];
    
    _exit =[SKSpriteNode spriteNodeWithImageNamed:@"exit.png"];
    _exit.position=CGPointMake(200, -150);
    _exit.xScale=0.3;
    _exit.yScale=0.3;
    _exit.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(237/3,117/3)];
    _exit.physicsBody.dynamic = NO;
    
    [self addChild:_exit];
    
    
    _aggravated =[SKSpriteNode spriteNodeWithImageNamed:@"a.png"];
    _aggravated.position=CGPointMake(-150, 120);
    _aggravated.xScale=0.5;
    _aggravated.yScale=0.5;
    _aggravated.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(767/3,131/3)];
    _aggravated.physicsBody.dynamic = NO;
    
    [self addChild:_aggravated];
    
    _plus =[SKSpriteNode spriteNodeWithImageNamed:@"+.png"];
    _plus.position=CGPointMake(-150, 80);
    _plus.xScale=0.5;
    _plus.yScale=0.5;
    _plus.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:78/3];
    _plus.physicsBody.dynamic = NO;
    
    [self addChild:_plus];
    
    _gravitated =[SKSpriteNode spriteNodeWithImageNamed:@"g.png"];
    _gravitated.position=CGPointMake(-150, 40);
    _gravitated.xScale=0.5;
    _gravitated.yScale=0.5;
    _gravitated.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(694/3,120/3)];
    _gravitated.physicsBody.dynamic = NO;
    
    [self addChild:_gravitated];
    
}

- (void)launchGame{ //a method to launch the game
    if(_trigger==0){//ensure this code is only executed once
        
        SKTransition *reveal = [SKTransition doorwayWithDuration:3]; //assign a transition
        SKScene *levelScene = [[LevelScene alloc] initWithSize: self.scene.size];//connect the LevelScene class to a new scene
        levelScene.anchorPoint=CGPointMake(0.5, 0.5); //let the (0,0) position be in the centre of the screen
        levelScene.scaleMode =SKSceneScaleModeAspectFill;//set the scale mode for the scene to be aspect fill
        
        [self.scene.view presentScene: levelScene transition: reveal]; //move to levelScene
        
        _trigger=1;
        
    }
    
}


#pragma mark - touch controls

- (void)touchDownAtPoint:(CGPoint)pos { //a method called when a touch input starts
    if (67<=pos.x && pos.x<=343){ //if played touch is inline with the buttons
        if (130<=pos.y && pos.y<=180){ //if the touch position is in the y range of the play button
            _gravitated.physicsBody.dynamic = YES; //make all labels physics bodies that are affected by each other and gravity
            _plus.physicsBody.dynamic = YES;
            _aggravated.physicsBody.dynamic = YES;
            _exit.physicsBody.dynamic = YES;
            _instructions.physicsBody.dynamic = YES;
            _play.physicsBody.dynamic = YES;
            
            double delayInSeconds = 4.0; //The following 3 lines that create a delay in time were copied from this online source: https://goo.gl/WvrAoW
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self launchGame]; //launch the game
            });
          }
        if (-20<=pos.y && pos.y<=20){ //if the touch position is in the y range of the instructions button
            //make certain nodes invisable
            _aggravated.alpha=0;
            _plus.alpha=0;
            _gravitated.alpha=0;
            _play.alpha=0;
            _rock.alpha=0;
            
            _exit.position=CGPointMake(-300, 180); //move the exit position to the top left corner to be used to exit the instructions menu
            _instructionText.alpha=1; //reveal the instruction text
            _instructions.position=CGPointMake(0, 180); //move the instruction button to the top of the screen to act as a title
        }
        if (-170<=pos.y && pos.y<=-130){ //if the touch position is in the y range of the exit button
            exit(0); //close the app
        }
    }
    
    if (-360<=pos.x && pos.x<=-240 && 160<=pos.y && pos.y<=200){ //if the exit button in the instruction section is pressed
        
        //invert all the changes made when the instruction button is pressed
        _aggravated.alpha=1;
        _plus.alpha=1;
        _gravitated.alpha=1;
        _play.alpha=1;
        _rock.alpha=1;
        
        _exit.position=CGPointMake(200, -150);
        _instructionText.alpha=0;
        _instructions.position=CGPointMake(200, 0);
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { //a method to detect the event of touching the screen
    for (UITouch *t in touches) {[self touchDownAtPoint:[t locationInNode:self]];}
}



@end
