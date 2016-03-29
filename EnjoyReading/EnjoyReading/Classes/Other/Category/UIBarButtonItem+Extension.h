//
//  UIBarButtonItem+Extension.h
//  
//
//  Created by 王亮 on 15/11/9.
//  Copyright (c) 2015年 wangliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title  target:(id)target action:(SEL)action;

@end
