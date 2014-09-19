//
//  Rectangle.m
//  TouchTraker
//
//  Created by New on 8/30/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "Rectangle.h"

@implementation Rectangle

- (NSString *)description
{
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%f, %f",
     ((self.endPoint.x - self.startPoint.x)/2 + self.startPoint.x),
     ((self.endPoint.y - self.startPoint.y)/2 + self.startPoint.y)];
    
    return descriptionString;
}


@end
