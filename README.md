# MaxTools

MaxTools 是一个只给自己使用的 macOS 个人工具合集，使用 Swift 和 SwiftUI 构建。

## 环境要求

- macOS 14+
- Xcode 15+
- Swift 5.10+

## 运行方式

用 Xcode 打开 `Package.swift`，选择 `MaxTools` 方案后运行。

也可以在终端运行：

```sh
swift run MaxTools
```

## 目录结构

```text
Sources/MaxToolsApp
  App/                 应用入口、窗口外壳、导航
  Core/
    Design/            视觉主题和通用组件
    Models/            共享模型
    Services/          系统能力和应用服务
    Utilities/         小型工具函数
  Features/
    Dashboard/         总览
    ClipboardTools/    剪贴板工具
    TextTools/         文本处理
    FileTools/         文件命名
    Skills/            技能总览
    ServerOps/         服务器运维
    NetworkTools/      URL 解析
  Resources/           资源文件
Tests/                 单元测试
Docs/                  项目说明
Scripts/               本地脚本
```

## 新增工具

1. 在 `Sources/MaxToolsApp/Features` 下创建一个新目录。
2. 为这个工具添加 SwiftUI 页面。
3. 在 `ToolRegistry.swift` 里添加一个 `ToolItem` 入口。
