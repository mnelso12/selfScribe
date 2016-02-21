//
//  WriteVC.m
//  selfScribe
//
//  Created by MadelynNelson on 2/21/16.
//  Copyright (c) 2016 Madelyn Nelson. All rights reserved.
//

#import "WriteVC.h"

@implementation WriteVC
{
    NSMutableDictionary *picsDict;
}

-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor colorWithRed:102/255. green:255/255. blue:178/255. alpha:1];
    
    //self.textField.hidden = YES;
    //[self.textField becomeFirstResponder];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];

    
    [self customKeyboard];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    UIView *view = recognizer.view;
    
    NSLog(@"tag: %d", view.tag);
    
}


- (void)customKeyboard // 8x5 keyboard
{
    CGFloat widthOfScreen  = [[UIScreen mainScreen] bounds].size.width;    CGFloat heightOfScreen = [[UIScreen mainScreen] bounds].size.height;
    
    UIView *keyboardView = [[UIView alloc] initWithFrame:CGRectMake(0, heightOfScreen*2/3, widthOfScreen, heightOfScreen/3)];
    
    NSMutableArray *arrOfMiniViews = [[NSMutableArray alloc] init];
    
    int tag = 0;
    
    for (int i=0; i<8; i++)
    {
        for (int j=0; j<5; j++)
        {
            UIView *miniView = [[UIView alloc] initWithFrame:CGRectMake((widthOfScreen/8)*i, j*(heightOfScreen/15), (widthOfScreen/8), heightOfScreen/15)];
            miniView.backgroundColor = [UIColor yellowColor];
            
            UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(handleSingleTap:)];
            [miniView addGestureRecognizer:singleFingerTap];
            miniView.tag = tag;
            tag++;
            
            [arrOfMiniViews addObject:miniView];
        }
        
    }
    
    for (int k=0; k<40; k++)
    {
        UIView *min = [[UIView alloc] init];
        min = [arrOfMiniViews objectAtIndex:k];
        NSLog(@"miniView = %lu", min.tag);
        [keyboardView addSubview:[arrOfMiniViews objectAtIndex:k]];
    }
    
    [self.view addSubview:keyboardView];
}























/*
//handle text container object length whether it's a UITextField, UITextView et al
NSUInteger LengthOfStringInTextInput(NSObject<UITextInput> *textContainer)
{
    UITextPosition *beginningOfDocument = [textContainer beginningOfDocument];
    UITextPosition *endOfDocument =       [textContainer endOfDocument];
    UITextRange    *fullTextRange =       [textContainer textRangeFromPosition:beginningOfDocument
                                                                    toPosition:endOfDocument];
    return [textContainer textInRange:fullTextRange].length;
}

 

- (void)wordsView
{
    //self.typingView = [[UIImageView alloc] init];
    NSString *currentText = [NSString stringWithString:self.textField.text];
    NSLog(@"current text: %@", currentText);
    
}
&/
/*
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self wordsView];

}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self wordsView];
}
*/


@end
