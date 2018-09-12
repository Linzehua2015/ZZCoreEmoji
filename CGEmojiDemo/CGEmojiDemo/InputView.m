//
//  InputView.m
//  CGEmojiDemo
//
//  Created by 林泽华 on 2018/9/10.
//  Copyright © 2018 林泽华. All rights reserved.
//

#import "InputView.h"

@interface InputView ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, copy) ConfirmBlock confirmBlock;

@end

@implementation InputView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.text = self.string;
}

- (void)confirmBlock:(ConfirmBlock)confirmBlock {
    self.confirmBlock = confirmBlock;
}

- (IBAction)confirmAction:(id)sender {
    if (self.confirmBlock) {
        self.confirmBlock(self.textView.text);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
