# 多种颜色渐变的圆形进度条支持纯代码、Xib、SB 

#使用说明:

1->把文件名名称“EBTCircleGradientProgress”里面的文件添加到项目工程中

2->#import "EBTCircleGradientProgressView.h"引用一下

3->设置progressPercent属性值，其值在0-100之间。

#纯代码使用案例:

 progressView = [[EBTCircleGradientProgressView alloc]initWithFrame:CGRectMake(0, 100, 400, 400)];
 
[self.view addSubview:progressView];

[progressView setProgressPercent:100.0];

#xib或者sb使用案例:
1->需要在控制器拖一个view并将其class设置为“EBTCircleGradientProgressView”

2->托线条
@property (weak, nonatomic) IBOutlet EBTCircleGradientProgressView *gradientProgressView;

3->设置progressPercent属性值
[_gradientProgressView setProgressPercent:100.0];

#效果演示图
![Image](https://github.com/KBvsMJ/EBTCircleGradientProgressDemo/blob/master/Demogif/circleprogress.gif)
