//
//  SourceEditorCommand.m
//  OEJsonToProperty
//
//  Created by apple on 2016/11/2.
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "SourceEditorCommand.h"
#import "ConvertTool.h"
#import "JsonModel.h"
@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
<<<<<<< Updated upstream
    NSString *text = [invocation.buffer.lines firstObject];
    id result = [[ConvertTool shareTool] dictionaryWithJsonStr:text];
=======
    
    
    XCSourceTextRange *selection = invocation.buffer.selections.firstObject;
    int start = (int)selection.start.line;
    int end  = (int)selection.end.line;
    
    NSMutableString *text = [NSMutableString string];
    
    for (int i=0; i<invocation.buffer.lines.count; i++) {
        NSLog(@"%ld",invocation.buffer.lines.count);
        if (end>=i && i>=start) {
            [text appendString:invocation.buffer.lines[i]];
            invocation.buffer.lines[i] = @"";
        }
    }
    id result = [self dictionaryWithJsonStr:text];
>>>>>>> Stashed changes
    if ([result isKindOfClass:[NSError class]]) {
        NSError *error = result;
        NSLog(@"Error：Json is invalid");
    }else{
<<<<<<< Updated upstream
        invocation.buffer.lines[0] = [[ConvertTool shareTool] dealClassNameWithJsonResult:result];
=======
        invocation.buffer.lines[start] = [self dealClassNameWithJsonResult:result];
>>>>>>> Stashed changes
    }
    completionHandler(nil);
}

<<<<<<< Updated upstream
=======
- (NSString *)dealClassNameWithJsonResult:(id)result {
    if ([result isKindOfClass:[NSDictionary class]]) {
        //遍历字典 生成对应属性
        ConvertTool *tool = [[ConvertTool alloc] init];
        NSArray *modelArr = [tool convertWithDict:result];
        NSMutableString *resultStr = [NSMutableString string];
        for (JsonModel *model in modelArr) {
            NSString *propertyStr = [NSString stringWithFormat:@"%@%@;\n",model.propertyClass,model.propertyName];
            [resultStr appendString:propertyStr];
        }
        return resultStr;
    }
    else if ([result isKindOfClass:[NSArray class]]) {
        return  @"";
    }
    else{
        return  @"";
    }
}
>>>>>>> Stashed changes



@end
