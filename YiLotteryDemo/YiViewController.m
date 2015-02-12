//
//  YiViewController.m
//  YiLotteryDemo
//
//  Created by apple on 15/2/11.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//

#import "YiViewController.h"
#import "YiLotteryCell.h"
#import "YiLotteryButton.h"

#define HScreen [[UIScreen mainScreen] bounds].size.height
#define WScreen [[UIScreen mainScreen] bounds].size.width
#define iOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
@interface YiViewController (){
    
    UIView *lotteryView;
    UIView *lotteryBgView;
    YiLotteryCell *lotteryCell1;
    YiLotteryCell *lotteryCell2;
    YiLotteryCell *lotteryCell3;
    YiLotteryCell *lotteryCell4;
    YiLotteryCell *lotteryCell5;
    YiLotteryCell *lotteryCell6;
    YiLotteryCell *lotteryCell7;
    YiLotteryCell *lotteryCell8;
    YiLotteryCell *lotteryCell9;
    YiLotteryCell *lotteryCell10;
    
    YiLotteryButton *startButton;
    
    NSArray *array;
    NSTimer *timer;
    YiLotteryCell *currentView;
    float intervalTime;//变换时间差（用来表示速度）
    float accelerate;//减速度
    float endTimerTotal;//减速共耗时间
   int a;
}

@end

@implementation YiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    [self initLottery];
    a=0;
}



//初始化抽奖视图

-(void)initLottery{
    lotteryBgView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, WScreen, HScreen)];
    [self.view addSubview:lotteryBgView];
    lotteryBgView.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0.9];
    lotteryBgView.hidden=YES;
    
    UIButton *lotteryBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:lotteryBt];
    lotteryBt.frame=CGRectMake(WScreen-70, 95, 50, 50);
    lotteryBt.layer.masksToBounds=YES;
    lotteryBt.layer.cornerRadius=25;
    lotteryBt.backgroundColor=[UIColor colorWithWhite:0.4 alpha:0.5];
    [lotteryBt setTitle:@"每日\n抽奖" forState:UIControlStateNormal];
    [lotteryBt setTitleColor:[UIColor colorWithRed:1 green:0.81 blue:0.18 alpha:1] forState:UIControlStateNormal];
    //    [lotteryBt setFont:[UIFont systemFontOfSize:13]];
    
    lotteryBt.titleLabel.lineBreakMode=UILineBreakModeWordWrap;
    lotteryBt.titleLabel.font=[UIFont boldSystemFontOfSize:13];
    [lotteryBt addTarget:self action:@selector(lotteryBtAction) forControlEvents:UIControlEventTouchUpInside];
    
    lotteryView=[[UIView alloc] initWithFrame:CGRectMake((WScreen-260)/2, 160, 260, 260)];
    [self.view addSubview:lotteryView];
    lotteryView.hidden=YES;
    lotteryView.backgroundColor=[UIColor whiteColor];
    UIButton *hideLotteryBt=[UIButton buttonWithType:UIButtonTypeCustom];
    [lotteryView addSubview:hideLotteryBt];
    hideLotteryBt.frame=CGRectMake(240, 0, 20, 20);
    [hideLotteryBt setImage:[UIImage imageNamed:@"l5"] forState:UIControlStateNormal];
    [hideLotteryBt addTarget:self action:@selector(hideLotteryBtAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lotteryTitle=[[UILabel alloc] initWithFrame:CGRectMake((260-150)/2, 22, 150, 30)];
    lotteryTitle.backgroundColor=[UIColor colorWithRed:0.99 green:0.78 blue:0.19 alpha:1];
    lotteryTitle.text=@"每日抽奖";
    lotteryTitle.textAlignment=NSTextAlignmentCenter;
    
    lotteryTitle.font=[UIFont boldSystemFontOfSize:14];
    lotteryTitle.textColor=[UIColor whiteColor];
    [lotteryView addSubview:lotteryTitle];
    
    endTimerTotal = 5.0;
    float originX=15;
    float space=10;
    float cellWidth=50;
    float cellHeight=43;
    float orginY=75;
    lotteryCell1=[[YiLotteryCell alloc] initWithFrame:CGRectMake(originX, orginY, cellWidth, cellHeight)];
    [lotteryView addSubview:lotteryCell1];
    lotteryCell1.label.text=@"2";
    lotteryCell2=[[YiLotteryCell alloc] initWithFrame:CGRectMake(originX+cellWidth+space, orginY, cellWidth, cellHeight)];
    [lotteryView addSubview:lotteryCell2];
    lotteryCell2.label.text=@"4";
    lotteryCell3=[[YiLotteryCell alloc] initWithFrame:CGRectMake(originX+cellWidth*2+space*2, orginY, cellWidth, cellHeight)];
    [lotteryView addSubview:lotteryCell3];
    lotteryCell3.label.text=@"6";
    lotteryCell4=[[YiLotteryCell alloc] initWithFrame:CGRectMake(originX+cellWidth*3+space*3, orginY, cellWidth, cellHeight)];
    [lotteryView addSubview:lotteryCell4];
    lotteryCell4.label.text=@"8";
    lotteryCell5=[[YiLotteryCell alloc] initWithFrame:CGRectMake(originX+cellWidth*3+space*3, orginY+cellHeight+space, cellWidth, cellHeight)];
    [lotteryView addSubview:lotteryCell5];
    lotteryCell5.label.text=@"10";
    
    lotteryCell6=[[YiLotteryCell alloc] initWithFrame:CGRectMake(originX+cellWidth*3+space*3, orginY+(cellHeight+space)*2, cellWidth, cellHeight)];
    [lotteryView addSubview:lotteryCell6];
    lotteryCell6.label.text=@"12";
    
    lotteryCell7=[[YiLotteryCell alloc] initWithFrame:CGRectMake(originX+cellWidth*2+space*2, orginY+(cellHeight+space)*2, cellWidth, cellHeight)];
    [lotteryView addSubview:lotteryCell7];
    lotteryCell7.label.text=@"14";
    
    lotteryCell8=[[YiLotteryCell alloc] initWithFrame:CGRectMake(originX+cellWidth*1+space*1, orginY+(cellHeight+space)*2, cellWidth, cellHeight)];
    [lotteryView addSubview:lotteryCell8];
    lotteryCell8.label.text=@"16";
    
    lotteryCell9=[[YiLotteryCell alloc] initWithFrame:CGRectMake(originX+cellWidth*0+space*0, orginY+(cellHeight+space)*2, cellWidth, cellHeight)];
    [lotteryView addSubview:lotteryCell9];
    lotteryCell9.label.text=@"18";
    
    lotteryCell10=[[YiLotteryCell alloc] initWithFrame:CGRectMake(originX+cellWidth*0+space*0, orginY+cellHeight+space, cellWidth, cellHeight)];
    [lotteryView addSubview:lotteryCell10];
    lotteryCell10.label.text=@"20";
    
    
    startButton=[[YiLotteryButton alloc] initWithFrame:CGRectMake(originX+cellWidth+space, orginY+cellHeight+space, cellWidth*2+space, cellHeight)];
    [lotteryView addSubview:startButton];
    [startButton addTarget:self action:@selector(prepareLotteryAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    array = [[NSArray alloc] initWithObjects:lotteryCell1,lotteryCell2,lotteryCell3,lotteryCell4,lotteryCell5,lotteryCell6,lotteryCell7,lotteryCell8,lotteryCell9,lotteryCell10,nil];
    int count = array.count;
    for (int i=0; i<count; i++) {
        YiLotteryCell *view = array[i];
        view.tag = i;
    }
    
    
}
// 显示与隐藏抽奖视图
-(void)lotteryBtAction{
    lotteryBgView.hidden=NO;
    lotteryView.hidden=NO;
}
-(void)hideLotteryBtAction{
    lotteryBgView.hidden=YES;
    lotteryView.hidden=YES;
}

//抽奖按钮按下后的准备工作
- (void)prepareLotteryAction {
    intervalTime = 0.7;//起始的变换时间差（速度）
    currentView.label.textColor = [UIColor colorWithRed:0.74 green:0.46 blue:0.07 alpha:1];
    currentView.image=[UIImage imageNamed:@"l3"];

    currentView = [array objectAtIndex:0];
    currentView.label.textColor = [UIColor whiteColor];
    currentView.image=[UIImage imageNamed:@"l2"];
    startButton.enabled = NO;

    
    timer = [NSTimer scheduledTimerWithTimeInterval:intervalTime target:self selector:@selector(startLotterry:) userInfo:currentView repeats:NO];
    
    
#pragma mark 网络请求的代码
    NSTimer *netRequestTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(netAction) userInfo:nil repeats:NO];
    [netRequestTimer setFireDate:[NSDate dateWithTimeIntervalSince1970:([[NSDate date] timeIntervalSince1970]+7) ]];
    
#pragma mark over

    
    
    
}
//抽奖中间获取网络数据后调用该方法停止抽奖
-(void)netAction{
    
    int resultValue = 9;
    [self endLotteryWithResultValue:resultValue];

}
//开始抽奖
-(void)startLotterry:(NSTimer *)sender{
    
    int count = array.count;
    NSTimer *myTimer = (NSTimer *)sender;
    UIView *preView = (UIView *)myTimer.userInfo;
    int index;
    if (preView==nil) {
        index = 0;
    }else{
        index = [array indexOfObject:preView];
    }
    if (index==count-1) {
        currentView = [array objectAtIndex:0];
    }else{
        currentView = [array objectAtIndex:index+1];
    }
    
    [self moveCurrentView:currentView inArray:array];
    
    
    if (intervalTime>0.1) {
        intervalTime = intervalTime - 0.1;
    }
    NSLog(@"intttt is %f",intervalTime);
    timer = [NSTimer scheduledTimerWithTimeInterval:intervalTime target:self selector:@selector(startLotterry:) userInfo:currentView repeats:NO];
}

//单元格移动一下
-(void)moveCurrentView:(YiLotteryCell *)curView  inArray:(NSArray *)views{
    
    YiLotteryCell *preView = [self previewByCurrentView:curView inArray:views];
    
    preView.label.textColor = [UIColor colorWithRed:0.74 green:0.46 blue:0.07 alpha:1];
    preView.image=[UIImage imageNamed:@"l3"];
    curView.label.textColor = [UIColor whiteColor];
    curView.image=[UIImage imageNamed:@"l2"];
    
}

-(void)endLotteryWithResultValue:(int)resultValue{
    intervalTime=0.3;
//    accelerate = [self accelerateWithResultValue:resultValue];
    
    int currentIndex = [array indexOfObject:currentView];
    int count = array.count;
    
    int endLength;
    
    if (currentIndex+1>=resultValue) {
        endLength = count-(currentIndex+1-resultValue);
    }else{
        endLength = resultValue-(currentIndex+1);
    }
    //    intervalTime = (0.1+0.1*endLength)*endLength/2.0;
    accelerate = (2*endTimerTotal/endLength-2*intervalTime)/(endLength-1);

    
//    intervalTime=0.1*accelerate;
    [self moveToStopWithAccelerate];
}

//减速至停止
-(void)moveToStopWithAccelerate{
    
    static float timeTotal = 0;
    int aaa=intervalTime/0.3;

    if (a<=accelerate) {
        
        a++;
        intervalTime = 0.3*a;
        NSLog(@"aaaaa is %f",intervalTime);

//        accelerate--;
//        timeTotal = timeTotal+intervalTime;
        [timer invalidate];
        currentView = [self nextViewByCurrentView:currentView inArray:array];
        [self moveCurrentView:currentView inArray:array];
        timer = [NSTimer scheduledTimerWithTimeInterval:intervalTime target:self selector:@selector(moveToStopWithAccelerate) userInfo:nil repeats:NO];
    }
    if (a>=accelerate) {
        
        [timer invalidate];
        timeTotal = 0;
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"恭喜你！抽中%d个积分",(currentView.tag+1)*2] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];

        
        startButton.enabled = YES;
        intervalTime=0.7;
        a=0;
    }
    
}

//得到上一个view
-(UIView *)previewByCurrentView:(UIView *)curView inArray:(NSArray *)views{
    int count = views.count;
    int curIndex = [views indexOfObject:curView];
    int preIndex;
    if (curIndex==0) {
        preIndex = count-1;
    }else{
        preIndex = curIndex-1;
    }
    return [views objectAtIndex:preIndex];
}

//得到下一个view
-(UIView *)nextViewByCurrentView:(UIView *)curView inArray:(NSArray *)views{
    int count = views.count;
    int curIndex = [views indexOfObject:curView];
    int nextIndex;
    if (curIndex==count-1) {
        nextIndex = 0;
    }else{
        nextIndex = curIndex+1;
    }
    return [views objectAtIndex:nextIndex];
}

//计算时间的加速度
-(float)accelerateWithResultValue:(int)resultValue{
    float a;
    int currentIndex = [array indexOfObject:currentView];
    int count = array.count;
    
    int endLength;
    
    if (currentIndex+1>=resultValue) {
        endLength = count-(currentIndex+1-resultValue);
    }else{
        endLength = resultValue-(currentIndex+1);
    }
//    intervalTime = (0.1+0.1*endLength)*endLength/2.0;
    a = (2*endTimerTotal/endLength-2*intervalTime)/(endLength-1);
    return endLength;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end