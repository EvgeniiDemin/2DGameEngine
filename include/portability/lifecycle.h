#ifndef ENGINE_PORTABILITY_LIFECYCLE_H
#define ENGINE_PORTABILITY_LIFECYCLE_H

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

void Startup(void);
void Shutdown(void);
void Update(void);

void Pause(bool pause);
void ResizeScreen(int width, int height);

void OnLowMemory(void);
void OnDeactivate(void);
void OnReactivate(void);

#ifdef  __cplusplus
}
#endif  // __cplusplus

#endif	// ENGINE_PORTABILITY_LIFECYCLE_H
