//
//  NewsViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/17.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsFirstViewController.h"
#import "NewsSecondViewController.h"
#import "NewsThirdViewController.h"
#import "NewsFourthViewController.h"
#import "NewsFifthViewController.h"
#import "NewsSixthViewController.h"
#import "NewsSeventhViewController.h"
#import "NewsEighthViewController.h"
#import "NewsTitleLabel.h"


@interface NewsViewController ()<UIScrollViewDelegate>

//@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
//@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
//@property (nonatomic, weak) UIView *indicatorView;//指示条
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    _contentScrollView.delegate = self;
//    
//    
//    [self setupChildVC];
//    
//    [self setupTitle];//title
//    
//    [self scrollViewDidEndScrollingAnimation:_contentScrollView];
    
//    [self indicatorView];
    
    
//    UIView * indicatorView = [[UIView alloc]init];
//    _indicatorView = indicatorView;
//    indicatorView.height = 2;
//    indicatorView.y = 33;
//    indicatorView.width = SCREEN_WIDTH/8;
//    indicatorView.x = 0;
//    indicatorView.backgroundColor = [UIColor redColor];
//    
//    [self.view addSubview:indicatorView];
}






#pragma mark -<UIScrollViewDelegate>
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{

    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger index = offsetX / width;
    
    NewsTitleLabel * label = self.titleScrollView.subviews[index];
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    titleOffset.x = label.center.x - width *0.5;
    
    [UIView animateWithDuration:0.25 animations:^{
        _indicatorView.centerX = label.center.x;
    }];
    
    
    if (titleOffset.x < 0) titleOffset.x = 0;
    
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - width;
    
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    
    for (NewsTitleLabel * otherLabel in self.titleScrollView.subviews) {
        if (otherLabel != label) otherLabel.scale = 0.0;
    }
    
    UIViewController * willShowVC = self.childViewControllers[index];
    
    if ([willShowVC isViewLoaded]) {
        return;
    }
    
    willShowVC.view.frame = CGRectMake(offsetX, 0, width, height);
    
    [scrollView addSubview:willShowVC.view];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat scale = scrollView.contentOffset.x /scrollView.frame.size.width;
    if (scrollView<0 || scale > self.titleScrollView.subviews.count - 1)
        return;
    
    NSInteger leftIndex = scale;
    NewsTitleLabel * leftLabel = self.titleScrollView.subviews[leftIndex];
    
    NSInteger rightIndex = leftIndex + 1;
    NewsTitleLabel * rightLabel = (rightIndex == self.titleScrollView.subviews.count) ? nil : self.titleScrollView.subviews[rightIndex];
    
    CGFloat rightScale = scale - leftIndex;
    CGFloat leftScale = 1 - rightScale;
    
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
    
}
#pragma mark -- titleLabel
- (void)setupTitle{
    
    CGFloat labelW = SCREEN_WIDTH/8;
    CGFloat labelY = 0;
    CGFloat labelH = self.titleScrollView.frame.size.height;
    
    for (NSInteger i = 0; i< 8; i++) {
        
        CGFloat labelX = i * labelW;
        NSLog(@"w=%f==x==%f",labelW,labelX);
        NewsTitleLabel * label = [[NewsTitleLabel alloc]initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
        label.text = [self.childViewControllers[i] title];
        
        NSLog(@"cc=%@",[self.childViewControllers[i] title]);
       
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClick:)]];
        label.tag = i;
        
        [self.titleScrollView addSubview:label];
        
        if (i == 0) {
            label.scale = 1.0;
        }
    }
    
    NSLog(@"%@",_titleScrollView.subviews);
    self.titleScrollView.contentSize = CGSizeMake(8* labelW, 0);
    self.contentScrollView.contentSize = CGSizeMake(8* [UIScreen mainScreen].bounds.size.width, 0);
    
    
}

-(void)labelClick:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag;
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * self.contentScrollView.frame.size.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
    
    NewsTitleLabel * label = self.titleScrollView.subviews[index];
    [UIView animateWithDuration:0.25 animations:^{
        _indicatorView.centerX = label.center.x;
    }];
    
    
}
-(void)setupChildVC{
    
    NewsFirstViewController * First = [[NewsFirstViewController alloc]init];
    First.title  = @"要闻";
    [self addChildViewController:First];
    
    NewsSecondViewController * Second = [[NewsSecondViewController alloc]init];
    Second.title = @"股指";
    [self addChildViewController:Second];
    
    NewsThirdViewController * Third = [[NewsThirdViewController alloc]init];
    Third.title = @"债券";
    [self addChildViewController:Third];
    
    NewsFourthViewController * Fourth = [[NewsFourthViewController alloc]init];
    Fourth.title = @"外汇";
    [self addChildViewController:Fourth];
    
    NewsFifthViewController * Fifth = [[NewsFifthViewController alloc]init];
    Fifth.title = @"贵金属";
    [self addChildViewController:Fifth];
    
    NewsSixthViewController * Sixth = [[NewsSixthViewController alloc]init];
    Sixth.title = @"农产品";
    [self addChildViewController:Sixth];
    
    NewsSeventhViewController * Seventh = [[NewsSeventhViewController alloc]init];
    Seventh.title = @"有色金属";
    [self addChildViewController:Seventh];
    
    NewsEighthViewController * Eighth = [[NewsEighthViewController alloc]init];
    Eighth.title = @"能源化工";
    [self addChildViewController:Eighth];
    
}
-(UIView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView.height = 2;
        _indicatorView.y = 33;
        _indicatorView.width = SCREEN_WIDTH/8;
        _indicatorView.x = 0;
        _indicatorView.backgroundColor = [UIColor redColor];
    }
    return _indicatorView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
