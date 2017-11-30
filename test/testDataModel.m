//
//  testDataModel.m
//  test
//
//  Created by 韩钊 on 2017/11/17.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import "testDataModel.h"

@implementation testDataModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"name":@"name",
             @"doing":@"do",
             @"with":@"with",
             @"where":@"where"
             };
}

/**
 YYModle
 #把数组里面带有对象的类型专门按照这个方法，这个格式写出来

 @return YYModel
 */
/*
-(nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"photos"       : YYPhoto.class,
             @"likedUsers"   : YYUser.class,
             @"likedUserIds" : NSNumber.class
             };
}
 */

/*
 + (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
 
 return @{@"messageId":@"i",
 @"content":@"c",
 @"time":@"t"};
 }
 */


@end
