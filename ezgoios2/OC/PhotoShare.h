//
//  SharePhoto.h
//  Unity-iPhone
//
//  Created by  Anthea on 2018/9/20.
//

//複製enterunityVC.h
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>//經緯度用
#import <AVFoundation/AVFoundation.h>//相機

//#ifndef SharePhote_h//文件自動產生
//#define SharePhote_h//文件自動產生


@interface PhotoShare : UIViewController<CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property NSTimer *timer;
@property NSTimer *timer1;
@property (nonatomic, weak) UIView *locationView;//add END按鈕

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, weak) UIViewController *fromViewController;//?


- (IBAction)OpenUnity:(id)sender;
- (IBAction)startUnity:(id)sender;

- (IBAction)startUnity:(id)sender;

@end


//#endif /* SharePhote_h */ //文件自動產生

//////





