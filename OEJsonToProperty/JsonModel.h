//
//  JsonModel.h
//  xTextHandler
//
//  Created by gaof on 2016/11/1.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonModel : NSObject

-(instancetype)initWithKey:(NSString *)key value:(id)value;
@property (nonatomic,strong) NSString *propertyName;
@property (nonatomic,strong) NSString *propertyClass;

@end
