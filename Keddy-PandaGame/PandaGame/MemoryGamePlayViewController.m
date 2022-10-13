//
//  MemoryGamePlayViewController.m
//  PandaGame
//
//  Created by apple on 3/25/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "MemoryGamePlayViewController.h"
#import "UIImage+animatedGIF.h"
#import "AppDelegate.h"
#import "Audio/SimpleAudioEngine.h"
@import GoogleMobileAds;

@interface MemoryGamePlayViewController()

@property int currentScore, targetScore;
@property (weak, nonatomic) IBOutlet UIImageView *currentScoreImageView;
@property (weak, nonatomic) IBOutlet UIImageView *targetScoreImageView;
@property (weak, nonatomic) IBOutlet UIView *objectView;
@property NSArray* categoryArray, *colorArray;
@property NSMutableArray *cardArray, *objectArray, *pairArray, *completedArray;
@property int totalCount;
@property UIImageView *tempCardImage, *tempObjImage;
@property (retain, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UIImageView *nameCard1;
@property (weak, nonatomic) IBOutlet UIImageView *nameCard2;
@property (weak, nonatomic) IBOutlet UIImageView *symbol;
@property (weak, nonatomic) IBOutlet UIButton *soundButton;

@end

@implementation MemoryGamePlayViewController

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
    self.view.multipleTouchEnabled = NO;
    
    if ([[AppDelegate sharedInstance] isSoundOn]) {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"nevermind.mp3"];
    }

    _categoryArray = [@"food,clothing,food,clothing,animal,food,animal,animal,animal,clothing,food,clothing,clothing,animal,animal,animal,clothing,food,food,animal,clothing,clothing,clothing,clothing,clothing,food,clothing,clothing,clothing,animal,food,food,food,food,food,food,food,clothing,food" componentsSeparatedByString:@","];
    _colorArray = [@"warm,cool,warm,cool,warm,warm,warm,warm,warm/cool,cool,cool,warm,cool,cool,warm/cool,cool,warm/cool,warm,warm,warm,warm,cool,warm,cool,cool,warm,warm,warm,warm,warm/cool,warm,cool,warm/cool,warm,warm,warm,warm,cool,warm" componentsSeparatedByString:@","];

    _currentScore = 0;
    const int card_image_width = 200;
    const int card_image_height = 290;
    int cardCount = 0;
    switch (_level) {
        case 10:
            cardCount = 6;
            _targetScore = 3;
            break;
            
        case 20:
            cardCount = 8;
            _targetScore = 4;
            break;

        case 30:
            cardCount = 10;
            _targetScore = 5;
            break;
        default:
            break;
    }
    
    _totalCount = cardCount;
    
//    [self.mainView addSubview:_objectView];
    // lay out the Cards
    // level == 10, 6 Cards
    // level == 20, 8 Cards
    // level == 30, 10 Cards
    NSMutableArray* arr = [[NSMutableArray alloc]init];
    NSMutableArray* arrSet = [[NSMutableArray alloc]init];
    
    _cardArray      = [[NSMutableArray alloc] init];
    _objectArray    = [[NSMutableArray alloc] init];
    _pairArray      = [[NSMutableArray alloc] init];
    _completedArray = [[NSMutableArray alloc] init];

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
    
    for (int i = 0; i < cardCount / 2; i++)
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

    NSMutableArray *randomArray = [[NSMutableArray alloc] init];
    NSMutableArray *halfArray = [[NSMutableArray alloc] init];;

    int randVal = -1;
    for (int i = 0; i < cardCount; i++) {
        
        do {
            randVal = rand() % [arr count];
        } while ([halfArray containsObject:[NSNumber numberWithInteger:randVal]]);
        
        
        for (int j = 0; j < i; j++) {
            if (randVal == [randomArray[j] intValue]) {
                [halfArray addObject:[NSNumber numberWithInteger:randVal]];
                break;
            }
        }
        
        [randomArray addObject:[NSNumber numberWithInteger:randVal]];
    }
    
    NSLog(@"randomArray = %@", randomArray);

    for (int i = 0; i < cardCount; i++) {
        int idx = [[randomArray objectAtIndex:i] intValue];
        [_objectArray addObject: arrSet[[arr[idx] intValue]]];
    }
    
    NSLog(@"_objectArray = %@", _objectArray);

    for (int i = 0; i < cardCount; i++)
    {
        //[[_objectView viewWithTag:101+i] removeFromSuperview];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"i_card_back.gif"]];
        if (_level == 10) {
            if (i < 3) {
                [imageView setFrame:CGRectMake(210 * (i + 1), 140, card_image_width, card_image_height)];
            } else {
                [imageView setFrame:CGRectMake(210 * (i - 2), 415, card_image_width, card_image_height)];
            }
        } else if (_level == 20) {
            if (i < 4) {
                [imageView setFrame:CGRectMake(100 + (210 * i), 140, card_image_width, card_image_height)];
            } else  {
                [imageView setFrame:CGRectMake(100 + (210 * (i - 4)), 415, card_image_width, card_image_height)];
            }
        } else if (_level == 30) {
            if (i < 5) {
                [imageView setFrame:CGRectMake(10 + (200 * i), 140, card_image_width, card_image_height)];
            } else  {
                [imageView setFrame:CGRectMake(10 + (200 * (i - 5)), 415, card_image_width, card_image_height)];
            }
        }
        imageView.tag = 101 + i;
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_cardArray addObject:imageView];
        [_objectView addSubview:imageView];
    }
    
    
    
    
    [self updateScore];
    [self updateSoundButton];
    
}

-(void)updateScore
{
    [_targetScoreImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"i_no_%d.gif", _targetScore]]];
    [_currentScoreImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"i_no_%d.gif", _currentScore]]];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches]anyObject];
    int tag = (int)[touch view].tag;
    
    if ([touch view].tag > 100) {
        [[_objectView viewWithTag:tag] removeFromSuperview];
        NSURL* url = [[NSBundle mainBundle] URLForResource:@"i_card_flip" withExtension:@"gif"];
        UIImageView *imageView = [_cardArray objectAtIndex:(tag - 101)];
        
        if (_totalCount == 6) {
            if (tag < 101 + 3) {
                imageView.frame = CGRectMake(210 * (tag - 101 + 1), 140, 200, 290);
            } else {
                imageView.frame = CGRectMake(210 * (tag - 101 - 2), 415, 200, 290);
            }
        } else if (_totalCount == 8) {
            if (tag < 101 + 4) {
                imageView.frame = CGRectMake(100 + (210 * (tag - 101)), 140, 200, 290);
            } else {
                imageView.frame = CGRectMake(100 + (210 * (tag - 101 - 4)), 415, 200, 290);
            }
        } else if (_totalCount == 10) {
            if (tag < 101 + 5) {
                imageView.frame = CGRectMake(10 + (200 * (tag - 101)), 140, 200, 290);
            } else {
                imageView.frame = CGRectMake(10 + (200 * (tag - 101 - 5)), 415, 200, 290);
            }
        }
        imageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
        //        imageView.tag = tag;
        //        imageView.userInteractionEnabled = YES;
        //        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        if ([[AppDelegate sharedInstance] isSoundOn]) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"Shuffle.wav" loop:NO];
        }
    
    
        [self performSelector:@selector(appearObject:) withObject:imageView afterDelay:0.4];
        
        [_objectView addSubview:imageView];
    }

}

-(void)appearObject:(UIImageView *)imageView
{
    int tag = (int)imageView.tag;
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"i_card_front" withExtension:@"gif"];
    imageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    
    
    UIImageView *objView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", [[_objectArray objectAtIndex:tag - 101] intValue]]]];
    objView.frame = CGRectMake(43, 88, 114, 114);
    
    objView.userInteractionEnabled = YES;
    objView.contentMode = UIViewContentModeScaleAspectFit;
    objView.tag = 1;

    [imageView addSubview:objView];
    
    _tempObjImage = objView;
    
    [self performSelector:@selector(appearName:) withObject:imageView afterDelay:0.1];
    
}

-(void)appearBack:(UIImageView *)imageView
{
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"i_card_back" withExtension:@"gif"];
    imageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
}

-(void)appearName:(UIImageView *)imageView
{
    int tag = (int)imageView.tag;
    int objectIndex = [[_objectArray objectAtIndex:tag - 101] intValue];
    if ([_pairArray count] == 0) {
        [_nameCard1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"n_%d.gif", objectIndex]]];
    } else {
        [_symbol setImage:[UIImage imageNamed:@"n_and.gif"]];
        [_nameCard2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"n_%d.gif", objectIndex]]];
    }
    
    if ([_pairArray count] == 0) {
        [_pairArray addObject:[_objectArray objectAtIndex:tag - 101]];
        imageView.tag = tag - 50;
        _tempCardImage = imageView;
    } else {
        if ([[_pairArray objectAtIndex:0] intValue] == objectIndex) {
            _currentScore ++;
            imageView.tag = tag - 50;
            
            
        } else {
            [[imageView viewWithTag:1] removeFromSuperview];
            [[_tempCardImage viewWithTag:1] removeFromSuperview];
            
            NSURL* url = [[NSBundle mainBundle] URLForResource:@"i_card_flip_2" withExtension:@"gif"];
            _tempCardImage.image = [UIImage animatedImageWithAnimatedGIFURL:url];
            [self performSelector:@selector(appearBack:) withObject:_tempCardImage afterDelay:0.4];
            _tempCardImage.tag += 50;
            
            
            imageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
            
            if ([[AppDelegate sharedInstance] isSoundOn]) {
                [[SimpleAudioEngine sharedEngine] playEffect:@"Shuffle.wav" loop:NO];
            }

            [self performSelector:@selector(appearBack:) withObject:imageView afterDelay:0.4];
            imageView.tag = tag;
        }
        [_pairArray removeAllObjects];
        
        [self performSelector:@selector(clearImages) withObject:nil afterDelay:1.0];
    }
    NSLog(@"pairArray = %@", _pairArray);

    [self updateScore];
    
    if (_currentScore == _targetScore) {
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

- (void)clearImages
{
    [_nameCard2 setImage:nil];
    [_symbol setImage:nil];
    [_nameCard1 setImage:nil];
}

- (IBAction)onKeepPlaying:(id)sender {
    [_completedImage setHidden:YES];
    _currentScore = 0;
    [self updateScore];
    
    for (int i = 0; i < _totalCount; i++) {
        [[_objectView viewWithTag:101 + i ] removeFromSuperview];
    }
    
    for (int i = 0; i < _totalCount; i++) {
        [[_objectView viewWithTag:51 + i ] removeFromSuperview];
    }
    [self viewDidLoad];
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
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"nevermind.mp3"];
    }
}
@end
