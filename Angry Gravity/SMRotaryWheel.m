//
//  SMRotaryWheel.m
//  Angry Gravity
//
//  Created by Joshua Colton [pm15jac] on 21/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "SMRotaryWheel.h"

@interface SMRotaryWheel()
- (void)drawWheel;
@end

@implementation SMRotaryWheel

@synthesize delegate, container, numberOfSections;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber {
    // 1 - Call super init
    if ((self = [super initWithFrame:frame])) {
        // 2 - Set properties
        self.numberOfSections = sectionsNumber;
        self.delegate = del;
        // 3 - Draw wheel
        [self drawWheel];
    }
    return self;
}

- (void) drawWheel {
    
}

@end
