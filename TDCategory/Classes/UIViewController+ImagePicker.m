//
//  TDAvatar.m
//  Pods
//
//  Created by Tun on 4/7/17.
//
//

#import "UIViewController+ImagePicker.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <objc/runtime.h>


static const void *ChoosePhotoCallbackVoid  = &ChoosePhotoCallbackVoid;

@implementation UIViewController (ImagePicker)

#pragma mark - Setter & Getter

- (ChoosePhotoCallback)callback
{
    return objc_getAssociatedObject(self, ChoosePhotoCallbackVoid);
}

- (void)setCallback:(ChoosePhotoCallback)callback
{
    objc_setAssociatedObject(self, ChoosePhotoCallbackVoid, callback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)takePhotoCompleted:(ChoosePhotoCallback)completionBlock
{
    self.callback = completionBlock;
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = (id)self;
      picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)choosePhotoCompleted:(ChoosePhotoCallback)completionBlock
{
    self.callback = completionBlock;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = (id)self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    __weak UIViewController *weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        weakSelf.callback(chosenImage, nil);
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    __weak UIViewController *weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        weakSelf.callback(nil, [NSError errorWithDomain:@"User cancel" code:101 userInfo:nil]);
    }];
    
}

@end
