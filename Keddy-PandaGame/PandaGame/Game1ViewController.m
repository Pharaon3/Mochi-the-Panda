//
//  Game1ViewController.m
//  PandaGame
//
//  Created by Steve on 2/26/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "Game1ViewController.h"
#import "Game1PlayViewController.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@import GoogleMobileAds;

@interface Game1ViewController()
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property int level;
@property (weak, nonatomic) IBOutlet UIButton *soundButton;
@end

@implementation Game1ViewController

-(void)fadeIn:(SEL)callBack
{
    [UIView animateWithDuration:2 animations:^{
        [_mainView setAlpha:0];
    } completion:^(BOOL finished) {
        [self performSelector:callBack withObject:nil afterDelay:0];
               [self performSelector:@selector(resetScreen) withObject:nil afterDelay:0.5];

    }];
}
-(void)resetScreen
{
    [_mainView setAlpha:1];
}
-(void)goHomeScreen
{
    if ([[AppDelegate sharedInstance] isSoundOn])
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [self.navigationController popViewControllerAnimated:NO];
}
- (IBAction)onBack:(id)sender {
    [self fadeIn:@selector(goHomeScreen)];
}
-(void)onPlayGame
{
    Game1PlayViewController* vc = (Game1PlayViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Game1PlayViewController"];
    
    vc.level = _level;
    [self.navigationController pushViewController:vc animated:NO];
    if ([[AppDelegate sharedInstance] isSoundOn])
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];

}
- (IBAction)onPlay:(id)sender {
    _level = (int)((UIButton*)sender).tag;
    NSLog(@"tag = %d", (int)((UIButton*)sender).tag);

    switch (_level)
    {
        case 10:
        case 20:
        case 30:
        {
            [self fadeIn:@selector(onPlayGame)];
        }
            break;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([[AppDelegate sharedInstance] isSoundOn])
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"moony.wav"];
    [self updateSoundButton];
}

-(void)viewDidLoad
{
}

- (IBAction)onSound:(id)sender {
    if ([[AppDelegate sharedInstance] isSoundOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsSoundOn];
        [_soundButton setImage:[UIImage imageNamed:@"i_sound_off.png"] forState:UIControlStateNormal];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsSoundOn];
        [_soundButton setImage:[UIImage imageNamed:@"i_sound_on.png"] forState:UIControlStateNormal];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"moony.wav"];
    }
}

-(void)updateSoundButton
{
    if ([[AppDelegate sharedInstance] isSoundOn]) {
        [_soundButton setImage:[UIImage imageNamed:@"i_sound_on.png"] forState:UIControlStateNormal];
    } else {
        [_soundButton setImage:[UIImage imageNamed:@"i_sound_off.png"] forState:UIControlStateNormal];
    }
}
@end
