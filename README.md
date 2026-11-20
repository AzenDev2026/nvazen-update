# 🐳 NVazen Update · Azen 新闻台

> 这里是 **NVazen 的自动更新仓库**，也是「NVazen Update」应用 News 页的新闻来源。
> 下面这段新闻会实时显示在每位用户的更新器里 —— 包括现在正在看的你！👋

---

## 📰 NVazen 新闻 · 生态正在迅速发展！

### 🚀 NVazen Update 全新上线（2026-11-20）

NVazen 从此告别「重装才能更新」：

- **自动更新** —— 更新器读取本仓库的最新 Release，把 NAAP、DeepTerminal 等组件更新到最新版
- **全新界面** —— 左侧栏「软件更新 / 系统更新」，News 页随时查看最新动态
- **新闻台** —— 就是你正在看的这一页，每次打开更新器都能看到 NVazen 的新鲜事

### 🧠 NAAP · 智能应用休眠（App Nap）

NAAP 的 App Nap 技术让后台应用自动「打盹」，省电又流畅，而且每次更新都更聪明。

### 💻 DeepTerminal 2.5.5 · Powerline 随心定制

提示符全面可定制：颜色、尖角/圆角、显示用户还是路径 —— 全都由你决定。

### 🎛️ SystemSettings v1.0 · 一键掌控系统

Windows 11 风格设置中心：深色/浅色/跟随系统、快捷设置卡、设备信息，应有尽有。

### 🧩 生态全家桶

- **NVazenMenu**：定制开始菜单 + 系统信息面板
- **ArchiveManager**：Windows 风格的压缩包管理器
- **sysfetch**：极简系统信息工具
- **azen.dev**：官网持续更新（update 29+）
- **Azenium 浏览器**：研发中 👀

### 📅 敬请期待

| 项目 | 说明 | 状态 |
| --- | --- | --- |
| 系统更新 | 一键升级整个 NVazen 系统 | 🚧 即将推出 |
| Azenium | NVazen 自己的浏览器 | 🚧 研发中 |

### 📊 生态速览

| 项目 | 是什么 | 状态 |
| --- | --- | --- |
| NAAP | 智能应用休眠（App Nap） | ✅ 持续更新 |
| DeepTerminal | 多功能终端 | ✅ 持续更新 |
| SystemSettings | 系统设置中心 | ✅ v1.0 |
| NVazen Update | 自动更新器 | ✅ 全新上线 |

---

## 🛠 这个仓库怎么工作

### 工作原理

```
nvazen_update（系统内）
   │  1. 查询最新 Release（tag 就是版本号）
   ▼
GitHub Release（本仓库）
   │  2. 下载更新包（zip / tar.gz），解包
   ▼
lead.txt（包内）
   │  3. 逐行执行安装指令
   ▼
目标位置（默认 /opt/nvazen/<目标>）
```

### lead.txt 语法

| 写法 | 作用 |
| --- | --- |
| `# ...` | 注释，忽略 |
| `/remove old-目标 [路径]` | 删除已安装的旧「目标」，不写路径时删 `INSTALL_BASE/目标` |
| `/install new-目标 [路径]` | 把更新包里的「目标」安装到位，不写路径时装到 `INSTALL_BASE/目标` |
| `/run 脚本 [参数...]` | 在更新包目录里执行安装脚本 |

示例（更新 NAAP 时就会是这样）：

```text
#this is the nvazen update lead file
#do not change the content unless error happened
/remove old-naap
/install new-naap
```

### 更新包结构

更新包就是一个 zip / tar.gz，里面**必须**有 `lead.txt`，其余按需放置：

```
nvazen-update-v0.1.0.zip
├── lead.txt
├── naap/            ← 新版 NAAP 的全部文件（install new-naap 装的就是这个目录）
│   └── ...
└── post.sh          ← 可选：/run post.sh 会执行它
```

### nvazen_update 用法

```
nvazen_update                     # 检查并应用最新更新
nvazen_update --check             # 只检查有没有新版本（退出码 100 = 有新版本）
nvazen_update --dry-run           # 预演，只看会做什么、不实际改动
nvazen_update --force             # 版本一样也强制重新应用
nvazen_update --package 包.zip    # 本地测试更新包，跳过网络
```

### 发布一个新版本（网页操作）

1. 打开本仓库 → **Releases** → **Draft a new release**
2. 点 **Choose a tag**，输入新版本号，例如 `v0.1.0` → **Create new tag**
3. 标题随意（如 `v0.1.0 更新 NAAP`），把打包好的更新包拖进附件区
4. 点 **Publish release**

> **tag 就是版本号**，每次发布必须用新的、更高的 tag，否则更新器会认为没有新版本。

## 许可证

GPL-3.0，见 [LICENSE](LICENSE)。
