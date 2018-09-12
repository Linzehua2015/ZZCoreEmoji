//
//  ZZCanvasView.m
//  CGEmojiDemo
//
//  Created by LinZehua on 2018/9/8.
//  Copyright © 2018 林泽华. All rights reserved.
//

#import "ZZCanvasView.h"
#import "ZZMatterView.h"
#import "ZZSelectedView.h"
#import "ZZPointUtil.h"

@interface ZZCanvasView () <UIGestureRecognizerDelegate, ZZSelectedViewDelegate>

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint startMatterCenter;
@property (nonatomic, assign) CGPoint startSizeViewCenter;

@property (nonatomic, strong) ZZSelectedView *selectedView;
@property (nonatomic, assign) BOOL isTouchDownSize;

@end

@implementation ZZCanvasView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.masksToBounds = YES;
    self.selectedView.delegate = self;
    
    // 添加旋转手势+缩放手势
    UIRotationGestureRecognizer *rotateGesute = [[UIRotationGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(rotateGesture:)];
    rotateGesute.delegate = self;
    [self addGestureRecognizer:rotateGesute];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(pinchGesture:)];
    pinchGesture.delegate = self;
    [self addGestureRecognizer:pinchGesture];
}

// 判断点击事件是否点击在更改尺寸按钮上
- (BOOL)isTouchInSizeButtonWithTouch:(UITouch *)touch {
    ZZMatterView *matter = self.currentView;
    CGPoint sizeViewCenter = CGPointMake(matter.bounds.size.width, matter.bounds.size.height);
    self.startSizeViewCenter = [matter convertPoint:sizeViewCenter toView:self];
    CGPoint point = [touch locationInView:matter];
    CGRect rect = CGRectMake(matter.bounds.size.width - 11, matter.bounds.size.height - 11, 22, 22);
    return CGRectContainsPoint(rect, point);
}

#pragma mark - Public

- (void)upCurrentMatter {
    if (!self.currentView) return;
    // 当前view与上一个view替换
    NSInteger index = [self.matterViews indexOfObject:self.currentView];
    if (index == self.matterViews.count - 1) return;
    NSInteger tergetIndex = index + 1;
    UIView *targetView = self.matterViews[tergetIndex];
    [self insertSubview:self.currentView aboveSubview:targetView];
    [self.matterViews exchangeObjectAtIndex:index withObjectAtIndex:tergetIndex];
}

- (void)downCurrentMatter {
    if (!self.currentView) return;
    // 当前view与下一个view替换
    NSInteger index = [self.matterViews indexOfObject:self.currentView];
    if (index == 0) return;
    NSInteger tergetIndex = index - 1;
    UIView *targetView = self.matterViews[tergetIndex];
    [self insertSubview:self.currentView belowSubview:targetView];
    [self.matterViews exchangeObjectAtIndex:index withObjectAtIndex:tergetIndex];
}

- (void)reloadSelectedView {
    if (self.currentView) {
        // 设置当前选中 标记
        self.selectedView.transform = CGAffineTransformMakeRotation(0);
        CGFloat width = self.currentView.bounds.size.width + 22;
        CGFloat height = self.currentView.bounds.size.height + 22;
        self.selectedView.frame = CGRectMake(0, 0, width, height);
        self.selectedView.center = self.currentView.center;
        self.selectedView.transform = self.currentView.transform;
        [self addSubview:self.selectedView];
    } else {
        [self.selectedView removeFromSuperview];
    }
}

#pragma mark - ZZSelectedViewDelegate

- (void)zzSelectedView:(ZZSelectedView *)selectedView clickClose:(UIButton *)button {
    [self.currentView removeFromSuperview];
    [self.matterViews removeObject:self.currentView];
    self.currentView = nil;
}

- (void)zzSelectedView_doubleTap:(ZZSelectedView *)selectedView {
    if (!self.currentView) return;
    if (self.currentView.type == ZZMatterTypeText) {
        // 编辑文字
        if (self.delegate && [self.delegate respondsToSelector:@selector(ZZCanvasView:doubleTapMatter:)]) {
            [self.delegate ZZCanvasView:self doubleTapMatter:self.currentView];
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - Gesture

- (void)rotateGesture:(UIRotationGestureRecognizer *)rotateGesture {
    
    if (!self.currentView) return;
    
    UIView *view = self.currentView;
    if (rotateGesture.state == UIGestureRecognizerStateBegan ||
        rotateGesture.state == UIGestureRecognizerStateChanged)
    {
        view.transform = CGAffineTransformRotate(view.transform, rotateGesture.rotation);
        [rotateGesture setRotation:0];
    }
    [self reloadSelectedView];
    
    // 按钮状态切换
    if (rotateGesture.state == UIGestureRecognizerStateBegan) {
        [self.selectedView hideButtons];
    } else if (rotateGesture.state == UIGestureRecognizerStateEnded) {
        [self.selectedView showButtons];
    }
}


- (void)pinchGesture:(UIPinchGestureRecognizer *)pinchGesture {
    
    if (!self.currentView) return;
         
    if (pinchGesture.state == UIGestureRecognizerStateBegan ||
        pinchGesture.state == UIGestureRecognizerStateChanged)
    {
        CGFloat length = self.currentView.lastLength * pinchGesture.scale;
        [self.currentView resetSizeWithLength:length];
        [self reloadSelectedView];
        
    } else if (pinchGesture.state == UIGestureRecognizerStateEnded) {
        
        pinchGesture.scale = 1;
        [self.currentView initLastLength];
    }
    
    // 按钮状态切换
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        [self.selectedView hideButtons];
    } else if (pinchGesture.state == UIGestureRecognizerStateEnded) {
        [self.selectedView showButtons];
    }
}


#pragma mark - 重写

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    self.startPoint = [touch locationInView:self]; // 用来计算偏移量
    
    // 记录当前焦点的view的center
    self.startMatterCenter = self.currentView.center;
    
    // 判断当前点中的是否是缩放按钮
    self.isTouchDownSize = [self isTouchInSizeButtonWithTouch:touch];
    
    // 隐藏按钮
    [self.selectedView hideButtons];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    CGFloat changeX = point.x - self.startPoint.x;
    CGFloat changeY = point.y - self.startPoint.y;
    
    if (self.isTouchDownSize) {
        
        ZZMatterView *matter = self.currentView;
        /* Size */
        CGFloat x = self.startSizeViewCenter.x + changeX;
        CGFloat y = self.startSizeViewCenter.y + changeY;
        CGPoint point = CGPointMake(x, y);
        CGFloat length = ZZPointDistance(matter.center, point) * 2;
        [matter resetSizeWithLength:length];
        
        /* Rotation */
        float ang = atan2(point.y - matter.center.y, point.x - matter.center.x);
        float angleDiff = matter.angle - ang;
        matter.transform = CGAffineTransformMakeRotation(-angleDiff);
        
    } else {
        
        /* Move */
        CGFloat x = self.startMatterCenter.x + changeX;
        CGFloat y = self.startMatterCenter.y + changeY;
        CGPoint center = CGPointMake(x, y);
        self.currentView.center = center;
        self.selectedView.center = center;
    }
    
    [self reloadSelectedView];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (self.isTouchDownSize) {
        
        // 记录当前的对角线长度
        [self.currentView initLastLength];
        
    } else {
        
        UITouch *touch = [touches anyObject];
        CGFloat x = ABS(self.startMatterCenter.x - self.currentView.center.x);
        CGFloat y = ABS(self.startMatterCenter.y - self.currentView.center.y);
        BOOL isSingleTap = x < 5 && y < 5;
        if (isSingleTap) {
            // 切换目标?
            BOOL isSwitch = NO;
            for (NSInteger i = self.matterViews.count - 1; i >= 0; i--) {
                ZZMatterView *matterView = self.matterViews[i];
                CGPoint point = [touch locationInView:matterView];
                if (CGRectContainsPoint(matterView.bounds, point)) {
                    self.currentView = matterView;
                    isSwitch = YES;
                    break;
                }
            }
            if (!isSwitch) {
                // 未找到可以响应点击事件的素材
                self.currentView = nil;
            }
        }
    }
    // 显示按钮
    [self.selectedView showButtons];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    // 显示按钮
    [self.selectedView showButtons];
}

#pragma mark - Set

- (void)setCurrentView:(ZZMatterView *)currentView {
    _currentView = currentView;
    [self reloadSelectedView];
}

#pragma mark - Get

- (ZZSelectedView *)selectedView {
    if (!_selectedView) {
        _selectedView = [[ZZSelectedView alloc] init];
    }
    return _selectedView;
}

- (NSMutableArray *)matterViews {
    if (!_matterViews) {
        _matterViews = @[].mutableCopy;
    }
    return _matterViews;
}

@end
