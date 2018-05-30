//
//  EnterUnityViewController.h
//  Unity-iPhone
//
//  Created by Forever.H on 15/12/23.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>//經緯度用

@interface EnterUnityViewController : UIViewController<CLLocationManagerDelegate>
@property NSTimer *timer;
@property NSTimer *timer1;

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic) int whichAnimal;


- (IBAction)startUnity:(id)sender;

@end
