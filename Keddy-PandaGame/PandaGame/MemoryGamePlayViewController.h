//
//  MemoryGamePlayViewController.h
//  PandaGame
//
//  Created by apple on 3/25/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdViewController.h"

@interface MemoryGamePlayViewController : AdViewController<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property int level;
@property (weak, nonatomic) IBOutlet UIView *completedImage;
@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@end
