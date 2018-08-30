#import "MainWindowController.h"
#import "GLView.h"

#include "portability/lifecycle.h"

void ShowAlert(NSString* title, NSString* message)
{
  NSAlert* alert = [[NSAlert alloc] init];
  [alert addButtonWithTitle:@"OK"];
  [alert setMessageText:title];
  [alert setInformativeText:message];
  [alert setAlertStyle:NSAlertStyleWarning];
  [alert runModal];
}

@interface MainWindowController()

@property NSTimer* updateTimer;
@property GLView* glView;

@end

@implementation MainWindowController

- (id)initWithWindow:(NSWindow *)window
{
  self = [super initWithWindow:window];

  {
    GLView* view = [[GLView alloc] init];
    [view awakeFromNib];
    [window setContentView:view];
    
    self.glView = view;
  }
  
  {
    NSView* view = [[NSView alloc] init];
    [view setWantsLayer:YES];
    view.layer.backgroundColor = CGColorGetConstantColor(kCGColorBlack);
  }
    
  return self;
}

-(void)applicationWillFinishLaunching:(NSNotification *)notification
{
  Startup();
  [self startUpdates];
  [[self window] toggleFullScreen:@""];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
  Shutdown();
  [self stopUpdates];
  [self.glView onApplicationTerminate];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
  return YES;
}

- (void)startUpdates {
  self.updateTimer = [NSTimer scheduledTimerWithTimeInterval: 1 / 60.f
                                                      target:self
                                                    selector:@selector(onUpdate)
                                                    userInfo:nil
                                                     repeats:YES];
  
  [[NSRunLoop currentRunLoop] addTimer:self.updateTimer forMode:NSDefaultRunLoopMode];
  [[NSRunLoop currentRunLoop] addTimer:self.updateTimer forMode:NSEventTrackingRunLoopMode];
}

- (void)stopUpdates {
  self.updateTimer = nil;
}

- (void)onUpdate {
  [self.glView drawView];
}

@end

