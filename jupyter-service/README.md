# 在 Windows 上让 JupyterLab 开机自启

> 对应书里 [附录C Jupyterlab 的安装与配置](<../附录C Jupyterlab 的安装与配置.md>) 的「将 Jupyter lab 配置成系统服务」一节。

## 先回答你的问题

`launchctl` 是 macOS 独有的，它是 launchd（苹果的系统服务管理器）的命令，Windows 上**没有**这个命令，也没有可以直接照抄的文件。但文章想要的效果是可以照搬的：

> 开机登录后 JupyterLab 自己在后台跑起来，我只要打开浏览器访问 <http://localhost:8888/> 就行。

在 Windows 上，这件事由 **启动脚本 + 「启动」文件夹里的快捷方式** 完成，效果和 macOS 的 LaunchAgent 一样（登录时以你自己的身份运行、不弹窗、不占一个终端窗口）。

## 概念对照表

| macOS（文章里的写法） | Windows（这里的写法） |
| --- | --- |
| `~/Library/LaunchAgents/com.jupyter.lab.plist` | `jupyter-lab.cmd`（要跑的命令）+ `jupyter-lab.vbs`（让它不弹黑窗） |
| plist 里的 `<ProgramArguments>` | `jupyter-lab.cmd` 里那一行 `jupyter lab --no-browser …` |
| `<key>RunAtLoad</key>` | 快捷方式放进「启动」文件夹 = 登录就跑 |
| `<key>StandardOutPath</key>` / `<key>StandardErrorPath</key>` | `.cmd` 里的 `>> logs\jupyter-lab.log 2>&1` |
| `launchctl load …plist` | 运行 `install-startup.ps1`（就是往启动文件夹放快捷方式） |
| `launchctl unload …plist` | 运行 `uninstall-startup.ps1` |
| `~/`（你的用户目录） | `C:\ooooo\xiaolai\自学是一门手艺`（笔记本根目录；默认取脚本所在目录往上两级） |

## 文件清单

| 文件 | 作用 |
| --- | --- |
| `jupyter-lab.cmd` | 真正启动 JupyterLab 的那条命令，日志写进 `logs\jupyter-lab.log`。**双击它**会留一个窗口，能直接看到报错，适合排查 |
| `jupyter-lab.vbs` | 用隐藏窗口的方式去跑上面的 `.cmd`，所以开机时不会闪一下黑框 |
| `install-startup.ps1` | 在「启动」文件夹里建一个指向 `.vbs` 的快捷方式（= `launchctl load`） |
| `uninstall-startup.ps1` | 删掉那个快捷方式（= `launchctl unload`） |
| `stop-jupyter-lab.cmd` + `stop-jupyter-lab.ps1` | 停掉正在跑的 8888 服务（= 关掉那个终端窗口） |

## 怎么用

**1. 先确认 8888 没被占着。** 如果你之前手动开过 JupyterLab（或者上一次的还在跑），它会和新服务抢端口，新服务会直接报错退出。先停掉旧的：

```powershell
cd C:\ooooo\xiaolai\自学是一门手艺\the-craft-of-selfteaching\jupyter-service
powershell -ExecutionPolicy Bypass -File .\stop-jupyter-lab.ps1
```

（没在跑的话它会说 `Nothing is listening on port 8888`，那就直接下一步。）

**2. 安装自启**（不需要管理员权限）：

```powershell
cd C:\ooooo\xiaolai\自学是一门手艺\the-craft-of-selfteaching\jupyter-service
powershell -ExecutionPolicy Bypass -File .\install-startup.ps1
```

`-ExecutionPolicy Bypass` 只对这一次运行生效，不改系统设置。

**3. 立刻试一下**（不必重启）：

```powershell
powershell -ExecutionPolicy Bypass -File .\install-startup.ps1 -Start
```

或者直接双击 `jupyter-lab.vbs`。等十几秒，浏览器打开 <http://localhost:8888/>，进去就是 JupyterLab，**不用再粘 token**。

**4. 不想要了**：

```powershell
powershell -ExecutionPolicy Bypass -File .\uninstall-startup.ps1
```

## 四个 Windows 特有的坑

### 1. `jupyter` 根本不在 PATH 里

这台机器上 JupyterLab 装在 `C:\Users\YU\anaconda3`，但那个 `Scripts` 目录没进用户 PATH（所以在终端里敲 `where jupyter` 是空的）。而**开机自启时的环境变量和你手敲命令时不一定一样**。所以脚本里一律写绝对路径：

```
C:\Users\YU\anaconda3\python.exe -m jupyter lab …
```

比 `jupyter-lab.exe` 更稳，也不依赖 PATH。你的 Anaconda 以后换了位置，改 `jupyter-lab.cmd` 开头的 `PYTHON=` 那一行就行（那一行是纯英文路径，可以随便改）。

笔记本根目录不用手写：脚本用 `%~dp0..\..` 自己往上推两级，也就是 `C:\ooooo\xiaolai\自学是一门手艺`。要换根目录，**别改文件里那行**（原因见坑 4），改用环境变量：

```powershell
setx JUPYTER_LAB_ROOT "D:\notes"
```

（`setx` 对之后新开的进程生效；改完最好注销重登一次。）

### 2. 文章里的配置项过时了

文章写于 2019 年（notebook 5 时代），`c.NotebookApp.*` 这套名字在 JupyterLab 4 / jupyter_server 2 里已经不认了，现在的名字是 `c.ServerApp.*`：

| 文章（旧） | 现在（JupyterLab 4） |
| --- | --- |
| `c.NotebookApp.token = ''` | `c.IdentityProvider.token = ''`（命令行仍可用 `--ServerApp.token=`） |
| `c.NotebookApp.open_browser = False` | `c.ServerApp.open_browser = False` |
| `c.NotebookApp.notebook_dir = '~/'` | `c.ServerApp.root_dir = r'C:\ooooo\xiaolai\自学是一门手艺'` |
| `c.NotebookApp.default_url = '/tree'` | `c.ServerApp.default_url = '/tree'` |

旧的写法**其实还能用**——`notebook_shim` 会把它们转交给 `ServerApp`，代价是日志里刷两行警告：

```
[JupyterNotebookApp] 'port' has moved from NotebookApp to ServerApp. ...
[JupyterNotebookApp] 'root_dir' has moved from NotebookApp to ServerApp. ...
```

但这属于「下个版本就删掉」的兼容层，所以你 `~/.jupyter/jupyter_notebook_config.py` 里那四行就算取消注释、靠垫片生效了，也不值得依赖。

这里的脚本干脆不吃配置文件，参数全写在 `.cmd` 里，一眼能看全。启动日志里还会有一行 `ServerApp.token config is deprecated in 2.0. Use IdentityProvider.token`，同理，**忽略**。

### 3. token 设空 = 等于没有密码

文章让你把 token 设成空字符串，图的是不用每次从终端里复制 token。这是对的，但前提是它只监听本机（默认就是 `localhost`，外网连不上）。日志里出现

```
[W] All authentication is disabled. Anyone who can connect to this server will be able to run code.
```

是预期内的。**别把 `--ServerApp.ip` 改成 `0.0.0.0`**，除非你清楚后果。

### 4. `.cmd` 里不能有中文——写进去会让整个脚本静默失效

这条是踩出来的：把 `ROOT_DIR` 改成 `C:\ooooo\xiaolai\自学是一门手艺` 之后，开机什么都不发生——没有窗口、没有报错、日志里也不多一行。

原因是编码对不上：`.cmd` 文件是 UTF-8 存的，而 cmd.exe 按系统 OEM 代码页（中文 Windows 是 936 / GBK）一字节一字节地读它。读到那几个中文字节时解析就错位了，直接在控制台里报：

```
'ab.cmd' is not recognized as an internal or external command,
operable program or batch file.
The syntax of the command is incorrect.
```

偏偏这个窗口是 `wscript.exe` 隐藏起来的，所以你看不见任何东西。

所以 `jupyter-lab.cmd` 现在是**纯 ASCII** 的（一个 >127 的字节都没有），根目录靠 `%~dp0..\..` 在运行时推出来——中文只在内存里，不经过文件解码。要换根目录就用上面说的 `JUPYTER_LAB_ROOT` 环境变量，别往文件里写中文路径。

同理，`jupyter-lab.vbs` 和两个 `.ps1` 也全是英文/ASCII。只有这个 `README.md` 是中文的，因为它是给人看的，不是给 cmd 解析的。

## 想要更像「系统服务」？

上面这套（启动文件夹）已经够用，只是有两个短板：**进程挂了不会自己重启**，也没有延迟启动。

### 任务计划程序（Task Scheduler）

这是 Windows 里 launchd 的正经对应物，可以设失败重启、延迟启动、只在某个网络下启动。

**图形界面**（推荐，不用跟引号搏斗）：按 <kbd>Win</kbd> 搜「任务计划程序」→「创建任务」→ 触发器「登录时」→ 操作「启动程序」，程序填 `wscript.exe`，参数填 `"C:\ooooo\xiaolai\自学是一门手艺\the-craft-of-selfteaching\jupyter-service\jupyter-lab.vbs"`（带引号）。

**命令行**：

```powershell
# 必须用【管理员】身份开 PowerShell，否则报 Access is denied（这一点已实测）
schtasks /Create /TN "JupyterLab" /TR "wscript.exe \"C:\ooooo\xiaolai\自学是一门手艺\the-craft-of-selfteaching\jupyter-service\jupyter-lab.vbs\"" /SC ONLOGON /RL LIMITED /F
```

卸载：`schtasks /Delete /TN "JupyterLab" /F`

> 这台机器上我不是管理员，所以命令行的 `/TR` 引号写法只核对了语法、没能端到端跑通；权限那一关是真的会卡住。要稳，用上面的图形界面。

### 真正的 Windows 服务（NSSM / WinSW）

用 [NSSM](https://nssm.cc/) 可以把任何 exe 注册成服务：

```powershell
nssm install JupyterLab "C:\Users\YU\anaconda3\python.exe" "-m jupyter lab --no-browser --ServerApp.root_dir=C:\Users\YU"
nssm set JupyterLab AppDirectory "C:\Users\YU"
nssm start JupyterLab
```

**但不建议为这件事上服务。** Windows 服务默认跑在没有用户桌面的 Session 0、以 SYSTEM 身份运行，`~` 会变成 `C:\Windows\system32\config\systemprofile`，快捷键、浏览器、文件权限都会变得别扭。你要的是「登录后就有」，不是「无人值守的服务器」——启动文件夹那套刚好。

## 停止 / 查看 / 日志

```powershell
# 看现在有哪些服务在跑
C:\Users\YU\anaconda3\Scripts\jupyter.exe server list

# 停掉 8888 那个
cd C:\ooooo\xiaolai\自学是一门手艺\the-craft-of-selfteaching\jupyter-service
powershell -ExecutionPolicy Bypass -File .\stop-jupyter-lab.ps1
```

因为服务是隐藏启动的，没有终端窗口可以关。双击 `stop-jupyter-lab.cmd` 效果一样，也可以带端口：`stop-jupyter-lab.cmd 8889`。

> **一个实测出来的坑**：`jupyter server stop 8888` 对这套配置**不管用**。它要发一个带 token 的关机请求，而我们为了省事把 token 关掉了（`--ServerApp.token=`），于是请求被 `HTTP 403: Forbidden` 拒绝——还甩一段 traceback，服务照旧活着。
>
> 所以停止脚本换个做法：找到监听这个端口的 python 进程，直接结束它。这也顺带解释了为什么任务管理器里能看到一个 `python.exe`——那就是服务本体。

日志在 `logs\jupyter-lab.log`，每启动一次追加一段。**开机后打不开 8888 时，先看这个文件**——最常见的两种内容是：

- `The port 8888 is already in use.` 和紧跟的 `ERROR: the Jupyter server could not be started because port 8888 is not available.`：上一个实例还活着，或者端口被别的程序占了。
- 末尾一行 `===== […] exited, code 1 =====`：往前翻 traceback，那是 Python 环境或某个扩展的问题。

这里特意加了 `--ServerApp.port_retries=0`：端口被占时**直接报错退出**，而不是悄悄换到 8889 去。否则你会看到 8888 打不开、却不知道服务其实活着，只是搬了家。

## 这套文件动了你系统的哪些东西

只做一件事：在「启动」文件夹（`C:\Users\YU\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`）里放一个 `JupyterLab.lnk`。同一个位置，你也可以按 <kbd>Win</kbd>+<kbd>R</kbd> 输入 `shell:startup` 自己打开看。

- 没有改你的 `~/.jupyter` 配置
- 没有改注册表
- 没有装任何第三方软件
- 没有动 PATH

不想用了就运行 `uninstall-startup.ps1`，或者直接把那个 `.lnk` 删掉，两者等价。
