


//
//  RDNoticeTableViewCell.m
//  RDFuturesApp
//
//  Created by user on 2017/5/12.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "RDNoticeTableViewCell.h"

@interface RDNoticeTableViewCell()

@property(nonatomic,strong)UIImageView *iconImage;//图标
@property(nonatomic,strong)UILabel *timeLabel;//时间标签
@property(nonatomic,strong)UIImageView *backgroudImageView;//背景图
@property(nonatomic,strong)UILabel *messageTitle;//消息标题
@property(nonatomic,strong)UILabel *messageText;//消息文本

@end

@implementation RDNoticeTableViewCell

-(void)setupViews{
    
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.backgroudImageView];
    [self.backgroudImageView addSubview:self.messageTitle];
    [self.backgroudImageView addSubview:self.messageText];
    self.backgroundColor = [UIColor clearColor];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


-(void)updateConstraints{
    WS(weakself)
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.contentView).with.mas_offset(15);
        make.size.mas_offset(CGSizeMake(300, 15));
    }];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(15);
        make.top.equalTo(weakSelf.timeLabel.mas_bottom).with.offset(15);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    [self.backgroudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.contentView).mas_offset(UIEdgeInsetsMake(40, 55, 0, 15));
    }];
    [self.messageTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backgroudImageView).with.offset(5);
        make.left.equalTo(weakSelf.backgroudImageView).with.offset(10);
        make.size.mas_offset(CGSizeMake(200, 16));
    }];
    [self.messageText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.backgroudImageView).mas_offset(UIEdgeInsetsMake(31, 10, 5, 5));
    }];
    [super updateConstraints];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"3月12日 9:20";
        _timeLabel.font = [UIFont rdSystemFontOfSize:fourteenFontSize];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}
-(UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.image = [UIImage imageNamed:@"Message_RDNotice_icon"];
    }
    return _iconImage;
}
-(UIImageView *)backgroudImageView{
    if (!_backgroudImageView) {
        _backgroudImageView = [[UIImageView alloc] init];
        _backgroudImageView.image = [self resizableImageWithName:@"RDNotice_notice_backgroundImage"];
        
    }
    return _backgroudImageView;
}
-(UILabel *)messageTitle{
    if (!_messageTitle) {
        _messageTitle = [[UILabel alloc] init];
        _messageTitle.text = @"开户进度";
        _messageTitle.font = [UIFont rdSystemFontOfSize:sixteenFontSize];
    }
    return _messageTitle;
}
-(UILabel *)messageText{
    if (!_messageText) {
        _messageText = [[UILabel alloc] init];
        _messageText.font = [UIFont rdSystemFontOfSize:fourteenFontSize];
        _messageText.text = @"您的开户请求已经提交，工作人员正在加紧为您处理，请耐心等待。点此可查看开户进度。";
        _messageText.numberOfLines = 0;
    }
    return _messageText;
}
-(UIImage *)resizableImageWithName:(NSString*)name{
    UIImage *normal = [UIImage imageNamed:name];
    // 左端盖宽度
    NSInteger leftCapWidth = normal.size.width*0.5;
    // 顶端盖高度
    NSInteger topCapHeight = normal.size.height*0.5;
    // 重新赋值
    return [normal stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
}
@end
