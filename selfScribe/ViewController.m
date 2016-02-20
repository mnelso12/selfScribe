//
//  ViewController.m
//  selfScribe
//
//  Created by Madelyn Nelson on 2/20/16.
//  Copyright (c) 2016 Madelyn Nelson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 10.0;
    opacity = 1.0;
    
    //self.view.backgroundColor = [UIColor blueColor];
    
    [self initializeImageViews];
    [self handleCharLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleCharLabel
{
    self.charLabel.text = @"A";
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
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    UIGraphicsBeginImageContext(CGSizeMake(self.tempDrawImage.frame.size.width, self.tempDrawImage.frame.size.height));
    [self.tempDrawImage.layer renderInContext:UIGraphicsGetCurrentContext()]; // changed from self.view.layer
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
