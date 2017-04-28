//
//  TDAvatar.h
//  Pods
//
//  Created by Tun on 4/7/17.
//
//

#import <UIKit/UIKit.h>

typedef void (^ChoosePhotoCallback) (UIImage *image, NSError *error);

@interface UIViewController (ImagePicker)
{
    
}
@property (nonatomic, copy) ChoosePhotoCallback callback;


- (UIImagePickerController *)takePhotoCompleted:(ChoosePhotoCallback)completionBlock;
- (UIImagePickerController *)choosePhotoCompleted:(ChoosePhotoCallback)completionBlock;

@end
