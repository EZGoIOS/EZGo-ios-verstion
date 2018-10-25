//
//  SharePhoto.m
//  Unity-iPhone
//
//  Created by  Anthea on 2018/9/24.
//

//#import <Foundation/Foundation.h>//original
#import "PhotoShare.h"
#import "MyDataManager.h"
#import <Unity/PhotoManager.h>//    拍照圖片全域變數用
#import <AVFoundation/AVFoundation.h>//相機
#import <AssetsLibrary/AssetsLibrary.h>
//#import <Photos/Photos.h>//相簿權限
#import <Photos/PHPhotoLibrary.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKSharePhoto.h>
#import <FBSDKShareKit/FBSDKSharePhotoContent.h>
#import <FBSDKShareKit/FBSDKShareButton.h>
#import <FBSDKShareKit/FBSDKShareDialog.h>
#import <FBSDKShareKit/FBSDKShareLinkContent.h>

#include <math.h>
#include <stdio.h>
//宣告
BOOL defaults ;//判斷語言

UIImageView *imgV;
UIImage *PHimg;

@interface PhotoShare ()
@end

UIView *pauseUnityView1;

@implementation PhotoShare

- (void)viewDidLoad {
    defaults = [[NSUserDefaults standardUserDefaults] boolForKey:@"english"];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"載入PhotoShare.m");
    //==========Background Img===============
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    
//
//    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init]; FBSDKSharePhoto * photo = [FBSDKSharePhoto photoWithImage:img userGenerated:YES]; content.photos = @[photo]; FBSDKShareButton *shareButton = [[FBSDKShareButton alloc] init]; shareButton.shareContent = content; [FBSDKShareDialog showFromViewController:self withContent:content delegate:self];
//    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareToFB:(id)sender {
    
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    photo.image =GlobImg;
//    photo.image = [UIImage imageNamed:@"fake"];
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    //            FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
    //            dialog.fromViewController = self;
    //            dialog.shareContent = content;
    //            dialog.mode = FBSDKShareDialogModeShareSheet;
    //            [dialog show];
    //若沒有照片可分享
    if(photo.image == nil)
    {
        UIAlertView *alert;
        alert = [[UIAlertView alloc] initWithTitle:@"注意"
                                           message:@"圖片緩存為空，請先拍照進行分享"
                                          delegate:self
                                 cancelButtonTitle:@"確定"
                                 otherButtonTitles:nil];
        [alert show];
        
    }else{
        [FBSDKShareDialog showFromViewController:self withContent:content delegate:nil];
    }
}

//返回主畫面
- (IBAction)BackToMainStoryboardBtn:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:NO completion:NULL];
}
- (IBAction)startUnity:(id)sender {
    
    [MyDataManager sharedManager].isInMyHomeView = true;
    //==========
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"~~~~~~~~~~~~~~~timer start~~~~~~~~~~~~~~~~");
    
    if([MyDataManager sharedManager].isRestartInUnity)
    {
        //判断是否是第一次启动unity
        
        //将存放在单例中的unityViewController变成当前的rootVC
        [MyDataManager sharedManager].myWindow.rootViewController = [MyDataManager sharedManager].unityViewController;
        
        //将unityVC放到window的最上面
        [[MyDataManager sharedManager].myWindow bringSubviewToFront: [MyDataManager sharedManager].unityViewController.view];
        
        //让unity的界面显示出来
        [[[UnityGetMainWindow() rootViewController] view]setHidden:NO];
        [UnityGetMainWindow() makeKeyAndVisible];
        UnityPause(false);
    }
    else
    {
        //如果是第一次启动unity，需要添加返回键===========
        [MyDataManager sharedManager].isRestartInUnity = true;
        //启动unity================
        [[MyDataManager sharedManager].myAppDelegate startUnity:UIApplication.sharedApplication];
    }
    
    
    
    //螢幕長寬
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    //===============生成返回键================
    pauseUnityView1 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight-(screenHeight * 0.1), screenWidth * 0.3, screenHeight)];//可以觸發的範圍
    //top
//    pauseUnityView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];//可以觸發的範圍
    UIButton *backBtnn = [[UIButton alloc] initWithFrame:
                          CGRectMake(screenWidth * 0, screenHeight * 0, screenWidth * 0.3, screenHeight * 0.1)];//x,y,寬,高
    UIButton *PicBtn = [[UIButton alloc] initWithFrame:
                        CGRectMake(screenWidth * 0.4, screenHeight * 0, screenHeight * 0.1, screenHeight * 0.1)];//x,y,寬,高
    //上面底色
    UILabel *lbltop = [[UILabel alloc] initWithFrame:CGRectMake(0,0, screenWidth , screenHeight * 0.13)];
    UIImage *camera = [UIImage imageNamed:@"photo-btn"];
    imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 ,screenWidth,screenHeight)];
    [backBtnn addTarget:self action:@selector(doExitSelector) forControlEvents:UIControlEventTouchDown];
    [backBtnn setBackgroundColor:[UIColor colorWithRed:(202/255.0) green:(71/255.0) blue:(96/255.0) alpha:.8]];//按鈕背景色
    [backBtnn setTitle:@"END" forState:(UIControlStateNormal)];//按鈕文字
    [backBtnn setTintColor:[UIColor whiteColor] ];//文字顏色 其實根本沒用＃＃＃
    [PicBtn setImage:camera forState:UIControlStateNormal];
    [PicBtn addTarget:self action:@selector(doSavePhoto) forControlEvents:UIControlEventTouchDown];
    [lbltop setBackgroundColor:[UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:.5]];//0.65背景色
//    [imgV setBackgroundColor:[UIColor redColor]];//====================================================
    //add Subviews
//    [pauseUnityView1 addSubview:lbltop];
    [pauseUnityView1 addSubview:backBtnn];
//    [pauseUnityView1 addSubview:PicBtn];
//    [pauseUnityView1 addSubview:imgV];
    //pauseUnityView 是 UIView 的自訂變數名
    
    
    [[MyDataManager sharedManager].myWindow.rootViewController.view addSubview:pauseUnityView1];
    self.locationView = pauseUnityView1;//!!!!!!!
}


//================返回键函数================
- (void)doExitSelector{
    [_timer invalidate];
    [_timer1 invalidate];
    NSLog(@"結束拍照button have been clicked.");

    UnityPause(true); //跳转回iOS部分时需要暂停unity
    
    //将unity的rootVC存在单例中防止被释放掉
    [MyDataManager sharedManager].unityViewController = [MyDataManager sharedManager].myWindow.rootViewController;
    [[[UnityGetMainWindow() rootViewController] view] setHidden:YES]; //隐藏Unity的rootVC
    [MyDataManager sharedManager].myWindow.rootViewController = self; //将当前界面B作为当前window的rootVC
    [UnityGetMainWindow() makeKeyAndVisible];
    
    [self.locationView removeFromSuperview];

}
- (void)doSavePhoto{
    NSLog(@"按下拍照按鈕");
    UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"溫馨提示" message:@"相片已儲存" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
    [alart show];
    
    //==========  要求相簿權限  ============
    //--如果沒有權限跳alert--第一次不會進来
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied){
        // 無權限 做一個友好的提示
        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"溫馨提示" message:@"請您設置允許該應用訪問您的相機\n設置>隱私>相機" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
        [alart show];
        return;
    }
    
    //----每次都會進来
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            NSLog(@"Authorized 開始截圖");
            //呼叫
//            [self fullScreenshots];
//            [self save];
            
//            [FBSDKShareDialog showFromViewController:self withContent:content delegate:nil];
        }else{
            NSLog(@"Denied or Restricted");
            //----为什么没有在这个里面进行权限判断，因为会项目会蹦。。。
        }
    }];
}


//==============  存到相簿  ===============
-(void)save{
  
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(PHimg, nil, nil, nil);  //保存到相册中
    UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"溫馨提示" message:@"相片已儲存" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
    [alart show];
}

@end

