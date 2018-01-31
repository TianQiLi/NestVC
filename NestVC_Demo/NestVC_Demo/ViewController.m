//
//  ViewController.m
//  NestVC_Demo
//
//  Created by litianqi on 2017/9/6.
//  Copyright © 2017年 tqUDown. All rights reserved.
//

#import "ViewController.h"
#import "HomeCCell.h"
#import "NestVC.h"
#import "Free_CourseVC.h"
#import "SwitchViewButton.h"
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)clickPresentBtn:(id)sender {
   
//    SubViewController * vc = [[SubViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    NestVC * courseVC = [[NestVC alloc] initWithSwitchItemArray:@[@"录播",@"直播",@"试卷"]  withClassArray:@[NSStringFromClass([Free_CourseVC class])] withIdentifiter:@[[Free_CourseVC  cellIdentifiter]]];
    [self.navigationController pushViewController:courseVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SwitchViewButton * _switchViewButton = [[SwitchViewButton alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,48)];
    _switchViewButton.arrayItem = @[@"录播",@"直播",@"试卷"];
    //    _switchViewButton.delegate = self;
    [_switchViewButton setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_switchViewButton];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
