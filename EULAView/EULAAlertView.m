//
//  EULAAlertView.m
//  testSingature
//
//  Created by jabraknight on 2021/10/22.
//  Copyright © 2021 zk. All rights reserved.
//

#import "EULAAlertView.h"
#import <Masonry.h>
@interface EULAAlertView()<UITextViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIButton *backgroundView;
@end

@implementation EULAAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    //背景
    self.backgroundView = [[UIButton alloc]init];
    UIColor *color = [UIColor whiteColor];//[UIColor colorWithRed:18/255.0 green:18/255.0 blue:18/255.0 alpha:1.0];
    self.backgroundView.backgroundColor = [color colorWithAlphaComponent:0.7];
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_equalTo(0);
        make.right.equalTo(self).mas_equalTo(0);
        make.top.equalTo(self).mas_equalTo(0);
        make.bottom.equalTo(self).mas_equalTo(0);
    }];
    
    //内容显示框
    UIView *contentDView = [[UIView alloc]init];
    contentDView.backgroundColor = UIColor.whiteColor;
    contentDView.layer.cornerRadius = 16;
    [self.backgroundView addSubview:contentDView];
    [contentDView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.backgroundView).offset(47);
//        make.right.equalTo(self.backgroundView).mas_equalTo(-47);
//        make.centerY.equalTo(self.backgroundView);
//        make.height.mas_equalTo(300);
        make.centerX.equalTo(self.backgroundView.mas_centerX);
        make.centerY.equalTo(self.backgroundView.mas_centerY).mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(282, 308));
    }];
    
    //不同意按钮
    UIButton *disagree = [[UIButton alloc]init];
    disagree.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:246/255.0 alpha:1.0];
    [disagree setTitle:@"不同意并退出" forState:UIControlStateNormal];
    [disagree setTitleColor:[UIColor colorWithRed:155/255.0 green:153/255.0 blue:169/255.0 alpha:1.0] forState:UIControlStateNormal];
    disagree.titleLabel.font = [UIFont systemFontOfSize:14];
    disagree.layer.cornerRadius = 20;
    [disagree addTarget:self action:@selector(clickdisagree) forControlEvents:(UIControlEventTouchUpInside)];
    [contentDView addSubview:disagree];
    
    //同意按钮
    UIButton *agree = [[UIButton alloc]init];
    agree.backgroundColor = UIColor.orangeColor;
    [agree setTitle:@"同意" forState:UIControlStateNormal];
    [agree setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    agree.layer.cornerRadius = 20;
    [agree addTarget:self action:@selector(clickRemove) forControlEvents:(UIControlEventTouchUpInside)];
    [contentDView addSubview:agree];
    
    
    [agree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentDView).mas_equalTo(-16);
        make.left.equalTo(disagree.mas_right).mas_equalTo(11);
        make.bottom.equalTo(contentDView).mas_equalTo(-24);
        make.width.equalTo(disagree);
        make.height.mas_equalTo(38);
    }];
    
   
    [disagree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentDView).mas_equalTo(15);
        make.right.equalTo(agree.mas_left).mas_equalTo(-11);
        make.bottom.equalTo(contentDView).mas_equalTo(-24);
        make.width.equalTo(agree);
        make.height.mas_equalTo(38);
    }];

    //标题
    UILabel *titleDLabel = [[UILabel alloc]init];
    [titleDLabel setText:@"欢迎使用XXXAPP"];
    titleDLabel.font = [UIFont systemFontOfSize:18];
    [titleDLabel setTextColor:UIColor.blackColor];
    [contentDView addSubview:titleDLabel];
    [titleDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentDView).mas_equalTo(16);
        make.top.equalTo(contentDView).mas_equalTo(10);
        make.width.mas_equalTo(20*9);
        make.height.mas_equalTo(30);
    }];
    
    NSString *str1 = @"在你使用XXXAPP前，请你认真阅读并了解";
    NSString *str2 = @"《1嘻嘻哈哈走你服务协议》";
    NSString *str3 = @"《2嘻嘻哈哈走你隐私政策》";
    NSString *str4 = @"《3嘻嘻哈哈走你服务协议》";
    NSString *str5 = @"《4嘻嘻哈哈走你67隐私协议》";
    NSString *str6 = @"点击“同意”即表示你已阅读并同意全部条款。";
    NSString *str = [NSString stringWithFormat:@"%@%@、%@、%@、%@，%@",str1,str2,str3,str4,str5,str6];
    NSRange range1 = [str rangeOfString:str1];
    NSRange range2 = [str rangeOfString:str2];
    NSRange range3 = [str rangeOfString:str3];
    NSRange range4 = [str rangeOfString:str4];
    NSRange range5 = [str rangeOfString:str5];
    NSRange range6 = [str rangeOfString:str6];

    UITextView *textView = [[UITextView alloc] init];
    textView.editable = NO;
    textView.delegate = self;
    for(UIGestureRecognizer *recognizer in textView.gestureRecognizers)
    {
        if([NSStringFromClass([recognizer class]) isEqualToString:@"UITextTapRecognizer"] || [NSStringFromClass([recognizer class]) isEqualToString:@"UITapAndAHalfRecognizer"]) {
            recognizer.enabled=NO;
        }
        if ([recognizer isKindOfClass:[UILongPressGestureRecognizer class]]){
            recognizer.enabled = NO;
        }
    }
    UILongPressGestureRecognizer *longRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longBangClick)];
    longRecognizer.delegate = self;
    [textView addGestureRecognizer:longRecognizer];
    
    [contentDView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentDView).mas_equalTo(10);
        make.right.equalTo(contentDView).mas_equalTo(-10);
        make.top.equalTo(titleDLabel.mas_bottom).mas_equalTo(8);
        make.bottom.equalTo(contentDView).mas_equalTo(-60);
    }];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;     //行间距
    NSMutableAttributedString *mastring = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f],NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:paragraphStyle}];

    
    [mastring beginEditing];
    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range2];
    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range3];
    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range4];
    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range5];
    NSString *valueString2 = [@"https://www.baidu1.com" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString *valueString3 = [@"https://www.baidu2.com" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString *valueString4 = [@"https://www.baidu3.com" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString *valueString5 = [@"https://www.baidu4.com" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [mastring addAttribute:NSLinkAttributeName value:valueString2 range:range2];
    [mastring addAttribute:NSLinkAttributeName value:valueString3 range:range3];
    [mastring addAttribute:NSLinkAttributeName value:valueString4 range:range4];
    [mastring addAttribute:NSLinkAttributeName value:valueString5 range:range5];
    [mastring endEditing];
    textView.attributedText = mastring;
    [textView sizeToFit];
    textView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor orangeColor]};

}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer*) gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*) otherGestureRecognizer{
//
//    if([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] && [NSStringFromClass([otherGestureRecognizer class])isEqualToString:@"UITextTapRecognizer"]){
//        return NO;
//    }
//    return YES;
//}
//重写此方法，来控制 UIMenuItem 的显示和隐藏
//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    return NO;
//}

- (void)removeAlertView{
    [self.backgroundView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)longBangClick{
    NSLog(@"使用自定义长按代替禁止长按效果");
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    //根据需求点击链接后跳转内部浏览器删除自身View
//    [self.backgroundView removeFromSuperview];
//    [self removeFromSuperview];
    NSLog(@"点击链接：url:%@",URL);
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"firstValue"];
    //内部做app跳转 返回NO,跳转外部浏览器 返回YES
    return NO;
}
//同意
- (void)clickRemove{
    [self removeAlertView];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstValue"];
    self.selectedData(YES);

}
//不同意
- (void)clickdisagree{
    [self removeAlertView];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"firstValue"];
    NSLog(@"退出程序");
    self.selectedData(NO);
    exit(0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
