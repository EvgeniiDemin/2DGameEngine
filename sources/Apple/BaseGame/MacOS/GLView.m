#import "GLView.h"
#import <Carbon/Carbon.h>

#include "portability/lifecycle.h"

#define SUPPORT_RETINA_RESOLUTION 1

enum PengingAction {
  PA_None,
  PA_Pause,
  PA_Unpause,
};

@interface GLView() {
  bool canResize;
  enum PengingAction pendingAction;
}

@property (nonatomic, retain) NSTrackingArea* trackingArea;

@end

@implementation GLView

@synthesize trackingArea;

- (id)init
{
  if( self = [super init]) {
    canResize     = false;
    pendingAction = PA_None;
  }
  return self;
}

- (void) awakeFromNib {
  [self setupGLParams];
  [self createTrackingArea];
}

- (void) createTrackingArea
{
  int options = (NSTrackingMouseMoved   |
                 NSTrackingActiveAlways |
                 NSTrackingCursorUpdate |
                 NSTrackingMouseEnteredAndExited);
  trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds]
                                              options:options
                                                owner:self
                                            userInfo:nil];
  [self addTrackingArea:trackingArea];
}

- (void) updateTrackingAreas
{
  [self removeTrackingArea:trackingArea];
  [self createTrackingArea];
  [super updateTrackingAreas];
}

- (void) setupGLParams
{
  NSOpenGLPixelFormatAttribute attrs[] =
  {
    NSOpenGLPFADoubleBuffer,
    NSOpenGLPFAAccelerated,
    NSOpenGLPFANoRecovery,
    NSOpenGLPFAColorSize, 24,
    NSOpenGLPFADepthSize, 16,
    0
  };
  
  NSOpenGLPixelFormat *pf = [[NSOpenGLPixelFormat alloc] initWithAttributes:attrs];
  if (!pf)
  {
    NSLog(@"No OpenGL pixel format");
    // TODO: exit mb?
  }
  
  NSOpenGLContext* context = [[NSOpenGLContext alloc] initWithFormat:pf shareContext:nil];
  [self setPixelFormat:pf];
  [self setOpenGLContext:context];
  
#if SUPPORT_RETINA_RESOLUTION
  [self setWantsBestResolutionOpenGLSurface:YES];
#endif // SUPPORT_RETINA_RESOLUTION
}

- (void) prepareOpenGL
{
  [super prepareOpenGL];
  [self initGL];
  [self subscribeOnWindowEvents];
  
  canResize = true;
}

- (void) subscribeOnWindowEvents
{
  NSNotificationCenter* notifications = [NSNotificationCenter defaultCenter];
  [notifications addObserver:self
                    selector:@selector(windowWillMiniaturize:)
                        name:NSWindowWillMiniaturizeNotification
                      object:[self window]];
  
  [notifications addObserver:self
                    selector:@selector(windowDidDeminiaturize:)
                        name:NSWindowDidDeminiaturizeNotification
                      object:[self window]];
  
  [notifications addObserver:self
                    selector:@selector(windowDidBecomeMain:)
                        name:NSWindowDidBecomeMainNotification
                      object:[self window]];
  
  [notifications addObserver:self
                    selector:@selector(windowDidResignMain:)
                        name:NSWindowDidResignMainNotification
                      object:[self window]];
}

- (void) windowWillMiniaturize:(NSNotification*)notification
{
  pendingAction = PA_Pause;
}

- (void) windowDidDeminiaturize:(NSNotification*)notification
{
  pendingAction = PA_Unpause;
}

- (void) windowDidResignMain:(NSNotification*)notification
{
  pendingAction = PA_Pause;
}

- (void) windowDidBecomeMain:(NSNotification*)notification
{
  pendingAction = PA_Unpause;
}

- (void) initGL
{
  // The reshape function may have changed the thread to which our OpenGL
  // context is attached before prepareOpenGL and initGL are called.  So call
  // makeCurrentContext to ensure that our OpenGL context current to this
  // thread (i.e. makeCurrentContext directs all OpenGL calls on this thread
  // to [self openGLContext])
  [[self openGLContext] makeCurrentContext];
  
  // Synchronize buffer swaps with vertical refresh rate
  GLint swapInt = 1;
  [[self openGLContext] setValues:&swapInt forParameter:NSOpenGLCPSwapInterval];
}

- (void) reshape
{
  [super reshape];
  
  if(!canResize)
    return;
  
  // We draw on a secondary thread through the display link. However, when
  // resizing the view, -drawRect is called on the main thread.
  // Add a mutex around to avoid the threads accessing the context
  // simultaneously when resizing.
  CGLLockContext([[self openGLContext] CGLContextObj]);
  
  // Get the view size in Points
  NSRect viewRectPoints = [self bounds];
  
#if SUPPORT_RETINA_RESOLUTION
  
  // Rendering at retina resolutions will reduce aliasing, but at the potential
  // cost of framerate and battery life due to the GPU needing to render more
  // pixels.
  
  // Any calculations the renderer does which use pixel dimentions, must be
  // in "retina" space.  [NSView convertRectToBacking] converts point sizes
  // to pixel sizes.  Thus the renderer gets the size in pixels, not points,
  // so that it can set it's viewport and perform and other pixel based
  // calculations appropriately.
  // viewRectPixels will be larger (2x) than viewRectPoints for retina displays.
  // viewRectPixels will be the same as viewRectPoints for non-retina displays
  NSRect viewRectPixels = [self convertRectToBacking:viewRectPoints];
#else //if !SUPPORT_RETINA_RESOLUTION
  
  // App will typically render faster and use less power rendering at
  // non-retina resolutions since the GPU needs to render less pixels.  There
  // is the cost of more aliasing, but it will be no-worse than on a Mac
  // without a retina display.
  
  // Points:Pixels is always 1:1 when not supporting retina resolutions
  NSRect viewRectPixels = viewRectPoints;
#endif // !SUPPORT_RETINA_RESOLUTION

  ResizeScreen(viewRectPixels.size.width, viewRectPixels.size.height);
  CGLUnlockContext([[self openGLContext] CGLContextObj]);
}

- (void) drawRect: (NSRect) theRect
{
  // Called during resize operations
  // Avoid flickering during resize by drawing
  [self drawView];
}

- (void) drawView
{
  [[self openGLContext] makeCurrentContext];

  // We draw on a secondary thread through the display link
  // When resizing the view, -reshape is called automatically on the main
  // thread. Add a mutex around to avoid the threads accessing the context
  // simultaneously when resizing
  CGLLockContext([[self openGLContext] CGLContextObj]);

  [self onUpdate];

  CGLFlushDrawable([[self openGLContext] CGLContextObj]);
  CGLUnlockContext([[self openGLContext] CGLContextObj]);
}

- (void) onUpdate
{
  if(pendingAction == PA_Pause) {
    Pause(true);
    pendingAction = PA_None;
    return;
  }

  if(pendingAction == PA_Unpause) {
    Pause(false);
    pendingAction = PA_None;
    return;
  }

  Update();
}

- (void) onApplicationTerminate
{
}

- (BOOL)mouseDownCanMoveWindow
{
  return NO;
}

- (BOOL)acceptsTouchEvents
{
  return YES;
}

// We want this view to be able to receive key events
- (BOOL) acceptsFirstResponder
{
  return YES;
}

@end
