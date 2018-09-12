//
//  ZZMatterView.h
//  EmojiWorld
//
//  Created by LinZehua on 2018/9/5.
//  Copyright © 2018 LH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZZMatterType) {
    ZZMatterTypeText,
    ZZMatterTypeIcon
};

@class ZZTextAttributes;
@interface ZZMatterView : UIView

@property (nonatomic, weak) UIImage *zz_image; // 指向实际素材
@property (nonatomic, copy) NSArray<UIImage *> *zz_images;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign, readonly) ZZMatterType type;
@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, strong) ZZTextAttributes *textAttributes; // 类型为ZZMatterTypeText的时候这个属性才有值

@property (nonatomic, assign) CGFloat lastLength; // 记录上次对角线的长度

// 创建文本素材
- (instancetype)initWithImage:(UIImage *)image
                       center:(CGPoint)center
                   attributes:(ZZTextAttributes *)attributes;
// 创建图片素材
- (instancetype)initWithImage:(UIImage *)image
                       center:(CGPoint)center;

- (void)reloadDataWithImage:(UIImage *)image;

- (void)initLastLength;
- (void)resetSizeWithLength:(CGFloat)length;

@end
