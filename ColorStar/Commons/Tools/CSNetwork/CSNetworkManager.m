//
//  CSNetworkManager.m
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import "CSNetworkManager.h"
#import <AFNetworking.h>
#import <YYModel.h>

@interface CSNetworkManager ()

@property (nonatomic, strong)AFHTTPSessionManager  * netManager;

@end

static CSNetworkManager * manager = nil;
@implementation CSNetworkManager

+ (instancetype)sharedManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CSNetworkManager alloc]init];
    });
    return manager;
}


- (instancetype)init{
    if (self = [super init]) {
        self.netManager = [AFHTTPSessionManager manager];
        self.netManager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];
    }
    return self;
}


- (void)getHomeInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"https://color.ehxkc.com/wap/index/jsondata/api/all";
    
    [self netGetWithURL:url param:nil successComplete:success failureComplete:failure];
}


///获取查看页面分类数据
- (void)getTopLevelCategoriesSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"https://color.ehxkc.com/wap/special/jsondata/api/grade_cate.html";
    [self netGetWithURL:url param:nil successComplete:success failureComplete:failure];
    
    
}

///获取查看页面二级分类数据
- (void)getSecondLevelCategoriesWithCategoryId:(NSString*)categoryId successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"https://color.ehxkc.com/wap/special/jsondata/api/subject_cate";
    [self netGetWithURL:url param:@{@"grade_id":categoryId} successComplete:success failureComplete:failure];
    
}

///获取查看页面详细数据
- (void)getTopicListWithCategoryId:(NSString*)categoryId page:(NSInteger)page successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    
    NSString * url = @"https://color.ehxkc.com/wap/special/jsondata/api/special_list.html?subject_id=21&search=&page=1&limit=10";
    NSDictionary * param = @{@"subject_id":categoryId,@"search":@"",@"page":@(page),@"limit":@(10)};
    [self netGetWithURL:url param:param successComplete:success failureComplete:failure];
    
}


- (void)netGetWithURL:(NSString*)url param:(NSDictionary*)param successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure{
    [self.netManager GET:url parameters:param headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"---------------/n收到数据啦:%@-----------/n",responseObject);
        CSNetResponseModel * model = [CSNetResponseModel yy_modelWithDictionary:responseObject];
        if (success) {
            success(model);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"-----------/n失败啦:%@------------/n",error);
        if (failure) {
            failure(error);
        }
        
    }];
    
    
    
}

@end
