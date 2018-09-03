#include "engine_pch.h"
#include "core/engine.h"

namespace eg {

Engine& Engine::instance() {
  static Engine theInstance;
  return theInstance;
}
  
void Engine::Startup() {
  // TODO: initialize subsystems

  if(applicationDelegate) {
    applicationDelegate->Initialize();
  }
  
  // TODO: run subsystems
  // TODO: extract to separate method m.b.
  if(applicationDelegate) {
    applicationDelegate->Start();
  }
}

void Engine::Shutdown() {
  if(applicationDelegate) {
    applicationDelegate->Shutdown();
  }
}
  
void Engine::Update() {
  if(applicationDelegate) {
    applicationDelegate->Update();
  }
}

void Engine::setApplicationDelegate(std::unique_ptr<IApplicationDelegate> delegate) {
  if(applicationDelegate) {
    // TODO: insert assert
    // TODO: report error
    return;
  }

  applicationDelegate = std::move(delegate);
}
  
} // namespace egs
