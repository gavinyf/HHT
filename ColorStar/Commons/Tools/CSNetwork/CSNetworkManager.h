//
//  CSNetworkManager.h
//  ColorStar
//
//  Created by gavin on 2020/8/3.
//  Copyright © 2020 gavin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetResponseModel.h"

typedef void(^CSNetWorkSuccessCompletion)(CSNetResponseModel * response);
typedef void(^CSNetWorkFailureCompletion)(NSError * error);

NS_ASSUME_NONNULL_BEGIN

@interface CSNetworkManager : NSObject

+ (instancetype)sharedManager;

///首页数据
- (void)getHomeInfoSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;


///获取查看页面分类数据
- (void)getTopLevelCategoriesSuccessComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///获取查看页面二级分类数据
- (void)getSecondLevelCategoriesWithCategoryId:(NSString*)categoryId successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

///获取查看页面详细数据
- (void)getTopicListWithCategoryId:(NSString*)categoryId page:(NSInteger)page successComplete:(CSNetWorkSuccessCompletion)success failureComplete:(CSNetWorkFailureCompletion)failure;

@end

NS_ASSUME_NONNULL_END
