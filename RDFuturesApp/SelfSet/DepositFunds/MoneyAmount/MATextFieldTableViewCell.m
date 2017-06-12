//
//  MATextFieldTableViewCell.m
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "MATextFieldTableViewCell.h"

@interface MATextFieldTableViewCell()
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UITextField *contentField;
@end

@implementation MATextFieldTableViewCell


-(void)setupViews{
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.contentField];
   
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints{
    WS(weakself)
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView).with.offset(15);
        make.size.mas_offset(CGSizeMake(60, 15));
    }];
    
    [self.contentField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.title.mas_right).with.offset(15);
        make.right.equalTo(weakSelf.contentView.mas_right).with.offset(-15);
        make.height.mas_offset(45);
    }];
    
    [super updateConstraints];
}
-(void)setPlaceholderStr:(NSString *)placeholderStr{
    [_contentField setPlaceholderString:placeholderStr];
}

-(void)setTitleStr:(NSString *)titleStr{
    self.title.text = titleStr;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UITextField *)contentField{
    if (!_contentField) {
        _contentField = [[UITextField alloc] init];
        _contentField.layer.borderColor = [RGB(210, 210, 210) CGColor];
        _contentField.font = [UIFont rdSystemFontOfSize:14];
        _contentField.layer.borderWidth = 0.5f;
        _contentField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _contentField;
}
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        [_title setTextColor:RGB(68, 68, 68)];
        _title.font = [UIFont rdSystemFontOfSize:15];
    }
    return _title;
}
@end
