//
//  SMRotaryProtocol.h
//  Angry Gravity
//
//  Created by Joshua Colton [pm15jac] on 21/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SMRotaryProtocol <NSObject>

- (void) wheelDidChangeValue:(NSString *)newValue;

@end
