//
//  ContractDetailViewController.m
//  TransactionList
//
//  Created by NowOrNever on 26/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ContractDetailViewController.h"
#import "ContractViewModel.h"

@interface ContractDetailViewController ()
@property (nonatomic,strong) UILabel *tel;
@property (nonatomic,strong) UILabel *genderLabel;
@property (nonatomic,strong) UILabel *ageLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIButton *chBtn;
@property (nonatomic,strong) ContractViewModel *cvm;
@property (nonatomic,assign) int contractId;
@end

@implementation ContractDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupFrame];
}

- (void)deleteBtn_click{
    __weak typeof(self) weakSelf = self;
    AlertHelper *alert = [AlertHelper shareHelper];
    [alert alertWithTitle:@"确定删除吗" message:@"删除后对方的列表也同时删除您" viewController:self];
    [alert setDefaultBtnWithTitle:@"确定" handlerBlock:^{
        [weakSelf.cvm deleteContractByContractId:self.contractId completeBlock:^(BOOL isSuccess) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }];
    [alert setCancelBtnWithTitle:@"取消" handlerBlock:nil];
    [alert show];
}

- (void)setInfoWithDic:(NSDictionary *)dic{
    self.contractId = [dic[@"userId"] intValue];
    self.tel.text = dic[@"userTel"];
    self.genderLabel.text = [dic[@"userGender"] intValue] == 0 ? @"女" : @"男";
    self.ageLabel.text = [NSString stringWithFormat:@"%@",dic[@"userAge"]];
    self.nameLabel.text = dic[@"userName"];
}

- (ContractViewModel *)cvm{
    if (!_cvm) {
        _cvm = [ContractViewModel new];
    }
    return _cvm;
}

- (void)setupFrame{
    __weak typeof (self) weakSelf = self;
    
    //上传头像
    UIButton *iconBtn = [UIButton new];
    [iconBtn setBackgroundImage:[UIImage imageNamed:@"userIcon"] forState:UIControlStateNormal];
    iconBtn.layer.cornerRadius = 45;
    [self.view addSubview:iconBtn];
    [iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).with.offset(90);
    }];
    
    //用户名
    UILabel *iconLabel = [UILabel new];
    iconLabel.text = @"";
    iconLabel.textColor = [UIColor darkGrayColor];
    iconLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:iconLabel];
    [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(iconBtn);
        make.top.equalTo(iconBtn.mas_bottom).with.offset(20);
    }];
    self.nameLabel = iconLabel;
    
    //性别图标
    UIImageView *genderIcon = [UIImageView new];
    genderIcon.image = [UIImage imageNamed:@"gender"];
    [self.view addSubview:genderIcon];
    [genderIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.top.equalTo(iconLabel.mas_bottom).with.offset(30);
    }];
    
    //
    UILabel *genderLabel = [UILabel new];
    genderLabel.text = @"性别";
    genderLabel.textColor = [UIColor darkGrayColor];
    genderLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:genderLabel];
    [genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@30);
        make.centerY.equalTo(genderIcon);
        make.left.equalTo(genderIcon.mas_right).with.offset(5);
        make.width.mas_equalTo(@50);
    }];
    
    //
    UILabel *genderContent = [UILabel new];
    genderContent.text = @"";
    genderContent.textColor = [UIColor darkGrayColor];
    genderContent.textAlignment = NSTextAlignmentRight;
    genderContent.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:genderContent];
    [genderContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(genderIcon);
        make.right.equalTo(weakSelf.view).with.offset(-10);
    }];
    self.genderLabel = genderContent;
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@1);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.top.equalTo(genderIcon.mas_bottom).with.offset(5);
    }];
    
    //年龄
    UIImageView *ageIcon = [UIImageView new];
    ageIcon.image = [UIImage imageNamed:@"age"];
    [self.view addSubview:ageIcon];
    [ageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.top.equalTo(lineView.mas_bottom).with.offset(10);
    }];
    
    //
    UILabel *ageLabel = [UILabel new];
    ageLabel.text = @"年龄";
    ageLabel.font = [UIFont systemFontOfSize:15];
    ageLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:ageLabel];
    [ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ageIcon);
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.left.equalTo(ageIcon.mas_right).with.offset(5);
    }];
    
    //
    UILabel *ageContent = [UILabel new];
    ageContent.textColor = [UIColor darkGrayColor];
    ageContent.font = [UIFont systemFontOfSize:15];
    ageContent.text = @"";
    ageContent.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:ageContent];
    [ageContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ageIcon);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.equalTo(weakSelf.view).with.offset(-10);
    }];
    self.ageLabel = ageContent;
    
    //
    UIView *lineView2 = [UIView new];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ageIcon.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@1);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
    }];
    
    //电话
    UIImageView *telIcon = [UIImageView new];
    telIcon.image = [UIImage imageNamed:@"tel"];
    [self.view addSubview:telIcon];
    [telIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(weakSelf.view).with.offset(10);
    }];
    
    //
    UILabel *telLabel = [UILabel new];
    telLabel.textColor = [UIColor darkGrayColor];
    telLabel.font = [UIFont systemFontOfSize:15];
    telLabel.text = @"电话";
    [self.view addSubview:telLabel];
    [telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(telIcon);
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.left.equalTo(telIcon.mas_right).with.offset(5);
    }];
    
    //
    UILabel *telContent = [UILabel new];
    telContent.textColor = [UIColor darkGrayColor];
    telContent.font = [UIFont systemFontOfSize:15];
    telContent.text = @"";
    telContent.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:telContent];
    [telContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(telIcon);
        make.size.mas_equalTo(CGSizeMake(120, 30));
        make.right.equalTo(weakSelf.view).with.offset(-10);
    }];
    self.tel = telContent;
    
    //
    UIView *lineView3 = [UIView new];
    lineView3.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView3];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(telIcon.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@1);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
    }];
    
    
    //
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.layer.cornerRadius = 5;
    [logoutBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    logoutBtn.layer.borderWidth = 1;
    logoutBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [logoutBtn setTitle:@"删除" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(deleteBtn_click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@30);
        make.left.equalTo(weakSelf.view).with.offset(10);
        make.right.equalTo(weakSelf.view).with.offset(-10);
        make.top.equalTo(lineView3.mas_bottom).with.offset(50);
    }];
}
@end
