//
//  PhotoManager.h
//  Unity-iPhone
//
//  Created by  Anthea on 2018/10/24.
//

#import <Foundation/Foundation.h>

@interface PhotoManager : NSObject
- ( void ) imageSaved: ( UIImage *) image didFinishSavingWithError:( NSError *)error
          contextInfo: ( void *) contextInfo;
extern UIImage *GlobImg;
@end
