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
    
    SKLabelNode *_titleLabel;
    SKLabelNode *_playLabel;
    SKLabelNode *_instructionsLabel;
    SKLabelNode *_exitLabel;

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








-(void)initLevel{ //initialize the first level

    
    
    

    _rock = [SKSpriteNode spriteNodeWithImageNamed:@"0.png"];
    _rock.position = CGPointMake(-100,0);
    _rock.size =CGSizeMake(70, 70);
    _rock.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_rock.size.width/2];
    _rock.physicsBody.dynamic = NO;
    [self addChild: _rock];
    
    _radGravity =[SKFieldNode radialGravityField];
    _radGravity.strength = 1;
    _radGravity.falloff =1;
    [_rock addChild:_radGravity];
    
    _radGravity.enabled=false;
    

    

    _titleLabel = [SKLabelNode labelNodeWithFontNamed:@"arial"];
    _titleLabel.text = [NSString stringWithFormat:@"aggravated \n and \n gravitated"];
    
    _titleLabel.fontSize = 40;
    _titleLabel.fontColor = [SKColor whiteColor];
    _titleLabel.position = CGPointMake(-100, 90);
    
    [self addChild:_titleLabel];
    
    _playLabel = [SKLabelNode labelNodeWithFontNamed:@"arial"];
    _playLabel.text = [NSString stringWithFormat:@"Play"];
    _playLabel.fontSize = 20;
    _playLabel.fontColor = [SKColor whiteColor];
    _playLabel.position = CGPointMake(200, 150);
    
    [self addChild:_playLabel];
    
    _instructionsLabel = [SKLabelNode labelNodeWithFontNamed:@"arial"];
    _instructionsLabel.text = [NSString stringWithFormat:@"Instructions"];
    _instructionsLabel.fontSize = 20;
    _instructionsLabel.fontColor = [SKColor whiteColor];
    _instructionsLabel.position = CGPointMake(200, 0);
    
    [self addChild:_instructionsLabel];
    
    _exitLabel = [SKLabelNode labelNodeWithFontNamed:@"arial"];
    _exitLabel.text = [NSString stringWithFormat:@"Exit"];
    _exitLabel.fontSize = 20;
    _exitLabel.fontColor = [SKColor whiteColor];
    _exitLabel.position = CGPointMake(200, -150);
    
    [self addChild:_exitLabel];
    
    
    
}



- (void)touchMovedToPoint:(CGPoint)pos {


}

- (void)touchUpAtPoint:(CGPoint)pos {
    

}

- (void)touchDownAtPoint:(CGPoint)pos {
    if (pos.x>=0){
        [self nextLevel];
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
        SKTransition *reveal = [SKTransition doorwayWithDuration:3];
        SKScene *levelScene = [[LevelScene alloc] initWithSize: self.scene.size];
        levelScene.anchorPoint=CGPointMake(0.5, 0.5);
        levelScene.scaleMode =SKSceneScaleModeAspectFill;

        [self.scene.view presentScene: levelScene transition: reveal];
        //[self initLevel];
        _trigger=1;

    }
    
  



}

-(void)update:(CFTimeInterval)currentTime {


    

    
    
    




}
@end
