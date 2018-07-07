//
//  HomeViewController.m
//  Unity-iPhone
//
//  Created by Forever.H on 15/12/23.
//
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
//    CGFloat screenWidth = screenSize.width;
//    CGFloat screenHeight = screenSize.height;
//    UIView *UiView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth * 0, screenHeight * 0.93 , screenWidth, screenHeight * 0.07)];//可以觸發的範圍
//    //抵達後跳出的文字
//    UIButton *jumpToEnterUnityVC = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth * 0.65, screenHeight * 0.01, screenWidth *0.3 , screenHeight * 0.05)];
//    [UiView addSubview:jumpToEnterUnityVC];
//    [self addSubview:UiView];
//
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (IBAction)jumpToEnterUnityVC:(id)sender {
//    EnterUnityViewController *enterVC = [[EnterUnityViewController alloc]init];
//    [self presentViewController:enterVC animated:NO completion:nil];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];//workSheet Main
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SWRevealViewController"];//workSheetViewController x DogInfoViewController KnowledgeViewController ok AboutViewController ok SWRevealViewController X LessonViewController X
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
}

//- (void) handleButtonClicked:(id)sender {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];//workSheet Main
//    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SWRevealViewController"];//workSheetViewController x DogInfoViewController KnowledgeViewController ok AboutViewController ok SWRevealViewController X LessonViewController X
//    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentViewController:vc animated:YES completion:NULL];
//}
@end
