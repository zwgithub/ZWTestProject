//
//  ZWForwardInvocationViewController.m
//  ZWTestProject
//
//  Created by shanWu on 16/4/13.
//  Copyright © 2016年 caozhenwei. All rights reserved.
//
//  本例子来测试动态方法决议和消息转发的整个流程。
//

#import "ZWForwardInvocationViewController.h"
#import <objc/runtime.h>

@interface ZWHelpClass : NSObject
@end

@implementation ZWHelpClass

- (void)helpFun {
    NSLog(@"模拟多继承 helpFun called!");
}

- (void)forwardInvocationTest {
    NSLog(@"消息转发 forwardInvocationTest called!");
}

@end

//####################################################################

@interface ZWTestResolveInstance : NSObject

@property (nonatomic, strong) ZWHelpClass *helpClass;

- (void)test;
- (void)helpFun;
- (void)forwardInvocationTest;

@end

@implementation ZWTestResolveInstance

- (instancetype)init{
    self = [super init];
    if (self) {
        if (!_helpClass) {
            _helpClass = [[ZWHelpClass alloc] init];
        }
    }
    return self;
}

void testFun(id self, SEL _cmd ){
    NSLog(@"动态方法决议 testFun called!");
}

//动态方法决议时要掉用的方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selectorStr = NSStringFromSelector(sel);
    if ([selectorStr hasPrefix:@"test"]) {
        class_addMethod(self, sel, (IMP)testFun, "v@:");
    }
    return NO;
}

//询问能不能把这条消息转给其它接收者来处理
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSString *selectorStr = NSStringFromSelector(aSelector);
    if ([selectorStr isEqualToString:@"helpFun"]) {
        return self.helpClass;
    }
    return nil;
}

//寻问这个消息是否有效
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig;
    sig = [self.helpClass methodSignatureForSelector:aSelector];
    if (sig) {
        return sig;
    }
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([self.helpClass respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:self.helpClass];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

@end

//####################################################################

@interface ZWForwardInvocationViewController ()
@end

@implementation ZWForwardInvocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZWTestResolveInstance *testObject = [[ZWTestResolveInstance alloc] init];
    [testObject test];//动态方法决议测试
    [testObject helpFun];//模拟多继承
    [testObject forwardInvocationTest];//消息转发测试
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
