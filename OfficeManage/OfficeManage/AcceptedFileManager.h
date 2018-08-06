//
//  AcceptedFileUtils.h
//  OfficeManage
//
//  Created by Hsusue on 2018/8/5.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject

@property (copy, nonatomic) NSString *fileName;
@property (copy, nonatomic) NSString *fileExtension;
@property (copy, nonatomic) NSString *fileFullPath;
@property (copy, nonatomic) NSDictionary *fileProperty;

@end



@interface AcceptedFileManager : NSObject



/**
 获取文件列表

 @return 文件列表（按创建时间降序）
 */
- (NSArray *)getFileListInFolder;


///**
// 获取文件全路径
//
// @param fileName 文件名
// @return 文件全路径
// */
//- (NSString *)getFileFullPathWithFileName:(NSString *)fileName;

/**
 删除文件

 @param fileName 文件名
 */
- (void)deleteFileWithName:(NSString*)fileName;

/**
 获取/Documents/Inbox路径

 @return /Documents/Inbox路径
 */
- (NSString *)getInboxPath;


@end
