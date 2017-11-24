//
//  ViewController.m
//  NestVC_Demo
//
//  Created by litianqi on 2017/9/6.
//  Copyright © 2017年 tqUDown. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"
#import "HomeCCell.h"
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)clickPresentBtn:(id)sender {
    DemoViewController * vc = [[DemoViewController alloc] initWithSwitchItemArray:@[@"分类1",@"分类2",@"分类3",@"分类4",@"分类5",@"分类6"] withClass:NSStringFromClass([HomeCCell class]) withIdentifiter:[HomeCCell identifier]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
