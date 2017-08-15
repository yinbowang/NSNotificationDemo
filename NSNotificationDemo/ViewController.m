//
//  ViewController.m
//  NSNotificationDemo
//
//  Created by wyb on 2017/8/14.
//  Copyright © 2017年 中天易观. All rights reserved.
//

#import "ViewController.h"
#import "YBNotificationCenter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [[YBNotificationCenter defaultCenter] addObserver:self selector:@selector(go:) name:@"wang" object:nil];
    
}

- (void)go{
    
    NSLog(@"dfd");
}

- (void)go:(NSNotification *)noti
{
    NSLog(@"%@",noti);
}

- (IBAction)btnAction:(id)sender {
    
    [[YBNotificationCenter defaultCenter] removeObserver:self];
    [[YBNotificationCenter defaultCenter] removeObserver:self name:@"wang" object:nil];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[YBNotificationCenter defaultCenter] postNotificationName:@"wang" object:nil];
//    [[YBNotificationCenter defaultCenter] postNotificationName:@"wang" object:nil userInfo:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
