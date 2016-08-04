//
//  ViewController.m
//  scrollView加Autolayout配合使用
//
//  Created by 远洋 on 15/2/2.
//  Copyright © 2015年 yuayang. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.添加一个scrollView到界面上
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    
    scrollView.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:scrollView];
    
    //2.在子视图和scrollView中间添加一个隔离视图
    UIView * containerView = [[UIView alloc]init];
    
//    containerView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    [scrollView addSubview:containerView];
    
    NSInteger scrollViewH = 200;
    //添加scrollView的约束
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.height.equalTo(@(scrollViewH));
    }];
    
    //添加隔离视图的约束
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        /**
         第一个约束表示自己上、下、左、右和contentSize的距离为0，因此只要container的大小确
         定，contentSize也就可以确定了，因为此时它和container大小、位置完全相同。
         */
        make.edges.equalTo(scrollView);
        
        //再确定高度
        make.height.mas_equalTo(scrollViewH);
        
        //接下来确定宽度 因为要往隔离视图上面添加很多红色的view 所以隔离视图的宽度应该是由子视图来确定的
    }];
    
    //往隔离视图上添加子视图 其实本来是想添加到scrollView上 但是由于scrollView的特殊性 中间多添加一个隔离视图 为了子视图的布局
    for (int i = 0 ; i < 5; i++) {
        UIView * redView = [[UIView alloc]init];
        
        [containerView addSubview:redView];
        
        redView.backgroundColor = [UIColor redColor];
        
        //设置约束
        [redView mas_makeConstraints:^(MASConstraintMaker *make) {
           //1.确定红色视图竖直方向的约束
            make.top.height.equalTo(containerView);
            
            //2.确定红色视图的宽度
            make.width.mas_equalTo((self.view.bounds.size.width - 10 *6 )/ 5);
            
            //只需要再确定x值就可以确定整个水平方向上的约束了 但是要注意分开设置
            //如果是第一个红色视图
            if (i == 0) {
                make.left.equalTo(containerView).offset(10);
            }else {
                //取出前一个view
                UIView * previousView = containerView.subviews[i - 1];
                
                //等于前一个view的右边界加上10
                make.left.equalTo(previousView.mas_right).offset(10);
            }
            
            if (i == 4){//如果是最后一个 确定containerView的右边界
                [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(redView).offset(-10);
                }];
            }
        }];
    }
    
    
}



@end
