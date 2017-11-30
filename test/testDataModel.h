//
//  testDataModel.h
//  test
//
//  Created by 韩钊 on 2017/11/17.
//  Copyright © 2017年 韩钊. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface testDataModel : MTLModel<MTLJSONSerializing>

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *doing;
@property(nonatomic,copy) NSString *with;
@property(nonatomic,copy) NSString *where;

@end
