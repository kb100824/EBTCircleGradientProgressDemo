//
//  ViewController.m
//  EBTCircleGradientProgressDemo
//
//  Created by MJ on 16/7/27.
//  Copyright © 2016年 com.csst.www. All rights reserved.
//

#import "ViewController.h"
#import "EBTCircleGradientProgressView.h"
@interface ViewController ()
{
    EBTCircleGradientProgressView *progressView;

}
@property (weak, nonatomic) IBOutlet EBTCircleGradientProgressView *gradientProgressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    progressView = [[EBTCircleGradientProgressView alloc]initWithFrame:CGRectMake(0, 100, 400, 400)];
    
    
   // [self.view addSubview:progressView];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(UIButton *)sender {
    
    [_gradientProgressView setProgressPercent:100.0];
}

@end
