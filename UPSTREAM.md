# 开源来源与本地修改

本项目已重置为 [BatteryHub / Wireless Device Battery Monitor](https://github.com/krisgfx9/Wireless-Device-Battery-Monitor) 的派生版本。设备枚举、HID++ 读取、任务栏绘制、菜单和自启均使用上游实现。

- 上游作者：krisgfx9 及贡献者。
- 固定版本：`v1.1.0`。
- 固定提交：`7cc44f2b2c63341e2b478463c7467759837a74a9`。
- 许可证：GPL-3.0，完整内容见 [LICENSE](LICENSE)。原作者署名及协议来源保留在各文件内。
- 上游官方发布包 SHA-256：`7a97a1ff0aefa895386077093b23a714df549a08fad3b1b9c37ccf2100a27026`。

筛选时也检查了 [LGSTrayBattery](https://github.com/andyvorld/LGSTrayBattery)；BatteryHub 原生支持常驻通知区域左侧的任务栏窗口，且有无运行时依赖的 Win32 构建，更贴合需求。

本地修改：默认每秒查询，菜单增加 1/2/5/10 秒选项；低电量颜色阈值为 `<20%`；充电中的百分比与闪电标记显示绿色；默认关闭文字背景，直接融入任务栏；显示内容不变时跳过重绘，重绘后仅尺寸变化才强制定位，避免透明组件反复刷新闪烁；增加本地运行诊断文件以检查组件自身的任务栏位置和重绘/定位次数。保留上游原生界面。构建使用 `dev` 通道，不会被官方自动更新覆盖。

旧 Go 实现保存在 `.legacy-backup/`（Git 忽略）及当前用户 `%LOCALAPPDATA%\MouseBattery\backups\mouse-before-batteryhub-*.zip`，不再参与构建。

电量以设备报告为准。更换开源实现不保证修复固件只在重启时更新百分比的问题；需要充电过程的实机验证。`--json` 可核对上游读取的值，不会根据充电时长编造百分比。
