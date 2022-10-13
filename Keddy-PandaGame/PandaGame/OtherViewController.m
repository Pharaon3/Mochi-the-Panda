//
//  OtherViewController.m
//  PandaGame
//
//  Created by apple on 3/25/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController()

@end

@implementation OtherViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    NSArray* arrList = @[@"i_placeholder_match.png", @"i_placeholder_memory.png", @"i_placeholder_spell.png", @"i_placeholder_story.png", @"i_placeholder_upgrade.png"];
    [_bgView setImage:[UIImage imageNamed:arrList[_index]]];
    
    NSLog(@"Image = %@", arrList[_index]);
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    self.bgView.userInteractionEnabled = YES;
    [self.bgView addGestureRecognizer:singleTap];
}

-(void)handleSingleTap:(id)sender
{
    [UIView animateWithDuration:1.5 animations:^{
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:NO];
    }];
    
}
@end
