//
//  HeaderView.m
//  OnAir
//
//  Created by Petar Gezenchov on 18/05/2015.
//  Copyright (c) 2015 com.gezenchov. All rights reserved.
//

#import "PGHeaderView.h"

@implementation PGHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/

- (void)drawRect:(CGRect)rect {
     // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
    
    // Draw them with a 0.5 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 0.5f);
    CGContextMoveToPoint(context, 0.0f, 0.25f); //start at this point
    CGContextAddLineToPoint(context, self.frame.size.width, 0.25f); //draw to this point
    
    // and now draw the Path!
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 0.0f, self.frame.size.height - 0.25f); //start at this point
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height - 0.25f); //draw to this point
    
    // and now draw the Path!
    CGContextStrokePath(context);
}

@end
