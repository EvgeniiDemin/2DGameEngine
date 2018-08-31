#import <AppKit/AppKit.h>
#import "MainWindowController.h"

#include "portability/launcher.h"

#define NON_LOCALIZED @"_non_localized_"

NSString* getLocalizedString(NSString* key)
{
  NSString* localizedString =
    [[NSBundle mainBundle] localizedStringForKey:key
                                           value:NON_LOCALIZED
                                           table:nil];
  return localizedString;
}

NSWindow* createApplicationWindow()
{
  NSUInteger windowStyle = (NSWindowStyleMaskTitled         |
                            NSWindowStyleMaskMiniaturizable |
                            NSWindowStyleMaskClosable       |
                            NSWindowStyleMaskResizable);
  
  NSRect windowRect = NSMakeRect(0, 0, 1024, 768);
  NSWindow * window = [[NSWindow alloc] initWithContentRect:windowRect
                                                  styleMask:windowStyle
                                                    backing:NSBackingStoreBuffered
                                                      defer:YES];
  
  [window setTitle:getLocalizedString(@"MainWindowTitle")];
  [window setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary];
  
  return window;
}

NSMenu* createMainMenu()
{
  NSMenu* menu = [[NSMenu alloc] init];
  
  NSMenuItem* about = [[NSMenuItem alloc] init];
  [about setTitle:getLocalizedString(@"AboutMenuItem")];
  [about setTarget:[NSApplication sharedApplication]];
  [about setAction:@selector(orderFrontStandardAboutPanel:)];
  [menu addItem:about];
  
  [menu addItem:[NSMenuItem separatorItem]];
  
  NSMenuItem* toggleFullScreen = [[NSMenuItem alloc] init];
  // Texts for this menu item are set automatically
  [toggleFullScreen setAction:@selector(toggleFullScreen:)];
  [toggleFullScreen setKeyEquivalent:@"f"];
  [toggleFullScreen setKeyEquivalentModifierMask: (NSEventModifierFlagCommand |
                                                   NSEventModifierFlagControl)];
  [menu addItem:toggleFullScreen];
  
  [menu addItem:[NSMenuItem separatorItem]];
  
  NSMenuItem* quit = [[NSMenuItem alloc] init];
  [quit setTitle:getLocalizedString(@"QuitGameMenuItem")];
  [quit setTarget:[NSApplication sharedApplication]];
  [quit setAction:@selector(terminate:)];
  [quit setKeyEquivalent:@"q"];
  [quit setKeyEquivalentModifierMask:NSEventModifierFlagCommand];
  [menu addItem:quit];
  
  NSMenuItem* subMenu = [[NSMenuItem alloc] init];
  [subMenu setSubmenu: menu];
  
  NSMenu* mainMenu = [[NSMenu alloc] init];
  [mainMenu addItem:subMenu];
  
  return mainMenu;
}

int RunApplication(int argc, const char* argv[]) {
  NSApplication* application = [NSApplication sharedApplication];
  NSWindow* mainWindow = createApplicationWindow();

  MainWindowController* controller =
      [[MainWindowController alloc] initWithWindow:mainWindow];
  [application setDelegate:controller];
  [application setMainMenu:createMainMenu()];
  [mainWindow makeKeyAndOrderFront:mainWindow];
	
  [application run];
  
  return 0;
}
