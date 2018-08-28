#import <Cocoa/Cocoa.h>

@interface GLView : NSOpenGLView {
}

-(void) drawView;
-(void) onApplicationTerminate;

@end
