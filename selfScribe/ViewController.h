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

@property (strong, nonatomic) IBOutlet UIImageView *tempDrawImage;
@property (strong, nonatomic) IBOutlet UIImageView *mainImage;

@end

