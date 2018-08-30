#include "engine_pch.h"
#include "portability/lifecycle.h"

void Startup() {
}

void Shutdown() {
}

void Update() {
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
