//
//  RGPopoverTagView.m
//  RGPopoverTagView
//
//  Created by Rain on 2018/8/21.
//  Copyright © 2018年 Rain. All rights reserved.
//

#import "RGPopoverTagView.h"
#import "SKTagView.h"

@interface RGPopoverTagView ()

@property (nonatomic, strong) UILabel *titleView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIControl *overlayView;
@property (nonatomic, strong) SKTagView *tagView;

@end

@implementation RGPopoverTagView

#pragma mark Initializer
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultInit];
    }
    return self;
}

- (void)defaultInit {
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 1.0;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    self.titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleView.font = [UIFont systemFontOfSize:17.0f];
    self.titleView.backgroundColor = [UIColor whiteColor];
    
    self.titleView.textAlignment = NSTextAlignmentCenter;
    self.titleView.textColor = [UIColor blueColor];
    CGFloat xWidth = self.bounds.size.width;
    self.titleView.lineBreakMode = NSLineBreakByTruncatingTail;
    self.titleView.frame = CGRectMake(0, 0, xWidth, 57.0f);
    [self addSubview:self.titleView];
    
    CGRect scrollFrame = CGRectMake(0, 57.0f, xWidth, self.bounds.size.height - 57.0f);
    self.scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    [self addSubview:self.scrollView];
    
    self.overlayView = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    [self.overlayView addTarget:self
                     action:@selector(dismiss)
           forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark Setter
- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    
    [self.tagView removeAllTags];
    
    self.tagView = [[SKTagView alloc] init];
    // 整个tagView对应其SuperView的上左下右距离
    self.tagView.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    // 上下行之间的距离
    self.tagView.lineSpacing = 10;
    // item之间的距离
    self.tagView.interitemSpacing = 20;
    // 最大宽度
    self.tagView.preferredMaxLayoutWidth = 375;
    
    for (id obj in self.dataSource) {
        SKTag *tag = [[SKTag alloc] initWithText:obj];
        // 标签相对于自己容器的上左下右的距离
        tag.padding = self.tagPadding;//UIEdgeInsetsMake(10, 8, 10, 8);
        // 弧度
        tag.cornerRadius = self.tagCornerRadius;//20.f;
        // 字体
        tag.font = [UIFont boldSystemFontOfSize:12];
        // 边框宽度
        tag.borderWidth = self.tagBorderWidth;//0;
        // 背景
        tag.bgColor = self.tagBgColor;//[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        // 边框颜色
        tag.borderColor = self.tagBorderColor;//[UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
        // 字体颜色
        tag.textColor = self.tagTextColor;//[UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
        // 是否可点击
        tag.enable = self.tagEnable;//YES;
        // 加入到tagView
        [self.tagView addTag:tag];
    }
    
    __weak typeof(self) weakSelf = self;
    // 点击事件回调
    self.tagView.didTapTagAtIndex = ^(NSUInteger idx){
        NSLog(@"点击了第%ld个",idx);
        NSLog(@"%@", weakSelf.dataSource[idx]);
        [weakSelf dismiss];
    };
    
    // 获取刚才加入所有tag之后的内在高度
    CGFloat tagHeight = self.tagView.intrinsicContentSize.height;
    NSLog(@"高度%lf",tagHeight);
    self.tagView.frame = CGRectMake(0, CGRectGetMinY(self.scrollView.frame), self.bounds.size.width, tagHeight);
    [self.tagView layoutSubviews];
    self.scrollView.contentSize = self.tagView.intrinsicContentSize;
    [self.scrollView addSubview:self.tagView];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleView.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleView.textColor = titleColor;
}

#pragma mark - animations
- (void)fadeIn {
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)fadeOut {
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.overlayView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

- (void)show {
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:_overlayView];
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2.0f);
    [self fadeIn];
}

- (void)dismiss {
    [self fadeOut];
}

#define mark - UITouch
- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    // tell the delegate the cancellation
    if (self.delegate && [self.delegate respondsToSelector:@selector(popoverTagViewCancel:)]) {
        [self.delegate popoverTagViewCancel:self];
    }
    
    // dismiss self
    [self dismiss];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
