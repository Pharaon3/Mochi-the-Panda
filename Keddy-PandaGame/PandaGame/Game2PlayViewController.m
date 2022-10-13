//
//  Game1PlayViewController.m
//  PandaGame
//
//  Created by Steve on 2/26/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "Game2PlayViewController.h"
#import "UIImage+animatedGIF.h"
#import "AppDelegate.h"
#import "Audio/SimpleAudioEngine.h"

@import GoogleMobileAds;

@interface Game2PlayViewController()
@property (weak, nonatomic) IBOutlet UIImageView *qObjectImageView;
@property (weak, nonatomic) IBOutlet UIView *aObjectView;
@property (weak, nonatomic) IBOutlet UIView *targetArea;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *panda;
@property (weak, nonatomic) IBOutlet UIImageView *totalScoreImageView;
@property (weak, nonatomic) IBOutlet UIImageView *currentScoreImageView;
@property int flag;
@property CGPoint startLocation;
@property CGRect originRect;
@property int qIndex, totalCount;
@property (weak, nonatomic) IBOutlet UIView *scoreView;
@property int currentScore, maxScore;
@property NSArray* wordsArray;
@property (weak, nonatomic) IBOutlet UIView *lettersView;
@property (weak, nonatomic) IBOutlet UIView *chooseLettersView;
@property int prevIndex, currentWordLetterIndex, rightIndex;
@property     NSMutableArray* wordsArr;
@property CGRect rtV1, rtV2, rtV3;
@property (weak, nonatomic) IBOutlet UIButton *soundButton;
@end

@implementation Game2PlayViewController

-(void)fadeIn:(SEL)callBack
{
    [UIView animateWithDuration:2 animations:^{
        [_mainView setAlpha:0];
    } completion:^(BOOL finished) {
        [self performSelector:callBack withObject:nil afterDelay:0];
    }];
}

-(void)goHomeScreen
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (IBAction)onBack:(id)sender {
    [self fadeIn:@selector(goHomeScreen)];
}


-(void)updateSoundButton
{
    if ([[AppDelegate sharedInstance] isSoundOn]) {
        [_soundButton setImage:[UIImage imageNamed:@"i_sound_on.png"] forState:UIControlStateNormal];
    } else {
        [_soundButton setImage:[UIImage imageNamed:@"i_sound_off.png"] forState:UIControlStateNormal];
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _prevIndex = -1;
    
    if ([[AppDelegate sharedInstance] isSoundOn])
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"waltz.wav"];
    
    srand((unsigned int)time(nil));
    self.view.multipleTouchEnabled = NO;
//    int width = _lettersView.frame.size.width;
    
    int count = 0;
    
    _currentScore = 0;
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"o_mochi_hold_down" withExtension:@"gif"];
    self.panda.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    self.panda.frame = CGRectMake(721,173,252,465);
    
    switch (_level)
    {
        case 10:
            count = 3;
            _maxScore = 5;
            break;
        case 20:
            count = 3;
            _maxScore = 7;
            break;
        case 30:
            count = 3;
            _maxScore = 10;
            break;
        default:
            return;
    }
    
    _rtV1 = [[self.view viewWithTag:101] frame];
    _rtV3 = [[self.view viewWithTag:103] frame];
    _rtV2 = [[self.view viewWithTag:102] frame];
    
    _totalCount = count;
    _flag = 1;
    
    _wordsArr = [[NSMutableArray alloc]init];
    

    
    _wordsArray = @[@"APPLE",
                    @"SHIRT",
                    @"BANANA",
                    @"BELT",
                    @"CAT",
                    @"CHERRY",
                    @"COW",
                    @"DOG",
                    @"FISH",
                    @"GLASSES",
                    @"GRAPES",
                    @"HAT",
                    @"HOODIE",
                    @"HORSE",
                    @"LION",
                    @"MOUSE",
                    @"NECKLACE",
                    @"ORANGE",
                    @"PEAR",
                    @"PIG",
                    @"POLOSHIRT",
                    @"RING",
                    @"SHOE",
                    @"TANKTOP",
                    @"SOCK",
                    @"BERRY",
                    @"SWEATER",
                    @"SWEATER",
                    @"TANKTOP",
                    @"TIGER",
                    @"CARROT",
                    @"EGGPLANT",
                    @"ONION",
                    @"PEAS",
                    @"RADISH",
                    @"TOMATO",
                    @"BROCOLLI",
                    @"WATCH",
                    @"MELON"];
    
    for (int i = 0; i < 39; i++)
    {
        int len = (int)([_wordsArray[i] length]);
        if (_level == 10 && (len >=3 && len <= 4))
            [_wordsArr addObject:_wordsArray[i]];
        else if (_level == 20 && (len >= 4 && len <= 6))
            [_wordsArr addObject:_wordsArray[i]];
        else if (_level == 30 && (len >= 6 && len <= 16))
            [_wordsArr addObject:_wordsArray[i]];
    }

    
    [self updateScore];
    [self updateSoundButton];
    
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_flag) return;
    UITouch *touch = [[event allTouches]anyObject];
    if([touch view].tag > 100)
    {
        CGPoint pt = [[touches anyObject] locationInView:[touch view]];
        _startLocation = pt;
        _originRect = [touch view].frame;
    }
    
    
}

- (void) touchesMoved:(NSSet *)touches withEvent: (UIEvent *)event
{
    if (!_flag) return;
    UITouch *touch = [[event allTouches]anyObject];
    if([touch view].tag > 100)
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

-(void)nextPlay
{
    _flag = 1;
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"o_mochi_hold_down" withExtension:@"gif"];
    self.panda.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    self.panda.frame = //CGRectMake(386,53,252,465);
                    CGRectMake(721,173,252,465);
    _currentScore ++;
    [self updateScore];
    if (_currentScore == _maxScore)
    {
        //        [[[UIAlertView alloc]initWithTitle:@"Success" message:@"You earned some food for Mochi! Feed him back at home." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
        //
        AppDelegate* appDelegate = [[UIApplication sharedApplication]delegate];
        
        int c = abs(rand()) % 39;
        NSArray* _categoryArray = [@"food,clothing,food,clothing,animal,food,animal,animal,animal,clothing,food,clothing,clothing,animal,animal,animal,clothing,food,food,animal,clothing,clothing,clothing,clothing,clothing,food,clothing,clothing,clothing,animal,food,food,food,food,food,food,food,clothing,food" componentsSeparatedByString:@","];
        for (int i = 0; ; i++)
            if ([_categoryArray[i % 39] isEqualToString:@"food"])
            {
                c--;
                if (c < 0)
                {
                    [appDelegate.foodInventory insertObject:[NSString stringWithFormat:@"%d.png", i % 39 + 1] atIndex:0];
                    if ([appDelegate.foodInventory count] > 3)
                        [appDelegate.foodInventory removeObjectAtIndex:3];
                    [_foodImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i % 39 + 1]]];
                    NSLog(@"%d", i % 39+1);
                    
                    if ([[AppDelegate sharedInstance] isSoundOn])
                        [[SimpleAudioEngine sharedEngine] playEffect:@"xylo.mp3" loop:NO];

                    [_completedImage setHidden:NO];
                    return;
                }
            }
        
    }
}
-(void)updateScore
{
    int cIndex = _prevIndex;
    
    while (cIndex == _prevIndex)
    {
        cIndex = abs(rand()) % [_wordsArr count];
    }
    
    _prevIndex = cIndex;
    [_qObjectImageView setAlpha:1];
    for (int i = 0; i < 39; i++)
        if ([_wordsArr[cIndex] isEqualToString:_wordsArray[i]])
        {
            [_qObjectImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i + 1]]];
            break;
        }

    [self.view viewWithTag:101].frame = _rtV1;
    [self.view viewWithTag:102].frame = _rtV2;
    [self.view viewWithTag:103].frame = _rtV3;
    
    int len = (int)[_wordsArr[_prevIndex] length];
    
    _currentWordLetterIndex = abs(rand()) % len;
    
    NSArray* views = [_lettersView subviews];
    for (UIView* view in views)
         [view removeFromSuperview];
    
    int width = _lettersView.frame.size.width;

    int letterWidth = 40;
    
    float gapWidth = (width - letterWidth * len) * 1.0 / (len + 1);
    
    float startX = gapWidth;
    for (int i = 0; i < len; i++)
    {
        CGRect rt = CGRectMake(startX, 12, letterWidth, 62);
        CGRect rt1 = CGRectMake(startX, 75, letterWidth, 8);
        startX += gapWidth + letterWidth;
        
        UIImageView* view = [[UIImageView alloc]initWithFrame:rt];
        UIView* view1 = [[UIView alloc]initWithFrame:rt1];
                                
        [view1 setBackgroundColor:[UIColor blackColor]];
                                
        NSString* strFileName = [NSString stringWithFormat:@"o_%c.png", (char)[[_wordsArr[_prevIndex] lowercaseString] characterAtIndex:i]];
        NSLog(@"%@", strFileName);
        [view setImage:[UIImage imageNamed:strFileName]];
        
        if (i == _currentWordLetterIndex)
        {
            [view setHidden:YES];
            view.tag = 70;
        }
        
        [_lettersView addSubview:view];
        [_lettersView addSubview:view1];
    }
    
    _rightIndex = abs(rand()) % 3;
    int diff = [_wordsArr[_prevIndex] characterAtIndex:_currentWordLetterIndex] - 'A';
    NSMutableArray* randomChars = [[NSMutableArray alloc]init];
    for (int i = 0; i < 3; i++)
    {
        int j, rVal = abs(rand()) % 26;
        
        if (diff == rVal) {i--; continue; }
        for (j = 0; j < [randomChars count]; j++)
            if ([randomChars[j] characterAtIndex:0] - 'a' == rVal) break;
        
        if (j == [randomChars count]) [randomChars addObject:[NSString stringWithFormat:@"%c", rVal + 'a']];
        else { i--; continue; }
    }
    for (int i = 0; i < 3; i++)
    {
        [((UIImageView*)[self.view viewWithTag:101 + i]) setAlpha:1];
        if (_rightIndex == i)
        {
            NSRange range;
            range.length = 1;
            range.location = _currentWordLetterIndex;
            
            [((UIImageView*)[self.view viewWithTag:101 + i]) setImage:[UIImage imageNamed:[NSString stringWithFormat:@"o_%@.png", [[_wordsArr[_prevIndex] substringWithRange:range] lowercaseString]]]];
            
        }
        else
        {
            NSRange range;
            range.length = 1;
            range.location = _currentWordLetterIndex;
            
            [((UIImageView*)[self.view viewWithTag:101 + i]) setImage:[UIImage imageNamed:[NSString stringWithFormat:@"o_%@.png", randomChars[i]]]];
        }
    }
    
    
    [_totalScoreImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"i_no_%d.gif", _maxScore]]];
    [_currentScoreImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"i_no_%d.gif", _currentScore]]];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches]anyObject];
    NSLog(@"%f, %f, %f, %f", [_lettersView viewWithTag:70].frame.origin.x,_aObjectView.frame.origin.x, _targetArea.frame.origin.x, [touch view].center.x);
    if ([touch view].tag > 100)
    {
        CGPoint center = [touch view].center;
//        center.x -= [_lettersView viewWithTag:70].frame.origin.x;
//        center.y -= [_lettersView viewWithTag:70].frame.origin.y;
        center.x -= _aObjectView.frame.origin.x;
        center.y -= _aObjectView.frame.origin.y;
        center.x -= _lettersView.frame.origin.x;
        center.y -= _lettersView.frame.origin.y;

        if( CGRectContainsPoint(_targetArea.frame, [touch view].center) ||
           CGRectContainsPoint([_lettersView viewWithTag:70].frame, center ))
        {
            
            if ([touch view].tag - 101 == _rightIndex)
            {
                [[touch view] setFrame:_originRect];
                [[touch view] setAlpha:0];
                [[self.view viewWithTag:70] setHidden:NO];
                
                [UIView animateWithDuration:0.5 animations:^{
                    
                    [_qObjectImageView setAlpha:0];
                } completion:^(BOOL finished) {
                    if ([[AppDelegate sharedInstance] isSoundOn])
                        [[SimpleAudioEngine sharedEngine] playEffect:@"Ding.mp3" loop:NO];

                    NSURL* url = [[NSBundle mainBundle] URLForResource:@"o_mochi_laugh" withExtension:@"gif"];
                    self.panda.frame = CGRectMake(582, -119,496,916);

                    self.panda.image = [UIImage animatedImageWithAnimatedGIFURL:url];
                    [self performSelector:@selector(nextPlay) withObject:nil afterDelay:2];
                    _flag = 0;
                    
                }];
            }
            else
            {
                if ([[AppDelegate sharedInstance] isSoundOn])
                    [[SimpleAudioEngine sharedEngine] playEffect:@"Horn.wav" loop:NO];

                NSURL* url = [[NSBundle mainBundle] URLForResource:@"o_mochi_trip" withExtension:@"gif"];
                self.panda.frame = CGRectMake(572,42,496,916);
                self.panda.image = [UIImage animatedImageWithAnimatedGIFURL:url];
                [self performSelector:@selector(againPlay) withObject:nil afterDelay:1];
                [_qObjectImageView setAlpha:0];
                [UIView animateWithDuration:0.5 animations:^{
                    [[touch view] setFrame:_originRect];
                } completion:^(BOOL finished) {
                    _flag = 0;
                }];
            }
            
        }
        else
        {
            [self.view viewWithTag:101].frame = _rtV1;
            [self.view viewWithTag:102].frame = _rtV2;
            [self.view viewWithTag:103].frame = _rtV3;
        }
    }
}

-(void)againPlay
{
 
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"o_mochi_hold_down" withExtension:@"gif"];
    self.panda.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    self.panda.frame = CGRectMake(721,173,252,465);
    NSLog(@"!");

    _flag = 1;
    _currentScore --;
    if (_currentScore < 0) _currentScore = 0;
    [self updateScore];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    _currentScore = 0;
    [self updateScore];
}

- (IBAction)onKeepPlaying:(id)sender {
    [_completedImage setHidden:YES];
    _currentScore = 0;
    [self updateScore];
}

- (IBAction)onGoHome:(id)sender {
    NSArray *pushedViewControllers = [self.navigationController viewControllers];
    if (pushedViewControllers.count >= 3) {
        UIViewController *toViewController = [pushedViewControllers objectAtIndex:pushedViewControllers.count - 3];
        [self.navigationController popToViewController:toViewController animated:NO];
    }
}

- (IBAction)onSoundButton:(id)sender {
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
@end
