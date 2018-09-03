#ifndef ENGINE_CORE_ENGINE_H
#define ENGINE_CORE_ENGINE_H

#include <memory>

#include "core/application_delegate.h"

namespace eg
{

class Engine {
public:
  static Engine& instance();

  void Startup();
  void Shutdown();
  void Update();

  void setApplicationDelegate(std::unique_ptr<IApplicationDelegate> delegate);
  
private:
  std::unique_ptr<IApplicationDelegate> applicationDelegate;
  
  Engine() = default;
  Engine(Engine const&) = delete;
  Engine& operator = (Engine const&) = delete;
  Engine(Engine&&) = delete;
  Engine& operator = (Engine&&) = delete;
};
  
} // namespace eg

#define g_engine eg::Engine::instance()

#endif  // ENGINE_CORE_ENGINE_H
