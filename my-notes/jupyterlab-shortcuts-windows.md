# JupyterLab 快捷键（Windows）

> 环境：Windows + Anaconda 里的 JupyterLab **4.5.11**（jupyter_server 2.20.0）
> 这份表不是抄的：是从本机 `C:\Users\a1299\anaconda3\share\jupyter\lab\schemas\` 下的默认绑定里读出来的（168 条），
> 已经按 Windows 的键位换算过（JupyterLab 里的 `Accel` 在 Windows 上就是 **Ctrl**）。

## 先记这 5 个，能走通 90% 的流程

| 按键 | 作用 |
| --- | --- |
| `Shift + Enter` | 运行本格，光标跳到下一格（最常用） |
| `Ctrl + Enter` | 运行本格，留在本格 |
| `Alt + Enter` | 运行本格，并在下面插一个新格 |
| `Esc` | 从编辑模式回到命令模式 |
| `Enter` | 从命令模式进入编辑模式 |

## 两种模式

- **编辑模式**：光标在格子里，能打字，单元格左侧是**绿色**竖条。
- **命令模式**：按 `Esc` 后，单元格左侧是**蓝色**竖条，此时**单字母**快捷键才生效（`A` `B` `D` `M` `Y` …）。
  在编辑模式里直接按 `A` 只会打出一个字母 a。

## 命令模式：单元格操作

| 按键 | 作用 |
| --- | --- |
| `A` | 在上方插入新单元格 |
| `B` | 在下方插入新单元格 |
| `Shift + A` / `Shift + B` | 在上方/下方插入**标题**单元格 |
| `D` `D`（连按两次） | 删除当前单元格 |
| `Z` | 撤销单元格操作 |
| `Shift + Z` | 重做单元格操作 |
| `Y` | 变成 Code 单元格 |
| `M` | 变成 Markdown 单元格 |
| `R` | 变成 Raw 单元格 |
| `1` … `6` | 变成 1~6 级标题 |
| `C` / `X` / `V` | 复制 / 剪切 / 粘贴单元格 |
| `Shift + J` 或 `Shift + ↓` | 向下多选 |
| `Shift + K` 或 `Shift + ↑` | 向上多选 |
| `Shift + Home` / `Shift + End` | 多选到最上 / 最下 |
| `Ctrl + A` | 全选单元格 |
| `Shift + M` | 合并选中的单元格 |
| `Ctrl + Backspace` | 与上方单元格合并 |
| `Ctrl + Shift + M` | 与下方单元格合并 |
| `O` | 显示/隐藏单元格输出 |
| `Shift + L` | 显示/隐藏行号 |
| `Shift + R` | 左右分屏渲染（markdown 实时预览） |
| `Ctrl + Shift + ←` / `→` | 折叠 / 展开全部标题 |
| `↑` `↓` / `K` `J` | 上下移动光标 |
| `←` / `→` | 折叠 / 展开当前标题 |

> 拆分单元格是**编辑模式**下的 `Ctrl + Shift + -`（减号）。

## 运行与内核

| 按键 | 作用 |
| --- | --- |
| `Shift + Enter` | 运行本格并跳到下一格 |
| `Ctrl + Enter` | 运行本格 |
| `Alt + Enter` | 运行本格并在下面插一格 |
| `I` `I`（连按两次） | 中断内核（命令模式） |
| `0` `0`（连按两次） | 重启内核（命令模式） |
| `Ctrl + Shift + Q` | 关闭并清理（关掉内核、断开连接） |

## 编辑模式（在格子里写代码时）

| 按键 | 作用 |
| --- | --- |
| `Tab` | 代码补全 |
| `Shift + Tab` | 看当前函数的文档（Docstring） |
| `Ctrl + /` | 注释 / 取消注释 |
| `Ctrl + D` | **删除当前行**（注意：不是"选中下一个相同词"） |
| `Ctrl + Shift + D` | 选中下一个相同的字符串 |
| `Ctrl + Shift + K` | 删除当前行（另一个绑定） |
| `Ctrl + Z` / `Ctrl + Shift + Z` | 撤销 / 重做 |
| `Ctrl + A` | 全选 |
| `Alt + ↑` / `Alt + ↓` | 调出历史输入的上一条 / 下一条 |
| `Ctrl + Shift + -` | 在光标处拆分单元格 |
| `Ctrl + M` | 等同 `Esc`，回命令模式 |
| `Alt + A` | 块注释 |

## 全局 / 界面

| 按键 | 作用 |
| --- | --- |
| `Ctrl + S` | 保存 |
| `Ctrl + Shift + S` | 另存为 |
| `Ctrl + F` | 在当前文件里查找 |
| `Ctrl + G` / `Ctrl + Shift + G` | 下一个 / 上一个匹配 |
| `Ctrl + Shift + C` | 命令面板（所有功能都能在这里搜到） |
| `Ctrl + Shift + H` | 快捷键总表（忘了就按它） |
| `Ctrl + ,` | 打开设置（Settings Editor） |
| `Ctrl + B` | 显示/隐藏左侧栏 |
| `Ctrl + J` | 显示/隐藏右侧栏 |
| `Ctrl + Shift + F` | 跳到文件浏览器 |
| `Ctrl + P` | 打印 / 导出 PDF |
| `Alt + W` | 关闭当前标签页 |
| `Ctrl + Shift + [` / `]` | 上一个 / 下一个标签页 |
| `Ctrl + Shift + T` | 重新打开刚刚关掉的标签页 |
| `Ctrl + Shift + L` | 打开启动器（新建 notebook / console） |
| `Ctrl + Shift + B` | 运行中的内核面板 |
| `Ctrl + Shift + K` | 目录（TOC）侧栏 |
| `Ctrl + Shift + E` | 调试器面板 |
| `Ctrl + Shift + X` | 扩展管理器 |
| `Ctrl + I` | 检查器（Inspector） |
| `F11` | 全屏 |

## 文件浏览器

| 按键 | 作用 |
| --- | --- |
| `F2` | 重命名 |
| `Delete` | 删除 |
| `Ctrl + C` / `Ctrl + X` / `Ctrl + V` | 复制 / 剪切 / 粘贴 |
| `Ctrl + D` | 生成副本（duplicate） |
| `Backspace` | 回到上一级目录 |
| `Ctrl + A` | 全选 |

## 几个容易踩的坑

1. **`Ctrl + D` 在编辑器里是删行**，不是 Sublime 的"选中下一个相同词"；后者是 `Ctrl + Shift + D`。
2. **`Ctrl + Shift + D` 有两个含义**：焦点在单元格里（`.cm-content`）是"选中下一个相同词"；
   焦点不在编辑器里时，它是 `application:toggle-mode`——切换"简单界面模式"。所以别在空白处乱按。
3. **`Ctrl + Shift + C` 会被浏览器抢走**（Chrome/Edge 的开发者工具也是这个键），命令面板打不开时就点菜单 `View → Activate Command Palette`。
4. **多光标**：文章里 `⌘ D`、`⌘ + 点击` 那套来自 `@ryantam626/jupyterlab_sublime` 插件，在 JupyterLab 4 里已经不能用了（4.x 的编辑器换成了 CodeMirror 6，并且把"加光标"的默认绑定移除了）。单机自用够用的替代是 `Ctrl + Shift + D` 逐个选中相同词。
5. **`Alt + J` / `Alt + K` 移动单元格**不是默认快捷键，那是原文作者自己加的（见下一节）。

## 和原文（macOS）表格的换算

| 原文（Mac） | Windows |
| --- | --- |
| `⌘` | `Ctrl` |
| `⌥`（Option） | `Alt` |
| `⇧` | `Shift` |
| `⌘ D`（Sublime：选中下一个相同字符串） | `Ctrl + Shift + D`（内置） |
| `⇧ ⌘ L`（Sublime：多行同时编辑） | 无（插件已不兼容 4.x） |
| `⌘ + 鼠标点击`（多光标） | 无默认绑定 |
| `⌥ J` / `⌥ K`（移动单元格） | 默认 `Ctrl + Shift + ↓` / `Ctrl + Shift + ↑` |

## 想自己加键（比如原文的 Alt+J / Alt+K）

`Ctrl + ,` 打开设置 → 左侧 **Keyboard Shortcuts** → 右上角切到 JSON 编辑，粘贴：

```json
{
  "notebook:move-cells-down": {
    "command": "notebook:move-cell-down",
    "keys": ["Alt J"],
    "selector": ".jp-Notebook.jp-mod-commandMode:not(.jp-mod-readWrite) :focus",
    "title": "Move Cells Down",
    "category": "Notebook Cell Operations"
  },
  "notebook:move-cells-up": {
    "command": "notebook:move-cell-up",
    "keys": ["Alt K"],
    "selector": ".jp-Notebook.jp-mod-commandMode:not(.jp-mod-readWrite) :focus",
    "title": "Move Cells Up",
    "category": "Notebook Cell Operations"
  }
}
```

改完立刻生效，保存在 `C:\Users\a1299\.jupyter\lab\user-settings\@jupyterlab\shortcuts-extension\shortcuts.jupyterlab-settings`。
想恢复默认：设置里那条快捷键右边点 "Reset"。
