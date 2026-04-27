# 架构说明

MaxTools 把每个小工具都作为独立的 SwiftUI 功能模块来维护。共享能力放在
`Core`，窗口、导航和入口放在 `App`。

每个功能模块应尽量保持独立：

- 页面状态放在功能页面或对应的视图模型中。
- 可复用的系统访问能力放在 `Core/Services`。
- 小型纯函数工具放在 `Core/Utilities`。
- 共享视觉组件和主题放在 `Core/Design`。
