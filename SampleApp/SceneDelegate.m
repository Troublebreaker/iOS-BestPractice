#import "SceneDelegate.h"
#import "GTNewsViewController.h"
#import "GTVideoViewController.h"
#import "GTRecommandViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    
    if (@available(iOS 13.0, *)) {
        UIWindowScene * windowScene = (UIWindowScene *)scene;
        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
        self.window.frame = windowScene.coordinateSpace.bounds;
    } else {
        // Fallback on earlier versions
    }

    UITabBarController *tabBarController = [[UITabBarController alloc] init];

    GTNewsViewController *controller1= [[GTNewsViewController alloc] init];
//    controller1.view.backgroundColor = [UIColor redColor];
    controller1.tabBarItem.title = @"新闻";
    controller1.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/news_normal"];
    controller1.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/news_slected"];
    
    
    
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller1];
//    navigationController.view.backgroundColor = [UIColor redColor];
//    navigationController.tabBarItem.title = @"新闻";
//    navigationController.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/news_normal"];
//    navigationController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/news_slected"];
//
    
    GTVideoViewController *controller2= [[GTVideoViewController alloc] init];
  
    
    GTRecommandViewController *controller3= [[GTRecommandViewController alloc] init];
    controller3.tabBarItem.title = @"推荐";
    controller3.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/recommand_normal"];
    controller3.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/recommand_slected@2x.png"];

    UIViewController *controller4= [[UIViewController alloc] init];
    controller4.view.backgroundColor = [UIColor lightGrayColor];
    controller4.tabBarItem.title = @"我的";
    controller4.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/person_normal"];
    controller4.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/person_slected@2x.png"];

    [tabBarController setViewControllers:@[controller1,controller2,controller3,controller3,controller4]];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
