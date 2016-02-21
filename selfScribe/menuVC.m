//
//  menuVC.m
//  selfScribe
//
//  Created by MadelynNelson on 2/21/16.
//  Copyright (c) 2016 Madelyn Nelson. All rights reserved.
//

#import "menuVC.h"

@interface menuVC ()
{
    NSMutableDictionary *myFonts;
    NSDictionary *myFonts2;
    //NSArray *imgArr;
}
@end

@implementation menuVC

- (void)viewDidLoad
{
    NSMutableDictionary *myFonts = [[NSMutableDictionary alloc] init];
    
    // next step is to connect all of these using NSUserDefaults!!!!!!!!!!!!!
    //myFonts = [[NSMutableDictionary alloc] init];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:102/255. green:255/255. blue:178/255. alpha:1];
    [self udpateUserDefaults];
    
    //NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
    
    [self getUserDefaults];
}

- (void)getUserDefaults
{
    // get copy of myFonts from defaults
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSData *data = [def objectForKey:@"myFonts"];
    NSDictionary *retrievedDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSDictionary *outDict = [[NSDictionary alloc] initWithDictionary:retrievedDictionary];
    
    NSLog(@"size of outDict: %lu", [outDict count]);
    
    for(NSString *key in [outDict allKeys]) {
        NSLog(@"%@",[outDict objectForKey:key]);
    }
    
    //NSLog(@"myFonts: %lu", [myFonts2 dictionaryRepresentation]);
    //NSLog(@"myFonts : %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"myFonts"]);
}

- (void)udpateUserDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    //NSMutableDictionary *myFonts = [[NSMutableDictionary alloc] init];
    
    NSArray *imgArr = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"GoldenDome.jpeg"], [UIImage imageNamed:@"notebook.jpg"], nil];
    [myFonts setObject:imgArr forKey:@"cursive"];
    //if (![defaults objectForKey:@"myFonts"])
    //{
        [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:myFonts] forKey:@"myFonts"];
    //}
    
    [defaults setObject:myFonts forKey:@"cursive"];
    
     [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end