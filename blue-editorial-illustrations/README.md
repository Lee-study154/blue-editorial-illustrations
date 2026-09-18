# Blue Editorial Illustrations

一个面向中文文稿、抽象概念和 HTML 演示的 Codex skill。它沿用 `ian-xiaohei-illustrations` 的“文稿拆解 -> shot list -> 原创物理隐喻 -> 角色动作 -> QA”工作方式，但只使用本项目自己的 IP 和图片，不携带上游角色素材或参考原图。

## 用途

- 将一段文稿拆成少量可读的视觉锚点。
- 用固定眼镜 IP 完成整理、修复、协作、分层和交付等具体动作。
- 生成黑、白、冷灰与单一克莱因蓝的编辑漫画插画。
- 在插画中绘制贴合动作/物件的短手写标注，并为 HTML 演示另配可编辑的标题和正文。

## 使用

安装到 Codex：

```bash
mkdir -p "${CODEX_HOME:-$HOME/.codex}/skills"
cp -R ./blue-editorial-illustrations "${CODEX_HOME:-$HOME/.codex}/skills/"
```

在 Codex 中直接调用：

```text
Use $blue-editorial-illustrations to turn this manuscript into 4-6 original illustrations.
Keep the in-image handwritten labels and HTML captions in Chinese unless I explicitly request English.
```

只要用户给出一个概念，就只规划或生成一张图；只有明确要求整组演示时才扩展为 4-8 个视觉锚点。默认使用全身构图，确保动作、宽裤、鞋和地面接触可读；只有明确要求近景时才使用半身。默认输出 2048x1152 PNG，图内绘制 1-4 个与画面动作互动的短手写标注，默认中文，明确要求时切换英文。HTML 阶段把图片作为满页视觉层，把演示标题和正文作为真实 DOM 文本放进 shot list 指定的安全留白。

首次生图需要运行时提供 `imagegen` CLI、Python 的 `openai` 依赖、支持 `gpt-image-2` 编辑接口的 provider 和安全凭证配置，详见 [generation-runtime.md](references/generation-runtime.md)。本仓库不携带 CLI 程序或 API key，也不会因为安装 skill 自动执行付费生图。规划不需要 API。

## 目录

- `SKILL.md`：触发条件、工作流和输出边界。
- `references/`：风格 DNA、IP 规范、构图、提示词、QA 与 reference pack。
- `prompts/`：当前 preset、8 张最终 reference 的提示词记录与带字实测材料。
- `assets/ip-reference.jpeg`：身份参考。
- `assets/examples/`：自有风格与构图样本。
- `assets/examples/english-title/`：两张独立英文标题 reference，不替换默认中文 reference。
- `agents/openai.yaml`：Codex 界面元数据。
- `tests/contract.sh`：结构和关键约束检查。
- `tests/release-contract.py`：可移植性、凭证模式、reference 格式与提示词映射检查。

## 公开发布

发布前运行 `tests/contract.sh`，并确认 `assets/` 中只包含有权公开的自有图片。上游来源与 MIT 文本见 `THIRD_PARTY_NOTICES.md`。

当前 reference pack 以 `references/reference-pack.md` 标出的 8 张用户最终选图为准。图内短标注能力另由 `assets/validation/text-annotations-v1.png` 验证；旧的 reference 迭代与半身探索不再属于 skill。

英文标题 reference 单独放在 `assets/examples/english-title/`，仅在用户明确要求英文标题或英文图内短标注时使用；对应提示词与 shot list 位于 `prompts/english-reference/`。

## 常用入口

只做配图规划：

```text
Use $blue-editorial-illustrations 先不要生图。
请分析下面这篇文章哪里值得配图，输出 5 张左右的 shot list。
每张写清楚：放在哪段后、主题、核心意思、结构类型、IP 在做什么、建议图内短标注词。
```

直接生成正文配图：

```text
Use $blue-editorial-illustrations 把下面这篇文章生成 4 张正文配图。
默认中文图内短标注，16:9、克莱因蓝 IP、留出 HTML 文字安全区。
```

单个概念：

```text
Use $blue-editorial-illustrations 为“把零散信息变成可交付结果”生成一张配图。
```

局部改图：

```text
Use $blue-editorial-illustrations 编辑这张图，只修正眼睛或图内短标注，其他内容保持不变。
```

也可以直接提供截图或已有 PNG 作为编辑目标；IP 身份参考由 skill 自动使用，不要求每次重新上传。
