//
//  PGHomeScreenViewController.m
//  PandaGame
//
//  Created by Steve on 2/9/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "PGHomeScreenViewController.h"
#import "MemoryGameViewController.h"
#import "Game1ViewController.h"
#import "AppDelegate.h"
#import "Game2ViewController.h"
#import "StoryViewController.h"
#import "MKStoreKit.h"
#import "SimpleAudioEngine.h"

@import GoogleMobileAds;

@interface UIInventoryView : UIImageView
@property CGRect originRect;
@end

@implementation UIInventoryView



@end


@interface PGHomeScreenViewController ()
{
    UIImage *_rainbowImage;
}

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *messageView;
@property int flag;
@property (weak, nonatomic) IBOutlet UIImageView *panda;
@property (weak, nonatomic) IBOutlet UIImageView *energyImage;
@property (weak, nonatomic) IBOutlet UIImageView *apple;
@property int energyPercent;
@property (weak, nonatomic) IBOutlet UIView *frontView;
@property CGPoint startLocation;
@property CGRect originRect;
@property (weak, nonatomic) IBOutlet GADBannerView *gadBannerView;
@property AppDelegate* appDelegate;
@property (weak, nonatomic) IBOutlet UIButton *memoryGameButton;
@property (weak, nonatomic) IBOutlet UIButton *spellGameButton;
@property (weak, nonatomic) IBOutlet UIButton *soundButton;
@property (weak, nonatomic) IBOutlet UIView *completedView;
@property (weak, nonatomic) IBOutlet UIView *dancingView;
@property (weak, nonatomic) IBOutlet UIImageView *rainbowImageView;
@property (weak, nonatomic) IBOutlet UIImageView *dancingImageView;
@end


@implementation PGHomeScreenViewController
@synthesize appDelegate;

-(void)setMonkeyGifImage:(NSString*)fileName
{
    if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPad"]) {
        if ([fileName isEqual:@"o_mochi_belly"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 250;
            rt.size.width = 423;
            
            rt.origin.y = 68;
            rt.size.height = 419;
            self.panda.frame = rt;
        } else if ([fileName isEqual:@"o_mochi_monkey"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 290;
            rt.size.width = 343;
            
            rt.origin.y = 68;
            rt.size.height = 419;
            self.panda.frame = rt;
        } else if ([fileName isEqual:@"o_mochi_tired"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 220;
            rt.size.width = 450;
            
            rt.origin.y = 220;
            rt.size.height = 260;
            self.panda.frame = rt;
        } else if ([fileName isEqual:@"o_mochi_laugh_nm"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 250;
            rt.size.width = 423;
            
            rt.origin.y = 60;
            rt.size.height = 419;
            self.panda.frame = rt;
        } else {
            CGRect rt = self.panda.frame;
            rt.origin.x = 320;
            rt.size.width = 283;
            
            rt.origin.y = 68;
            rt.size.height = 419;
            self.panda.frame = rt;
        }
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone4"]) {
        if ([fileName isEqual:@"o_mochi_belly"])
        {
            CGRect rt = self.panda.frame;
            rt.origin.x = 115;
            rt.size.width = 190;
            
            rt.origin.y = 30;
            rt.size.height = 180;
            self.panda.frame = rt;
        } else if ([fileName isEqual:@"o_mochi_monkey"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 155;
            rt.size.width = 137;
            
            rt.origin.y = 30;
            rt.size.height = 180;
            self.panda.frame = rt;
        } else if ([fileName isEqual:@"o_mochi_tired"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 90;
            rt.size.width = 240;
            
            rt.origin.y = 120;
            rt.size.height = 100;
            self.panda.frame = rt;
        } else if ([fileName isEqual:@"o_mochi_laugh_nm"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 115;
            rt.size.width = 190;
            
            rt.origin.y = 30;
            rt.size.height = 180;
            self.panda.frame = rt;
        } else {
            CGRect rt = self.panda.frame;
            rt.origin.x = 145;
            rt.size.width = 130;
            
            rt.origin.y = 30;
            rt.size.height = 180;
            self.panda.frame = rt;
        }
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone5"]) {
        if ([fileName isEqual:@"o_mochi_belly"])
        {
            CGRect rt = self.panda.frame;
            rt.origin.x = 250;
            rt.size.width = 423;
            
            rt.origin.y = 68;
            rt.size.height = 419;
            self.panda.frame = rt;
        } else if ([fileName isEqual:@"o_mochi_monkey"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 290;
            rt.size.width = 343;
            
            rt.origin.y = 68;
            rt.size.height = 419;
            self.panda.frame = rt;
        } else if ([fileName isEqual:@"o_mochi_tired"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 220;
            rt.size.width = 450;
            
            rt.origin.y = 220;
            rt.size.height = 260;
            self.panda.frame = rt;
        } else if ([fileName isEqual:@"o_mochi_laugh_nm"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 250;
            rt.size.width = 423;
            
            rt.origin.y = 60;
            rt.size.height = 419;
            self.panda.frame = rt;
        } else {
            CGRect rt = self.panda.frame;
            rt.origin.x = 320;
            rt.size.width = 283;
            
            rt.origin.y = 68;
            rt.size.height = 419;
            self.panda.frame = rt;
        }
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6"]) {
        if ([fileName isEqual:@"o_mochi_belly"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 250;
            rt.size.width = 423;
            
            rt.origin.y = 68;
            rt.size.height = 419;
            self.panda.frame = rt;
        } else if ([fileName isEqual:@"o_mochi_monkey"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 290;
            rt.size.width = 343;
            
            rt.origin.y = 68;
            rt.size.height = 419;
            self.panda.frame = rt;
        } else if ([fileName isEqual:@"o_mochi_tired"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 220;
            rt.size.width = 450;
            
            rt.origin.y = 220;
            rt.size.height = 260;
            self.panda.frame = rt;
        } else if ([fileName isEqual:@"o_mochi_laugh_nm"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 250;
            rt.size.width = 423;
            
            rt.origin.y = 60;
            rt.size.height = 419;
            self.panda.frame = rt;
        } else {
            CGRect rt = self.panda.frame;
            rt.origin.x = 320;
            rt.size.width = 283;
            
            rt.origin.y = 68;
            rt.size.height = 419;
            self.panda.frame = rt;
        }
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6+"]) {
        if ([fileName isEqual:@"o_mochi_belly"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 250;
            rt.size.width = 423;
            
            rt.origin.y = 68;
            rt.size.height = 419;
            self.panda.frame = rt;
        } else if ([fileName isEqual:@"o_mochi_monkey"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 290;
            rt.size.width = 343;
            
            rt.origin.y = 68;
            rt.size.height = 419;
            self.panda.frame = rt;
        } else if ([fileName isEqual:@"o_mochi_tired"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 220;
            rt.size.width = 450;
            
            rt.origin.y = 220;
            rt.size.height = 260;
            self.panda.frame = rt;
        } else if ([fileName isEqual:@"o_mochi_laugh_nm"]) {
            CGRect rt = self.panda.frame;
            rt.origin.x = 250;
            rt.size.width = 423;
            
            rt.origin.y = 60;
            rt.size.height = 419;
            self.panda.frame = rt;
        } else {
            CGRect rt = self.panda.frame;
            rt.origin.x = 320;
            rt.size.width = 283;
            
            rt.origin.y = 68;
            rt.size.height = 419;
            self.panda.frame = rt;
        }
    }




    
    NSURL* url = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"gif"];
    self.panda.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setMonkeyGifImage:@"o_mochi_idle"];
    NSLog(@"frame = %f, %f", self.panda.frame.origin.x, self.panda.frame.origin.y);

    
    _backView.alpha = 1;
    if ([[AppDelegate sharedInstance] isSoundOn]) {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"cozy.mp3"];
    }
    [self updateInventoryView];
    [self updateMessageView];
    [self updateSoundButton];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"i_bg_rainbow" withExtension:@"gif"];
    _rainbowImage = [UIImage animatedImageWithAnimatedGIFURL:url];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didUpdateToPro:) name:kUpdatedToProNotification object:nil];

    // Do any additional setup after loading the view.
    appDelegate = [[UIApplication sharedApplication]delegate];
    _energyPercent = 100;

    for (int i = 0; i < 3; i++)
        ((UIInventoryView*)[self.view viewWithTag:990 + i]).originRect = ((UIInventoryView*)[self.view viewWithTag:990 + i]).frame;
    _flag = 1;
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    self.panda.userInteractionEnabled = YES;
    [self.panda addGestureRecognizer:singleTap];
    
    if (![[AppDelegate sharedInstance] isProVersion]) {
        [_memoryGameButton setImage:[UIImage imageNamed:@"i_navicon_memory_locked.png"] forState:UIControlStateNormal];
        [_spellGameButton setImage:[UIImage imageNamed:@"i_navicon_spell_locked.png"] forState:UIControlStateNormal];
    }
}
-(void)backToIdle:(id)obj
{
    [self setMonkeyGifImage:@"o_mochi_idle"];
    if (obj) [self removeInventoryView:[obj intValue]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            _rainbowImageView.image = nil;
            _dancingImageView.image = nil;
        });
    });
    [_dancingView setHidden:YES];
    
    if (_energyPercent == 0)
    {
        [self performSelector:@selector(setTiredPanda) withObject:nil afterDelay:0.2];
    }
    [self updateMessageView];
}

-(void)updateMessageView
{
    [_messageView setImage:[UIImage imageNamed:@"i_home_dialog_1.png"]];
    
    if ([appDelegate.foodInventory count] > 0 && _energyPercent == 0)
        [_messageView setImage:[UIImage imageNamed:@"i_home_dialog_2.png"]];
    else if ([appDelegate.foodInventory count] == 0 && _energyPercent == 0)
        [_messageView setImage:[UIImage imageNamed:@"i_home_dialog_3.png"]];
    
}

-(void)updateSoundButton
{
    if ([[AppDelegate sharedInstance] isSoundOn]) {
        [_soundButton setImage:[UIImage imageNamed:@"i_sound_on.png"] forState:UIControlStateNormal];
    } else {
        [_soundButton setImage:[UIImage imageNamed:@"i_sound_off.png"] forState:UIControlStateNormal];
    }
}

-(void)setTiredPanda
{
    [self setMonkeyGifImage:@"o_mochi_tired"];
}

-(void)handleSingleTap:(id)sender
{
    
    if (_energyPercent > 0) {
        if ([[AppDelegate sharedInstance] isSoundOn]) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"bounce.mp3" loop:NO];
        }
        
        int idx = abs(rand()) % 4;
        NSString* fileName;
        switch (idx) {
            case 0:
                fileName = @"o_mochi_shuffle";
                break;
                
            case 1:
                fileName = @"o_mochi_belly";
                break;
                
            case 2:
                fileName = @"o_mochi_laugh_nm";
                break;
                
            case 3:
                fileName = @"o_mochi_march";
                break;
                
            case 4:
                fileName = @"o_mochi_monkey";
                break;
                
            default:
                break;
        }
        [self setMonkeyGifImage:fileName];
        
        [_dancingView setHidden:NO];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                _rainbowImageView.image = _rainbowImage;
                [_rainbowImageView setAlpha:0.3];

                _dancingImageView.image = [[AppDelegate sharedInstance] getDancingImage];
                [_dancingImageView setAlpha:0.75];
            });
        });

        _energyPercent -= 25;
        [_energyImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"i_energy_%02d.png", _energyPercent]]];
        
        [self performSelector:@selector(backToIdle:) withObject:nil afterDelay:2];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_flag) return;
    UITouch *touch = [[event allTouches]anyObject];
    if([touch view].tag > 900 && [[touch view] isKindOfClass:[UIInventoryView class]] && [((UIImageView*)[touch view]) image] != nil)
    {
        CGPoint pt = [[touches anyObject] locationInView:[touch view]];
        _startLocation = pt;
    }
    
   
}

- (void) touchesMoved:(NSSet *)touches withEvent: (UIEvent *)event
{
    if (!_flag) return;
    UITouch *touch = [[event allTouches]anyObject];
    if([[touch view] isKindOfClass:[UIInventoryView class]] && [((UIImageView*)[touch view]) image] != nil)
    {
        CGPoint pt = [[touches anyObject] previousLocationInView:[touch view]];
        CGFloat dx = pt.x - _startLocation.x;
        CGFloat dy = pt.y - _startLocation.y;
        CGPoint newCenter = CGPointMake([touch view].center.x + dx, [touch view].center.y + dy);
        [touch view].center = newCenter;
    }
    
    
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches]anyObject];
    if([[touch view] isKindOfClass:[UIInventoryView class]] && CGRectContainsPoint(_frontView.frame, [touch view].center) && [((UIImageView*)[touch view]) image] != nil && [touch view].tag > 900)
    {

        _flag = 0;
        [self setMonkeyGifImage:@"o_mochi_eat"];
        
        if ([[AppDelegate sharedInstance] isSoundOn]) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"crunch.mp3" loop:NO];
        }

        ((UIImageView*)[_backView viewWithTag:50]).image = ((UIImageView*)[touch view]).image;
        [touch view].hidden = YES;
        ([_backView viewWithTag:50]).hidden = NO;
        [touch view].frame = ((UIInventoryView*)[touch view]).originRect;
        __block UIView* view = [touch view];
        [UIView animateWithDuration:1.5 animations:^{
            [([_backView viewWithTag:50]) setFrame:CGRectMake(([_backView viewWithTag:50]).center.x, ([_backView viewWithTag:50]).center.y, 0, 0)];
        } completion:^(BOOL finished) {
            _energyPercent = 100;
            [_energyImage setImage:[UIImage imageNamed:@"i_energy_100.png"]];
            CGPoint center = [_backView viewWithTag:50].center;
            [_backView viewWithTag:50].hidden = YES;
            [_backView viewWithTag:50].frame = ((UIInventoryView*)view).originRect;
            [_backView viewWithTag:50].center = center;
            [touch view].hidden = NO;
            _flag = 1;

            [self setMonkeyGifImage:@"o_mochi_belly"];
            [self performSelector:@selector(backToIdle:) withObject:[NSNumber numberWithInt:(int)view.tag] afterDelay:1.5];
        }];
    }
    else
        if ([[touch view] isKindOfClass:[UIInventoryView class]] && [((UIImageView*)[touch view]) image] != nil )
            [touch view].frame = ((UIInventoryView*)[touch view]).originRect;
}
-(void)removeInventoryView:(int)ID
{
    
    [appDelegate.foodInventory removeObjectAtIndex:ID - 990];
    [self updateInventoryView];
    
}
-(void)updateInventoryView
{
    int i = 0;
    for (i = 0; i < [appDelegate.foodInventory count]; i++)
    {
        [((UIInventoryView*)[_backView viewWithTag:i + 990]) setHidden:NO];
         [((UIInventoryView*)[_backView viewWithTag:i + 990]) setImage:[UIImage imageNamed:appDelegate.foodInventory[i]]];
        NSLog(@"Image: %@", appDelegate.foodInventory[i]);
    }
    for (; i < 3; i++)
        [((UIInventoryView*)[_backView viewWithTag:i + 990]) setImage:nil];

}
- (IBAction)onButtonClicked:(id)sender {
    if (![[AppDelegate sharedInstance] isProVersion]) {
        [[[UIAlertView alloc]initWithTitle:@"Upgrade" message:@"Please buy the full version to play this game!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Upgrade!", nil] show];
    } else {
        [_completedView setHidden:NO];        
//        [UIView animateWithDuration:1.5 animations:^{
//            self.backView.alpha = 0;
//        } completion:^(BOOL finished) {
//            
//            MemoryGameViewController *viewController = (MemoryGameViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"screenyetcome"];
//            NSLog(@"tag = %d", (int)((UIButton*)sender).tag);
//            viewController.index = (int)((UIButton*)sender).tag - 1;
//            [self.navigationController pushViewController:viewController animated:NO];
//        }];
    }

}

- (IBAction)onButton1Clicked:(id)sender {
    [UIView animateWithDuration:1.5 animations:^{
        if ([[AppDelegate sharedInstance] isSoundOn]) {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        }
        self.backView.alpha = 0;
    } completion:^(BOOL finished) {
        Game1ViewController *viewController = (Game1ViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Game1ViewController"];

        [self.navigationController pushViewController:viewController animated:NO];
    }];
    
}

- (IBAction)onButton2Clicked:(id)sender {
    if (![[AppDelegate sharedInstance] isProVersion]) {
        [[[UIAlertView alloc]initWithTitle:@"Upgrade" message:@"Please buy the full version to play this game!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Upgrade!", nil] show];
    } else
    {
        [UIView animateWithDuration:1.5 animations:^{
            if ([[AppDelegate sharedInstance] isSoundOn]) {
                [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
            }
            self.backView.alpha = 0;
        } completion:^(BOOL finished) {
            MemoryGameViewController *viewController = (MemoryGameViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"MemoryGameController"];
            [self.navigationController pushViewController:viewController animated:NO];
        }];
    }
}

- (IBAction)onButton3Clicked:(id)sender {
    if (![[AppDelegate sharedInstance] isProVersion]) {
        [[[UIAlertView alloc]initWithTitle:@"Upgrade" message:@"Please buy the full version to play this game!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Upgrade!", nil] show];
    } else
    {
            [UIView animateWithDuration:1.5 animations:^{
                if ([[AppDelegate sharedInstance] isSoundOn]) {
                    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                }
                self.backView.alpha = 0;
            } completion:^(BOOL finished) {
                Game2ViewController *viewController = (Game2ViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"Game2ViewController"];
        
                [self.navigationController pushViewController:viewController animated:NO];
            }];
    }
}

- (IBAction)onButton4Clicked:(id)sender {
    [UIView animateWithDuration:1.5 animations:^{
        if ([[AppDelegate sharedInstance] isSoundOn]) {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        }
        self.backView.alpha = 0;
    } completion:^(BOOL finished) {
        StoryViewController *viewController = (StoryViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"storyview"];
        
        [self.navigationController pushViewController:viewController animated:NO];
    }];
}

- (IBAction)onSoundBtnClicked:(id)sender {
    if ([[AppDelegate sharedInstance] isSoundOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kIsSoundOn];
        [_soundButton setImage:[UIImage imageNamed:@"i_sound_off.png"] forState:UIControlStateNormal];
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsSoundOn];
        [_soundButton setImage:[UIImage imageNamed:@"i_sound_on.png"] forState:UIControlStateNormal];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"cozy.mp3"];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex = %ld", (long)buttonIndex);
    if (buttonIndex == 1) {
        // Upgrade process
        [[AppDelegate sharedInstance] updateToProFrom:self];
    }
}

- (void)didUpdateToPro:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_memoryGameButton setImage:[UIImage imageNamed:@"i_navicon_memory.png"] forState:UIControlStateNormal];
        [_spellGameButton setImage:[UIImage imageNamed:@"i_navicon_spell.png"] forState:UIControlStateNormal];
    });
}

- (IBAction)onButtonWelcome:(id)sender {
    [_completedView setHidden:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
