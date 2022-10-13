//
//  AppDelegate.h
//  PandaGame
//
//  Created by Steve on 2/9/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString*    kProductProKey;
extern NSString*    kUpdatedToProNotification;
extern NSString*    kIsSoundOn;
extern NSString*    kIsFirstStart;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) NSMutableArray* foodInventory;


+ (AppDelegate *)sharedInstance;

- (BOOL)isProVersion;
- (BOOL)isSoundOn;
- (UIImage*)getDancingImage;
- (NSString*)getStringKindOfDevice;
- (void)updateToProFrom:(UIViewController *)srcViewController;

@end

