# R Science Figure Workflow

一个面向 Codex 的技能：检查并搭建 R、RStudio、`ggplot2` 和 `ggsci` 环境，再验证科研绘图和 NPG / AAAS 配色。

## 能做什么

- 检查现有 R、RStudio 和包库；保留已有环境，按需补齐缺失组件。
- 在授权安装时，依据操作系统从可信来源选择兼容的 R 和 RStudio。需要管理员认证或安装器交互时，由使用者完成。
- 安装缺失的 `ggplot2`、`ggsci` 及依赖；测试加载、NPG / AAAS 配色与基础绘图。
- 用用户的数据协助生成可复现脚本与图表，并根据目标期刊要求调整。

## 安装到 Codex

macOS / Linux，在终端运行：

```bash
mkdir -p ~/.codex/skills
git clone https://github.com/Yaobin29/r-science-figure-workflow.git ~/.codex/skills/r-science-figure-workflow
```

Windows PowerShell：

```powershell
New-Item -ItemType Directory -Force "$HOME\.codex\skills" | Out-Null
git clone https://github.com/Yaobin29/r-science-figure-workflow.git "$HOME\.codex\skills\r-science-figure-workflow"
```

安装后启动或重新启动 Codex，让它发现技能。输入：

```text
$r-science-figure-workflow 检查并配置 R、RStudio 和科研绘图包，再验证 NPG 与 AAAS 配色。
```

这条请求授权 Codex 检查和配置当前电脑。它会先判断系统和现有软件；如果网络、系统权限、图形界面或兼容性不允许自动完成，会说明还需哪些步骤。已有 R、项目锁定环境或包不会被默认升级或替换。无桌面的服务器不默认安装或测试 RStudio Desktop。若只希望检查，明确写“只检查，不安装”。

## 配色示例

在完成包安装的 RStudio Console 中：

```r
values <- c(20, 50, 80, 40, 60, 100)
barplot(values, col = ggsci::pal_npg()(6),
        names.arg = paste("Group", LETTERS[1:6]),
        xlab = "Group", ylab = "Value")
```

把 `pal_npg()` 改成 `pal_aaas()` 即可试用 AAAS 风格。`ggsci` 的配色受期刊图表启发，并非期刊官方模板或投稿合规保证；数据表达、统计、文件格式和最终规范仍需按目标期刊及研究设计核对。

## 验证与范围

本项目已在 macOS Apple Silicon 的既有 R 4.6.1 环境中测试包检测、安装和绘图；其他系统的完整安装流程依赖其实际权限、网络和官方支持状态，尚未在所有平台实机验证。`SKILL.md` 说明完整流程，`scripts/setup_packages.R` 只处理 R 包及绘图验证，系统软件安装由 Codex 根据系统和官方资料执行。

[English version](README.en.md) · [Skill instructions](SKILL.md) · [MIT License](LICENSE)
