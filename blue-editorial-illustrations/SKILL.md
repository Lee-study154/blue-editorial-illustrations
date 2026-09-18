---
name: blue-editorial-illustrations
description: Use when a Chinese article, post, blog, Notion page, workflow document, screenshot, manuscript, abstract concept, or HTML presentation needs original IP-led illustrations, illustration planning, or targeted image edits in a cobalt-blue editorial comic style.
---

# 克莱因蓝 IP 演示插画

## 核心定位

把文稿中的关键判断、抽象关系和状态变化，转成由固定眼镜 IP 角色亲自完成核心动作的编辑漫画插画。主视觉是黑、白、冷灰与单一克莱因蓝；不做通用矢量图库、正式流程图或幼儿吉祥物。

## 参考路由

按当前任务读取，不要一次加载全部：

- 必须读 [style-dna.md](references/style-dna.md)：线条、颜色、灰面、材质和光影。
- 必须读 [ip-spec.md](references/ip-spec.md)：IP 的头部、眼睛、服装、鞋和多角色一致性。
- 需要从文稿规划配图或 HTML 演示时，读 [composition-patterns.md](references/composition-patterns.md)。
- 生成或修图时，读 [prompt-template.md](references/prompt-template.md)。
- 第一次在新环境生成，或 CLI/provider 未配置时，读 [generation-runtime.md](references/generation-runtime.md)。
- 查收和迭代时，读 [qa-checklist.md](references/qa-checklist.md)。
- 需要选择、命名或复核自有示例与互动式配文时，读 [reference-pack.md](references/reference-pack.md)。
- 需要复制可用的任务提示词骨架时，读 [prompts/README.md](prompts/README.md)。

`assets/ip-reference.jpeg` 是默认身份参考；`assets/examples/01-manuscript-to-presentation.png` 是已确认的风格基准，只做本地视觉校准，不默认作为外部生图输入，也不复制它的场景。

`assets/examples/english-title/` 是独立的英文标题 reference；只有用户明确要求英文标题或英文图内短标注时才读取，不替换默认中文 reference，也不改变默认中文输出。

默认构图以完整人物为主：单人概念、双人协作和多人环境优先使用全身或完整动作姿态；只有用户明确要求半身，或画面需要近距离手部动作时，才启用半身裁切。多人和大场景必须保留完整的腿脚、地面接触和前后空间关系。

## 使用模式

- **只做配图规划**：用户说“先分析、不要生图”时，只输出 shot list。
- **直接生成**：用户说“生成、做图、输出配图”时，完成规划后直接生成，不停在提示词。
- **单个概念**：用户只给一个观点时，只生成一张图，不扩成一组。
- **局部改图**：用户指出眼睛、鞋、颜色、文字或其他局部错误时，锁定已成立的画面，每轮只修一类问题。

## 工作流

1. 读取用户提供的文稿、链接、Markdown 或截图，提炼中心命题、认知转折和可被画成物理动作的抽象概念；不适合画面的段落保留为文字，不平均配图。
2. 不平均配图。默认选 4-8 个视觉锚点；短文用 1-3 张，长文也不轻易超过 9 张。每张只表达一个核心命题。
3. 先产出 shot list：放置位置、核心意思、结构类型、物理隐喻、IP 动作、人数、环境、逐字确定的图内短标注及其物件锚点、HTML 文字安全留白。
4. 用文字编译风格，生成时自动附加 bundled IP；用户不需要每次手动上传 IP。外部传输仍遵守当前运行时的授权要求。
5. 默认走 CLI + `gpt-image-2` 外部 Image2 后端。`imagegen` 只提供 CLI 工作流，不代表切换到 Codex 内置生图服务。复用现有配置，不让用户重复输入密钥，不打印或写入凭证；发布包不含私人配置，首次启动按 runtime 说明检查。
6. 存在子 agent 时，把生成和修图交给一个执行型子 agent；多张图每张单独生成，不拼成一张。主 agent 亲自查看原尺寸和缩略图，根据 QA 决定通过或定向修正。
7. 用户要求 HTML 演示时，把插画作为无边框的满页视觉层；图内短标注随插画绘制，演示标题和正文仍是真实 HTML 文字，放在预留安全区。

## 配文原则

- 每张图默认绘制 1-4 个短手写标注，分别贴近画面中可见的动作、物件或结果；在 shot list 中逐字列出文字和位置，不把整段文稿或幻灯片标题画进图中。
- HTML 标题和说明先指向画面动作，再连接抽象观点；不重复图内标注，也不直接复述整段文稿。
- 默认中文。只有用户明确要求 English / 英文时才切换英文，不在同一组中混用两种语言。
- 英文标题 reference 只作为英文标注的字形、长度和物件贴合校准；英文内容仍需按当前 shot list 逐字确定，不复制其场景。
- 图内文字沿用黑墨线与少量蓝色点染的手绘字形，像画面本来的一部分，不做标签框；中文有笔锋和粗细变化，英文参考有手写感的展示衬线。HTML 标题使用短句、说明控制在一至两行，保留有设计感且可读的字体。
- 生图后逐字核对短标注；错字或缺字优先局部修图，无法稳定修正时缩短标注重新生成，不以 HTML 叠字冒充图内手写。

## 输出

只要策略时输出简洁 shot list。明确要求生成时不停在提示词：生成、检查、修正并交付文件路径。默认保存到 `assets/<article-slug>-illustrations/NN-topic.png`，不覆盖已确认版本。交付时说明每张用途，并标出最稳定的必选图与可选图。
