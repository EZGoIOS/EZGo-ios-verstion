//
//  EnterUnityViewController.m
//  Unity-iPhone
//
//  Created by Forever.H on 15/12/23.
//1 斑點狗//2 TW Bear//3 North Gray Wolf//4 Black Tail Mouse/5 Happy Bird//6Mountain gun//7Teaching core
//有aa的行 133 239 280 309 322
//UnitySendMessage 92 132 187

#import "EnterUnityViewController.h"
#import "MyDataManager.h"
#import <AVFoundation/AVFoundation.h>//相機
#import <AssetsLibrary/AssetsLibrary.h>
#import "ezgo2-Swift.h"

#include <math.h>
#include <stdio.h>

double mylat,mylng;
double aa,ab,ac,ad,ae,af,ag;
bool isFirstTime = true;
//NSString *whichAnimal=NULL;
int whichAnimal;
BOOL defaults ;

@interface EnterUnityViewController ()

@end
UIView *pauseUnityView1;//End 按鈕
UIView *downUiView;//下方抵達範圍
UIView *upUiView;//上右邊lbl

@implementation EnterUnityViewController

@synthesize locationManager;//自動幫忙產生setter/getter //user location


- (void)viewDidLoad {
    defaults = [[NSUserDefaults standardUserDefaults] boolForKey:@"english"];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self startTimer];
    //=======取得經緯度======
    //建立CLLocationManger，並存於locationManager實體變數中
    locationManager = [[CLLocationManager alloc]init];
    [locationManager setDelegate:self];//委派予self
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    //傳送startUpdatingLocation訊息，開始更新訊息
    [locationManager startUpdatingLocation];
    
    //===========相機權限==============
    //==========Background Img===============
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [locationManager stopUpdatingLocation];//?
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)BackToMainStoryboardBtn:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:NO completion:NULL];
}
//======= 開啟Unity導航按鈕 ========
- (IBAction)startUnity:(id)sender {
    [self startTimer];
    [MyDataManager sharedManager].isInMyHomeView = true;
    //==========
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"~~~~~~~~~~~~~~~ 開啟Unity ~~~~~~~~~~~~~~~~");
    
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
    pauseUnityView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];//可以觸發的範圍
    UIButton *backBtn = [[UIButton alloc] initWithFrame:
                         CGRectMake(screenHeight * 0, screenHeight * 0, screenWidth * 0.3, screenHeight * 0.13)];//x,y,寬,高
    //上面底色
    UILabel *lbltop = [[UILabel alloc] initWithFrame:CGRectMake(0,0, screenWidth , screenHeight * 0.13)];
    [backBtn addTarget:self action:@selector(doExitSelector) forControlEvents:UIControlEventTouchDown];
    [backBtn setBackgroundColor:[UIColor colorWithRed:(202/255.0) green:(71/255.0) blue:(96/255.0) alpha:1]];//按鈕背景色
    
    [backBtn setTitle:@"END" forState:(UIControlStateNormal)];//按鈕文字
    
    [backBtn setTintColor:[UIColor whiteColor] ];//文字顏色 其實根本沒用＃＃＃
    [lbltop setBackgroundColor:[UIColor colorWithRed:(73/255.0) green:(167/255.0) blue:(73/255.0) alpha:1]];//0.65背景色
    //add Subviews
    [pauseUnityView1 addSubview:lbltop];
    [pauseUnityView1 addSubview:backBtn];
    
    //pauseUnityView 是 UIView 的自訂變數名
    [[MyDataManager sharedManager].myWindow.rootViewController.view addSubview:pauseUnityView1];
    self.locationView = pauseUnityView1;//!!!!!!!

}

//========== 返回键函数 ===========
- (void)doExitSelector{
    [_timer invalidate];
    [_timer1 invalidate];
    [locationManager stopUpdatingLocation];
    
    UnityPause(true); //跳转回iOS部分时需要暂停unity
    
    //将unity的rootVC存在单例中防止被释放掉
    [MyDataManager sharedManager].unityViewController = [MyDataManager sharedManager].myWindow.rootViewController;
    
    [[[UnityGetMainWindow() rootViewController] view] setHidden:YES]; //隐藏Unity的rootVC
    [MyDataManager sharedManager].myWindow.rootViewController = self; //将当前界面B作为当前window的rootVC
    [UnityGetMainWindow() makeKeyAndVisible];
    //刪除
    [self.locationView removeFromSuperview];
    [self.locationViewDown removeFromSuperview];
    [self.locationViewUp removeFromSuperview];
    NSLog(@"結束導航button have been clicked. 清superview");

}
//========= 開始作答鍵函數 =================
- (void) handleButtonClicked:(id)sender {
    [_timer invalidate];
    [_timer1 invalidate];
    [locationManager stopUpdatingLocation];
    //刪除
    [self.locationView removeFromSuperview];
    [self.locationViewDown removeFromSuperview];
    [self.locationViewUp removeFromSuperview];
    UnityPause(1); //跳转回iOS部分时需要暂停unity
    //将unity的rootVC存在单例中防止被释放掉
    [MyDataManager sharedManager].unityViewController = [MyDataManager sharedManager].myWindow.rootViewController;
    [[[UnityGetMainWindow() rootViewController] view] setHidden:YES]; //隐藏Unity的rootVC
    [MyDataManager sharedManager].myWindow.rootViewController = self; //将当前界面B作为当前window的rootVC
    
    [UnityGetMainWindow() makeKeyAndVisible];
    //
  

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"workSheet" bundle:nil];//workSheet
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"workSheetViewController"];//workSheetViewController DogInfoViewController GuideViewController ok
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:NO completion:NULL];
}


//算距離1
- (double)rad:(double)d{
    return (d * 3.14159265358979) / 180.0;
}
//算距離2
-(double)xx:(double)lat1 xxx:(double)lng1 xxxx:(double)lat2 xxxxx:(double)lng2{//
    double earthRadius = 6378.137;
    double radLat1 = [self rad:(lat1)];
    double radLat2 = [self rad:(lat2)];
    double a = radLat1 - radLat2;
    double b = [self rad:(lng1)] - [self rad:(lng2)];
    double s =2 * asin(sqrt(pow(sin(a/2),2) + cos(radLat1) * cos(radLat2) * pow(sin(b/2),2)));
    s = s * earthRadius;
    s = round(s*10000)/10000;
    //NSLog(@"xx函數裡面的s = %f", s*1000);//nice log can't delete
    
    return s *1000;
}


#pragma mark - CLLocationManagerDelegate function

//user location
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *) locations{
    //取得當前位置
    CLLocation *location = [locations lastObject];
    // CLLocation *llocation = [locations objectAtIndex:0];//另一種寫法 不知道差在哪
    
    NSLog(@"Lat: %f, Lng: %f", location.coordinate.latitude,location.coordinate.longitude);
    //======宣告使用者座標變數=====
    //double mylat;
    //double mylng;
    mylat = location.coordinate.latitude;
    mylng = location.coordinate.longitude;
    NSLog(@"mylat: %f, mylng: %f", mylat,mylng);
    //=====用變數存算出來的距離====
    //北商 25.041718, 121.526008
     AnimalLocationClass * mc = [ [ AnimalLocationClass alloc ] init ]; // <== INSTANTIATE SWIFT CLASS!!!
//    AnimalLocationClass * mc = [AnimalLocationClass  new ]; // <==改成new 不知道差在哪 INSTANTIATE SWIFT CLASS!!!
    
    double AniLat0 = mc.latAni00;
    double AniLat1 = mc.latAni11;
    double AniLat2 = mc.latAni22;
    double AniLat3 = mc.latAni33;
    double AniLat4 = mc.latAni44;
    double AniLat5 = mc.latAni55;
    double AniLat6 = mc.latAni66;
    double AniLng0 = mc.lngAni00;
    double AniLng1 = mc.lngAni11;
    double AniLng2 = mc.lngAni22;
    double AniLng3 = mc.lngAni33;
    double AniLng4 = mc.lngAni44;
    double AniLng5 = mc.lngAni55;
    double AniLng6 = mc.lngAni66;
    
    aa = [self xx:(mylat) xxx:(mylng) xxxx:(AniLat0) xxxxx:(AniLng0)];//斑點狗
    ab = [self xx:(mylat) xxx:(mylng) xxxx:(AniLat1) xxxxx:(AniLng1)];//TW Bear
    ac = [self xx:(mylat) xxx:(mylng) xxxx:(AniLat2) xxxxx:(AniLng2)];//North Gray Wolf
    ad = [self xx:(mylat) xxx:(mylng) xxxx:(AniLat4) xxxxx:(AniLng4)];//Black Tail Mouse
    ae = [self xx:(mylat) xxx:(mylng) xxxx:(AniLat3) xxxxx:(AniLng3)];//Happy Bird
    af = [self xx:(mylat) xxx:(mylng) xxxx:(AniLat6) xxxxx:(AniLng6)];//Mountain gun
    ag = [self xx:(mylat) xxx:(mylng) xxxx:(AniLat5) xxxxx:(AniLng5)];//Teaching core
}

//=============判斷是否到達範圍================
-(bool)distanceIs:(double)distance{
    bool yesno;//是否小於Xm
    if(distance <290000){//74
        yesno = true;
    }else{
        yesno = false;
    }
    return yesno;
}

//=========Let Timer呼叫兩個副程式重複執行============
- (void)startTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(freshLbl) userInfo:nil repeats:YES];
    _timer1 = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(resetAnimalLocation) userInfo:nil repeats:YES];
}
//===========Timer呼叫==================
- (void) freshLbl{
    NSLog(@"timer執行一次");
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    upUiView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth * 0.31, screenHeight * 0 , screenWidth * 0.7, screenHeight * 0.13)];// 上右方 可以觸發的範圍
    //距離
    UILabel *lblupright = [[UILabel alloc] initWithFrame:CGRectMake(0,screenHeight * 0, screenWidth * 0.7, screenHeight * 0.13)];
    downUiView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth * 0, screenHeight * 0.87 , screenWidth, screenHeight * 0.13)];// 下方 可以觸發的範圍
    

    //抵達後跳出的文字
    UILabel *lbldown = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth *0.04,screenHeight*0, screenWidth * 0.64 , screenHeight * 0.13)];
    //抵達後跳出的底色
    UILabel *lbldownBG = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth *0.0,screenHeight*0, screenWidth , screenHeight * 0.13)];
    //開始作答
    UIButton *startBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth * 0.65, screenHeight * 0, screenWidth *0.35 , screenHeight * 0.13)];
    
    [lblupright setBackgroundColor:[UIColor colorWithRed:(73/255.0) green:(167/255.0) blue:(73/255.0) alpha:1]];
    [lblupright setTextColor:[UIColor whiteColor]];
    lblupright.shadowOffset = CGSizeMake(1, 1);
    if (defaults == true){
        lblupright.text = [NSString stringWithFormat:@" Searching for target..."];
        [startBtn setTitle:@"TEST!" forState:(UIControlStateNormal)];
    }else{
        lblupright.text = [NSString stringWithFormat:@" 搜尋目標中..."];
        [startBtn setTitle:@"開始作答!" forState:(UIControlStateNormal)];
    }
    [lbldownBG setBackgroundColor:[UIColor colorWithRed:(73/255.0) green:(167/255.0) blue:(73/255.0) alpha:1]];
    [lbldown setTextColor:[UIColor whiteColor]];
    lbldown.shadowOffset = CGSizeMake(1, 1); //阴影偏移  x，y为正表示向右下偏移
    [startBtn addTarget:self action:@selector(handleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setBackgroundColor:[UIColor colorWithRed:(85/255.0) green:(100/255.0) blue:(110/255.0) alpha:1]];//按鈕背景色
    //======    自動換行設定    ===========
    lblupright.lineBreakMode = UILineBreakModeWordWrap;
    lblupright.numberOfLines = 0;
    lbldown.lineBreakMode = UILineBreakModeWordWrap;
    lbldown.numberOfLines = 0;
    //=====  add Subview  ======
    lbldown.text = [NSString stringWithFormat:@""];
    [self.locationViewUp removeFromSuperview];
    [self.locationViewDown removeFromSuperview];
    [downUiView addSubview:lbldown];
//    [upUiView addSubview:lblupright];//搜尋目標中...
    [[MyDataManager sharedManager].myWindow.rootViewController.view addSubview:upUiView];
    [[MyDataManager sharedManager].myWindow.rootViewController.view addSubview:downUiView];
    self.locationViewDown = downUiView;//!!!!!!!刪除元件用
    self.locationViewUp = upUiView;//!!!!!!!刪除元件用
//    //===================是否第一次開啟程式 是的話add addSubview==========
//    if(isFirstTime == true){
//        NSLog(@"第一次開啟此檔案 add subview");
//        isFirstTime = false;
//    }
//

    //================是否抵達選取的範圍======================
    switch (_whichAnimal) {
        case 1:
            //=== 如果是英文 =============
            if (defaults == true){
                lblupright.text = [NSString stringWithFormat:@" Spotted hyena. Distance %.0f M",aa];
                [upUiView addSubview:lblupright];
                //如果到了
                if ([self distanceIs:(aa)] == true){
                    NSLog(@"到了喔到了喔到了喔到了喔到了喔到了喔1111111111111");
                    lbldown.text = [NSString stringWithFormat:@"Arrive-Spotted hyena"];
                    [downUiView addSubview:lbldownBG];
                    [downUiView addSubview:lbldown];
                    [downUiView addSubview:startBtn];
                }else{  //如果還沒到
                    NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                    [self.locationViewDown removeFromSuperview];
                }
            }else{//==是中文============
//                [self.locationViewUp removeFromSuperview];
//                NSLog(@"刪除一次");
                lblupright.text = [NSString stringWithFormat:@" 離斑點鬣狗   %.0f   公尺",aa];
                [upUiView addSubview:lblupright];
                //如果到了
                if ([self distanceIs:(aa)] == true){
                    NSLog(@"到了喔到了喔到了喔到了喔到了喔到了喔1111111111111");
//                    [self.locationViewDown removeFromSuperview];
                    lbldown.text = [NSString stringWithFormat:@"已抵達斑點鬣狗範圍"];
                    [downUiView addSubview:lbldownBG];
                    [downUiView addSubview:lbldown];
                    [downUiView addSubview:startBtn];
                }else{  //如果還沒到
                    NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                    [self.locationViewDown removeFromSuperview];
                }
            }
            break;
        case 2:
            //=== 如果是英文 =============
            if (defaults == true){
                lblupright.text = [NSString stringWithFormat:@" Formosan black bear. Distance %.0f M",ab];
                [upUiView addSubview:lblupright];
                //如果到了
                if ([self distanceIs:(ab)] == true){
                    NSLog(@"到了喔到了喔到了喔到了喔到了喔到了喔22222222222");
                    lbldown.text = [NSString stringWithFormat:@"Arrive-Formosan black bear"];
                    [downUiView addSubview:lbldownBG];
                    [downUiView addSubview:lbldown];
                    [downUiView addSubview:startBtn];
                }else{  //如果還沒到
                    NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                    [self.locationViewDown removeFromSuperview];
                }
            }else{//==是中文============
                lblupright.text = [NSString stringWithFormat:@" 離台灣黑熊   %.0f   公尺",ab];
                [upUiView addSubview:lblupright];
                //如果到了
                if ([self distanceIs:(ab)] == true){
                    NSLog(@"到了喔到了喔到了喔到了喔到了喔到了喔22222222222");
                    lbldown.text = [NSString stringWithFormat:@"已抵達台灣黑熊範圍"];
                    [downUiView addSubview:lbldownBG];
                    [downUiView addSubview:lbldown];
                    [downUiView addSubview:startBtn];
                }else{  //如果還沒到
                    NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                    [self.locationViewDown removeFromSuperview];
                }
            }
            break;
        case 3:
            //=== 如果是英文 =============
            if (defaults == true){
                lblupright.text = [NSString stringWithFormat:@" North American gray wolf. Distance %.0f M",ac];
                [upUiView addSubview:lblupright];
                //如果到了
                if ([self distanceIs:(ac)] == true){
                    NSLog(@"到了喔到了喔到了喔到了喔到了喔到了喔333333333333333");
                    lbldown.text = [NSString stringWithFormat:@"Arrive-North American gray wolf"];
                    [downUiView addSubview:lbldownBG];
                    [downUiView addSubview:lbldown];
                    [downUiView addSubview:startBtn];
                }else{  //如果還沒到
                    NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                    [self.locationViewDown removeFromSuperview];
                }
            }else{//==是中文============
                lblupright.text = [NSString stringWithFormat:@" 離北美灰狼    %.0f   公尺",ac];
                [upUiView addSubview:lblupright];
                //如果到了
                if ([self distanceIs:(ac)] == true){
                    NSLog(@"到了喔到了喔到了喔到了喔到了喔到了喔333333333333333");
                    lbldown.text = [NSString stringWithFormat:@"已抵達北美灰狼範圍"];
                    [downUiView addSubview:lbldownBG];
                    [downUiView addSubview:lbldown];
                    [downUiView addSubview:startBtn];
                }else{  //如果還沒到
                    NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                    [self.locationViewDown removeFromSuperview];
                }
            }
            break;
        case 4:
            //=== 如果是英文 =============
            if (defaults == true){
                lblupright.text = [NSString stringWithFormat:@"Black-tailed PrairieDog.Distance %.0f M",ad];
                [upUiView addSubview:lblupright];
                //如果到了
                if ([self distanceIs:(ad)] == true){
                    NSLog(@"到了喔到了喔到了喔到了喔到了喔到了喔44444444444");
                    lbldown.text = [NSString stringWithFormat:@"Arrive-Black-tailed PrairieDog"];
                    [downUiView addSubview:lbldownBG];
                    [downUiView addSubview:lbldown];
                    [downUiView addSubview:startBtn];
                }else{  //如果還沒到
                    NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                    [self.locationViewDown removeFromSuperview];
                }
            }else{//==是中文============
                lblupright.text = [NSString stringWithFormat:@" 離黑尾草原犬鼠 %.0f 公尺",ad];
                [upUiView addSubview:lblupright];
                //如果到了
                if ([self distanceIs:(ad)] == true){
                    NSLog(@"到了喔到了喔到了喔到了喔到了喔到了喔44444444444");
                    lbldown.text = [NSString stringWithFormat:@"已抵達黑尾草原犬鼠範圍"];
                    [downUiView addSubview:lbldownBG];
                    [downUiView addSubview:lbldown];
                    [downUiView addSubview:startBtn];
                }else{  //如果還沒到
                    NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                    [self.locationViewDown removeFromSuperview];
                }
            }
            break;
        case 5:
            //=== 如果是英文 =============
            if (defaults == true){
                lblupright.text = [NSString stringWithFormat:@" Laughing kookaburra.  Distance %.0f M",ae];
                [upUiView addSubview:lblupright];
                //如果到了
                if ([self distanceIs:(ae)] == true){
                    NSLog(@"到了喔到了喔到了喔到了喔到了喔到了555555555555555");
                    lbldown.text = [NSString stringWithFormat:@"Arrive-Laughing kookaburra"];
                    [downUiView addSubview:lbldownBG];
                    [downUiView addSubview:lbldown];
                    [downUiView addSubview:startBtn];
                }else{  //如果還沒到
                    NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                    [self.locationViewDown removeFromSuperview];
                }
            }else{//==是中文============
                lblupright.text = [NSString stringWithFormat:@" 離笑翠鳥    %.0f   公尺",ae];
                [upUiView addSubview:lblupright];
                //如果到了
                if ([self distanceIs:(ae)] == true){
                    NSLog(@"到了喔到了喔到了喔到了喔到了喔到了555555555555555");
                    lbldown.text = [NSString stringWithFormat:@"已抵達笑翠鳥範圍"];
                    [downUiView addSubview:lbldownBG];
                    [downUiView addSubview:lbldown];
                    [downUiView addSubview:startBtn];
                }else{  //如果還沒到
                    NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                    [self.locationViewDown removeFromSuperview];
                }
            }
            break;
        case 6:
            //=== 如果是英文 =============
            if (defaults == true){
                lblupright.text = [NSString stringWithFormat:@" Reeves's muntjac.  Distance %.0f M",af];
                [upUiView addSubview:lblupright];
                //如果到了
                if ([self distanceIs:(af)] == true){
                    NSLog(@"到了喔到了喔到了喔到了喔到了喔到了喔6666666666666");
                    lbldown.text = [NSString stringWithFormat:@"Arrive-Reeves's muntjac"];
                    [downUiView addSubview:lbldownBG];
                    [downUiView addSubview:lbldown];
                    [downUiView addSubview:startBtn];
                }else{  //如果還沒到
                    NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                    [self.locationViewDown removeFromSuperview];
                }
            }else{//==是中文============
                lblupright.text = [NSString stringWithFormat:@" 離山羌    %.0f   公尺",af];
                [upUiView addSubview:lblupright];
                //如果到了
                if ([self distanceIs:(af)] == true){
                    NSLog(@"到了喔到了喔到了喔到了喔到了喔到了喔6666666666666");
                    lbldown.text = [NSString stringWithFormat:@"已抵達山羌範圍"];
                    [downUiView addSubview:lbldownBG];
                    [downUiView addSubview:lbldown];
                    [downUiView addSubview:startBtn];
                }else{  //如果還沒到
                    NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                    [self.locationViewDown removeFromSuperview];
                }
            }
            break;
        default:
            NSLog(@"不知道到了沒？？？？？？？？？？？？？");
            [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            lbldown.text = [NSString stringWithFormat:@""];
            [downUiView addSubview:lbldown];
            break;
    }
   

}

//=========Timer呼叫1.讀檔->2.讀檔傳目標給unity============
- (void)resetAnimalLocation{
    NSLog(@"重新整理旺哥目標位置");
    //1.讀檔
    //取得路徑
    NSString *filePath = [self documentsPath];
    
    // get a reference to our file
    filePath = [filePath stringByAppendingPathComponent:@"which_Animal.txt"];
    // 讀檔案的 contents into a string
    NSString *fileContent= [[NSString alloc]initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    _whichAnimal = [fileContent intValue];
    if ( [[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSLog(@"檔案已經存在");
        
        // display our file
        NSLog(@"檔案內容:<%d>", _whichAnimal);
    }else{
        NSLog(@"檔案尚未建立");
    }
    //2.send messeage
    if(_whichAnimal==1){
        UnitySendMessage("Main Camera","GetIOSData","1");
    }else if(_whichAnimal==2){
        UnitySendMessage("Main Camera","GetIOSData","2");
    }else if(_whichAnimal==3){
        UnitySendMessage("Main Camera","GetIOSData","3");
    }else if(_whichAnimal==4){
        UnitySendMessage("Main Camera","GetIOSData","4");
    }else if(_whichAnimal==5){
        UnitySendMessage("Main Camera","GetIOSData","5");
    }else if(_whichAnimal==6){
        UnitySendMessage("Main Camera","GetIOSData","6");
    }else{
        NSLog(@"whichAnimal havn't been write.");
    }
}

//============讀檔=取得文件路徑===============
-(NSString *) documentsPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDir = [paths objectAtIndex:0];
    return documentDir;
}

@end
