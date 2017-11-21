//
//  SMRotaryWheel.h
//  Angry Gravity
//
//  Created by Joshua Colton [pm15jac] on 21/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMRotaryProtocol.h" 




@interface SMRotaryWheel : UIControl

@property (weak) id <SMRotaryProtocol> delegate;
@property (nonatomic, strong) UIView *container;
@property int numberOfSections;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber;

@end
