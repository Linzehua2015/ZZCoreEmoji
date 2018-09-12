#使用方法

1、在头部导入 #import "ZZCoreEmoji.h" 

2、创建一个画布、在画布上创建素材。

素材支持移动、旋转、缩放、文字素材支持双击替换文字、并且可以自定义文字样式。


![效果](https://upload-images.jianshu.io/upload_images/2083012-5f1e3c7a863d715a.gif?imageMogr2/auto-orient/strip)

 
```
    // -----图片素材-----
    ZZMatterView *mView = [[ZZMatterView alloc]
                           initWithImage:[UIImage imageNamed:@"panda"]
                           center:CGPointMake(200, 200)];
    [self.canvasView addSubview:mView];
    [self.canvasView.matterViews addObject:mView];

    // -----文本素材-----
    ZZTextAttributes *attributes = [[ZZTextAttributes alloc]
                                    initWithText:@"哈哈哈\n呵呵额"
                                    font:[UIFont systemFontOfSize:40]
                                    textColor:[UIColor redColor]
                                    borderColor:[UIColor yellowColor]];
    UIImage *textImage = [UIImage zz_imageWithAttributes:attributes];
    mView = [[ZZMatterView alloc] initWithImage:textImage
                                         center:CGPointMake(100, 100)
                                           attributes:attributes];
    [self.canvasView addSubview:mView];
    [self.canvasView.matterViews addObject:mView];
```

图片制作方法调用

```
    // 制作图片
    self.canvasView.currentView = nil;
    
    ZZDrawImageOptions *options = [[ZZDrawImageOptions alloc]
                                   initWithCanvasView:self.canvasView
                                   originalImage:self.iconView.image
                                   matterViews:self.canvasView.matterViews];
    
    ZZDrawImageManager *manager = [ZZDrawImageManager new];
    __weak typeof(self) weakSelf = self;
    [manager drawImageWithOptions:options complete:^(UIImage *image) {

    }];
    
```

大致架构设计

![image.png](https://upload-images.jianshu.io/upload_images/2083012-732d556a4dd44962.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/640)

Demo地址：https://github.com/Linzehua2015/ZZCoreEmoji
