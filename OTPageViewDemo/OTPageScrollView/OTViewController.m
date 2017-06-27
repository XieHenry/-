//
//  OTViewController.m
//  OTPageScrollView
//
//  Created by akron on 7/22/14.
//  Copyright (c) 2014 Oolong Tea. All rights reserved.
//

#import "OTViewController.h"
#import "OTPageScrollView.h"
#import "OTPageView.h"

static BOOL isFirstShowVc;

@interface OTViewController () <OTPageScrollViewDataSource,OTPageScrollViewDelegate>
@property (nonatomic,strong) OTPageView *PScrollView;
@end

@implementation OTViewController {
    NSMutableArray *_dataArray;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isFirstShowVc = YES;
    
    _PScrollView = [[OTPageView alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, 110)];
    _PScrollView.pageScrollView.dataSource = self;
    _PScrollView.pageScrollView.delegate = self;
    _PScrollView.pageScrollView.padding = 15;
    _PScrollView.pageScrollView.leftRightOffset = 0;
    _PScrollView.pageScrollView.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width -65)/2, 0, 65, 110);
    _PScrollView.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:139.0f/255.0f blue:139.0f/255.0f alpha:1.0f];
    _dataArray = [NSMutableArray array];
    
    _dataArray = [NSMutableArray arrayWithObjects:
                  @"0",
                  @"1",
                  @"2",
                  @"3",
                  @"4",
                  @"5",
                  @"6",
                  @"7",
                  @"8",
                  @"9",
                  @"10",
                  @"11",
                  @"12",
                  @"13",
                  @"14",
                  @"15",
                  @"16",
                  @"17",
                  @"18",
                  @"19",
                 nil];
    [_PScrollView.pageScrollView reloadData];
    
    [self.view addSubview:_PScrollView];
    
    
    UIView *arrowView = [[UIView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2-2, 210, 4, 10)];
    arrowView.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:79.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
    [self.view addSubview:arrowView];
    
    
}

- (NSInteger)numberOfPageInPageScrollView:(OTPageScrollView*)pageScrollView {
    return [_dataArray count];
}

- (UIView*)pageScrollView:(OTPageScrollView*)pageScrollView viewForRowAtIndex:(int)index {
    
    UIView *cell = [[UIView alloc] init];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 25;
    cell.frame = CGRectMake(0, 0, 50, 50);
    cell.backgroundColor = [UIColor colorWithRed:191.0f/255.0f green:239.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    cell.tag = 100 +index;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:10];
    label.text = _dataArray[index];
    [cell addSubview:label];

    
    return cell;

}


- (CGSize)sizeCellForPageScrollView:(OTPageScrollView*)pageScrollView {
    return CGSizeMake(50, 50);
}

#pragma mark  点击选中
- (void)pageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index {
    

    [self animaView:index];
}


#pragma mark  滑动选中
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    [self animaView:index];

}


- (void)animaView:(NSInteger)index {
    //先对以前选中的进行还原，在对选中的进行改变大小
    for (int i=0; i<_dataArray.count; i++) {
        UIView *view = [self.view viewWithTag:100 + i];
        view.transform = CGAffineTransformMakeScale(1, 1);
        view.layer.borderColor = [UIColor clearColor].CGColor;
        view.layer.borderWidth = 0;
    }
    
    
    UIView *view = [self.view viewWithTag:100 + index];
    view.layer.borderColor = [UIColor redColor].CGColor;
    view.layer.borderWidth = 2;
    view.transform = CGAffineTransformMakeScale(1 + 0.2, 1  + 0.2);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

