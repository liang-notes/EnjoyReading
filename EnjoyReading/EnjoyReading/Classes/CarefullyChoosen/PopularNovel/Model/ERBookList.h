//
//  ERBookList.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/23.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERBookList : NSObject
/**  书的唯一标识id */
@property (nonatomic, copy) NSString *id;

/**  封面 */
@property (nonatomic, copy) NSString *img;

/**  书名 */
@property (nonatomic, copy) NSString *name;

/**  简介 */
@property (nonatomic, copy) NSString *summary;

/**  作者 */
@property (nonatomic, copy) NSString *author;

/**  收藏数 */
@property (nonatomic, copy) NSString *count;

/**  高度 */
@property (nonatomic, assign) CGFloat cellHeight;

//{"id":1861,"img":"http://api.avatardata.cn/Book/Img?file=39f3aa6e1d4142f488d3d8edecd2646d.jpg","name":"时尚“折”学","bookclass":6,"summary":" 本书汇集了作者的80篇时尚短文，每篇写一种时尚现象或知识，每篇篇幅为1000字左右。每篇文章对应一张精美的时尚照片或插画。本书从时尚新闻、时尚知识等方面进行叙述与思考，深度思考时尚与人文之间的关系。文章风格幽默，运用了一些古代文风，调侃当今一些荒诞的时尚现象。比如标榜高贵奢华的时尚顶级品牌的打折现象、时尚人士虚伪的环保意识、以大牌为装扮狐假虎威的现象等。这类图书一方面可以让读者了解一些时尚运作的内幕，提高读者的时尚品味；另一方面也可以增加读者的谈资，容趣味性和知识型于一炉。读者以白领与大学生为主，以及一些想对时尚有兴趣的读者。","author":"梦亦非","rcount":0,"time":1438490059000,"fcount":0,"count":606}
@end
