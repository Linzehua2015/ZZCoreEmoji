//
//  ResultVC.m
//  CGEmojiDemo
//
//  Created by 林泽华 on 2018/9/7.
//  Copyright © 2018 林泽华. All rights reserved.
//

#import "ResultVC.h"

@interface ResultVC ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation ResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iconView.image = self.image;
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
