//
//  TakePhotoSecondController.h
//  RDFuturesApp
//
//  Created by user on 17/4/5.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ViewBaseController.h"
#import "TakePhotoView.h"

@interface TakePhotoSecondController : ViewBaseController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, assign)LoadType loadType;

@end
