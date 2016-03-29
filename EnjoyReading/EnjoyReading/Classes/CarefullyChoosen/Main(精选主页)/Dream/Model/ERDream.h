//
//  ERDream.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/16.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERDream : NSObject
//"title":"梦见掉牙流血","content":"<div>孕妇梦见掉牙流血，是预示将要生产。<br/>孕妇梦见自己掉牙流血，是不吉之兆。有做此梦的孕妇平常要多加小心，多关注宝宝的健康，预防流产。<br/>孕妇做梦梦见别人掉牙流血，代表孕妇近日心理有些焦虑，担心宝宝的安危。<br/>孕妇做梦梦见家人掉牙流血，是暗示家里可能会有不好的时发生，如会有丧事等。做此梦孕妇要多关心家人。<br/>孕妇梦见朋友掉牙流血，是预示该朋友近期会有困难出现，提醒他要多注意。   </div>","type":"其他类"

/**  关键字 */
@property (nonatomic, copy) NSString *title;
/**  内容 */
@property (nonatomic, copy) NSString *content;

/**  cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
