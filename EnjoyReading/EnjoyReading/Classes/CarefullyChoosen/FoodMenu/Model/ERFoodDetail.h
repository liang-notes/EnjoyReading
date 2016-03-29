//
//  ERFoodDetail.h
//  EnjoyReading
//
//  Created by 王亮 on 16/3/19.
//  Copyright (c) 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ERFoodDetail : NSObject
/**  标题 */
@property (nonatomic, copy) NSString *name;
/**  材料 */
@property (nonatomic, copy) NSString *food;
/**  描述 */
@property (nonatomic, copy) NSString *descrip;
/**  图片 */
@property (nonatomic, copy) NSString *img;
/**  内容 */
@property (nonatomic, copy) NSString *message;
/**  关键字 */
@property (nonatomic, copy) NSString *keywords;
/**  访问数 */
@property (nonatomic, copy) NSString *count;
/**  收藏数 */
@property (nonatomic, copy) NSString *fcount;
/**  回复数 */
@property (nonatomic, copy) NSString *rcount;

/**  cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

+ (instancetype)foodDetailWithDict:(NSDictionary *)dict;

//{"result":[{"id":111160,"food":"高粉,全麦粉,酵母粉,核桃","description":"小诀窍1、夏天天气热，用面包机揉面，面包机很容易出现高温而不工作了，这时可以选择把盖子打开散热，并且将一些液体材料事先在冰箱里降温；2、此面团无只要揉到面团光滑就可以了，不用计较有没有出很薄的膜","name":"无油低糖全麦核桃包","img":"http://api.avatardata.cn/Cook/Img?file=16df1759fbaf4ac186a0fa0a1a22a559.jpg","keywords":"面团 核桃 面包机 面包 发酵 ","message":"<h2>菜谱简介</h2><hr>      <h2>材料 </h2><hr>  \n<p>高粉280克，全麦粉20克，白糖15克，盐4克，安琪酵母粉6克，水200克，核桃90克。</p>   <h2>做法 </h2><hr>  \n<p>1、将生桃仁放入烤箱中层，150度烤10分钟。冷却后。将核桃掰成稍小的颗粒。 </p> \n<p>2、将高粉、全麦粉、白糖、盐、水、酵母揉成团，加入核桃碎继续揉，至表面光滑的面团。（这一步我是用面包机揉面，总共揉了三个二十分钟，在最后十分钟加入核桃碎）。 </p> \n<p>3、基本发酵至两倍大。 </p> \n<p>4、滚圆，松驰15分钟。 </p> \n<p>5、将面团擀成长椭圆形，翻面，卷成圆柱状，接缝捏紧，摆入烤盘。 </p> \n<p>6、视情况加盖保鲜膜，温暖处发酵至两倍大，均匀撒上全麦粉，再用刀割几个口。 </p> \n<p>7、烤箱预热，中层，上下管，180度30分钟。</p>   <h2>小诀窍</h2><hr>  \n<p>1、夏天天气热，用面包机揉面，面包机很容易出现高温而不工作了，这时可以选择把盖子打开散热，并且将一些液体材料事先在冰箱里降温； </p> \n<p>2、此面团无只要揉到面团光滑就可以了，不用计较有没有出很薄的膜。</p>","fcount":0,"rcount":0,"count":73}],"error_code":0,"reason":"Succes"}

@end
