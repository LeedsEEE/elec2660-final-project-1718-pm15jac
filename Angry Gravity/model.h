//
//  model.h
//  Angry Gravity
//
//  Created by Joshua Colton [pm15jac] on 24/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface model : NSObject
//this class is a model with the data needed to define a level
@property int rockAmount;
@property CGPoint rock1Pos; //position of first rock
@property CGPoint rock2Pos; //position of second rock
@property CGPoint rock3Pos; //position of third rock
@property CGFloat gravSize; //size of rock gravity field
@property CGPoint coinPos; //position of coin
@property CGPoint ellipseA; //first ellipse focal point
@property CGPoint ellipseB; //second ellipse focal point
@property CGPoint antiGravity; //position of antiGravity
@property CGPoint vortex; //position of the vortex



@end
