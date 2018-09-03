#ifndef ENGINE_CORE_APPLICATION_DELEGATE_H
#define ENGINE_CORE_APPLICATION_DELEGATE_H

namespace eg
{

class IApplicationDelegate {
public:
  virtual ~IApplicationDelegate() = default;
  
  virtual void Initialize() = 0;
  virtual void Start()      = 0;
  virtual void Update()     = 0;
  virtual void Shutdown()   = 0;
};

} // namespace eg

#endif  // ENGINE_CORE_APPLICATION_DELEGATE_H
