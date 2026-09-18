# Blue Editorial Illustrations

克莱因蓝眼镜 IP 插画 skill：把文稿里的判断、关系和状态变化，转成由固定角色亲自完成的物理动作。

16:9、白底、黑色手绘墨线、连续冷灰体积、唯一克莱因蓝。默认中文图内短标注，明确要求时切换英文；HTML 的标题和正文仍为可编辑文本。

![文稿整理与成稿](blue-editorial-illustrations/assets/examples/01-manuscript-to-presentation.png)

## 核心逻辑

`文稿理解 -> 认知锚点 -> 核心判断 -> 物理动词 -> 低科技物件 -> IP 动作 -> 结果状态 -> 单张生图 -> QA -> PNG 交付`

不是先找一张旧图换标题。先选择值得视觉化的段落，再为每个命题发明一个成立的物理隐喻。示例仅校准 IP、笔触、留白和文字行为，不作为默认构图模板。

底层架构与工作流改编自 [Ian Xiaohei Illustrations](https://github.com/helloianneo/ian-xiaohei-illustrations)，替换为本项目自己的 IP、蓝色彩绘风格和 CLI 后端。对照记录见 [发布验收](docs/release-acceptance.md)。

## 安装

```bash
git clone https://github.com/Lee-study154/blue-editorial-illustrations.git
cd blue-editorial-illustrations
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R ./blue-editorial-illustrations "${CODEX_HOME:-$HOME/.codex}/skills/"
```

真正安装的是子目录 `blue-editorial-illustrations/`，不是整个仓库根目录。

可在 [Releases](https://github.com/Lee-study154/blue-editorial-illustrations/releases) 下载版本化安装 ZIP，解压得到同名 skill 文件夹。

## 使用

只做规划，不调用生图 API：

```text
Use $blue-editorial-illustrations 先不要生图。
为下面这篇文稿规划 5 张左右插画，输出位置、核心命题、物理隐喻、IP 动作和图内短标注。

<文稿>
```

直接生成：

```text
Use $blue-editorial-illustrations 为下面这份文稿生成 4 张插画。
默认中文图内短标注，预留 HTML 文字安全区。

<文稿>
```

单个概念：

```text
Use $blue-editorial-illustrations 为“反馈必须落实到下一轮动作才算闭环”生成一张插画。
```

英文配文：

```text
Use $blue-editorial-illustrations 为这份文稿生成 3 张插画，图内短标注用英文。
英文 reference 只校准字形与物件贴合，不复刻已有构图。
```

局部改图：

```text
Use $blue-editorial-illustrations 编辑这张图，只修正指定错字，保持人物、道具、构图和其他文字不变。
```

用于 HTML 演示：

```text
Use $blue-editorial-illustrations 结合这份文稿生成插画并制作 HTML 演示。
图内短标注与动作互动，页面标题和正文保持真实 HTML 文本，不遮挡脸、手和主道具。
```

Skill 不是 HTML 框架或前端模板。HTML 由执行 agent 实现并在目标视口验收，插画侧提供 shot list、资源和安全区。

## 运行前提

规划不需要 API。实际生图需要运行时提供 `imagegen` CLI、Python `openai` 依赖、支持 `gpt-image-2` 编辑接口的 provider 和安全凭证配置。

本项目已实测 ZenMux `https://zenmux.ai/api/v1`。`imagegen` 仅用其 CLI 程序，不混用 Codex 内置生图服务。仓库不包含 CLI、API key、Keychain 配置或自动付费调用；安装后不会自动生图。

新环境的检查步骤见 [CLI 运行环境](blue-editorial-illustrations/references/generation-runtime.md)。已有配置直接复用，IP 由 skill 自动提供，不要求用户每次手动上传。

## 中文 Reference

当前 8 张正式中文 reference，各有一份实际生成提示词：

| Reference | 图内配文 | 核心动作 |
| --- | --- | --- |
| 文稿整理 | 散页 / 成稿 | 组织零散输入形成展示稿 |
| 连接修复 | 断点 / 缝合 | 缝合断裂的工作带 |
| 双人承重 | 共同承重 / 稳固 | 协作安装蓝梁 |
| 分拣整理 | 杂讯 / 归位 | 把散页收进分拣架 |
| 多人工作台 | 送料 / 校准 / 收取 | 完成连续生产动作 |
| 修补交付 | 修补 / 交付 | 从修复走向验证与接收 |
| 推理判断 | 一步 / 判断 | 踏上台阶检查证据 |
| 最终校准 | 校准 / 完成 | 收紧夹具稳定连接 |

![连接修复](blue-editorial-illustrations/assets/examples/01-repairing-link-close.png)
![共同承重](blue-editorial-illustrations/assets/examples/02-shared-load.png)
![分拣整理](blue-editorial-illustrations/assets/examples/02-sorting-storm.png)
![多人工作台](blue-editorial-illustrations/assets/examples/03-workshop-team.png)
![修补交付](blue-editorial-illustrations/assets/examples/06-delivery.png)
![推理判断](blue-editorial-illustrations/assets/examples/06-reasoning.png)
![最终校准](blue-editorial-illustrations/assets/examples/07-conclusion.png)

## 英文标题 Reference

两张独立英文 reference 保留原图构图，仅加入英文手写短标注。这里“英文标题 reference”指物件旁的图内英文标注，不是整页幻灯片大标题。

![English manuscript reference](blue-editorial-illustrations/assets/examples/english-title/01-manuscript-to-presentation.png)
![English positioning reference](blue-editorial-illustrations/assets/examples/english-title/01-positioning.png)

详情与对应提示词见 [Reference Pack](blue-editorial-illustrations/references/reference-pack.md)。

## 目录与验证

```text
blue-editorial-illustrations/
  SKILL.md
  agents/openai.yaml
  references/
  prompts/
  assets/ip-reference.jpeg
  assets/examples/
  assets/examples/english-title/
  assets/validation/
  tests/
```

```bash
bash blue-editorial-illustrations/tests/contract.sh
python3 blue-editorial-illustrations/tests/release-contract.py
```

测试检查结构、可移植性、凭证模式、图像格式与提示词映射；不证明远端 API、视觉效果或 HTML 布局正确。图片和文字仍需人工 QA，HTML 安全区按实际画面和视口复核，不把提示词中的留白比例当作实测保证。

## 来源与权利

上游归属及 MIT 原文见 [THIRD_PARTY_NOTICES](blue-editorial-illustrations/THIRD_PARTY_NOTICES.md)。本仓库不包含上游小黑角色、彩绘参考原图或其示例图片。

IP 与自有图片不自动适用上游 MIT 授权。公开展示不等于素材开放授权，素材使用与再发布须取得相应授权；发布不新增对原创改编内容的许可。见 [权利说明](NOTICE.md)。
