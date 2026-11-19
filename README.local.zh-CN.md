# 鼠标电量任务栏组件

基于 BatteryHub v1.1.0，来源和修改见 [UPSTREAM.md](UPSTREAM.md)。原版使用说明见 [README.md](README.md)。

## 获取源码

独立仓库：[huajianLLs/mouse-battery](https://github.com/huajianLLs/mouse-battery)。

```powershell
git clone git@github.com:huajianLLs/mouse-battery.git
```

在 `go_learn` 仓库中，本项目位于子模块 `app/mouse`。首次拉取或更新主仓库后，在 `go_learn` 根目录执行：

```powershell
git submodule update --init --recursive -- app/mouse
```

## 使用

运行 `bin\mouse-battery.exe`。默认使用 BatteryHub 原生任务栏界面，显示鼠标图标和百分比，位于 `^` 隐藏图标按钮左侧。右键可立即刷新、更改查询间隔、切换显示模式和设置开机自启。

默认不显示文字背景，直接融入任务栏；需要时可在右键菜单中开启背景。

Windows 可执行文件经过静态链接，只需一个 EXE 即可运行，无需额外安装运行库。EXE、构建缓存和旧版备份不纳入源码仓库。

- 默认每秒查询；可在“检查电量间隔”菜单调整。显示内容不变时不重复重绘，尺寸不变时不强制重新定位。
- 未充电且低于 20%：红色；正在充电：绿色。
- 充满、休眠、断开状态沿用上游提示。
- `bin\mouse-battery.exe --json`：查询真实设备并输出 JSON 后退出。
- `bin\mouse-battery.exe --quit`：退出本地运行实例。
- 运行诊断：`%LOCALAPPDATA%\MouseBattery\batteryhub-status.json`，包含当前设备读数、查询间隔、重绘/定位计数和组件自身的任务栏窗口位置，不采集屏幕。

上游原生驱动支持 HID++ 1.0/2.0、短/长报告、电量/电压/ADC 功能发现以及接收器和充电线连接的设备合并。数值能否实时变化仍取决于设备上报；不能通过缩短轮询保证固件重新测量。

## 编译

需要 MinGW-w64 工具链，不再使用 Go 编译。已在本机配置 w64devkit 2.11.0：

```powershell
.\build.ps1
# 其他位置的工具链
.\build.ps1 -ToolchainBin 'C:\tools\w64devkit\bin'
```

生成 `bin\mouse-battery-next.exe`。退出运行实例后，可替换 `bin\mouse-battery.exe`。上游 `Makefile` 和 `build.bat` 也保留。

```powershell
.\test.ps1
```

测试使用上游测试套件，不打开程序界面。源码遵循 GPL-3.0；详见 [LICENSE](LICENSE)。
