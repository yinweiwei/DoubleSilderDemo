//
//  YSDoubleSilderV.m
//  zebraLife
//
//  Created by bm on 2017/11/8.
//  Copyright © 2017年 bm. All rights reserved.
//

#import "YSDoubleSilderV.h"


static CGFloat interval=15.0;
@interface YSDoubleSilderV ()
@property (weak, nonatomic) IBOutlet UILabel *minLab;
@property (weak, nonatomic) IBOutlet UILabel *maxLab;
@property (weak, nonatomic) IBOutlet UILabel *lengthLab;
@property (weak, nonatomic) IBOutlet UIView *firstSilder;
@property (weak, nonatomic) IBOutlet UIView *lastSilder;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstSilderWLeft;//左边滑块
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstSilderW;//滑块是等长的
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lastSilderRight;//右边滑块

@end

@implementation YSDoubleSilderV

-(void)setFirstS:(CGFloat)firstS{
    _firstS=firstS;
    CGFloat first=(firstS-_min)/(_max-_min);
    CGFloat k=(self.lengthLab.frame.size.width-2*self.firstSilderW.constant)*first;
    self.firstSilderWLeft.constant+=k;
    CGFloat proportion=(self.firstSilderWLeft.constant-interval)/(self.lengthLab.frame.size.width-self.firstSilderW.constant*2);
    
    
    _minLab.text=[NSString stringWithFormat:@"%ld",(long)(_min+(_max-_min)*proportion)];


}
-(void)setLastS:(CGFloat)lastS{
    _lastS=lastS;

    CGFloat last=(_max-lastS)/(_max-_min);
    self.lastSilderRight.constant+=(self.lengthLab.frame.size.width-2*self.firstSilderW.constant)*last;
    CGFloat proportion=(self.lastSilderRight.constant-interval)/(self.lengthLab.frame.size.width-self.firstSilderW.constant*2);
    _maxLab.text=[NSString stringWithFormat:@"%ld",(long)(_max-(_max-_min)*proportion)];
}

-(void)setMax:(CGFloat)max{
    _max=max;
    self.maxLab.text = [NSString stringWithFormat:@"%ld",(long)_max];
    

}
-(void)setMin:(CGFloat)min{
    _min=min;
    self.minLab.text = [NSString stringWithFormat:@"%ld",(long)_min];
    
}
-(void)awakeFromNib{

    [super awakeFromNib];
    //拖动手势
    UIPanGestureRecognizer *panL=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveL:)];
    UIPanGestureRecognizer *panR=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveR:)];
    
    [self.firstSilder addGestureRecognizer:panL];
    [self.lastSilder addGestureRecognizer:panR];
}

-(instancetype)init{
    YSDoubleSilderV *doubleSilderV=[[[NSBundle mainBundle] loadNibNamed:@"YSDoubleSilderV" owner:nil options:nil] firstObject];
    
    return doubleSilderV;
}

-(void)moveL:(UIPanGestureRecognizer *)pan{
    
    CGPoint trans =[pan translationInView:pan.view];
    if (self.firstSilderWLeft.constant<=interval && trans.x<=0) {
        return;
    }
    if ([self length] || trans.x<=0) {
        CGPoint point = [pan locationInView:pan.view];
        self.firstSilderWLeft.constant+=(point.x-self.firstSilderW.constant/2);
        
        //有误差，手动排除一下
        if ((self.firstSilderWLeft.constant+self.lastSilderRight.constant+self.firstSilderW.constant*2-2*interval )>=self.lengthLab.frame.size.width) {
            self.firstSilderWLeft.constant=self.lengthLab.frame.size.width-(self.lastSilderRight.constant+self.firstSilderW.constant*2-2*interval);
        }
        if(self.firstSilderWLeft.constant<interval){
            self.firstSilderWLeft.constant=interval;
        }
        CGFloat proportion=(self.firstSilderWLeft.constant-interval)/(self.lengthLab.frame.size.width-self.firstSilderW.constant*2);
        _minLab.text=[NSString stringWithFormat:@"%ld",(long)(_min+(_max-_min)*proportion)];
    }
    

}
-(void)moveR:(UIPanGestureRecognizer *)pan{
    CGPoint trans =[pan translationInView:pan.view];
    if (self.lastSilderRight.constant<interval && trans.x>=0) {
        return;
    }
    
    if ([self length] ||trans.x>=0) {
        //实际坐标
        CGPoint point = [pan locationInView:pan.view];
        self.lastSilderRight.constant-=(point.x-self.firstSilderW.constant/2);
        
        if ((self.firstSilderWLeft.constant+self.lastSilderRight.constant+self.firstSilderW.constant*2-2*interval )>=self.lengthLab.frame.size.width) {
            self.lastSilderRight.constant=self.lengthLab.frame.size.width-(self.firstSilderWLeft.constant+self.firstSilderW.constant*2-2*interval);
        }
        if(self.lastSilderRight.constant<interval){
            self.lastSilderRight.constant=interval;
        }
        CGFloat proportion=(self.lastSilderRight.constant-interval)/(self.lengthLab.frame.size.width-self.firstSilderW.constant*2);
        
       _maxLab.text=[NSString stringWithFormat:@"%ld",(long)(_max-(_max-_min)*proportion)];
    }
}

-(BOOL)length{
    CGFloat length=self.firstSilderWLeft.constant+self.lastSilderRight.constant+self.firstSilderW.constant*2-2*interval;
    if(length<=self.lengthLab.frame.size.width)
        return YES;

    return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
