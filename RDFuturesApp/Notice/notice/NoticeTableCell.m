//
//  NoticeTableCell.m
//  RDFuturesApp
//
//  Created by user on 17/4/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NoticeTableCell.h"

@interface NoticeTableCell()
@property (weak, nonatomic) UIImageView *icon;//图标

@property (weak, nonatomic) UILabel *title;

@property (weak, nonatomic) UILabel *time;

@property (weak, nonatomic) UIImageView *content;//内容图片

@property (weak, nonatomic) UIButton *join;

@end

@implementation NoticeTableCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setupViews{
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
  
        UIImageView *iconImage = [[UIImageView alloc] init];
        [self.contentView addSubview:iconImage];
        self.icon = iconImage;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:titleLabel];
        self.title = titleLabel;

        UILabel *timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:timeLabel];
        self.time = timeLabel;
        
        UIImageView *contentImage = [[UIImageView alloc] init];
        [self.contentView addSubview:contentImage];
        self.content = contentImage;
        UIButton *joinButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:joinButton];
        self.join =joinButton;
        
        
        
    }
    return self;
}
-(void)updateConstraints{
    [super updateConstraints];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.join mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];

}
-(void)setModel:(NoticeModel *)model {
    
    if (!model) {
        return;
    }
    _model = model;
    self.title.text = _model.title;
    self.time.text = @"上午 09：03";
    [self.join setTitle:@"立即参与" forState:UIControlStateNormal];
    [self.content sd_setImageWithURL:[NSURL URLWithString:_model.image]];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_model.log]];
}

@end
