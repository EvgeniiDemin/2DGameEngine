#include "engine_pch.h"
#include "portability/lifecycle.h"

#include "core/engine.h"

void Startup() {
  g_engine.Startup();
}

void Shutdown() {
  g_engine.Shutdown();
}

void Update() {
  g_engine.Update();
}

void Pause(bool pause) {
  UNREFERENCED_PARAMETER(pause);
}

void ResizeScreen(int width, int height) {
  UNREFERENCED_PARAMETER(width);
  UNREFERENCED_PARAMETER(height);
}

void OnLowMemory() {
}

void OnDeactivate() {
}

void  OnReactivate() {
}
