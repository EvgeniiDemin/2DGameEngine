#ifndef ENGINE_PORTABILITY_LIFECYCLE_H
#define ENGINE_PORTABILITY_LIFECYCLE_H

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

void Startup();
void Shutdow();
void Update();

void Pause(bool pause);
void ResizeScreen(int width, int height);

void OnLowMemory();
void OnDeactivate();
void OnReactivate();

#ifdef  __cplusplus
}
#endif  // __cplusplus

#endif	// ENGINE_PORTABILITY_LIFECYCLE_H
