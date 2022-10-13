//
//  Game1PlayViewController.h
//  PandaGame
//
//  Created by Steve on 2/26/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdViewController.h"

@interface Game1PlayViewController : AdViewController<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UIView *completedImage;


@property int level;
@end
