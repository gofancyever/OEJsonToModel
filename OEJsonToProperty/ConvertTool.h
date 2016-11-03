//
//  ConvertTool.h
//  xTextHandler
//
//  Created by gaof on 2016/11/1.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConvertTool : NSObject

+ (instancetype)shareTool;

/**通过字转换所需属性模型*/
-(NSArray *)convertWithDict:(NSDictionary *)dict;

/**
 *  检查是否是一个有效的JSON
 */
-(id)dictionaryWithJsonStr:(NSString *)jsonString;

- (NSString *)dealClassNameWithJsonResult:(id)result;
@end
