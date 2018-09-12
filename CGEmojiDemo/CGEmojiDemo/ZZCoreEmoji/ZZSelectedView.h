//
//  ZZSelectedView.h
//  CGEmojiDemo
//
//  Created by LinZehua on 2018/9/9.
//  Copyright © 2018 林泽华. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZSelectedView;
@protocol ZZSelectedViewDelegate <NSObject>
- (void)zzSelectedView:(ZZSelectedView *)selectedView clickClose:(UIButton *)button;
- (void)zzSelectedView_doubleTap:(ZZSelectedView *)selectedView; // 用户双击事件
@end

@interface ZZSelectedView : UIView

@property (nonatomic, weak) id<ZZSelectedViewDelegate> delegate;

- (void)hideButtons;
- (void)showButtons;

@end
