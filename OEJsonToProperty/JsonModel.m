//
//  JsonModel.m
//  xTextHandler
//
//  Created by gaof on 2016/11/1.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "JsonModel.h"


@implementation JsonModel

-(instancetype)initWithKey:(NSString *)key value:(id)value {
    self = [super init];
    if (self) {
        self.propertyName = key;
        self.propertyClass = [self convertClassName:value];
    }
    return self;
}
- (NSString *)convertClassName:(id)value {
    if ([value isKindOfClass:[NSString class]]) {
        return @"@property (nonatomic,strong) NSString *";
    }
    
    else if ([value isKindOfClass:[NSNumber class]]) {
        return @"@property (nonatomic,assign) NSArray *";
    }
    else if ([value isKindOfClass:[NSArray class]]) {
        return @"@property (nonatomic,strong) NSArray *";
    }
    else {
        return @"@property (nonatomic,strong) <#ClassName#>";
    }
}
@end
