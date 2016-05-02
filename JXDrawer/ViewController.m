//
//  ViewController.m
//  JXDrawer
//
//  Created by 王加祥 on 16/5/2.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/** 左边视图 */
@property (nonatomic,weak) UIView * leftView;
/** 主视图 */
@property (nonatomic,weak) UIView * mainView;
/** 右边视图 */
@property (nonatomic,weak) UIView * rightView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加视图
    [self setupView];
    
    
    // 添加手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];

}

#pragma mark - UIPanGestureRecognizer
- (void)pan:(UIPanGestureRecognizer *)panGesture {
    CGPoint point = [panGesture translationInView:self.view];
    if (point.x >= 0) {
        self.rightView.alpha = 0;
    } else if (point.x < 0) {
        self.rightView.alpha = 1;
    }
    
    NSLog(@"%@",NSStringFromCGPoint(point));
    
//    self.mainView.center = CGPointMake(100, 100);
    self.mainView.transform = CGAffineTransformTranslate(self.mainView.transform, point.x, 0);
    [panGesture setTranslation:CGPointZero inView:self.view];
}
#pragma mark - 添加视图
- (void)setupView {
    // 添加左边视图
    UIView * leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor orangeColor];
    leftView.frame = self.view.bounds;
    self.leftView = leftView;
    [self.view addSubview:leftView];

//    [self addChildViewToView:self.leftView withColor:[UIColor orangeColor]];
    
    
    // 添加右边视图
    UIView * rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor blueColor];
    rightView.frame = self.view.bounds;
    self.rightView = rightView;
    [self.view addSubview:rightView];
//    [self addChildViewToView:self.rightView withColor:[UIColor blueColor]];

    // 添加主视图
    UIView * mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor lightGrayColor];
    mainView.frame = self.view.bounds;
    self.mainView = mainView;
    [self.view addSubview:mainView];
//    [self addChildViewToView:self.mainView withColor:[UIColor lightGrayColor]];
}

- (void)addChildViewToView:(UIView *)view withColor:(UIColor *)color {
    UIView * mainView = [[UIView alloc] init];
    mainView.backgroundColor = color;
    mainView.frame = self.view.bounds;
    view = mainView;
    [self.view addSubview:mainView];
}
@end
