//
//  DrawViewController.m
//  TouchTraker
//
//  Created by New on 8/30/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "DrawViewController.h"
#import "TableListViewController.h"
#import "DrawView.h"

@interface DrawViewController()

@property (nonatomic, strong) DrawView * theView;

@end

@implementation DrawViewController

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _theView = [[DrawView alloc] initWithFrame:CGRectZero];
        
        UISwipeGestureRecognizer * swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        swipeLeft.numberOfTouchesRequired = 1;
        swipeLeft.delaysTouchesBegan = YES;
        [self.view addGestureRecognizer:swipeLeft];
    }
    
    return self;
}

-(void)loadView
{
    self.view = _theView;
}

-(void)swipeLeft:(UIGestureRecognizer *)gr
{
    TableListViewController * tlvc = [[TableListViewController alloc] init];
    tlvc.allRects = _theView.finishedRectangles;
    
    [self.navigationController pushViewController:tlvc animated:YES];
}

@end
