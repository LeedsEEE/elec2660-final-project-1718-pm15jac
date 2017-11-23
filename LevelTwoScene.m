//
//  LevelTwoScene.m
//  Angry Gravity
//
//  Created by Joshua Colton [pm15jac] on 23/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "LevelTwoScene.h"

@implementation LevelTwoScene


- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"arial"];
    label.text = @"lives: 5";
    label.fontSize = 40;
    label.fontColor = [SKColor whiteColor];
    label.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self addChild:label];
    
    
}

@end
