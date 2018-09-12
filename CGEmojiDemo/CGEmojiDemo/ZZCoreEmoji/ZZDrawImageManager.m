//
//  ZZDrawImageManager.m
//  EmojiWorld
//
//  Created by LinZehua on 2018/9/5.
//  Copyright © 2018 LH. All rights reserved.
//

#import "ZZDrawImageManager.h"
#import "ZZMatterView.h"

@implementation ZZDrawImageManager

// 合成图片
- (void)drawImageWithOptions:(ZZDrawImageOptions *)options
                    complete:(void(^)(UIImage *image))complete
{
    UIImage *originalImage = options.originalImage;
    CGSize size = originalImage.size;
    
    NSMutableArray<UIImage *> *images = originalImage.images.mutableCopy;
    if (images.count == 0) {
        images = @[originalImage].mutableCopy;
    }
     
    // 生成一张透明背景图 在透明背景图上贴上素材
    UIImage *matterImage = [self imageWithView:options.matterViews.firstObject.superview];
    
    /* 方案2
    // 生成一张透明背景图 在透明背景图上贴上素材
    NSMutableArray<UIImage *> *masterImages = @[].mutableCopy;
    for (NSInteger i = 0; i < images.count; i++) {
        for (ZZMatterView *matterView in options.matterViews) {
            matterView.imageView.image = matterView.zz_images[i % matterView.zz_images.count];
            UIImage *image = [self imageWithView:options.matterViews.firstObject.superview];
            [masterImages addObject:image];
        }
    }
    for (ZZMatterView *matterView in options.matterViews) {
        matterView.imageView.image = matterView.zz_image;
    }
    */
    
    // 使用队列组，异步多图片进行重绘
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("com.zz.diy_queue", DISPATCH_QUEUE_CONCURRENT);
    // 使用信号量控制写入操作并发数
    dispatch_semaphore_t sema = dispatch_semaphore_create(1);
    
    
    // 开始往gif的每一帧图片上贴上素材
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    for (NSInteger i = 0; i < images.count; i++) {
        dispatch_group_async(group, queue, ^{
            UIImage *image = images[i];
            
            UIGraphicsBeginImageContextWithOptions(size, NO, 1.0f);
            
            [image drawInRect:rect];
            // 方案2
            // [masterImages[i] drawInRect:rect];
            // 方案1
            [matterImage drawInRect:rect];
            
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            images[i] = UIGraphicsGetImageFromCurrentImageContext();
            dispatch_semaphore_signal(sema);
            
            UIGraphicsEndImageContext();
        });
    }
    
    // 所有任务完成后调用
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        UIImage *finalImage = [UIImage animatedImageWithImages:images duration:originalImage.duration];
        complete(finalImage);
    });
}

- (UIImage *)imageWithView:(UIView *)view {
    CGSize size = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
