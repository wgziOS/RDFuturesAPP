//
//  TakePhotoSecondController.m
//  RDFuturesApp
//
//  Created by user on 17/4/5.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "TakePhotoSecondController.h"
#import "TakePhotoThirdController.h"

@interface TakePhotoSecondController ()
@property(nonatomic,weak)UIButton *nextStep;
@property(nonatomic,weak)UIButton *remakeBtn;
@property(nonatomic,weak)UIImageView *imagePhoto;//相机图片
@end
@implementation TakePhotoSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadingChildView];
    [self setTitle:@"拍照确认"];
    
    if (self.loadType ==LoadTypeCompleted) {
        [self getPhotoConfirmInfo];
    }}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadingChildView{
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, VIEW_WIDTH-20, 30)];
    title.font = [UIFont fontWithName:@"FZHei-B01S" size:16];
    [title setText:@"请按指定动作拍摄二张照片"];
    [self.view addSubview:title];
    
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, getTop(title), VIEW_WIDTH-20, 30)];
    stepLabel.font = [UIFont fontWithName:@"FZHei-B01S" size:16];
    [stepLabel setText:@"第二张：单指摸耳朵"];
    [stepLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:stepLabel];
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, getTop(stepLabel)+10, VIEW_WIDTH, 280)];
    [bgview setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgview];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH*0.5-150, 20, 300 , 198)];
    [imageView setImage:[UIImage imageNamed:@"take_photo_example_2"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [bgview addSubview:imageView];
    self.imagePhoto = imageView;
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH*0.5-150, 20, 300 , 198)];
    [bgImageView setImage:[UIImage imageNamed:@"take_photo_bgImageView"]];
    [bgview addSubview:bgImageView];
    
    UIButton *remake = [UIButton buttonWithType:UIButtonTypeSystem];
    remake.frame = CGRectMake(VIEW_WIDTH*0.5-50, getTop(bgImageView)+20, 100, 35);
    [remake setTitle:@"拍摄" forState:UIControlStateNormal];
    [remake setBackgroundImage:[UIImage imageNamed:@"b_btn"] forState:UIControlStateNormal];
    [remake addTarget:self action:@selector(takePhotoClick) forControlEvents:UIControlEventTouchUpInside];
    [remake setBackgroundColor:[UIColor blueColor]];
    remake.layer.masksToBounds = YES;
    remake.layer.cornerRadius = 5;
    self.remakeBtn = remake;
    [bgview addSubview:remake];
    
    
    UILabel *warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,getTop(bgview)+20, VIEW_WIDTH-20, 50)];
    warningLabel.text = @"请使用手机“拍照”功能即时拍摄，不要上传图库中已有的照片，并确保三张照片的衣着和背景一致。";
    warningLabel.font = [UIFont fontWithName:@"FZHei-B01S" size:14];
    warningLabel.numberOfLines = 0;
    [self.view addSubview:warningLabel];
    
    UIImageView *imageBtnView = [[UIImageView alloc] initWithFrame:CGRectMake(20, getTop(warningLabel)+20, VIEW_WIDTH-40, 45)];
    [imageBtnView setImage:[UIImage imageNamed:@"b_btn"]];
    [self.view addSubview:imageBtnView];
    UIButton *shotBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [shotBtn setFrame:CGRectMake(20, getTop(warningLabel)+20, VIEW_WIDTH-40, 45)];
    [shotBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [shotBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shotBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shotBtn.titleLabel.font = [UIFont fontWithName:@"FZHei-B01S" size:14];
    [shotBtn addTarget:self action:@selector(sumbitPhoto) forControlEvents:UIControlEventTouchUpInside];
    self.nextStep = shotBtn;
    [self.view addSubview:shotBtn];
    
}


-(void)sumbitPhoto{
    NSData* imgData = UIImageJPEGRepresentation(self.imagePhoto.image, 1.0f);
    
    NSString *encodedImageStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *string = [NSString stringWithFormat:@"data:image/png;base64,%@",encodedImageStr];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setObject:string forKey:@"user_image"];
    [dataDic setObject:@"2" forKey:@"index"];
    
    loading(@"正在上传");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        RDRequestModel *model = [RDRequest postPhotoConfirmInfoWithParam:dataDic
                                                                   error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                showMassage(model.Message);
                if ([model.State isEqualToString:@"1"]){
                    [self puchtakePhotoThird];
                }
            }
        });
        
    });
    
}
-(void)takePhotoClick{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    
    
    //图片选择是相册（图片来源自相册）
    
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //设置代理
    
    picker.delegate=self;
    
    //模态显示界面
    
    [self presentViewController:picker animated:YES completion:nil];
    
    
    
    
}

-(void)getPhotoConfirmInfo{
    NSDictionary *dic = [[NSDictionary alloc] init];
    [dic setValue:@"2" forKey:@"index"];
    loading(@"正在加载");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        RDRequestModel *model = [RDRequest getPhotoConfirmInfoWithParam:dic
                                                                  error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                showMassage(model.Message);
                NSString *imageUrl = [NSString stringWithFormat:@"%@",[model.Data objectForKey:@"user_image"]];
                [self.imagePhoto sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"b_btn"]];   
            }
        });
        
    });
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //通过key值获取到图片
    
    UIImage * image =info[UIImagePickerControllerOriginalImage];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        NSLog(@"在相机中选择图片");
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
        self.imagePhoto.image = image;
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}


@end
