//
//  NewsTitleScrollView.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsTitleScrollView.h"
#define offectX xVlaue*(SCREEN_WIDTH/4.57 + 1.5) + ((SCREEN_WIDTH/4.57)- 35)/2


@interface NewsTitleScrollView()<UIScrollViewDelegate>
{
    int xVlaue;
}

@property (nonatomic,strong)UISegmentedControl * segment;

@end

@implementation NewsTitleScrollView

-(void)bindViewModel{

    [[self.viewModel.titleClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        self.segment.selectedSegmentIndex = [x intValue];
        
        xVlaue = [x intValue];
        
        [self updateLineView];
        
        switch ([x intValue]) {
            case 0:
            {
                CGPoint position = CGPointMake(0, 0);
                
                [self setContentOffset:position animated:YES];
            }
                break;
            case 1:
            {
                CGPoint position = CGPointMake(0, 0);
                
                [self setContentOffset:position animated:YES];
            }
                break;
            case 2:
            {
                CGPoint position = CGPointMake(0, 0);
                
                [self setContentOffset:position animated:YES];
            }
                break;
            case 3:
            {
                //根据内容滚动值第几个vc  来使title滚动
                CGPoint position = CGPointMake(SCREEN_WIDTH/4.57, 0);
                
                [self setContentOffset:position animated:YES];
            }
                break;
            case 4:
            {
                //根据内容滚动值第几个vc  来使title滚动
                CGPoint position = CGPointMake((SCREEN_WIDTH/4.57)*2, 0);
                
                [self setContentOffset:position animated:YES];
            }
                break;
            case 5:
            {
                //根据内容滚动值第几个vc  来使title滚动
                CGPoint position = CGPointMake((SCREEN_WIDTH/4.57)*3, 0);
                
                [self setContentOffset:position animated:YES];
            }
                break;
            case 6:
            {
                //根据内容滚动值第几个vc  来使title滚动
                CGPoint position = CGPointMake((SCREEN_WIDTH/4.57)*3.5, 0);
                
                [self setContentOffset:position animated:YES];
            }
                break;
            case 7:
            {
                //根据内容滚动值第几个vc  来使title滚动
                CGPoint position = CGPointMake((SCREEN_WIDTH/4.57)*3.5, 0);
                
                [self setContentOffset:position animated:YES];
            }
                break;
                
            default:
                break;
        }
        
    }];

}

-(void)setupViews{


    [self addSubview:self.segment];
    [self addSubview:self.lineView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints{

    WS(weakself)
    
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(weakSelf.mas_left).offset(0);
        make.top.equalTo(weakSelf.mas_top);
        make.right.equalTo(weakSelf);
        make.height.equalTo(@33.5);

    }];
    

    
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.segment.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(38, 1.5));
        make.left.equalTo(weakSelf.mas_left).with.offset(offectX);
    }];
    
    
    
    
    
    [super updateConstraints];
 
}
-(void)tapWithtag:(NSString *)string{

    [self.viewModel.titleClickSubject sendNext:string];
}

-(UIView *)lineView{

    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = BLUECOLOR;
        
    }
    return _lineView;
}

-(UISegmentedControl *)segment{

    if (!_segment) {
        NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"要闻",@"股指",@"债券",@"外汇",@"贵金属",@"农产品",@"有色金属",@"能源化工",nil];
    
        _segment = [[UISegmentedControl alloc]initWithItems:segmentedArray];
        _segment.tintColor = [UIColor blackColor];
        _segment.layer.borderWidth = 4;
        _segment.layer.masksToBounds = YES;
        _segment.layer.borderColor = [UIColor whiteColor].CGColor;

        
        // 设置UISegmentedControl选中的图片
        [_segment setBackgroundImage:[UIImage imageNamed:@"kuang"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        

        // 正常的图片
        [_segment setBackgroundImage:[UIImage imageNamed:@"kuang"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        [_segment setDividerImage:[UIImage imageNamed:@"white_bar"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        // 设置选中的文字颜色
        [_segment setTitleTextAttributes:@{NSForegroundColorAttributeName: BLUECOLOR} forState:UIControlStateSelected];


        
        _segment.selectedSegmentIndex = 0;
        [_segment setWidth:SCREEN_WIDTH/4.57 forSegmentAtIndex:0];
        [_segment setWidth:SCREEN_WIDTH/4.57 forSegmentAtIndex:1];
        [_segment setWidth:SCREEN_WIDTH/4.57 forSegmentAtIndex:2];
        [_segment setWidth:SCREEN_WIDTH/4.57 forSegmentAtIndex:3];
        [_segment setWidth:SCREEN_WIDTH/4.57 forSegmentAtIndex:4];
        [_segment setWidth:SCREEN_WIDTH/4.57 forSegmentAtIndex:5];
        [_segment setWidth:SCREEN_WIDTH/4.57 forSegmentAtIndex:6];
        [_segment setWidth:SCREEN_WIDTH/4.57 forSegmentAtIndex:7];
        
        [_segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _segment;
}

-(void)segmentClick:(UISegmentedControl *)seg{

    
    NSInteger index = seg.selectedSegmentIndex;
    xVlaue = (short)index;
    NSString * str = [NSString stringWithFormat:@"%ld",(long)index];
    [self.viewModel.titleClickSubject sendNext:str
     ];
    
    
    [self updateLineView];
  
}
-(void)updateLineView{
    
    WS(weakself)
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mas_left).with.offset(offectX);
    }];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}
#pragma mark - 代理
//减速停止的时候开始执行
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    
    self.viewModel = (NewsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}



@end
