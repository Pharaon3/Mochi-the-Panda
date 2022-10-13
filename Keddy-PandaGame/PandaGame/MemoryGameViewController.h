//
//  MemoryGameViewController.h
//  PandaGame
//
//  Created by Steve on 2/9/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdViewController.h"

@interface MemoryGameViewController : AdViewController
@property (weak, nonatomic) IBOutlet UIImageView *bkgView;
@property int index;
@end
