//
//  myFontsVC.m
//  selfScribe
//
//  Created by MadelynNelson on 2/21/16.
//  Copyright (c) 2016 Madelyn Nelson. All rights reserved.
//

#import "myFontsVC.h"
#import "WriteVC.h"

@implementation myFontsVC
{
    NSArray *tableData;
}


- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:102/255. green:255/255. blue:178/255. alpha:1];
    tableData = [NSArray arrayWithObjects:@"madelyn", @"cursive", @"boldFont", nil];
    
    UIImageView *notebook = [[UIImageView alloc] init];
    notebook.image = [UIImage imageNamed:@"notebook.jpg"];
    UIView *middleView = [[UIView alloc] init];
    [middleView addSubview:notebook];
    self.tableView.backgroundView = notebook;
    
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
    //[headerView setBackgroundColor:[UIColor colorWithRed:102/255. green:255/255. blue:178/255. alpha:1]];
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(0, 22, 400, 69);
    myLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:50];
    myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    myLabel.textColor = [UIColor colorWithRed:0/255. green:4/255. blue:101/255. alpha:1];
    //myLabel.backgroundColor = [UIColor colorWithRed:255/255. green:118/255. blue:251/255. alpha:1];
    myLabel.backgroundColor = [UIColor clearColor];
    
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
    
    [cell.imageView setImage:[UIImage imageNamed:@"GoldenDome.jpeg"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // remember which font was chosen here
    [self choseFont];
}

- (IBAction)choseFont
{
    ///////// save font to defaults here //////////////////
    
    //WriteVC *myNewVC = [[WriteVC alloc] init];
    
    // do any setup you need for myNewVC
    
    //[self performSegueWithIdentifier:@"shaqSegue" sender:self];
    
    //[self presentModalViewController:myNewVC animated:YES];
    
    
    
    
    // remember chosen font, go to root, then go to WriteVC
    [self.navigationController popToRootViewControllerAnimated:YES];

    
}

@end
