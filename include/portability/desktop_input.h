#ifndef ENGINE_PORTABILITY_DESKTOP_INPUT_H
#define ENGINE_PORTABILITY_DESKTOP_INPUT_H

#ifdef __cplusplus
extern "C" {
#endif

void OnMouseUp(int x, int y, int button);
void OnMouseDown(int x, int y, int button);
void OnMouseMove(int x, int y, int button);
void OnKeyDown(wchar_t c);
void OnKeyUp(wchar_t c);
void OnCharPressed(wchar_t c);

#ifdef  __cplusplus
}
#endif

#endif  // ENGINE_PORTABILITY_DESKTOP_INPUT_H
