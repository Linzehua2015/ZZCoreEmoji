//
//  ZZDrawImageOptions.m
//  EmojiWorld
//
//  Created by LinZehua on 2018/9/5.
//  Copyright © 2018 LH. All rights reserved.
//

#import "ZZDrawImageOptions.h"

@implementation ZZDrawImageOptions

- (instancetype)initWithCanvasView:(UIView *)canvasView
                     originalImage:(UIImage *)originalImage
                       matterViews:(NSArray<ZZMatterView *> *)matterViews
{
    self = [super init];
    if (self) {
        _originalImage = originalImage;
        _matterViews = matterViews;
        _canvasView = canvasView;
    }
    return self;
}

@end
