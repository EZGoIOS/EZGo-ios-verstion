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

#include <math.h>
#include <stdio.h>

double mylat,mylng;
double aa,ab,ac,ad,ae,af,ag;
bool isFirstTime = true;
//NSString *whichAnimal=NULL;
int whichAnimal;


@interface EnterUnityViewController ()

@end

@implementation EnterUnityViewController

@synthesize locationManager;//自動幫忙產生setter/getter //user location


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self startTimer];
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
        // UnitySendMessage("Main Camera","GetIOSData","5");
        //UnitySendMessage("Main Camera","GetIOSData","2");
        NSLog(@"如果是第一次開啟unity 傳送目標.");
       // UnitySendMessage("Main Camera","GetIOSData","2");//不重要因為之後會覆蓋掉
    }
    else
    {
        //如果是第一次启动unity，需要添加返回键===========
        [MyDataManager sharedManager].isRestartInUnity = true;
        //启动unity================
        [[MyDataManager sharedManager].myAppDelegate startUnity:UIApplication.sharedApplication];
        //螢幕長寬
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        CGFloat screenWidth = screenSize.width;
        CGFloat screenHeight = screenSize.height;
        //===============生成返回键================
        UIView *pauseUnityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];//可以觸發的範圍
        UIButton *backBtn = [[UIButton alloc] initWithFrame:
                             CGRectMake(screenHeight * 0, screenHeight * 0, screenWidth * 0.3, screenHeight * 0.13)];//x,y,寬,高
        //上面底色
        UILabel *lbltop = [[UILabel alloc] initWithFrame:CGRectMake(0,0, screenWidth , screenHeight * 0.13)];
        [backBtn addTarget:self action:@selector(doExitSelector) forControlEvents:UIControlEventTouchDown];
        [backBtn setBackgroundColor:[UIColor colorWithRed:(202/255.0) green:(71/255.0) blue:(96/255.0) alpha:1]];//按鈕背景色
        [backBtn setTitle:@"結束導航" forState:(UIControlStateNormal)];//按鈕文字
        [backBtn setTintColor:[UIColor whiteColor] ];//文字顏色 其實根本沒用＃＃＃
        [lbltop setBackgroundColor:[UIColor colorWithRed:(73/255.0) green:(167/255.0) blue:(73/255.0) alpha:1]];//0.65背景色
        //add Subviews
        [pauseUnityView addSubview:lbltop];
        [pauseUnityView addSubview:backBtn];
        
        //pauseUnityView 是 UIView 的自訂變數名
        [[MyDataManager sharedManager].myWindow.rootViewController.view addSubview:pauseUnityView];
        
        //UnitySendMessage("Main Camera","GetIOSData","2");//不重要因為之後會覆蓋掉
    }
}

//================返回键函数================
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
    NSLog(@"結束導航button have been clicked.");
    
}
//====================開始作答鍵函數=================
- (void) handleButtonClicked:(id)sender {
    [_timer invalidate];
    [_timer1 invalidate];
    [locationManager stopUpdatingLocation];
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
    //圓山25.071819, 121.520059 25.017182, Lng: 121.292658 25.020389, Lng: 121.294560
    //先跑一次 把log中的 Lat:??.???,Lng:???.??? 複製到 229行中測試
    //25.042672, Lng: 121.524953
    aa = [self xx:(mylat) xxx:(mylng) xxxx:(24.9946605) xxxxx:(121.5887605)];//斑點狗 xxxx:(24.9946605) xxxxx:(121.5887605)
    ab = [self xx:(mylat) xxx:(mylng) xxxx:(24.9975801) xxxxx:(121.5799735)];//TW Bear
    ac = [self xx:(mylat) xxx:(mylng) xxxx:(24.9932772) xxxxx:(121.5900815)];//North Gray Wolf
    ad = [self xx:(mylat) xxx:(mylng) xxxx:(24.9921553) xxxxx:(121.5890408)];//Black Tail Mouse
    ae = [self xx:(mylat) xxx:(mylng) xxxx:(24.995106) xxxxx:(121.583514)];//Happy Bird
    af = [self xx:(mylat) xxx:(mylng) xxxx:(24.9977223) xxxxx:(121.5810719)];//Mountain gun
    ag = [self xx:(mylat) xxx:(mylng) xxxx:(24.998286) xxxxx:(121.581045)];//Teaching core
}

//=============判斷是否到達範圍================
-(bool)distanceIs:(double)distance{
    bool yesno;//是否小於Xm
    if(distance <25){//74
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
    UIView *upUiView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth * 0.31, screenHeight * 0 , screenWidth * 0.7, screenHeight * 0.13)];//可以觸發的範圍
    //距離
    UILabel *lblupright = [[UILabel alloc] initWithFrame:CGRectMake(0,screenHeight * 0, screenWidth * 0.7, screenHeight * 0.13)];
    UIView *downUiView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth * 0, screenHeight * 0.87 , screenWidth, screenHeight * 0.13)];//可以觸發的範圍
    //抵達後跳出的文字
    UILabel *lbldown = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth *0.04,screenHeight*0, screenWidth , screenHeight * 0.13)];
    //抵達後跳出的底色
    UILabel *lbldownBG = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth *0.0,screenHeight*0, screenWidth , screenHeight * 0.13)];
    //開始作答
    UIButton *startBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth * 0.65, screenHeight * 0, screenWidth *0.35 , screenHeight * 0.13)];
    
    [lblupright setBackgroundColor:[UIColor colorWithRed:(73/255.0) green:(167/255.0) blue:(73/255.0) alpha:1]];
    [lblupright setTextColor:[UIColor whiteColor]];
    lblupright.shadowOffset = CGSizeMake(1, 1);
    lblupright.text = [NSString stringWithFormat:@" 搜尋目標中..."];
    [lbldownBG setBackgroundColor:[UIColor colorWithRed:(73/255.0) green:(167/255.0) blue:(73/255.0) alpha:1]];
    [lbldown setTextColor:[UIColor whiteColor]];
    lbldown.shadowOffset = CGSizeMake(1, 1); //阴影偏移  x，y为正表示向右下偏移
    [startBtn addTarget:self action:@selector(handleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setBackgroundColor:[UIColor colorWithRed:(85/255.0) green:(100/255.0) blue:(110/255.0) alpha:1]];//按鈕背景色
    [startBtn setTitle:@"開始作答!" forState:(UIControlStateNormal)];
    //add Subview
    lbldown.text = [NSString stringWithFormat:@""];
    [upUiView addSubview:lbldown];
    [upUiView addSubview:lblupright];//搜尋目標中...
    [[MyDataManager sharedManager].myWindow.rootViewController.view addSubview:upUiView];
    [[MyDataManager sharedManager].myWindow.rootViewController.view addSubview:downUiView];
    //===================是否第一次開啟程式 是的話add addSubview==========
    if(isFirstTime == true){
        NSLog(@"第一次開啟此檔案 add subview");
        isFirstTime = false;
    }
    

    //================是否抵達選取的範圍======================
    switch (_whichAnimal) {
        case 1:
            lblupright.text = [NSString stringWithFormat:@" 離斑點鬣狗   %.0f   公尺",aa];
            [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            if ([self distanceIs:(aa)] == true){
                NSLog(@"到了喔到了喔到了喔到了喔到了喔到了喔1111111111111");
                [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [upUiView addSubview:lblupright];
                [downUiView addSubview:lbldownBG];
                [downUiView addSubview:lbldown];
                [downUiView addSubview:startBtn];
                lbldown.text = [NSString stringWithFormat:@"已抵達斑點鬣狗範圍"];
            }
            if ([self distanceIs:(aa)] == false){
                NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                lbldown.text = [NSString stringWithFormat:@""];
                [downUiView addSubview:lbldown];
            }
            break;
        case 2:
            lblupright.text = [NSString stringWithFormat:@" 離台灣黑熊   %.0f   公尺",ab];
            [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            if ([self distanceIs:(ab)] == true){
                NSLog(@"到了喔到了喔到了喔到了喔到了喔到了喔22222222222");
                [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [upUiView addSubview:lblupright];
                [downUiView addSubview:lbldownBG];
                [downUiView addSubview:lbldown];
                [downUiView addSubview:startBtn];
                lbldown.text = [NSString stringWithFormat:@"已抵達台灣黑熊範圍"];
            }
            if ([self distanceIs:(ab)] == false){
                NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                lbldown.text = [NSString stringWithFormat:@""];
                [downUiView addSubview:lbldown];            }
            break;
        case 3:
            lblupright.text = [NSString stringWithFormat:@" 離北美灰狼    %.0f   公尺",ac];
            [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            if ([self distanceIs:(ac)] == true){
                NSLog(@"到了喔到了喔到了喔到了喔到了喔到了喔333333333333333");
                [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [upUiView addSubview:lblupright];
                [downUiView addSubview:lbldownBG];
                [downUiView addSubview:lbldown];
                [downUiView addSubview:startBtn];
                lbldown.text = [NSString stringWithFormat:@"已抵達北美灰狼範圍"];
            }
            if ([self distanceIs:(ac)] == false){
                NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                lbldown.text = [NSString stringWithFormat:@""];
                [downUiView addSubview:lbldown];
            }
            break;
        case 4:
            lblupright.text = [NSString stringWithFormat:@" 離黑尾草原犬鼠 %.0f 公尺",ad];
            [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            if ([self distanceIs:(ad)] == true){
                [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                NSLog(@"到了喔到了喔到了喔到了喔到了喔到了喔44444444444");
                [upUiView addSubview:lblupright];
                [downUiView addSubview:lbldownBG];
                [downUiView addSubview:lbldown];
                [downUiView addSubview:startBtn];
                lbldown.text = [NSString stringWithFormat:@"已抵達黑尾草原犬鼠範圍"];
            }
            if ([self distanceIs:(ad)] == false){
                NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                lbldown.text = [NSString stringWithFormat:@""];
                [downUiView addSubview:lbldown];            }
            break;
        case 5:
            lblupright.text = [NSString stringWithFormat:@" 離笑翠鳥    %.0f   公尺",ae];
            [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            if ([self distanceIs:(ae)] == true){
                NSLog(@"到了喔到了喔到了喔到了喔到了喔到了555555555555555");
                [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [upUiView addSubview:lblupright];
                [downUiView addSubview:lbldownBG];
                [downUiView addSubview:lbldown];
                [downUiView addSubview:startBtn];
                lbldown.text = [NSString stringWithFormat:@"已抵達笑翠鳥範圍"];
            }
            if ([self distanceIs:(ae)] == false){
                NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                lbldown.text = [NSString stringWithFormat:@""];
                [downUiView addSubview:lbldown];
            }
            break;
        case 6:
            lblupright.text = [NSString stringWithFormat:@" 離山羌    %.0f   公尺",af];
            [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            if ([self distanceIs:(af)] == true){
                NSLog(@"到了喔到了喔到了喔到了喔到了喔到了喔6666666666666");
                [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [upUiView addSubview:lblupright];
                [downUiView addSubview:lbldownBG];
                [downUiView addSubview:lbldown];
                [downUiView addSubview:startBtn];
                lbldown.text = [NSString stringWithFormat:@"已抵達山羌範圍"];
            }
            if ([self distanceIs:(af)] == false){
                NSLog(@"還沒到還沒到還沒到加把勁XXXXXXXXXXXXXX");
                [[downUiView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                lbldown.text = [NSString stringWithFormat:@""];
                [downUiView addSubview:lbldown];
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

//if(_whichAnimal==1){
//
//}else if(_whichAnimal==2){
//
//}else if(_whichAnimal==3){
//
//}else if(_whichAnimal==4){
//
//}else if(_whichAnimal==5){
//
//}else if(_whichAnimal==6){
//
//}else{
//    NSLog(@"whichAnimal havn't been write.");
//}

