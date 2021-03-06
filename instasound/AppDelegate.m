#import "AppDelegate.h"
#import "ViewController.h"
#import "SCUI.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

+ (void)initialize;
{
    [SCSoundCloud  setClientID:@"02e56b33c5b3ba11cf4a4b387b0fc983"
                        secret:@"f39445195a1bb5cffd1202da54bf6ad9"
                   redirectURL:[NSURL URLWithString:@"instasound://oauth2"]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.viewController = [[ViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor redColor]];
    [self.window makeKeyAndVisible];
    [self.window setRootViewController:self.viewController];

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // XXX
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // XXX
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // XXX
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // XXX
}

@end
