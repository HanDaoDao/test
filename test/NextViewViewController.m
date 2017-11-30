//
//  NextViewViewController.m
//  test
//
//  Created by 韩钊 on 2017/11/20.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "NextViewViewController.h"
#import "ReactiveObjC.h"
#import "ViewController.h"

@interface NextViewViewController ()

@property(nonatomic,strong) UIButton *button;

@end

@implementation NextViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(200, 200, 100, 50)];
    _button.backgroundColor = [UIColor redColor];
//    [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    _button.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {

        [self dismissViewControllerAnimated:YES completion:nil];

        return [RACSignal empty];
    }];
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
