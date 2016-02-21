//
//  myFontsVC.m
//  selfScribe
//
//  Created by MadelynNelson on 2/21/16.
//  Copyright (c) 2016 Madelyn Nelson. All rights reserved.
//

#import "myFontsVC.h"

@implementation myFontsVC
{
    NSArray *tableData;
}


- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:102/255. green:255/255. blue:178/255. alpha:1];
    tableData = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[self.navigationController navigationBar] setHidden:YES];
    self.navigationController.navigationBar.clipsToBounds = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 90;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    [headerView setBackgroundColor:[UIColor colorWithRed:102/255. green:255/255. blue:178/255. alpha:1]];
   
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(0, 22, 400, 67);
    myLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:50];
    myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    myLabel.textColor = [UIColor colorWithRed:0/255. green:4/255. blue:101/255. alpha:1];
    myLabel.backgroundColor = [UIColor colorWithRed:255/255. green:255/255. blue:180/255. alpha:1];
    
    [headerView addSubview:myLabel];
    
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"my fonts";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor colorWithRed:0/255. green:4/255. blue:101/255. alpha:1];
    cell.textLabel.textColor = [UIColor colorWithRed:102/255. green:255/255. blue:178/255. alpha:1];
    UIFont *myFont = [UIFont fontWithName:@"Verdana" size:40];
    cell.textLabel.font = myFont;
    
    UIView *selectionView = [[UIView alloc] init];
    selectionView.backgroundColor = [UIColor colorWithRed:102/255. green:255/255. blue:178/255. alpha:1];
    cell.selectedBackgroundView = selectionView;
    
    cell.textLabel.highlightedTextColor = [UIColor colorWithRed:0/255. green:4/255. blue:101/255. alpha:1];
    
    
    return cell;
}

@end
