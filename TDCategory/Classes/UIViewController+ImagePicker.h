//
//  TDAvatar.h
//  Pods
//
//  Created by Tun on 4/7/17.
//
//

#import <UIKit/UIKit.h>

typedef void (^ChoosePhotoCallback) (UIImage *croppedImage, NSError *error);

@interface UIViewController (ImagePicker)
{
    
}
@property (nonatomic, copy) ChoosePhotoCallback callback;


- (void)takePhotoCompleted:(ChoosePhotoCallback)completionBlock;
- (void)choosePhotoCompleted:(ChoosePhotoCallback)completionBlock;

@end