//
//  ViewController.m
//  CGEmojiDemo
//
//  Created by 林泽华 on 2018/9/6.
//  Copyright © 2018 林泽华. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "ResultVC.h"
#import "InputView.h"

#import "ZZCoreEmoji.h"

@interface ViewController () <ZZCanvasViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *canvasViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *canvasViewHeight;

@property (weak, nonatomic) IBOutlet ZZCanvasView *canvasView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.canvasView.delegate = self;
    __weak typeof(self) weakSelf = self;
    NSString *str = @"https://ws2.sinaimg.cn/large/9150e4e5gw1fbsjbe9lf8g208w06qnpb.gif";
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:str]
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
    {
        weakSelf.canvasViewWidth.constant = image.size.width;
        weakSelf.canvasViewHeight.constant = image.size.height;
    }];
    
    
    // -----图片-----
    ZZMatterView *mView = [[ZZMatterView alloc]
                           initWithImage:[UIImage imageNamed:@"panda"]
                           center:CGPointMake(200, 200)];
    [self.canvasView addSubview:mView];
    [self.canvasView.matterViews addObject:mView];
    self.canvasView.currentView = mView;
    
    // -----文本-----
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
}


#pragma mark - ZZCanvasViewDelegate

- (void)ZZCanvasView:(ZZCanvasView *)canvasView
         doubleTapMatter:(ZZMatterView *)matterView
{
    __weak typeof(self) weakSelf = self;
    ZZTextAttributes *attributes = matterView.textAttributes;
    NSString *text = attributes.text;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    InputView *inputView = [sb instantiateViewControllerWithIdentifier:@"InputView"];
    inputView.string = text;
    [inputView confirmBlock:^(NSString *string) {
        // 获取到新的文案
        attributes.text = string;
        UIImage *img = [UIImage zz_imageWithAttributes:attributes];
        [matterView reloadDataWithImage:img];
        [weakSelf.canvasView reloadSelectedView];
    }];
    [self presentViewController:inputView animated:YES completion:nil];
}

#pragma mark - Button

- (IBAction)designAction:(id)sender {
    
    
    self.canvasView.currentView = nil;
    
    ZZDrawImageOptions *options = [[ZZDrawImageOptions alloc]
                                   initWithCanvasView:self.canvasView
                                   originalImage:self.iconView.image
                                   matterViews:self.canvasView.matterViews];
    
    ZZDrawImageManager *manager = [ZZDrawImageManager new];
    __weak typeof(self) weakSelf = self;
    [manager drawImageWithOptions:options complete:^(UIImage *image) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ResultVC *resultVC = [sb instantiateViewControllerWithIdentifier:@"ResultVC"];
        resultVC.image = image;
        [weakSelf presentViewController:resultVC animated:YES completion:nil];
    }];
}

- (IBAction)upAction:(id)sender {
    [self.canvasView upCurrentMatter];
}

- (IBAction)downAction:(id)sender {
    [self.canvasView downCurrentMatter];
}

@end
