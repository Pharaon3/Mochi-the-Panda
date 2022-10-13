//
//  MemoryGameViewController.m
//  PandaGame
//
//  Created by Steve on 2/9/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "MemoryGameViewController.h"
#import "MemoryGamePlayViewController.h"
#import "AppDelegate.h"
#import "Audio/SimpleAudioEngine.h"

@import GoogleMobileAds;


@interface MemoryGameViewController ()

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property int level;
@property (weak, nonatomic) IBOutlet UIButton *soundButton;
@end

@implementation MemoryGameViewController

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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([[AppDelegate sharedInstance] isSoundOn])
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"nevermind.mp3"];
    [self updateSoundButton];
}

-(void)viewDidLoad
{
}

- (IBAction)onBack:(id)sender
{
    [self fadeIn:@selector(goHomeScreen)];
}

- (IBAction)onPlay:(id)sender
{
    _level = (int)((UIButton*)sender).tag;
    
    switch (_level) {
        case 10:
        case 20:
        case 30:
        {
            [self fadeIn:@selector(onPlayGame)];
        }
            break;
            
        default:
            break;
    }
}

-(void)onPlayGame
{
    MemoryGamePlayViewController* vc = (MemoryGamePlayViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"MemoryGamePlayViewController"];
    
    vc.level = _level;
    [self.navigationController pushViewController:vc animated:NO];
    
    if ([[AppDelegate sharedInstance] isSoundOn]) {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    }
}

- (IBAction)onSound:(id)sender {
    if ([[AppDelegate sharedInstance] isSoundOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsSoundOn];
        [_soundButton setImage:[UIImage imageNamed:@"i_sound_off.png"] forState:UIControlStateNormal];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];

    } else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsSoundOn];
        [_soundButton setImage:[UIImage imageNamed:@"i_sound_on.png"] forState:UIControlStateNormal];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"nevermind.mp3"];
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
