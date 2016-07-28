//
//  EBTCircleGradientProgressView.m
//  EBTCircleGradientProgressDemo
//
//  Created by MJ on 16/7/27.
//  Copyright © 2016年 com.csst.www. All rights reserved.
//

#import "EBTCircleGradientProgressView.h"
#define kPercentWidth 120
#define kPercentHeight 24

@interface EBTCircleGradientProgressView ()
{
    CAShapeLayer *layer_Track;  //底部背景图层
    CAShapeLayer *layer_progress; //表示进度的图层
    CABasicAnimation *animate_Progress; //为进度添加动画
    CATextLayer *textPercentLayer; //百分比
    NSInteger progressVaule;//自增进度值用来实现数字动画
   
}
@property(nonatomic,strong) CADisplayLink *displayLink;

@end
@implementation EBTCircleGradientProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setUp];
    
    }
    
    return self;

}
- (void)setUp{

    layer_Track = [CAShapeLayer layer];
    layer_Track.frame = self.bounds;
    layer_Track.fillColor = [UIColor clearColor].CGColor;
    layer_Track.strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:0.25].CGColor;
   // layer_Track.lineCap = kCALineCapRound;
    layer_Track.lineWidth = 10;
    UIBezierPath *trackPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(
                                                                                self.bounds.size.width/2.0,
                                                                                self.bounds.size.height/2.0)
                                                             radius:self.bounds.size.width/4.0 startAngle:0
                                                           endAngle:2*M_PI
                                                          clockwise:YES
                               ];
    layer_Track.path = trackPath.CGPath;
    [self.layer addSublayer:layer_Track];
    
    
    
    textPercentLayer = [CATextLayer layer];
    textPercentLayer.fontSize = 18.0;
    textPercentLayer.alignmentMode = kCAAlignmentCenter;
    textPercentLayer.foregroundColor = [UIColor blackColor].CGColor;
    textPercentLayer.frame = CGRectMake( self.bounds.size.width/2.0-kPercentWidth/2.0,  self.bounds.size.height/2.0-kPercentHeight/2.0, kPercentWidth, kPercentHeight);
    textPercentLayer.contentsScale = [UIScreen mainScreen].scale;
    textPercentLayer.string = nil;
    
    [layer_Track addSublayer:textPercentLayer];
    
    
    
    
    layer_progress = [CAShapeLayer layer];
    layer_progress.frame = self.bounds;
    layer_progress.fillColor = [UIColor clearColor].CGColor;
    layer_progress.strokeColor = [UIColor redColor].CGColor;
   // layer_progress.lineCap = kCALineCapRound;
    layer_progress.lineWidth = 10;
    layer_progress.path = trackPath.CGPath;
    layer_progress.strokeEnd = 0;
    
    
    
    CALayer *layer_Combind = [CALayer layer];
    /**
     *  设置四种颜色进行渐变
     */
    CAGradientLayer * gradientLayerOne = [CAGradientLayer layer];
    gradientLayerOne.frame = self.bounds;
    //设置渐变颜色
    gradientLayerOne.colors = @[(__bridge id)[UIColor yellowColor].CGColor,
                                (__bridge id)[UIColor redColor].CGColor];
    //颜色渐变开始结束
    gradientLayerOne.startPoint = CGPointMake(0.5, 0.1);
    gradientLayerOne.endPoint = CGPointMake(0.5, 0.45);
    [layer_Combind addSublayer:gradientLayerOne];
    
    
    CAGradientLayer * gradientLayerTwo = [CAGradientLayer layer];
    gradientLayerTwo.frame = CGRectMake(self.bounds.size.width/2, 0,
                                        self.bounds.size.width/2 ,
                                        self.bounds.size.height);
    //设置渐变颜色
    gradientLayerTwo.colors = @[(__bridge id)[UIColor brownColor].CGColor,
                                (__bridge id)[UIColor blueColor].CGColor];
    //颜色渐变开始结束
    gradientLayerTwo.startPoint = CGPointMake(0.5, 0.1);
    gradientLayerTwo.endPoint = CGPointMake(0.5, 0.45);
    
    [layer_Combind addSublayer:gradientLayerTwo];
    //设置mask蒙板
    layer_Combind.mask = layer_progress;
    [self.layer addSublayer:layer_Combind];
    
    
    
    

}
- (void)awakeFromNib{
   [self setUp];
    
}

- (CADisplayLink *)displayLink{

    if (!_displayLink) {
       
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updatePercent)];
    }
    return _displayLink;
    

}

- (void)updatePercent{

    if(progressVaule<_progressPercent){
        progressVaule++;
         textPercentLayer.string = [self formatterPercent:progressVaule];
    
    }else{
        progressVaule = 0;
        
        [self.displayLink invalidate];
        self.displayLink = nil;
        
    }
  
    
    

}
- (void)dealloc{

    [self.displayLink invalidate];
    self.displayLink = nil;
    
    
}
/**
 *  百分比设置富文本
 *
 *  @param progress 进度值
 *
 *  @return 返回处理好样式字符串
 */
- (NSMutableAttributedString *)formatterPercent:(NSInteger)progress{

    NSMutableAttributedString *formatterString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld%%",progress]];
    
    NSDictionary *attribute_Dict= @{
                                    NSForegroundColorAttributeName:[UIColor redColor],
                                    NSFontAttributeName:[UIFont systemFontOfSize:24.0]
                                    };
    
    [formatterString addAttributes:attribute_Dict range:NSMakeRange(0, formatterString.length-1)];
    
    return formatterString;
    
    
}
- (void)setProgressPercent:(CGFloat)progressPercent{

    _progressPercent = progressPercent;
    
    if (progressPercent<0.0) {
        _progressPercent = 0.0;
    }
    else if (progressPercent>100.0){
    
        _progressPercent = 100;
    }
    
    layer_progress.strokeEnd = _progressPercent/100.0;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [layer_progress removeAnimationForKey:@"AnimateStrokeEnd"];
    animate_Progress = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animate_Progress.fromValue = @(0);
    animate_Progress.toValue = @(_progressPercent/100.0);
    animate_Progress.duration = _progressPercent==100?3.0:2.0;
    
    [layer_progress addAnimation:animate_Progress forKey:@"AnimateStrokeEnd"];
    
    
    
}

@end
