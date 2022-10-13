//
//  Game1PlayViewController.m
//  PandaGame
//
//  Created by Steve on 2/26/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "Game1PlayViewController.h"
#import "UIImage+animatedGIF.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@import GoogleMobileAds;

@interface Game1PlayViewController()
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
@property int currentScore, maxScore;
@property NSArray* categoryArray, *colorArray;
@property (weak, nonatomic) IBOutlet UIButton *soundButton;


@end
@implementation Game1PlayViewController

-(void)fadeIn:(SEL)callBack
{
    [UIView animateWithDuration:2 animations:^{
        [_mainView setAlpha:0];
    } completion:^(BOOL finished) {
        [self performSelector:callBack withObject:nil afterDelay:0];
    }];
}

-(void)goDifficultyScreen
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)onBack:(id)sender {
    [self fadeIn:@selector(goDifficultyScreen)];
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
    
    if ([[AppDelegate sharedInstance] isSoundOn])
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"moony.wav"];

    self.view.multipleTouchEnabled = NO;
    _categoryArray = [@"food,clothing,food,clothing,animal,food,animal,animal,animal,clothing,food,clothing,clothing,animal,animal,animal,clothing,food,food,animal,clothing,clothing,clothing,clothing,clothing,food,clothing,clothing,clothing,animal,food,food,food,food,food,food,food,clothing,food" componentsSeparatedByString:@","];
    _colorArray = [@"warm,cool,warm,cool,warm,warm,warm,warm,warm/cool,cool,cool,warm,cool,cool,warm/cool,cool,warm/cool,warm,warm,warm,warm,cool,warm,cool,cool,warm,warm,warm,warm,warm/cool,warm,cool,warm/cool,warm,warm,warm,warm,cool,warm" componentsSeparatedByString:@","];
    srand((unsigned int)time(nil));
    int width = [[UIScreen mainScreen]bounds].size.width;
    
    int count = 0;
    
    _currentScore = 0;
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"o_mochi_hold_down" withExtension:@"gif"];
    self.panda.image = [UIImage animatedImageWithAnimatedGIFURL:url];
   
    if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPad"]) {
        self.panda.frame = CGRectMake(386, 53, 252, 465);
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone4"]) {
        self.panda.frame = CGRectMake(181, 22, 118, 194);
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone5"]) {
        self.panda.frame = CGRectMake(386, 53, 252, 465);
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6"]) {
        self.panda.frame = CGRectMake(386, 53, 252, 465);
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6+"]) {
        self.panda.frame = CGRectMake(386, 53, 252, 465);
    }
    
    
//    int categoryCount = [_categoryArray count];
//    int colorCount = [_colorArray count];
//    NSLog(@"category's size = %d, color's size = %d", categoryCount, colorCount);
    
    switch (_level)
    {
        case 10:
            count = 3;
            _maxScore = 5;
            break;
        case 20:
            count = 5;
            _maxScore = 7;
            break;
        case 30:
            count = 7;
            _maxScore = 10;
            break;
        default:
            return;
    }
    _totalCount = count;

    int image_size = 0;
    if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPad"]) {
        image_size = 152 - count * 10;
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone4"]) {
        image_size = 102 - count * 10;
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone5"]) {
        image_size = 152 - count * 10;
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6"]) {
        image_size = 152 - count * 10;
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6+"]) {
        image_size = 152 - count * 10;
    }
    
    NSMutableArray* arr = [[NSMutableArray alloc]init];
    NSMutableArray* arrSet = [[NSMutableArray alloc]init];
    
    if (_level == 10)
        for (int i = 0; i < 39; i++)
             [arrSet addObject:[NSNumber numberWithInt:i + 1]];
    else if (_level == 20)
    {
        NSArray* categories = @[@"food", @"animal", @"clothing"];
        int selectedIndex = rand() % 3;
        for (int i = 0; i < 39; i++)
        {
            if ([categories[selectedIndex] isEqualToString:_categoryArray[i]])
                [arrSet addObject:[NSNumber numberWithInt:i + 1]];
        }
    }
    else if (_level == 30)
    {
        
            NSArray* categories = @[@"warm", @"cool"];
            int selectedIndex = rand() % 2;
            for (int i = 0; i < 39; i++)
            {
                if ([_colorArray[i] containsString:categories[selectedIndex]])
                    [arrSet addObject:[NSNumber numberWithInt:i + 1]];
            }

    }
    
    NSLog(@"%@", arrSet);
    
    for (int i = 0; i < count; i++)
    {
        int flag = 0;
        int val = rand() % [arrSet count];
        for (int j = 0; j < i; j++)
            if (val == [arr[j] intValue])
            { flag = 1;     break;}
        if (flag) {i --; continue; }
        [arr addObject:[NSNumber numberWithInteger:val]];
        
    }
    
    NSLog(@"%@", arr);
    NSLog(@"imageSize = %d", image_size);
    for (int i = 0; i < count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", [arrSet[[arr[i] intValue]] intValue]]]];

        if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPad"]) {
            [imageView setFrame:CGRectMake(width / (count + 1) * (i + 1) - image_size / 2, 560, image_size, image_size)];
        } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone4"]) {
            [imageView setFrame:CGRectMake(width / (count + 1) * (i + 1) - image_size / 2, 210, image_size, image_size)];
        } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone5"]) {
            [imageView setFrame:CGRectMake(width / (count + 1) * (i + 1) - image_size / 2, 560, image_size, image_size)];
        } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6"]) {
            [imageView setFrame:CGRectMake(width / (count + 1) * (i + 1) - image_size / 2, 560, image_size, image_size)];
        } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6+"]) {
            [imageView setFrame:CGRectMake(width / (count + 1) * (i + 1) - image_size / 2, 560, image_size, image_size)];
        }

        imageView.tag = 101 + i;
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_aObjectView addSubview:imageView];
    }
    
    _qIndex = rand() % count;
    _qObjectImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", (int)[arrSet[[arr[_qIndex] intValue]] integerValue]]] ;
    
    _flag = 1;
    
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

    if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPad"]) {
        self.panda.frame = CGRectMake(386, 53, 252, 465);
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone4"]) {
        self.panda.frame = CGRectMake(181, 22, 118, 194);
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone5"]) {
        self.panda.frame = CGRectMake(386, 53, 252, 465);
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6"]) {
        self.panda.frame = CGRectMake(386, 53, 252, 465);
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6+"]) {
        self.panda.frame = CGRectMake(386, 53, 252, 465);
    }
    
    NSMutableArray*arr = [[NSMutableArray alloc]init];
    NSMutableArray* arrSet = [[NSMutableArray alloc]init];
    
    if (_level == 10)
        for (int i = 0; i < 39; i++)
            [arrSet addObject:[NSNumber numberWithInt:i + 1]];
    else if (_level == 20)
    {
        NSArray* categories = @[@"food", @"animal", @"clothing"];
        int selectedIndex = rand() % 3;
        for (int i = 0; i < 39; i++)
        {
            if ([categories[selectedIndex] isEqualToString:_categoryArray[i]])
                [arrSet addObject:[NSNumber numberWithInt:i + 1]];
        }
    }
    else if (_level == 30)
    {
        
        NSArray* categories = @[@"cool", @"warm"];
        int selectedIndex = rand() % 2;
        for (int i = 0; i < 39; i++)
        {
            if ([_colorArray[i] containsString:categories[selectedIndex]])
                [arrSet addObject:[NSNumber numberWithInt:i + 1]];
        }
        
    }
        int count = _totalCount, width = [[UIScreen mainScreen]bounds].size.width;
    for (int i = 0; i < count; i++)
    {
        int flag = 0;
        int val = rand() % [arrSet count];
        for (int j = 0; j < i; j++)
            if (val == [arr[j] intValue])
            { flag = 1;     break;}
        if (flag) {i --; continue; }
        [arr addObject:[NSNumber numberWithInteger:val]];
        
    }

    int image_size = 0;
    if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPad"]) {
        image_size = 152 - count * 10;
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone4"]) {
        image_size = 102 - count * 10;
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone5"]) {
        image_size = 152 - count * 10;
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6"]) {
        image_size = 152 - count * 10;
    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6+"]) {
        image_size = 152 - count * 10;
    }

    NSLog(@"%@", arr);
    
    for (int i = 0; i < count; i++)
    {
        [[_aObjectView viewWithTag:101+i] removeFromSuperview];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", [arrSet[[arr[i] intValue]] intValue]]]];
        
        if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPad"]) {
            [imageView setFrame:CGRectMake(width / (count + 1) * (i + 1) - image_size / 2, 560, image_size, image_size)];
        } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone4"]) {
            [imageView setFrame:CGRectMake(width / (count + 1) * (i + 1) - image_size / 2, 210, image_size, image_size)];
        } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone5"]) {
            [imageView setFrame:CGRectMake(width / (count + 1) * (i + 1) - image_size / 2, 560, image_size, image_size)];
        } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6"]) {
            [imageView setFrame:CGRectMake(width / (count + 1) * (i + 1) - image_size / 2, 560, image_size, image_size)];
        } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6+"]) {
            [imageView setFrame:CGRectMake(width / (count + 1) * (i + 1) - image_size / 2, 560, image_size, image_size)];
        }

        imageView.tag = 101 + i;
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_aObjectView addSubview:imageView];
    }
    
    _qIndex = rand() % _totalCount;
    _qObjectImageView.image = [(UIImageView*)[_aObjectView viewWithTag:101+_qIndex] image];
    _qObjectImageView.alpha = 1;
    
    _flag = 1;
    _currentScore ++;
    [self updateScore];
    if (_currentScore == _maxScore)
    {
//        [[[UIAlertView alloc]initWithTitle:@"Success" message:@"You earned some food for Mochi! Feed him back at home." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
//
        AppDelegate* appDelegate = [[UIApplication sharedApplication]delegate];
        
        int c = abs(rand()) % 39;
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
    [_totalScoreImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"i_no_%d.gif", _maxScore]]];
    [_currentScoreImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"i_no_%d.gif", _currentScore]]];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches]anyObject];
        NSLog(@"%d, %f, %f", (int)[touch view].tag, _targetArea.frame.origin.x, [touch view].center.x);
    if ([touch view].tag > 100)
    {
        if( CGRectContainsPoint(_targetArea.frame, [touch view].center))
        {

            if ([touch view].tag - 101 == _qIndex)
            {
                [[touch view] setFrame:_originRect];
                [[touch view] setAlpha:0];
                [UIView animateWithDuration:0.5 animations:^{
                    
                    [_qObjectImageView setAlpha:0];
                } completion:^(BOOL finished) {
                    if ([[AppDelegate sharedInstance] isSoundOn])
                        [[SimpleAudioEngine sharedEngine] playEffect:@"Ding.mp3" loop:NO];
                    NSURL* url = [[NSBundle mainBundle] URLForResource:@"o_mochi_laugh" withExtension:@"gif"];
                    

                    if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPad"]) {
                        self.panda.frame = CGRectMake(247, -239,496,916);
                    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone4"]) {
                        self.panda.frame = CGRectMake(181, 22, 118, 194);
                    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone5"]) {
                        self.panda.frame = CGRectMake(386, 53, 252, 465);
                    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6"]) {
                        self.panda.frame = CGRectMake(386, 53, 252, 465);
                    } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6+"]) {
                        self.panda.frame = CGRectMake(386, 53, 252, 465);
                    }

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
                
                
                if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPad"]) {
                    self.panda.frame = CGRectMake(237,-78,496,916);
                } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone4"]) {
                    self.panda.frame = CGRectMake(181, 22, 118, 194);
                } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone5"]) {
                    self.panda.frame = CGRectMake(386, 53, 252, 465);
                } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6"]) {
                    self.panda.frame = CGRectMake(386, 53, 252, 465);
                } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6+"]) {
                    self.panda.frame = CGRectMake(386, 53, 252, 465);
                }

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
            int width = [[UIScreen mainScreen]bounds].size.width;
            int image_size = 0;
            if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPad"]) {
                image_size = 152 - _totalCount * 10;
            } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone4"]) {
                image_size = 102 - _totalCount * 10;
            } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone5"]) {
                image_size = 152 - _totalCount * 10;
            } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6"]) {
                image_size = 152 - _totalCount * 10;
            } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6+"]) {
                image_size = 152 - _totalCount * 10;
            }

            for (int i = 0; i < _totalCount; i++)
            {
                UIImageView* imageView = (UIImageView*)[self.view viewWithTag:101 + i];
                
                if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPad"]) {
                    [imageView setFrame:CGRectMake(width / (_totalCount + 1) * (i + 1) - image_size / 2, 560, image_size, image_size)];
                } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone4"]) {
                    [imageView setFrame:CGRectMake(width / (_totalCount + 1) * (i + 1) - image_size / 2, 210, image_size, image_size)];
                } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone5"]) {
                    [imageView setFrame:CGRectMake(width / (_totalCount + 1) * (i + 1) - image_size / 2, 560, image_size, image_size)];
                } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6"]) {
                    [imageView setFrame:CGRectMake(width / (_totalCount + 1) * (i + 1) - image_size / 2, 560, image_size, image_size)];
                } else if ([[[AppDelegate sharedInstance] getStringKindOfDevice] isEqualToString:@"iPhone6+"]) {
                    [imageView setFrame:CGRectMake(width / (_totalCount + 1) * (i + 1) - image_size / 2, 560, image_size, image_size)];
                }

            }
        }
    }
}

-(void)againPlay
{
    _flag = 1;
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"o_mochi_hold_down" withExtension:@"gif"];
    self.panda.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    self.panda.frame = CGRectMake(386,53,252,465);
    NSMutableArray*arr = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _totalCount; i++)
    {
        int flag = 0;
        int val = rand() % 39 + 1;
        for (int j = 0; j < i; j++)
            if (val == [arr[j] intValue])
            { flag = 1;     break;}
        if (flag) {i --; continue; }
        [arr addObject:[NSNumber numberWithInteger:val]];
        
    }
    
    NSLog(@"%@", arr);
    for (int i = 0; i < _totalCount; i++)
    {
        UIImageView *imageView = (UIImageView*)[self.view viewWithTag:101 + i];
        imageView.alpha = 1;
        imageView.tag = 101 + i;
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", [arr[i] intValue]]]];
        
    }
    
    _qIndex = rand() % _totalCount;
    _qObjectImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", (int)[arr[_qIndex] integerValue]]] ;
    _qObjectImageView.alpha = 1;
    
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
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"moony.wav"];
    }
}
@end
