//
//  ZZCanvasView.h
//  CGEmojiDemo
//
//  Created by LinZehua on 2018/9/8.
//  Copyright © 2018 林泽华. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZMatterView, ZZCanvasView;
@protocol ZZCanvasViewDelegate<NSObject>
- (void)ZZCanvasView:(ZZCanvasView *)canvasView doubleTapMatter:(ZZMatterView *)matterView;
@end

@interface ZZCanvasView : UIView

@property (nonatomic, weak) ZZMatterView *currentView;
@property (nonatomic, strong) NSMutableArray<ZZMatterView *> *matterViews;
@property (nonatomic, weak) id<ZZCanvasViewDelegate> delegate;

- (void)upCurrentMatter;
- (void)downCurrentMatter;
- (void)reloadSelectedView;

@end
