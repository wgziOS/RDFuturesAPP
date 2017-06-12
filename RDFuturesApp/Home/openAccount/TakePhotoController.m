//
//  TakePhotoController.m
//  RDFuturesApp
//
//  Created by user on 17/3/15.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "TakePhotoController.h"
#import "TakePhotoView.h"

@interface TakePhotoController ()
@property(nonatomic,strong)TakePhotoView *takephoto;
@property(nonatomic,weak)UIButton *nextStep;
@property(nonatomic,weak)UIButton *remakeBtn;

@end

@implementation TakePhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadingChildView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadTakePhotoView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadingChildView{
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, VIEW_WIDTH-20, 30)];
    title.font = [UIFont fontWithName:@"FZHei-B01S" size:16];
    [title setText:@"请按指定动作拍摄三张照片"];
    [self.view addSubview:title];
    
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, getTop(title), VIEW_WIDTH-20, 30)];
    stepLabel.font = [UIFont fontWithName:@"FZHei-B01S" size:16];
    [stepLabel setText:@"第一张：单指摸鼻子"];
    [stepLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:stepLabel];
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, getTop(stepLabel)+10, VIEW_WIDTH, 280)];
    [bgview setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgview];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH*0.5-150, 20, 300 , 198)];
    [imageView setImage:[UIImage imageNamed:@""]];
    [bgview addSubview:imageView];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH*0.5-150, 20, 300 , 198)];
    [bgImageView setImage:[UIImage imageNamed:@"take_photo_bgImageView"]];
    [bgview addSubview:bgImageView];
    
    UIButton *remake = [UIButton buttonWithType:UIButtonTypeCustom];
    remake.frame = CGRectMake(VIEW_WIDTH*0.5-50, getTop(bgImageView)+20, 100, 35);
    [remake setTitle:@"拍摄" forState:UIControlStateNormal];
    [remake addTarget:self action:@selector(takePhotoClick) forControlEvents:UIControlEventTouchUpInside];
    [remake setBackgroundColor:[UIColor blueColor]];
    remake.layer.masksToBounds = YES;
    remake.layer.cornerRadius = 5;
    self.remakeBtn = remake;
    [bgview addSubview:remake];
    
    
    UILabel *warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,getTop(bgview)+20, VIEW_WIDTH-20, 40)];
    warningLabel.text = @"请使用手机“拍照”功能即时拍摄，不要上传图库中已有的照片，并确保三张照片的衣着和背景一致。";
    warningLabel.font = [UIFont fontWithName:@"FZHei-B01S" size:16];
    warningLabel.numberOfLines = 0;
    [self.view addSubview:warningLabel];
    
    
    UIButton *shotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shotBtn setFrame:CGRectMake(20, getTop(warningLabel)+20, VIEW_WIDTH-40, 45)];
    [shotBtn setBackgroundColor:[UIColor blueColor]];
    [shotBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [shotBtn addTarget:self action:@selector(sumbitPhoto) forControlEvents:UIControlEventTouchUpInside];
    shotBtn.layer.masksToBounds = YES;
    self.nextStep = shotBtn;
    shotBtn.layer.cornerRadius = 5;
    [self.view addSubview:shotBtn];
    
}
-(void)loadTakePhotoView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.view addSubview:self.takephoto];
    });
    
}
-(TakePhotoView *)takephoto{
    if (!_takephoto) {
        _takephoto = [[TakePhotoView alloc] initWithFrame:self.view.bounds];
    }
    return _takephoto;
}

-(void)sumbitPhoto{
    
    TakePhotoController *take = [[TakePhotoController alloc] init];
    take.stepString = @"3";
    [self.navigationController pushViewController:take animated:YES];
}
-(void)takePhotoClick{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    //如果设备支持相机，就使用拍照模式
    //否则让用户从照片库中选取照片
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
}
@end
