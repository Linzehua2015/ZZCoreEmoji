//
//  ZZDrawImageManager.h
//  EmojiWorld
//
//  Created by LinZehua on 2018/9/5.
//  Copyright © 2018 LH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZDrawImageOptions.h"

@interface ZZDrawImageManager : NSObject

- (void)drawImageWithOptions:(ZZDrawImageOptions *)options
                    complete:(void(^)(UIImage *image))complete;

@end
