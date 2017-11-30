//
//  ViewController.m
//  test
//
//  Created by 韩钊 on 2017/11/16.
//  Copyright © 2017年 韩钊. All rights reserved.
//
#import "ViewController.h"
#import "Mantle.h"
#import "testDataModel.h"
#import "YYModel.h"
#import "Masonry.h"
#import "ReactiveObjC.h"
#import "NextViewViewController.h"

@interface ViewController ()

@property(nonatomic,strong) UITextField *textField;
@property(nonatomic,strong) UIView *uiView;
@property(nonatomic,strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*-------------------------*/
    /*
     Mantle用法
     */
    
    //JSON数据
        NSDictionary * dic = @{@"name":@"me",@"do":@"something",@"with":@"you",@"where":@"home"};
    
        //JSON转为NSData
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:NULL];
        NSLog(@"\njsonData数据为--%@",jsonData);
    
        //Data转为JSONDic
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
        NSLog(@"\n%@",jsonDic);
    
        //Mantle
        testDataModel *testModel = [MTLJSONAdapter modelOfClass:[testDataModel class] fromJSONDictionary:jsonDic error:NULL];
        NSLog(@"\n----Mantle----%@",testModel.doing);
    
        //YYModel
        testDataModel *model = [testDataModel yy_modelWithJSON:dic];
        NSLog(@"\n----YYModel----%@",model.with);
    
    /*------------textfiled键盘适配----------*/
    
    _textField = [UITextField new];
    _textField.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_textField];
    
    _uiView = [[UIView alloc] init];
    _uiView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_uiView];
    
    _label = [[UILabel alloc] init];
    _label.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_label];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(0);
    }];
    
    
    [_uiView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.size.mas_equalTo(CGSizeMake(200, 200));
        //        make.center.equalTo(self.view);
        make.left.mas_equalTo(self.view.mas_left).offset(100);
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-400);
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_uiView.mas_bottom).offset(50);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(50);
    }];
    
    
    //注册键盘通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    
    [self printfTextFiledText];
    
    /*
     试着用RAC来进行按钮点击变换颜色
     */
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.backgroundColor = [UIColor greenColor];
//    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];


//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(100, 50));
//        make.center.equalTo(self.view);
//    }];

//    RAC(button,backgroundColor) = [RACObserve(button, selected) map:^UIColor *(NSNumber * selected) {
//        return [selected boolValue] ? [UIColor redColor] : [UIColor yellowColor];
//    }];

//    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]
//             subscribeNext:^(UIButton * button) {
//                 button.selected = !button.selected;
//    }];
    
//    button.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//        NSLog(@"按钮被点击");
//        NextViewViewController *nextVC = [[NextViewViewController alloc] init];
//        [self presentViewController:nextVC animated:YES completion:nil];
//        return [RACSignal empty];
//    }];
//
    
//    [self testRAC];
    
}

-(void)testRAC{
    
    RAC(self.label,text) = _textField.rac_textSignal;
    
}

-(void)printfTextFiledText{
    
    [[self.textField.rac_textSignal filter:^BOOL(NSString *  text) {
        return text.length > 3;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
}

/**
 键盘将要弹出的代理方法
 
 @param notification <#notification description#>
 */
-(void)keyboardWillChangeFrameNotification:(NSNotification *)notification{
    NSLog(@"-----%@",notification);
    //获取notification的信息
    NSDictionary * userInfo = [notification userInfo];
    //UIKeyboardFrameEndUserInfoKey方法是用来获取键盘弹出后的高度，宽度
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboardHeight   = CGRectGetHeight(rect);
    
    CGFloat keyboardY   = rect.origin.y;
    NSLog(@"%f",keyboardHeight);
    NSLog(@"%f",keyboardY);
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [_uiView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(100-keyboardHeight);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-keyboardHeight-400);
    }];
    
    [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-keyboardHeight);
    }];
    
    
    // 更新约束
//    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
//    }];

}

/**
 键盘将要隐藏的代理方法

 @param notification <#notification description#>
 */
- (void)keyboardWillHideNotification:(NSNotification *)notification{
    NSLog(@"~~~~~~%@",notification);
    // 获得键盘动画时长
    NSDictionary *userInfo   = [notification userInfo];
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 修改为以前的约束（距下边距0）
    [_uiView mas_updateConstraints:^(MASConstraintMaker *make) {
        //        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.view.mas_left).offset(100);
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-400);
    }];
    
    [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
    
    // 更新约束
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
