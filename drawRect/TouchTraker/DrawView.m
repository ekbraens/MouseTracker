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
@property (nonatomic, strong) NSMutableArray * finishedRectangles;

@end

@implementation DrawView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * t = [touches anyObject];
    
    CGPoint location = [t locationInView:self];
    
//    // from the BNR creating lines
//    self.currentLine = [[Line alloc] init];
//    self.currentLine.startPoint = location;
//    self.currentLine.endPoint = location;
    
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
    
//    // from the BNR creating lines
//    self.currentLine.endPoint = location;
    
    // my go at it with retangles
    self.currentRectangle.endPoint = location;
    self.currentRectangle.rectHeight = self.currentRectangle.startPoint.y - self.currentRectangle.endPoint.y;
    self.currentRectangle.rectWidth = self.currentRectangle.startPoint.x - self.currentRectangle.endPoint.x;
    
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    // form the BNR creating lines
//    [self.finishedLines addObject:self.currentLine];
//    self.currentLine = nil;

    // my go at it with rectangles
    [self.finishedRectangles addObject:self.currentRectangle];
    self.currentRectangle = nil;
    
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    // Draw finished lines in black
    [[UIColor blackColor] set];
//    for (Line * line in self.finishedLines)
//    {
//        [self strokeLine:line];
//    }
    for (Rectangle * rectangle in self.finishedRectangles)
    {
        [self makeRect:rectangle];
    }
//    // from the BNR creating lines
//    if (self.currentLine)
    if (self.currentRectangle)
    {
        [[UIColor redColor] set];
//        // from the BNR creating lines
//        [self strokeLine:self.currentLine];
        
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
    CGRect newRectangle = CGRectMake(rectangle.startPoint.x, rectangle.startPoint.y, rectangle.rectHeight, rectangle.rectWidth);
    bp = [UIBezierPath bezierPathWithRect:newRectangle];
    [bp stroke];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.finishedLines = [[NSMutableArray alloc] init];
        self.finishedRectangles = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
//        self.multipleTouchEnabled = YES;
    }
    
    return self;
}

@end
