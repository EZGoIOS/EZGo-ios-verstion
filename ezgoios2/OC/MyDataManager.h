//
//  MyDataManager.h
//  Unity-iPhone
//
//  Created by Forever.H on 15/12/23.
//
//

//放全域變數
//判斷是否要跳轉
#import <Foundation/Foundation.h>
#import "UnitySubAppDelegate.h"

@interface MyDataManager : NSObject

@property (nonatomic) BOOL isInMyHomeView;
@property (nonatomic) BOOL isRestartInUnity;
@property (strong, nonatomic) UIViewController *unityViewController;
@property (strong, nonatomic) UIWindow *myWindow;
@property (strong, nonatomic) UnitySubAppDelegate *myAppDelegate;

+ (MyDataManager*) sharedManager;

@end
