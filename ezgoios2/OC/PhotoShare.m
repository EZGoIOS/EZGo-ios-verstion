//
//  SharePhoto.m
//  Unity-iPhone
//
//  Created by  Anthea on 2018/9/24.
//

//#import <Foundation/Foundation.h>//original
#import "PhotoShare.h"
#import "MyDataManager.h"
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
AVCaptureSession *myCaptureSession;//Oct 2
AVCaptureStillImageOutput *myStillImageOutput;
AVCaptureConnection *myVideoConnection = nil;
UIView *pauseUnityView1;

@implementation PhotoShare

- (void)viewDidLoad {
    defaults = [[NSUserDefaults standardUserDefaults] boolForKey:@"english"];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"載入PhotoShare.m");
    //==========Background Img===============
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    //建立 AVCaptureSession
    myCaptureSession = [[AVCaptureSession alloc] init];
    [myCaptureSession setSessionPreset:AVCaptureSessionPresetPhoto];
//
//    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init]; FBSDKSharePhoto * photo = [FBSDKSharePhoto photoWithImage:img userGenerated:YES]; content.photos = @[photo]; FBSDKShareButton *shareButton = [[FBSDKShareButton alloc] init]; shareButton.shareContent = content; [FBSDKShareDialog showFromViewController:self withContent:content delegate:self];
//    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareToFB:(id)sender {
    // Example content. Replace with content from your app.
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    
    
//    photo.image =PHimg;
        photo.image = [UIImage imageNamed:@"fake"];
    
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    //            content.contentURL = [NSURL URLWithString:@"https://developers.facebook.com"];
    content.photos = @[photo];
    
    //            FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
    //            dialog.fromViewController = self;
    //            dialog.shareContent = content;
    //            dialog.mode = FBSDKShareDialogModeShareSheet;
    //            [dialog show];
    [FBSDKShareDialog showFromViewController:self withContent:content delegate:nil];
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
    pauseUnityView1 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight-(screenHeight * 0.1), screenWidth, screenHeight)];//可以觸發的範圍
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
    [pauseUnityView1 addSubview:lbltop];
    [pauseUnityView1 addSubview:backBtnn];
    [pauseUnityView1 addSubview:PicBtn];
    [pauseUnityView1 addSubview:imgV];
    //pauseUnityView 是 UIView 的自訂變數名
    
    
    
    
    
    
    [[MyDataManager sharedManager].myWindow.rootViewController.view addSubview:pauseUnityView1];
    self.locationView = pauseUnityView1;//!!!!!!!
    
    //Oct 4
    //建立 AVCaptureSession
    myCaptureSession = [[AVCaptureSession alloc] init];
    [myCaptureSession setSessionPreset:AVCaptureSessionPresetPhoto];
    //Oct 4
    //建立 AVCaptureDeviceInput
    NSArray *myDevices = [AVCaptureDevice devices];
    
    for (AVCaptureDevice *device in myDevices) {
        if ([device position] == AVCaptureDevicePositionBack) {
            NSLog(@"後攝影機硬體名稱: %@", [device localizedName]);
        }
        
        if ([device position] == AVCaptureDevicePositionFront) {
            NSLog(@"前攝影機硬體名稱: %@", [device localizedName]);
        }
        
        if ([device hasMediaType:AVMediaTypeAudio]) {
            NSLog(@"麥克風硬體名稱: %@", [device localizedName]);
        }
    }
    
    //建立 AVCaptureVideoPreviewLayer
    AVCaptureVideoPreviewLayer *myPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:myCaptureSession];
    [myPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    CGRect rect = CGRectMake(160, 280, 320, 240);
    [myPreviewLayer setBounds:rect];
    
    UIView *myView = [[UIView alloc]initWithFrame:rect];
    [myView.layer addSublayer:myPreviewLayer];
    
    [pauseUnityView1 addSubview:myView];
    
    NSLog(@"addSubview AVCapture");

    
    //啟用攝影機 成功
    [myCaptureSession startRunning];
    
 
//    //建立 AVCaptureStillImageOutput
//    myStillImageOutput = [[AVCaptureStillImageOutput alloc] init];
//    NSDictionary *myOutputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
//    [myStillImageOutput setOutputSettings:myOutputSettings];
//    
//    [myCaptureSession addOutput:myStillImageOutput];//!!!!!!!!!
    
    
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

//========  截圖範圍  ==========
-(void)fullScreenshots{
//    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];     UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
//
//    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    NSLog(@"拍照");
//        [self save];
    //從 AVCaptureStillImageOutput 中取得正確類型的 AVCaptureConnection
    for (AVCaptureConnection *connection in myStillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                
                myVideoConnection = connection;
                break;
            }
        }
    }
    
    //擷取影像（包含拍照音效）
    [myStillImageOutput captureStillImageAsynchronouslyFromConnection:myVideoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        
        //完成擷取時的處理常式(Block)
        if (imageDataSampleBuffer) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            
            //取得的靜態影像
            UIImage *myImage = [[UIImage alloc] initWithData:imageData];
//            [self setImage:myImage];
            
            //取得影像資料（需要ImageIO.framework 與 CoreMedia.framework）
            CFDictionaryRef myAttachments = CMGetAttachment(imageDataSampleBuffer, kCGImagePropertyExifDictionary, NULL);
            NSLog(@"影像屬性: %@", myAttachments);
            
        }
    }];

//    UIImage *getImage = [self screenPhoto];
//    UIImageView *newIM = [[UIImageView alloc] initWithImage:getImage];
//    [newIM setFrame:CGRectMake(60, 200, 200, 700)];
//    [self.view addSubview:newIM];
//    [self imagePickerController];
}

//==============  存到相簿  ===============
-(void)save{

//    UIGraphicsBeginImageContextWithOptions([MyDataManager sharedManager].unityViewController.view.bounds.size, YES, [UIScreen mainScreen].scale);
    
     UIGraphicsBeginImageContextWithOptions([MyDataManager sharedManager].myWindow.rootViewController.view.bounds.size, NO, [UIScreen mainScreen].scale);
    [[MyDataManager sharedManager].myWindow.rootViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    PHimg = UIGraphicsGetImageFromCurrentImageContext();
  
    //call func
    PHimg = [self captureScreen];
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(PHimg, nil, nil, nil);  //保存到相册中
    UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"溫馨提示" message:@"相片已儲存" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
    [alart show];
}


////失敗
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
//
//    imgV.image = chosenImage;
//
//    UIImageWriteToSavedPhotosAlbum(chosenImage, nil, nil, nil);
//
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
    photo.image = image;
    photo.userGenerated = YES;
    FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
    content.photos = @[photo];
    [FBSDKShareDialog showFromViewController:self withContent:content delegate:nil];
    
}
- (UIImage *) captureScreen {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end

