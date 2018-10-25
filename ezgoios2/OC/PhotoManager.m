#import "PhotoManager.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKSharePhoto.h>
#import <FBSDKShareKit/FBSDKSharePhotoContent.h>
#import <FBSDKShareKit/FBSDKShareButton.h>
#import <FBSDKShareKit/FBSDKShareDialog.h>
#import <FBSDKShareKit/FBSDKShareLinkContent.h>


@implementation PhotoManager

NSString *strReadAddr ;
UIImage *GlobImg ;

-(void)imageSaved:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    NSLog(@"保存结束");
//    if(error != nil){
//        NSLog(@"有错误");
//    }
    UIAlertView *alert;
    
    //以error參數判斷是否成功儲存影像
    if (error) {
        alert = [[UIAlertView alloc] initWithTitle:@"錯誤"
                                           message:[error description]
                                          delegate:self
                                 cancelButtonTitle:@"確定"
                                 otherButtonTitles:nil];
                                        NSLog(@"有错误");
    } else {
        alert = [[UIAlertView alloc] initWithTitle:@"成功"
                                           message:@"影像已存入相簿中"
                                          delegate:self
                                 cancelButtonTitle:@"確定"
                                 otherButtonTitles:nil];
                                        NSLog(@"保存结束");
//        FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
//        photo.image = img;
//        FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
//        //            content.contentURL = [NSURL URLWithString:@"https://developers.facebook.com"];
//        content.photos = @[photo];
//        [FBSDKShareDialog showFromViewController:self withContent:content delegate:nil];

    }
    
    //顯示警告訊息
    [alert show];
}

void _SavePhoto(char *readAddr){
    strReadAddr = [NSString stringWithUTF8String:readAddr];
    GlobImg = [UIImage imageWithContentsOfFile:strReadAddr];
    NSLog(@"%@", [NSString stringWithFormat:@"w:%f, h:%f", GlobImg.size.width, GlobImg.size.height]);
    PhotoManager *instance = [PhotoManager alloc];
    if(GlobImg.size.width >=1){
        UIImageWriteToSavedPhotosAlbum(GlobImg, instance, @selector(imageSaved:didFinishSavingWithError:contextInfo:), nil);
    }else{
        UIImageWriteToSavedPhotosAlbum(GlobImg, instance, nil, nil);
        UIImageWriteToSavedPhotosAlbum(GlobImg, instance, @selector(imageSaved:didFinishSavingWithError:contextInfo:), nil);
    }
}
@end
