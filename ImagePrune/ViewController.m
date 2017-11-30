//
//  ViewController.m
//  ImagePrune
//
//  Created by 红喇叭 on 2017/11/29.
//  Copyright © 2017年 红喇叭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    UIView *leftTop;
    UIView *rightBttom;
}
@property (weak, nonatomic) IBOutlet UIImageView *pImageV;

@property(nonatomic,strong)UIView *pruneView;
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    CGRect frame = CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.width);
    self.imageView = [[UIImageView alloc] initWithFrame:frame];
    [_imageView setImage:[UIImage imageNamed:@"店铺管理_03"]];
    _imageView.userInteractionEnabled = true;
    //_imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIPanGestureRecognizer *pan12 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(Pan1:)];
    [_imageView addGestureRecognizer:pan12];
    [self.view addSubview:_imageView];
    
    _pImageV.contentMode = UIViewContentModeScaleAspectFit;
    
    _pruneView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    _pruneView.backgroundColor = [UIColor clearColor];
    _pruneView.layer.borderWidth = 1;
    _pruneView.layer.borderColor = [UIColor redColor].CGColor;
  
    
    [self.view addSubview:_pruneView];
    
    //  _pruneView.userInteractionEnabled = NO;
    //加上这个手势  剪裁框可以随便移动  但是图片跟剪裁框重合的部分会存在手势冲突
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [_pruneView addGestureRecognizer:pan];
    
    leftTop = [[UIView alloc] init];
    leftTop.backgroundColor = [UIColor redColor];
    leftTop.frame = CGRectMake(0, 0, 20, 20);
    leftTop.center = CGPointMake(100,200);
    [self.view addSubview:leftTop];
    UIPanGestureRecognizer *pan1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftTopPan:)];
    [leftTop addGestureRecognizer:pan1];
    
    
    
    rightBttom = [[UIView alloc] init];
    rightBttom.backgroundColor = [UIColor redColor];
    rightBttom.frame = CGRectMake(0, 0, 20, 20);
    rightBttom.center = CGPointMake(300, 400);
    [self.view addSubview:rightBttom];
    UIPanGestureRecognizer *pan4 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rightBttomPan:)];
    [rightBttom addGestureRecognizer:pan4];
   
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state != UIGestureRecognizerStateEnded && recognizer.state != UIGestureRecognizerStateFailed){
        CGPoint translation = [recognizer translationInView:self.view];
        CGPoint center = self.pruneView.center;
        self.pruneView.center = CGPointMake(center.x + translation.x, center.y + translation.y);
        [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
        CGRect rect =  self.pruneView.frame;
         leftTop.center = CGPointMake(rect.origin.x,rect.origin.y);
         rightBttom.center = CGPointMake(rect.origin.x +rect.size.width, rect.origin.y+rect.size.height);
    }
}

- (void)leftTopPan:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state != UIGestureRecognizerStateEnded && recognizer.state != UIGestureRecognizerStateFailed){
        CGPoint translation1 = [recognizer translationInView:self.view];
        
        CGPoint center = leftTop.center;
        leftTop.center = CGPointMake(center.x + translation1.x, center.y + translation1.y);
        CGPoint translation = leftTop.center;
        [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
        CGRect rect =  self.pruneView.frame;
        NSLog(@"x===%f,y===%f",translation.x,translation.y);
        if(translation.x > rect.origin.x + rect.size.width){
            
            rect.size.width = translation.x - rect.origin.x - rect.size.width;
            rect.origin.x = rect.origin.x + rect.size.width;
        }else{
            
            rect.size.width = rect.origin.x + rect.size.width - translation.x;
            rect.origin.x = translation.x;
        }

        if(translation.y>rect.origin.y+rect.size.height){
            
            rect.size.height =  translation.y - rect.origin.y-rect.size.height;
            rect.origin.y = rect.origin.y+rect.size.height;

        }else{
            
            rect.size.height = rect.origin.y+rect.size.height-translation.y;
            rect.origin.y = translation.y;
        }
    NSLog(@"x===%f,y===%f,width==%f,height==%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
        self.pruneView.frame = rect;
        rightBttom.center = CGPointMake(rect.origin.x +rect.size.width, rect.origin.y+rect.size.height);
    }
}


- (void)rightBttomPan:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state != UIGestureRecognizerStateEnded && recognizer.state != UIGestureRecognizerStateFailed){
        CGPoint translation1 = [recognizer translationInView:self.view];
        
        CGPoint center = rightBttom.center;
        rightBttom.center = CGPointMake(center.x + translation1.x, center.y + translation1.y);
        CGPoint translation = rightBttom.center;
        [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
        CGRect rect =  self.pruneView.frame;
        NSLog(@"x===%f,y===%f",translation.x,translation.y);
        if(translation.x > rect.origin.x){
            
            rect.size.width = translation.x - rect.origin.x;
//            rect.origin.x = rect.origin.x + rect.size.width;
        }else{
            
            rect.size.width = rect.origin.x - translation.x;
            rect.origin.x = translation.x;
        }
        
        if(translation.y>rect.origin.y){
            
            rect.size.height =  translation.y - rect.origin.y;
            //rect.origin.y = rect.origin.y+rect.size.height;
            
        }else{
            
            rect.size.height = rect.origin.y-translation.y;
            rect.origin.y = translation.y;
        }
        
        self.pruneView.frame = rect;
        leftTop.center = CGPointMake(rect.origin.x,rect.origin.y);
    }
}
- (IBAction)Pruneimage:(id)sender {
    
    UIImage *cpImage = [UIImage imageNamed:@"店铺管理_03"];
    CGRect cropFrame = self.pruneView.frame;
    CGFloat orgX = (cropFrame.origin.x-self.imageView.frame.origin.x) * (cpImage.size.width / self.imageView.frame.size.width);
    CGFloat orgY =(cropFrame.origin.y-self.imageView.frame.origin.y) * (cpImage.size.height / self.imageView.frame.size.height);
    CGFloat width = cropFrame.size.width * (cpImage.size.width / self.imageView.frame.size.width);
    CGFloat height = cropFrame.size.height * (cpImage.size.height / self.imageView.frame.size.height);
    CGRect cropRect = CGRectMake(orgX, orgY, width, height);
    CGImageRef imgRef = CGImageCreateWithImageInRect(cpImage.CGImage, cropRect);
    
    CGFloat deviceScale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(cropFrame.size, 0, deviceScale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //截出来的是反的  所以位置要倒一下
    CGContextTranslateCTM(context, 0, cropFrame.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, CGRectMake(0, 0, cropFrame.size.width, cropFrame.size.height), imgRef);
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(imgRef);
    UIGraphicsEndImageContext();
    
    _pImageV.image = newImg;
    
    
}

- (void)Pan1:(UIPanGestureRecognizer *)recognizer {

    if (recognizer.state != UIGestureRecognizerStateEnded && recognizer.state != UIGestureRecognizerStateFailed){
        CGPoint translation = [recognizer translationInView:self.view];
        CGPoint center = self.imageView.center;
        self.imageView.center = CGPointMake(center.x + translation.x, center.y + translation.y);
        [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    }
}




@end
