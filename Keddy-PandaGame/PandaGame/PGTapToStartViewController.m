//
//  PGTapToStartViewController.m
//  PandaGame
//
//  Created by Steve on 2/9/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "PGTapToStartViewController.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@interface PGTapToStartViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bkgView;
@property (weak, nonatomic) IBOutlet UIImageView *tapToStartButton;
@property (weak, nonatomic) IBOutlet UIView *completedView;



@end

@implementation PGTapToStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"cozy.mp3"];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(onTimer:)
                                   userInfo:nil
                                    repeats:YES];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    _bkgView.userInteractionEnabled = YES;
    [_bkgView addGestureRecognizer:singleTap];
}

-(void)onTimer:(id)sender
{
    [UIView animateWithDuration:0.7 animations:^{
        [_tapToStartButton setAlpha: 1 - (_tapToStartButton.alpha)];
    }];
}
-(void)handleSingleTap:(id)sender
{
    [UIView animateWithDuration:2 animations:^{
        if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsFirstStart]) {
            [_bkgView setAlpha:0];
            [_tapToStartButton setAlpha:0];
        } else {
            [_tapToStartButton setHidden:YES];
        }
    } completion:^(BOOL finished) {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        if (![[NSUserDefaults standardUserDefaults] boolForKey:kIsFirstStart]) {
            [_completedView setHidden:NO];
        } else {
            UIViewController* viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"homescreen"];
            [self.navigationController pushViewController:viewcontroller animated:NO];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onOK:(id)sender {
    [_completedView setHidden:YES];
    [_tapToStartButton setHidden:NO];
    UIViewController* viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"storyview"];
    [self.navigationController pushViewController:viewcontroller animated:NO];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsFirstStart];
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
