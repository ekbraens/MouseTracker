//
//  DrawView.m
//  TouchTraker
//
//  Created by New on 8/30/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "DrawView.h"
#import "Line.h"
#import "Rectangle.h"

@interface DrawView ()

@property (nonatomic, strong) Line * currentLine;
@property (nonatomic, strong) Rectangle * currentRectangle;
@property (nonatomic, strong) NSMutableArray * finishedLines;
@property (nonatomic, strong) NSMutableArray * cgrectArray;
@property (nonatomic, assign) BOOL deleting;

@end

@implementation DrawView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _deleting = NO;
    UITouch * t = [touches anyObject];
    
    for (int i = 0; i < [self.cgrectArray count]; ++i)
    {
        CGRect theRect = [[self.cgrectArray objectAtIndex:i] CGRectValue];
        CGPoint theTouch = [t locationInView:self];
        if (CGRectContainsPoint(theRect, theTouch))
        {
            [self.finishedRectangles removeObjectAtIndex:i];
            [self.cgrectArray removeObjectAtIndex:i];
            _deleting = YES;
        }
    }
    
    CGPoint location = [t locationInView:self];
    
    // my go at it with rectangles
    self.currentRectangle = [[Rectangle alloc] init];
    self.currentRectangle.startPoint = location;
    self.currentRectangle.endPoint = location;
    
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * t = [touches anyObject];
    CGPoint location = [t locationInView:self];
    
    // my go at it with retangles
    self.currentRectangle.endPoint = location;
    self.currentRectangle.rectHeight = self.currentRectangle.endPoint.y - self.currentRectangle.startPoint.y;
    self.currentRectangle.rectWidth = self.currentRectangle.endPoint.x - self.currentRectangle.startPoint.x;
    
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_deleting == NO)
    {
        // my go at it with rectangles
        CGRect newRectangle = CGRectMake(_currentRectangle.startPoint.x, _currentRectangle.startPoint.y, _currentRectangle.rectWidth, _currentRectangle.rectHeight);
        [self.cgrectArray addObject:[NSValue valueWithCGRect:newRectangle]];
        [self.finishedRectangles addObject:self.currentRectangle];
        self.currentRectangle = nil;
    }
    
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    // Draw finished lines in black
    [[UIColor blackColor] set];

    for (Rectangle * rectangle in self.finishedRectangles)
    {
        [self makeRect:rectangle];
    }

    if (self.currentRectangle)
    {
        [[UIColor redColor] set];

        
        [self makeRect:self.currentRectangle];
    }
}

-(void)strokeLine:(Line *)line
{
    UIBezierPath * bp = [[UIBezierPath alloc] init];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.startPoint];
    [bp addLineToPoint:line.endPoint];
    [bp stroke];
}

-(void)makeRect:(Rectangle *)rectangle
{
    UIBezierPath * bp = [[UIBezierPath alloc] init];
    bp.lineWidth = 10;
    
    [bp moveToPoint:rectangle.startPoint];
    CGRect newRectangle = CGRectMake(rectangle.startPoint.x, rectangle.startPoint.y, rectangle.rectWidth, rectangle.rectHeight);
    bp = [UIBezierPath bezierPathWithRect:newRectangle];
    
    [bp stroke];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.finishedRectangles = [[NSMutableArray alloc] init];
        self.cgrectArray = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
//        self.multipleTouchEnabled = YES;
    }
    
    return self;
}

@end
