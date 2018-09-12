//
//  InputView.h
//  CGEmojiDemo
//
//  Created by 林泽华 on 2018/9/10.
//  Copyright © 2018 林泽华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ConfirmBlock)(NSString *string);

@interface InputView : UIViewController

@property (nonatomic, copy) NSString *string;
- (void)confirmBlock:(ConfirmBlock)confirmBlock;

@end
