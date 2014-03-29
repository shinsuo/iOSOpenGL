//
//  AppDelegate.m
//  iOSOpenGL
//
//  Created by shin on 3/29/14.
//  Copyright (c) 2014 shin. All rights reserved.
//

#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

typedef struct{
    float Position[3];
    float Color[4];
} Vertex;

const Vertex vertices[] = {
    {{1,-1,0},{1,0,0,1}},
    {{1,1,0},{0,1,0,1}},
    {{-1,1,0},{0,0,1,1}},
    {{-1,-1,0},{0,0,0,1}}
};

const GLubyte Indices[] = {
    0,1,2,
    2,3,0
};

@implementation AppDelegate
{
    float _curRed;
    bool _increasing;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    GLKView* view = [[GLKView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.context = context;
    view.delegate = self;
    
    CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _curRed = 0.0;
    _increasing = true;
    
    [self.window addSubview:view];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)render:(CADisplayLink*) displayLink
{
    NSLog(@"render");
    GLKView* view = [[self.window subviews] objectAtIndex:0];
    [view display];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    if (_increasing)
    {
        _curRed += 0.01;
    }
    else
    {
        _curRed -= 0.01;
    }
    
    if (_curRed >= 1.0)
    {
        _curRed = 1.0;
        _increasing = false;
    }
    if (_curRed <= 0.0)
    {
        _curRed = 0.0;
        _increasing = true;
    }
    
    glClearColor(_curRed, 0.0, 0.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
