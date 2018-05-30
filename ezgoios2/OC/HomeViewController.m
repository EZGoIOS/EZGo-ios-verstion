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
@end
