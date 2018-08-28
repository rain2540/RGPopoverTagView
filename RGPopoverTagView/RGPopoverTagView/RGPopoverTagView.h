//
//  RGPopoverTagView.h
//  RGPopoverTagView
//
//  Created by Rain on 2018/8/21.
//  Copyright © 2018年 Rain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RGPopoverTagView;

@protocol RGPopoverTagViewDelegate <NSObject>
@optional

- (void)popoverTagViewCancel:(RGPopoverTagView *)popoverTagView;

@end

@interface RGPopoverTagView : UIView

@property (nonatomic, weak) id<RGPopoverTagViewDelegate> delegate;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, assign) UIEdgeInsets tagPadding;
@property (nonatomic, assign) CGFloat tagCornerRadius;
@property (nonatomic, strong) UIFont *tagFont;
@property (nonatomic, assign) CGFloat tagBorderWidth;
@property (nonatomic, strong) UIColor *tagBgColor;
@property (nonatomic, strong) UIColor *tagBorderColor;
@property (nonatomic, strong) UIColor *tagTextColor;
@property (nonatomic, assign) BOOL tagEnable;

- (void)show;

@end
