//
//  TakePhotoThirdController.h
//  RDFuturesApp
//
//  Created by user on 17/4/5.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ViewBaseController.h"

@interface TakePhotoThirdController : ViewBaseController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (nonatomic, assign)LoadType loadType;

@end
