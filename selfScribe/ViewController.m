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
    NSMutableArray *glyphPts;
    NSMutableArray *arrOfGlyphPts;
    NSMutableArray *glyphStringsArr;
    NSString *glyphDString;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    currentChar = @"A"; // just to start
    numEachLetter = 3; // could change later
    
    glyphPts = [[NSMutableArray alloc] init];
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
    
    [glyphPts addObject:[NSValue valueWithCGPoint:currentPoint]];
    NSLog(@"glyph points array: %@", [glyphPts description]);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //NSLog(@"MOUSE LIFTED!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    CGPoint resetPt = {0,0};
    [glyphPts addObject:[NSValue valueWithCGPoint:resetPt]];
    NSLog(@"glyph points array: %@", [glyphPts description]);
    
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

- (UIImage *)captureTemplateView
{
    
    CGRect rect = [self.view bounds];
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
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
}

// postman - chrome way to send post requests to online service
// need to send post request (not just url bar)
// userfile_url
// svg file!
// always shop teachers - (Iron Yard)
// general assemly - in UK, office in London, boot camp for web dev etc. (Make School - best guy to talk to is CEO jeremy@makeschool.com)
// code.org



- (void)fillTemplate
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    UIImageView *templateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    
    templateView.image = [UIImage imageNamed:@"ScriptTemplate.png"];
    [self.view bringSubviewToFront:templateView];
    
    // add mini letter views to template
    // coordinates for letter in position (x,y) = (15+36x, 58+40y, 24, 29) ish
    
    NSMutableArray *arrOfViews = [[NSMutableArray alloc] init];
    
    int extraX = 0;
    int extraY = 0;
    
    for (int i=0; i<10; i++)
    {
        if (((i+1)%3 == 0) && (i != 0))
        {
            extraX++;
        }
        for (int j=0; j<9; j++)
        {
            if (((j)%5 == 0))
            {
                extraY++;
            }
            
            UIImageView *smallView = [[UIImageView alloc] initWithFrame:CGRectMake((15+36*i - extraX), (58+40*j+extraY), 24, 29)];
            smallView.image = [fontArr objectAtIndex:((i+j)%7)];
            [arrOfViews addObject:smallView];
        }
        extraY = 0;
    }
    
    // put little views from array onto templateView
    for (UIImageView *iv in arrOfViews)
    {
        [templateView addSubview:iv];
    }
    
    [self.view addSubview:templateView];
    [self.view bringSubviewToFront:templateView];
    
    
    UIImage *templateToUpload = [self captureTemplateView]; // this is template, potentially send this in an email to the user
}

- (NSString *)glyphPtsToStr(NSMutableArray *arr)
{
    // separate points into "x y"
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    int next = 0;
    
    for (int i = 0; i < [arr count]; i++)
    {
        NSValue *ptVal = [arr objectAtIndex:i];
        CGPoint pt = [ptVal CGPointValue];
        CGFloat xVal = pt.x;
        CGFloat yVal = pt.y;
        
        NSString *xStr;
        NSString *yStr;
        if (next == 1) // if previous point was a restart point
        {
            xStr = [NSString stringWithFormat:@" M%d ", (int)xVal];
            yStr = [NSString stringWithFormat:@"%d", (int)yVal]; // y is always normal for this
            [arr addObject:xStr];
            [arr addObject:yStr];
            next = 0;
            continue;
        }
        

        if ((xVal == 0.) && (yVal == 0)) // reset point, indicates that finger was lifted with "M", reset new line
        {
            xStr = @" M";
            next = 1;
        }
        else if (i == 0) // if first point of all
        {
            xStr = [NSString stringWithFormat:@"M%d ", (int)xVal];
            yStr = [NSString stringWithFormat:@"%d", (int)yVal]; // y is always normal for this
            [arr addObject:xStr];
            [arr addObject:yStr];
        }
        else // use L to connect the points
        {
            xStr = [NSString stringWithFormat:@" L%d ", (int)xVal];
            yStr = [NSString stringWithFormat:@"%d", (int)yVal]; // y is always normal for this
            [arr addObject:xStr];
            [arr addObject:yStr];
        }
    
    }
    
    
    
    return [NSString stringWithFormat:@"%@%@%@", @"d=\"",[arr componentsJoinedByString:@""],@"\" />"];
}


- (IBAction)nextLetterButtonPress:(id)sender
{
    if (!picsDict[currentChar])         // done with alphabet
    {
        [self analyzeResults];
    }
    else if ([picsDict[currentChar] count] < (numEachLetter)) // stay on this letter, it needs more images
    {
        UIImage *myImage = [self captureView];
        
        [arrOfGlyphPts addObject:glyphPts];
        
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
        
        if ([picsDict[currentChar] count] == 3)
        {
            unichar c = [currentChar characterAtIndex:0];
            c++;
            currentChar = [NSString stringWithCharacters:&c length:1];
            
            if (!picsDict[currentChar])
            {
                return; // done with list
            }
        }
        
        self.charLabel.text = currentChar;
        
    }
}

- (void)analyzeResults
{
    //NSLog(@"string? %@", [self glyphPtsToStr]);
    glyphDString = [self glyphPtsToStr]; // pass glyphPts to this function somehow
    
    [self makeFontArray];
    [self fillTemplate];
    
}

@end
