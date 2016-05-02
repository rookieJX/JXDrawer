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
    
    // KVO 监视frame的变化
    /**
     *  Observer:观察者 谁想监听
     *  KeyPath：监听的属性
     *  options:监听新值的改变
     */
    [self.mainView addObserver:self forKeyPath:@"transform" options:NSKeyValueObservingOptionNew context:nil];

}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSLog(@"%@",NSStringFromCGRect(self.mainView.frame));
    if (self.mainView.frame.origin.x <= 0) {
        self.rightView.hidden = YES;
    } else {
        self.rightView.hidden = NO;
    }
}


#pragma mark - UIPanGestureRecognizer
- (void)pan:(UIPanGestureRecognizer *)panGesture {
    CGPoint point = [panGesture translationInView:self.view];

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
    
    
    // 添加右边视图
    UIView * rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor blueColor];
    rightView.frame = self.view.bounds;
    self.rightView = rightView;
    [self.view addSubview:rightView];

    // 添加主视图
    UIView * mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor lightGrayColor];
    mainView.frame = self.view.bounds;
    self.mainView = mainView;
    [self.view addSubview:mainView];
}

- (void)addChildViewToView:(UIView *)view withColor:(UIColor *)color {
    UIView * mainView = [[UIView alloc] init];
    mainView.backgroundColor = color;
    mainView.frame = self.view.bounds;
    view = mainView;
    [self.view addSubview:mainView];
}
@end
