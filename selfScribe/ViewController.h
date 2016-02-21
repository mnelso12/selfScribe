//
//  ViewController.h
//  selfScribe
//
//  Created by Madelyn Nelson on 2/20/16.
//  Copyright (c) 2016 Madelyn Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
    
}

@property (strong, nonatomic) IBOutlet UILabel *charLabel;
@property (strong, nonatomic) IBOutlet UIButton *clearButton;
- (IBAction)clearButtonPress:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *nextLetterButton;
- (IBAction)nextLetterButtonPress:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *tempDrawImage;
@property (strong, nonatomic) IBOutlet UIImageView *mainImage;
@property (strong, nonatomic) IBOutlet UIImageView *whiteBackground;
@property (strong, nonatomic) IBOutlet UIImageView *tempImageView;

extern NSMutableDictionary *picsDict;

@end

