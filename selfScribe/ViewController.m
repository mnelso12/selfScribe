//
//  ViewController.m
//  selfScribe
//
//  Created by Madelyn Nelson on 2/20/16.
//  Copyright (c) 2016 Madelyn Nelson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableDictionary *picsDict;
    NSMutableArray *fontArr; // A, B, ...
    NSString *currentChar;
    int numEachLetter;
    int imgCount;
    UIImage *letterCopy;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    currentChar = @"A"; // just to start
    numEachLetter = 3; // could change later
    
    picsDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                [NSMutableArray arrayWithObjects:nil], @"A",
                [NSMutableArray arrayWithObjects:nil], @"B",
                [NSMutableArray arrayWithObjects:nil], @"C",
                [NSMutableArray arrayWithObjects:nil], @"D",
                [NSMutableArray arrayWithObjects:nil], @"E",
                [NSMutableArray arrayWithObjects:nil], @"F",
                [NSMutableArray arrayWithObjects:nil], @"G",
                nil];
    
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 10.0;
    opacity = 1.0;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[self.navigationController navigationBar] setHidden:YES];
    self.navigationController.navigationBar.clipsToBounds = NO;
    
    // from irish bikes
    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];
    
    [self initializeImageViews];
    [self handleCharLabel];
}

/*
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleCharLabel
{
    self.charLabel.text = currentChar;
}

- (void)initializeImageViews
{
    //CGRect screenRect = [[UIScreen mainScreen] bounds];
    //GFloat screenWidth = screenRect.size.width;
    //CGFloat screenHeight = screenRect.size.height;
    
    //self.mainImage.frame = CGRectMake(0, screenHeight/2, screenWidth, screenHeight/2);
    //self.tempDrawImage.frame = CGRectMake(0, screenHeight/2, screenWidth, screenHeight/2);
    
    //self.mainImage.frame = CGRectMake(0, 100, 100, 100);
    //self.tempDrawImage.frame = CGRectMake(0, 100, 100, 100);
}


// from http://www.raywenderlich.com/18840/how-to-make-a-simple-drawing-app-with-uikit
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.tempDrawImage]; // changed from self.view to self.tempDrawImage
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.tempDrawImage]; // changed from self.view to self.tempDrawImage
    
    UIGraphicsBeginImageContext(self.tempDrawImage.frame.size); // changed from self.view.frame.size to self.tempDrawImage.frame.size
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.tempDrawImage.frame.size.width, self.tempDrawImage.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImage setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.tempDrawImage.frame.size); // changed from self.view.frame.size to self.tempDrawImage.frame.size

        [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.tempDrawImage.frame.size.width, self.tempDrawImage.frame.size.height)];        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.tempDrawImage.frame.size.width, self.tempDrawImage.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0]; // changed this
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.tempDrawImage.frame.size.width,self.tempDrawImage.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity]; // changed this
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImage.image = nil;
    UIGraphicsEndImageContext();
}

- (IBAction)clearButtonPress:(id)sender
{
    [self clearImage];
}

- (void)clearImage
{
    UIGraphicsBeginImageContext(CGSizeMake(self.tempDrawImage.frame.size.width, self.tempDrawImage.frame.size.height));
    [self.tempDrawImage.layer renderInContext:UIGraphicsGetCurrentContext()]; // changed from self.view.layer
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (UIImage *)captureView
{
    
    CGRect rect = [self.mainImage bounds];
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.mainImage.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
    
}

- (void)makeFontArray
{
    // for now, fontArr will be the first of each letter in the picsDict. Later, snazzy OCR mathy stuff will go here
    
    fontArr = [[NSMutableArray alloc] init];
    NSArray *letters = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G",nil];
    
    for (int i=0; i<[picsDict count]; i++)
    {
        NSMutableArray *arr = picsDict[letters[i]];
        [fontArr addObject:[arr objectAtIndex:0]];
    }
    
    [self fillTemplate];
}

- (void)fillTemplate
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    UIImageView *templateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    
    templateView.image = [UIImage imageNamed:@"ScriptTemplate.png"];
    [self.view bringSubviewToFront:templateView];
    [self.view addSubview:templateView];
    
    
}

- (IBAction)nextLetterButtonPress:(id)sender
{
    if (!picsDict[currentChar])         // done with alphabet
    {
        // following is for testing
        NSLog(@"%@", [picsDict description]);
        
        UIImage *myImage = [picsDict[@"B"] objectAtIndex:2];
        [self.mainImage setImage:myImage];
        // until here
        
        [self makeFontArray];
    }
    else if ([picsDict[currentChar] count] < (numEachLetter)) // stay on this letter, it needs more images
    {
        UIImage *myImage = [self captureView];
        
        NSLog(@"in second else if");
        if (myImage == nil)
        {
            NSLog(@"main is null");
            return;
        }
        else
        {
            [picsDict[currentChar] addObject:myImage];
            NSLog(@"saving %@ image number %lu", currentChar, (unsigned long)[picsDict[currentChar] count]);
        }
        [self clearImage];
        self.charLabel.text = currentChar;
        
    }
    else // move on to next letter
    {
        NSLog(@"in else");
        unichar c = [currentChar characterAtIndex:0];
        c++;

        currentChar = [NSString stringWithCharacters:&c length:1];
        if (!picsDict[currentChar]) // moved on to a letter that's not in the dictionary
        {
            NSLog(@"not going to letter %@ thats not int picsDict", currentChar);
            [self clearImage];
            return;
        }
        
        UIImage *myImage = [self captureView];
        
        if (myImage == nil)
        {
            NSLog(@"main is null");
            return;
        }
        else
        {
            [picsDict[currentChar] addObject:myImage];
            NSLog(@"saving %@ image number %lu", currentChar, (unsigned long)[picsDict[currentChar] count]);

        }
        [self clearImage];
        self.charLabel.text = currentChar;
    
    }
}

@end
