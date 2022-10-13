//
//  AppDelegate.m
//  PandaGame
//
//  Created by Steve on 2/9/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "AppDelegate.h"
#import "MKStoreKit/MKStoreKit.h"
#import "MBProgressHUD/MBProgressHUD.h"
#import "SimpleAudioEngine.h"
#import "UIImage+animatedGIF.h"

NSString    *kProductProKey                 = @"guiang.mochithepanda.unlockgames";
NSString    *kUpdatedToProNotification      = @"UpdatedToPro";
NSString    *kIsSoundOn                     = @"sound_on";
NSString    *kIsFirstStart                  = @"first_start";
UIImage     *_dancingImage;
NSString    *_kindOfDevice;

static NSString *kIsProVersionKey           = @"IsProVersion";


@interface AppDelegate ()
{
    UIViewController *_currentViewController;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        UIStoryboard        *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
        UIViewController    *initialViewController = [mainStoryboard instantiateInitialViewController];
        NSLog(@"iPad");
        
        _kindOfDevice = @"iPad";
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = initialViewController;
        
        [self.window makeKeyAndVisible];
    } else {
        NSLog(@"height = %f", [[UIScreen mainScreen] bounds].size.width);
        if([[UIScreen mainScreen] bounds].size.width == 480.0) {
            UIStoryboard        *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone4" bundle:nil];
            UIViewController    *initialViewController = [mainStoryboard instantiateInitialViewController];
            NSLog(@"iPhone4");
            
            _kindOfDevice = @"iPhone4";
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.window.rootViewController = initialViewController;
            
            [self.window makeKeyAndVisible];
        } else if([[UIScreen mainScreen] bounds].size.width == 568.0) {
            UIStoryboard        *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone5" bundle:nil];
            UIViewController    *initialViewController = [mainStoryboard instantiateInitialViewController];
            NSLog(@"iPhone5");
            
            _kindOfDevice = @"iPhone5";
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.window.rootViewController = initialViewController;
            
            [self.window makeKeyAndVisible];
        } else if([[UIScreen mainScreen] bounds].size.width == 667.0) {
            UIStoryboard        *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone6" bundle:nil];
            UIViewController    *initialViewController = [mainStoryboard instantiateInitialViewController];
            NSLog(@"iPhone6");
            
            _kindOfDevice = @"iPhone6";
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.window.rootViewController = initialViewController;
            
            [self.window makeKeyAndVisible];
        } else if([[UIScreen mainScreen] bounds].size.width == 736.0) {
            UIStoryboard        *mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone6+" bundle:nil];
            UIViewController    *initialViewController = [mainStoryboard instantiateInitialViewController];
            NSLog(@"iPhone6+");
            
            _kindOfDevice = @"iPhone6+";
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.window.rootViewController = initialViewController;
            
            [self.window makeKeyAndVisible];
        }
    }
    
    _foodInventory = [[NSMutableArray alloc] initWithArray:@[@"1.png"]];
    
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"i_bg_dance" withExtension:@"gif"];
    _dancingImage = [UIImage animatedImageWithAnimatedGIFURL:url];

    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsSoundOn];
    [[MKStoreKit sharedKit] startProductRequest];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kMKStoreKitProductsAvailableNotification
                                                      object:nil
                                                       queue:[[NSOperationQueue alloc] init]
                                                  usingBlock:^(NSNotification *note) {
                                                      
                                                      NSLog(@"Products available: %@", [[MKStoreKit sharedKit] availableProducts]);
                                                  }];
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kMKStoreKitProductPurchasedNotification
                                                      object:nil
                                                       queue:[[NSOperationQueue alloc] init]
                                                  usingBlock:^(NSNotification *note) {
                                                      if (_currentViewController) {
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              [MBProgressHUD hideAllHUDsForView:_currentViewController.view animated:NO];
                                                              _currentViewController = nil;
                                                          });
                                                      }
                                                      
                                                      NSString *productIdentifier = [note object];
                                                      if ([productIdentifier isEqualToString:kProductProKey]) {
                                                          [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsProVersionKey];
                                                          [[NSUserDefaults standardUserDefaults] synchronize];
                                                          
                                                          [[NSNotificationCenter defaultCenter] postNotificationName:kUpdatedToProNotification object:nil];
                                                      }
                                                      NSLog(@"Purchased/Subscribed to product with id: %@", [note object]);
                                                  }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kMKStoreKitRestoredPurchasesNotification
                                                      object:nil
                                                       queue:[[NSOperationQueue alloc] init]
                                                  usingBlock:^(NSNotification *note) {
                                                      
                                                      NSLog(@"Restored Purchases");
                                                  }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kMKStoreKitRestoringPurchasesFailedNotification
                                                      object:nil
                                                       queue:[[NSOperationQueue alloc] init]
                                                  usingBlock:^(NSNotification *note) {
                                                      if (_currentViewController) {
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              [MBProgressHUD hideAllHUDsForView:_currentViewController.view animated:NO];
                                                              _currentViewController = nil;
                                                          });
                                                      }
                                                      
                                                      NSLog(@"Failed restoring purchases with error: %@", [note object]);
                                                  }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kMKStoreKitProductPurchaseFailedNotification
                                                      object:nil
                                                       queue:[[NSOperationQueue alloc] init]
                                                  usingBlock:^(NSNotification *note) {
                                                      if (_currentViewController) {
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              [MBProgressHUD hideAllHUDsForView:_currentViewController.view animated:NO];
                                                              _currentViewController = nil;
                                                          });
                                                      }
                                                      
                                                      NSLog(@"Failed purchases with error: %@", [note object]);
                                                      
                                                  }];
    
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"cozy.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"bounce.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"moony.wav"];
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"waltz.wav"];
    [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"nevermind.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Ding.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Horn.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"Shuffle.wav"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"xylo.mp3"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"crunch.mp3"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"Ding.wav"];
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"Horn.wav"];
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"Shuffle.wav"];
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"xylo.mp3"];
    [[SimpleAudioEngine sharedEngine] unloadEffect:@"crunch.mp3"];
}

#pragma mark - singleton
+ (AppDelegate *)sharedInstance
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)isProVersion
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIsProVersionKey];
}

- (BOOL)isSoundOn
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIsSoundOn];
}

- (UIImage*)getDancingImage
{
    return _dancingImage;
}

- (NSString*)getStringKindOfDevice
{
    return _kindOfDevice;
}


- (void)updateToProFrom:(UIViewController *)srcViewController
{
    if (_currentViewController) {
        [MBProgressHUD hideAllHUDsForView:_currentViewController.view animated:NO];
        _currentViewController = nil;
    }
    _currentViewController = srcViewController;
    
    [MBProgressHUD showHUDAddedTo:_currentViewController.view animated:NO];
    
    [[MKStoreKit sharedKit] initiatePaymentRequestForProductWithIdentifier:kProductProKey];
}
@end
