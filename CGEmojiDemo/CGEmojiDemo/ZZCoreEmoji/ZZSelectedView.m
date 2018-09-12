//
//  ZZSelectedView.m
//  CGEmojiDemo
//
//  Created by LinZehua on 2018/9/9.
//  Copyright © 2018 林泽华. All rights reserved.
//

#import "ZZSelectedView.h"

@interface ZZSelectedView ()

@property (nonatomic, strong) UIView *left;
@property (nonatomic, strong) UIView *right;
@property (nonatomic, strong) UIView *top;
@property (nonatomic, strong) UIView *bottom;

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *sizeButton;

@end

@implementation ZZSelectedView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.left = [[UIView alloc] init];
        self.left.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.left];
        
        self.right = [[UIView alloc] init];
        self.right.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.right];
        
        self.top = [[UIView alloc] init];
        self.top.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.top];
        
        self.bottom = [[UIView alloc] init];
        self.bottom.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bottom];
        
        self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.closeButton setImage:[UIImage imageNamed:@"zz_close"] forState:UIControlStateNormal];
        [self addSubview:self.closeButton];
        [self.closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.sizeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.sizeButton setImage:[UIImage imageNamed:@"zz_size"] forState:UIControlStateNormal];
        [self addSubview:self.sizeButton];
        [self.sizeButton addTarget:self action:@selector(sizeAction) forControlEvents:UIControlEventTouchUpInside];
        self.sizeButton.userInteractionEnabled = NO;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(doubleTapGetsure:)];
        tapGesture.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

#pragma mark - Public

- (void)hideButtons {
    self.closeButton.hidden = YES;
    self.sizeButton.hidden = YES;
}

- (void)showButtons {
    self.closeButton.hidden = NO;
    self.sizeButton.hidden = NO;
}

#pragma mark - Gesture

- (void)doubleTapGetsure:(UITapGestureRecognizer *)tap {
    // 双击事件
    if (self.delegate && [self.delegate respondsToSelector:@selector(zzSelectedView_doubleTap:)]) {
        [self.delegate zzSelectedView_doubleTap:self];
    }
    [self showButtons];
}

#pragma mark - Button

- (void)closeAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(zzSelectedView:clickClose:)]) {
        [self.delegate zzSelectedView:self clickClose:button];
    }
}

- (void)sizeAction {
}

#pragma mark - Set

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    CGFloat thick = 2;
    CGFloat interval = 11;
    CGFloat width = CGRectGetWidth(frame) - interval * 2 + thick;
    CGFloat height = CGRectGetHeight(frame) - interval * 2 + thick;
    CGFloat leftX = interval - thick * 0.5;
    CGFloat topY = interval - thick * 0.5;
    CGFloat rightX = CGRectGetWidth(frame) - interval + thick * 0.5;
    CGFloat bottomY = CGRectGetHeight(frame) - interval + thick * 0.5;
    self.left.frame = CGRectMake(leftX, topY, thick, height);
    self.top.frame = CGRectMake(leftX, topY, width, thick);
    self.right.frame = CGRectMake(rightX, topY, thick, height);
    self.bottom.frame = CGRectMake(leftX, bottomY, width + thick, thick);
    
    self.closeButton.frame = CGRectMake(0, 0, 22, 22);
    self.sizeButton.frame = CGRectMake(CGRectGetWidth(frame) - 22, CGRectGetHeight(frame) - 22, 22, 22);
}

@end
