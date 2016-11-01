//
//  ViewController.m
//  JsonToModel
//
//  Created by apple on 2016/11/1.
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "ViewController.h"
#import "ConvertTool.h"
#import "JsonModel.h"
@interface ViewController ()

@property (weak) IBOutlet NSTextField *inputView;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}
- (IBAction)btnClick:(id)sender {
    NSString *text = self.inputView.stringValue;
    id result = [self dictionaryWithJsonStr:text];
    if ([result isKindOfClass:[NSError class]]) {
        NSError *error = result;
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
        NSLog(@"Error：Json is invalid");
    }else{
        [self dealClassNameWithJsonResult:result];
    }

}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

- (void)dealClassNameWithJsonResult:(id)result {
    if ([result isKindOfClass:[NSDictionary class]]) {
        //遍历字典 生成对应属性
        ConvertTool *tool = [[ConvertTool alloc] init];
        NSArray *modelArr = [tool convertWithDict:result];
        NSLog(@"%@",modelArr);
    }
    else if ([result isKindOfClass:[NSArray class]]) {
        
    }
    else{
        
    }
}

/**
 *  检查是否是一个有效的JSON
 */
-(id)dictionaryWithJsonStr:(NSString *)jsonString{
    jsonString = [[jsonString stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"jsonString=%@",jsonString);
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id dicOrArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                      error:&err];
    if (err) {
        return err;
    }else{
        return dicOrArray;
    }
    
}

@end
