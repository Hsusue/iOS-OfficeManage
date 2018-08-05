//
//  ViewController.m
//  OfficeManage
//
//  Created by Hsusue on 2018/8/5.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#import "ViewController.h"
#import "AcceptedFileManager.h"
#import "PreviewController.h"
#import <QuickLook/QuickLook.h>

static NSString *const fileCell = @"fileCell";


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, QLPreviewControllerDelegate, QLPreviewControllerDataSource>

@property (strong, nonatomic) AcceptedFileManager *acceptedFileManger;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *filesArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupView];
    [self configFilesArray];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configFilesArray) name:@"configFilesArray" object:nil];

}

- (void)setupView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor lightGrayColor];
}

- (void)configFilesArray {
    self.filesArray = [NSMutableArray arrayWithArray:[self.acceptedFileManger getFileListInFolder]];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDelegate&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fileCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fileCell];
    }
    cell.textLabel.text = self.filesArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    NSLog(@"部分注视的是WebView浏览方法，打开就可以测试");
    NSLog(@"部分注视的是WebView浏览方法，打开就可以测试");
    NSLog(@"部分注视的是WebView浏览方法，打开就可以测试");
    // 用webView预览
//    // 文件全路径
//    NSString *fullPath = [self.acceptedFileManger getFileFullPathWithFileName:self.filesArray[indexPath.row]];
//    PreviewController *vc = [[PreviewController alloc] init];
//    vc.url = [NSURL fileURLWithPath:fullPath];
//    [self.navigationController pushViewController:vc animated:YES];
    
    //用QuickLoock预览
    [self quickLookFileAtIndex:indexPath.row];
    
}

- (void)quickLookFileAtIndex:(NSInteger)index {
    QLPreviewController *myQlPreViewController = [[QLPreviewController alloc]init];
    myQlPreViewController.delegate = self;
    myQlPreViewController.dataSource = self;
    [myQlPreViewController setCurrentPreviewItemIndex:index];
    [self presentViewController:myQlPreViewController animated:YES completion:nil];
    
}

#pragma mark   ===============Quick Look代理===============
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return self.filesArray.count;
}
- (id)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    
    NSString *fullPath = [self.acceptedFileManger getFileFullPathWithFileName:self.filesArray[index]];
    return [NSURL fileURLWithPath:fullPath];
    
}

#pragma mark - 懒加载
- (NSMutableArray *)filesArray {
    if (!_filesArray) {
        _filesArray = [NSMutableArray array];
    }
    return _filesArray;
}

- (AcceptedFileManager *)acceptedFileManger {
    if (!_acceptedFileManger) {
        _acceptedFileManger = [[AcceptedFileManager alloc] init];
    }
    return _acceptedFileManger;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"configFilesArray" object:nil];
}
@end
