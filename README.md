# nvazen-update

nvazen 系统的**在线更新仓库**：解决「ISO 安装后内容就定格了」的问题。

安装好的 nvazen 里的 `nvazen_update` 程序会读取本仓库的最新 [Release](../../releases)，
下载更新包、解包，然后按照包内 `lead.txt` 的指引完成安装。以后 NAAP、DeepTerminal 这些组件
出了新版本，发一个 Release 就行，用户不用重新下载整个 ISO。

## 工作原理

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

## lead.txt 语法

| 写法 | 作用 |
| --- | --- |
| `# ...` | 注释，忽略 |
| `/remove old-目标 [路径]` | 删除已安装的旧「目标」，不写路径时删 `INSTALL_BASE/目标` |
| `/install new-目标 [路径]` | 把更新包里的「目标」安装到位，不写路径时装到 `INSTALL_BASE/目标` |
| `/run 脚本 [参数...]` | 在更新包目录里执行安装脚本（如需要额外步骤时） |

示例（更新 NAAP 时就会是这样）：

```text
#this is the nvazen update lead file
#do not change the content unless error happened
/remove old-naap
/install new-naap
```

## 更新包结构

更新包就是一个 zip / tar.gz，里面**必须**有 `lead.txt`，其余按需放置：

```
nvazen-update-v0.1.0.zip
├── lead.txt
├── naap/            ← 新版 NAAP 的全部文件（install new-naap 装的就是这个目录）
│   └── ...
└── post.sh          ← 可选：/run post.sh 会执行它
```

`lead.txt` 可以放在包内任意一层目录里，程序会自动找到。

## nvazen_update 用法

```
nvazen_update                     # 检查并应用最新更新
nvazen_update --check             # 只检查有没有新版本（退出码 100 = 有新版本）
nvazen_update --dry-run           # 预演，只看会做什么、不实际改动
nvazen_update --force             # 版本一样也强制重新应用
nvazen_update --package 包.zip    # 本地测试更新包，跳过网络
```

- 默认安装目录 `/opt/nvazen`，可用 `/etc/nvazen-update.conf` 里的 `INSTALL_BASE` 修改；
- 安装到系统目录时需要 root：`sudo nvazen_update`；
- 已安装的版本记录在 `/var/lib/nvazen-update/current_version`（非 root 运行时在 `~/.local/share/nvazen-update/`），
  版本相同就自动跳过；
- 设置 `GH_TOKEN` 环境变量可提高 GitHub API 限额（不设也能用）；
- 可选：包里放 `SHA256SUMS` 校验文件，解包后会自动校验完整性。

## 发布一个新版本（网页操作）

1. 打开本仓库 → **Releases** → **Draft a new release**
2. 点 **Choose a tag**，输入新版本号，例如 `v0.1.0` → **Create new tag**
3. 标题随意（如 `v0.1.0 更新 NAAP`），把打包好的更新包拖进附件区
4. 点 **Publish release**

用户侧运行 `nvazen_update`（或等系统自动检查）就能收到这次更新。

> **tag 就是版本号**，每次发布必须用新的、更高的 tag，否则更新器会认为没有新版本。

## 许可证

GPL-3.0，见 [LICENSE](LICENSE)。
