//
//  ZZDrawImageOptions.h
//  EmojiWorld
//
//  Created by LinZehua on 2018/9/5.
//  Copyright © 2018 LH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZMatterView;
@interface ZZDrawImageOptions : NSObject

// 原图
@property (nonatomic, strong, readonly) UIImage *originalImage;
// 素材所在的视图
@property (nonatomic, copy, readonly) NSArray<ZZMatterView *> *matterViews;
// 承载素材的视图
@property (nonatomic, weak, readonly) UIView *canvasView;

- (instancetype)initWithCanvasView:(UIView *)canvasView
                     originalImage:(UIImage *)originalImage
                       matterViews:(NSArray<ZZMatterView *> *)matterViews;

@end
