//
// Created by Marek Mościchowski on 05.10.2013.
// Copyright (c) 2013 Marek Mościchowski. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MenuView.h"


@implementation MenuView
{

}

- (void)awakeFromNib
{
    dataSource = [[NSMutableArray alloc] init];
    [dataSource addObject:@"Test 1"];
    [dataSource addObject:@"Truciek"];
    [dataSource addObject:@"Chałupka"];

    [tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectItem:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell"];

    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:@"TableCell"];
    }

    cell.textLabel.text = [dataSource objectAtIndex:indexPath.row];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

@end