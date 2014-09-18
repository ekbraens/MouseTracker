//
//  TableListViewController.m
//  TouchTraker
//
//  Created by New on 9/1/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "TableListViewController.h"
#import "DrawView.h"

@interface TableListViewController ()

@property (nonatomic, strong) NSArray * items;

@end

@implementation TableListViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
    }

    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.tableView reloadData];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_allRects count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    //cell.textLabel.text = item.description;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _allRects[indexPath.row]];

    return cell;
}


@end
