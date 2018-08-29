#include "engine_pch.h"
#include "portability/touch_input.h"

void OnTouchBegin(int x, int y, unsigned int touch) {
  UNREFERENCED_PARAMETER(x);
  UNREFERENCED_PARAMETER(y);
  UNREFERENCED_PARAMETER(touch);
}

void OnTouchMove(int x, int y, unsigned int touch) {
  UNREFERENCED_PARAMETER(x);
  UNREFERENCED_PARAMETER(y);
  UNREFERENCED_PARAMETER(touch);
}

void OnTouchEnd(int x, int y, unsigned int touch) {
  UNREFERENCED_PARAMETER(x);
  UNREFERENCED_PARAMETER(y);
  UNREFERENCED_PARAMETER(touch);
}

void OnTouchCancel(int x, int y, unsigned int touch) {
  UNREFERENCED_PARAMETER(x);
  UNREFERENCED_PARAMETER(y);
  UNREFERENCED_PARAMETER(touch);
}

void OnAcceleration(float x, float y, float z) {
  UNREFERENCED_PARAMETER(x);
  UNREFERENCED_PARAMETER(y);
  UNREFERENCED_PARAMETER(z);
}
