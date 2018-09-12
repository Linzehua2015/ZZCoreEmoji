//
//  ZZMatterView.m
//  EmojiWorld
//
//  Created by LinZehua on 2018/9/5.
//  Copyright © 2018 LH. All rights reserved.
//

#import "ZZMatterView.h"
#import "ZZPointUtil.h"

@interface ZZMatterView ()

@property (nonatomic, assign) CGFloat wScale;
@property (nonatomic, assign) CGFloat hScale;

@end

@implementation ZZMatterView

- (instancetype)initWithImage:(UIImage *)image
                       center:(CGPoint)center
                   attributes:(ZZTextAttributes *)attributes
{
    self = [super init];
    if (self) {
        self.textAttributes = attributes;
        _type = ZZMatterTypeText;
        [self reloadDataWithImage:image center:center];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
                       center:(CGPoint)center 
{
    self = [super init];
    if (self) {
        _type = ZZMatterTypeIcon;
        [self reloadDataWithImage:image center:center];
    }
    return self;
}

- (void)reloadDataWithImage:(UIImage *)image {
    [self reloadDataWithImage:image center:self.center];
}

- (void)reloadDataWithImage:(UIImage *)image center:(CGPoint)center {
    self.zz_image = image;
    if (image.images.count > 0) {
        self.zz_images = image.images;
    } else {
        self.zz_images = @[image];
    }
    
    // 根据image设置UIView的frame
    CGFloat scale = 0.5;
    CGFloat width = image.size.width * scale;
    CGFloat height = image.size.height * scale;
    self.bounds = CGRectMake(0, 0, width, height);
    self.center = center;
    
    // 获取对角线长度length，设置 w/l h/l 的比例。
    [self initLastLength];
    
    if (!self.imageView) {
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
    }
    self.imageView.frame = CGRectMake(0, 0, width, height);
    self.imageView.image = image;
    
    
    self.angle = atan2(self.frame.origin.y+self.frame.size.height - self.center.y,
                       self.frame.origin.x+self.frame.size.width - self.center.x) ;
}

- (void)initLastLength {
    CGPoint point = CGPointMake(self.bounds.size.width, self.bounds.size.height);
    self.lastLength = ZZPointDistance(CGPointZero, point);
    self.wScale = self.bounds.size.width / self.lastLength;
    self.hScale = self.bounds.size.height / self.lastLength;
}

- (void)resetSizeWithLength:(CGFloat)length {
    length = MAX(30, length);
    CGFloat width = self.wScale * length;
    CGFloat height = self.hScale * length;
    self.bounds = CGRectMake(0, 0, width, height);
}

#pragma mark - Set

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    self.imageView.frame = bounds;
}

@end
