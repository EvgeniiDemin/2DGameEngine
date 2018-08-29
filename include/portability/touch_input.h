#ifndef ENGINE_PORTABILITY_TOUCH_INPUT_H
#define ENGINE_PORTABILITY_TOUCH_INPUT_H

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

void OnTouchBegin(int x, int y, unsigned int touch);
void OnTouchMove(int x, int y, unsigned int touch);
void OnTouchEnd(int x, int y, unsigned int touch);
void OnTouchCancel(int x, int y, unsigned int touch);
void OnAcceleration(float x, float y, float z);

#ifdef  __cplusplus
}
#endif  // __cplusplus

#endif  // ENGINE_PORTABILITY_TOUCH_INPUT_H
