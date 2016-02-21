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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    //[UIColor colorWithRed:102/255. green:255/255. blue:178/255. alpha:1];
    cell.backgroundColor = [UIColor colorWithRed:0/255. green:4/255. blue:101/255. alpha:1];
    cell.textLabel.textColor = [UIColor colorWithRed:102/255. green:255/255. blue:178/255. alpha:1];
    UIFont *myFont = [UIFont fontWithName:@"Verdana" size:50];
    cell.textLabel.font = myFont;
    return cell;
}

@end
