//
//  Game1ViewController.m
//  PandaGame
//
//  Created by Steve on 2/26/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "Game2ViewController.h"
#import "Game2PlayViewController.h"
#import "AppDelegate.h"
#import "Audio/SimpleAudioEngine.h"
@import GoogleMobileAds;

@interface Game2ViewController()
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property int level;
@property (weak, nonatomic) IBOutlet UIButton *soundButton;

@end

@implementation Game2ViewController

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
    [self.navigationController popViewControllerAnimated:NO];
}
- (IBAction)onBack:(id)sender {
    [self fadeIn:@selector(goHomeScreen)];
}
-(void)onPlayGame
{
    Game2PlayViewController* vc = (Game2PlayViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Game2PlayViewController"];
    
    vc.level = _level;
    [self.navigationController pushViewController:vc animated:NO];
    
    if ([[AppDelegate sharedInstance] isSoundOn])
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];

}
- (IBAction)onPlay:(id)sender {
    _level = (int)((UIButton*)sender).tag;
    
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
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"waltz.wav"];
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
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"waltz.wav"];
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
