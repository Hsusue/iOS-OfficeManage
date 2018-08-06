//
//  AcceptedFileUtils.m
//  OfficeManage
//
//  Created by Hsusue on 2018/8/5.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#import "AcceptedFileManager.h"

@implementation FileModel

@end

@implementation AcceptedFileManager


// 获取文件列表（降序）
- (NSArray *)getFileListInFolder {
    
    NSString *directory = [self getInboxPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 遍历目录
    // 获取目录下文件数组 只会返回文件名哭唧唧
    NSArray *paths = [fileManager subpathsAtPath:directory];
    // 转换成 文件属性 数组
    NSMutableArray *filePropertyArray = [NSMutableArray array];
    for (NSString *fileName in paths) {
        // 获取文件全路径
        NSString *fileUrl = [directory stringByAppendingPathComponent:fileName];
        // 获取文件信息 这字典没有文件名哭唧唧
        /*
         NSFileCreationDate = "2018-08-05 08:06:17 +0000";
         NSFileExtensionHidden = 0;
         NSFileGroupOwnerAccountID = 20;
         NSFileGroupOwnerAccountName = staff;
         NSFileModificationDate = "2018-08-05 08:06:17 +0000";
         NSFileOwnerAccountID = 501;
         NSFilePosixPermissions = 420;
         NSFileReferenceCount = 1;
         NSFileSize = 38587;
         NSFileSystemFileNumber = 8597377995;
         NSFileSystemNumber = 16777221;
         NSFileType = NSFileTypeRegular;
         */
        NSDictionary *fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:fileUrl error:nil];
        
        // 换成模型 既要名字又要字典
        FileModel *model = [[FileModel alloc] init];
        model.fileName = fileName;
        model.fileExtension = [fileName pathExtension];
        model.fileFullPath = fileUrl;
        model.fileProperty = fileInfo;
        // 添加到 文件属性 数组中
        [filePropertyArray addObject:model];
    }
    
    // 对文件按照时间进行排序
    NSArray *sortedPaths = [filePropertyArray sortedArrayUsingComparator:^(FileModel * firstModel, FileModel* secondModel) {
        id firstData = [firstModel.fileProperty objectForKey:NSFileModificationDate];//获取前一个文件修改时间
        id secondData = [secondModel.fileProperty objectForKey:NSFileModificationDate];//获取后一个文件修改时间
        //        return [firstData compare:secondData];//升序
        return [secondData compare:firstData];//降序
    }];
    return sortedPaths;
}


// 获取文件全路径
- (NSString *)getFileFullPathWithFileName:(NSString *)fileName {
    // 拼接路径
    NSString *directoryPath = [self getInboxPath];
    NSString *filePath = [directoryPath stringByAppendingPathComponent:fileName];
    
    return filePath;
}

// 删除文件
- (void)deleteFileWithName:(NSString*)fileName {
    // 获取全路路径
    NSString *filePath = [self getFileFullPathWithFileName:fileName];
    
    //删除文件
    BOOL isSuccess = [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    if (isSuccess) {
        NSLog(@"删除文件成功");
    }else{
        NSLog(@"删除文件失败");
    }
    
}


// 获取/Documents/Inbox路径
- (NSString *)getInboxPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"Inbox"];
}

@end
