//
//  StoryViewController.m
//  PandaGame
//
//  Created by Steve on 3/9/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "StoryViewController.h"
#import <MediaPlayer/MediaPlayer.h>


@interface StoryViewController()
@property (strong, nonatomic) IBOutlet MPMoviePlayerController *moviePlayer;

@end
@implementation StoryViewController
-(void)stopPlaying
{
    [_moviePlayer pause];
    [[[UIAlertView alloc]initWithTitle:@"Paused" message:@"Continue watching story or go back home?" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:@"Home", nil] show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
        [_moviePlayer play];
    else
    {
        [UIView animateWithDuration:1 animations:^{
            [_moviePlayer view].alpha = 0;
        } completion:^(BOOL finished) {
            [self.navigationController popViewControllerAnimated:NO];
        }];
    }
}
-(void)viewDidLoad
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Mochi_Story_1" ofType:@"mp4"];
    _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:filePath]];
    
    [[_moviePlayer view] setFrame:[[self view] bounds]];
    [[self view] addSubview: [_moviePlayer view]];
    
    _moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    _moviePlayer.controlStyle = MPMovieControlStyleNone;
    [_moviePlayer play];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishPlayback:) name:MPMoviePlayerPlaybackDidFinishNotification object:_moviePlayer];

    UIView* tapView = [[UIView alloc]initWithFrame:[self view].bounds];
    tapView.alpha = 0.05;
    [self.view addSubview:tapView];
    
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stopPlaying)];
    recognizer.numberOfTapsRequired = 1;
    [tapView addGestureRecognizer:recognizer];


}
-(void)didFinishPlayback:(id)sender
{
    [UIView animateWithDuration:1 animations:^{
        [_moviePlayer view].alpha = 0;
    } completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:NO];
    }];
    
}
@end
