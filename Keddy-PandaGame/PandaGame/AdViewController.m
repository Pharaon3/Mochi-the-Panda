//
//  AdViewController.m
//  FreeMusicDownloader
//
//  Created by AAA on 3/24/15.
//  Copyright (c) 2015 BBB. All rights reserved.
//

#import "AdViewController.h"
#import "AppDelegate.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

NSString * gAdBannerID = @"ca-app-pub-8387890899538086/9502167851";

static GADBannerView * sAdBannerView = nil;

@interface AdViewController () <GADBannerViewDelegate, GADInterstitialDelegate>
{
    __weak IBOutlet NSLayoutConstraint *_bannerHeightConstraint;
}


@end

@implementation AdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAppInfo) name:UIApplicationDidBecomeActiveNotification object:nil];
    [self showAdBanner:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
}

#pragma mark - Update App Info
- (void)updateAppInfo
{
}

#pragma mark - Ad Banner
- (void)showAdBanner:(BOOL)recreate
{
    if (!sAdBannerView || recreate) {
        [sAdBannerView removeFromSuperview];
        NSString *stringKindOfDevice = [[AppDelegate sharedInstance] getStringKindOfDevice];
        if ([stringKindOfDevice isEqualToString:@"iPad"]) {
            sAdBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeFullBanner];
        } else {
            sAdBannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerLandscape];
        }
        sAdBannerView.adUnitID = gAdBannerID;
        recreate = YES;
    }
    
    CGRect bounds = self.view.bounds;
    CGRect frame = sAdBannerView.frame;
    
    [sAdBannerView removeFromSuperview];
    sAdBannerView.frame = CGRectMake(bounds.origin.x, bounds.origin.y + bounds.size.height - frame.size.height, bounds.size.width, frame.size.height);
    [self.view addSubview:sAdBannerView];
    
    sAdBannerView.rootViewController = self;
    sAdBannerView.delegate = self;
    
    if (recreate) {
        sAdBannerView.adUnitID = gAdBannerID;
        GADRequest *request = [GADRequest request];
//        request.testDevices = @[ @"5fff11f74393ebad2ff07bf80ca54353",
//                                 @"c6fd3834e72c4a2d577158c53770fff8",
//                                 @"4fabb649ea5aed39f6be7b04f2896c3f",
//                                 @"902BE2CD-12D3-4462-8C45-75A129B6D1F3",
//                                 @"a444043fff6c1024be26644f9fda3403",
//                                 @"0855331009710000183daedb9d870a74",
//                                 @"ed949605ad5cf2ad46c1a047f0e137ae4a7d5d4d",
//                                 @"4f73a3fe5b3237eb589074de97829a5e",
//                                 @"cc0e48623133cb76c41189c90fd652e3",
//                                 @"441c8c7224ffaa84ebe32e889a26563c",
//                                 @"a1d8afa24d58403bf12400be521f23ba",
//                                 @"d12578cb7a565c02802e2069b851ad3c"];
        
        [sAdBannerView loadRequest:request];
        sAdBannerView.hidden = NO;
    }
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    UIView *bannerContainerView = [self.view viewWithTag:9999];
    if (bannerContainerView) {
        sAdBannerView.frame = bannerContainerView.frame;
        sAdBannerView.hidden = NO;
    }
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    sAdBannerView.hidden = NO;
}








@end
