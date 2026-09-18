# 自有 Reference Pack

这组自有生成图用于校准本 skill 的 IP、笔触、冷灰体积、克莱因蓝和构图密度，不包含上游仓库或彩绘参考原图。示例不是后续概念的场景模板。

## 视觉锚点

- `assets/examples/01-manuscript-to-presentation.png`：主风格锚点，观察黑色墨线、白底留白、蓝色焦点和动作构图。
- `assets/ip-reference.jpeg`：唯一身份锚点，锁定侧分黑发、圆镜框、单瞳孔、蓝色翻领、黑色宽裤和扁平小尖鞋。

## 8 张最终 Reference Pack

以下 8 张是当前正式样本，来自新版带中文字的 reference 批次。每张都是独立生成的 2048×1152 RGB PNG，文件名使用稳定的 canonical stem。主题覆盖文稿整理、连接修复、共同承重、分拣、多人工坊、交付、推理和收束；没有完全重复文件。

| 文件 | 结构 | 画面动作 | 互动式配文锚点 |
| --- | --- | --- | --- |
| `assets/examples/01-manuscript-to-presentation.png` | 单人全身 / 文稿整理 | 从散页中组织展示材料 | `散页` 贴近地面散页，`成稿` 贴近夹好的展示稿；标注分别指向输入与结果 |
| `assets/examples/01-repairing-link-close.png` | 单人全身 / 连接修复 | 缝合断裂的工作带 | `断点` 指向带子缺口，`缝合` 指向针线和连续接缝 |
| `assets/examples/02-shared-load.png` | 双人全身 / 协作承重 | 两人共同抬起并安装厚重蓝梁 | `共同承重` 写在蓝梁上，`稳固` 指向右侧支架底座 |
| `assets/examples/02-sorting-storm.png` | 单人全身 / 分拣整理 | 把散页扫入分拣架 | `杂讯` 指向散页，`归位` 指向架口的整齐纸堆 |
| `assets/examples/03-workshop-team.png` | 多人环境 / 工作台协作 | 送料、校准、收取连续发生 | `送料`、`校准`、`收取` 分别贴近进料口、导轨和成品堆 |
| `assets/examples/06-delivery.png` | 双人全身 / 修补交付 | 前景修补，背景穿过验证门完成交付 | `修补` 跟随接缝，`交付` 贴近验证门与接收动作 |
| `assets/examples/06-reasoning.png` | 单人全身 / 方法分层 | 沿台阶逐层接近判断结果 | `一步` 贴近第一阶，`判断` 贴近放大镜与顶端目标 |
| `assets/examples/07-conclusion.png` | 单人全身 / 概念收束 | 用夹具校准两根轨道的最终连接 | `校准` 贴近夹具，`完成` 贴近稳定接缝 |

这 8 张新版图的实际生成提示词保存在 `prompts/final-reference/`，与当前文件逐一对应；它们不是旧批次的重建提示词。生成式模型不能保证逐像素复现。

## 英文标题 Reference

以下两张是独立的英文标题 reference，不计入默认 8 张中文 reference，也不替换中文示例。它们保持原有构图、人物、道具和克莱因蓝配色，只在已有物件附近加入少量英文手写标注，用于校准英文标题/英文图内短标注的字形、长度和贴合方式。

| 文件 | 英文标注 | 使用边界 |
| --- | --- | --- |
| `assets/examples/english-title/01-manuscript-to-presentation.png` | `LOOSE PAGES`, `DRAFT`, `SORT`, `DELIVER` | 用户明确要求英文标题或英文图内标注时参考 |
| `assets/examples/english-title/01-positioning.png` | `NOISE`, `INPUT`, `SORT`, `IN ORDER` | 用户明确要求英文标题或英文图内标注时参考 |

这两张已由用户确认。对应提示词和 shot list 位于 `prompts/english-reference/`。这里的“英文标题 reference”指图内英文短标注样本，不是烧入图片的幻灯片大标题；英文 reference 只校准文字行为，不要求后续英文插画复用这两张的场景或构图。

## 图内短标注验证

`assets/validation/text-annotations-v1.png` 是独立的带字能力验证图，不属于 8 张正式 reference。它通过一次 ZenMux `gpt-image-2` CLI 实测：中文 `通路` 与 `卡点` 逐字正确，在 640px 缩略图下仍可读，并分别贴近蓝色路径和门楔。对应提示词、shot list 与无密钥执行摘要位于 `prompts/validation/`。

## 语言与字体

- 默认中文；用户明确说 English / 英文时才使用英文。
- 中文标题用有人文笔锋和粗细变化的宋体/人文宋，正文用舒展可读的人文宋。
- 英文标题用高对比、偏手写感的展示衬线，正文用温暖的书籍衬线。
- 图内短标注由生图绘制，中文用有人文笔锋的手绘字，英文用带手写感的展示衬线；逐字核对，不用胶囊标签或密集说明框。
- HTML 的演示标题和正文另作真实文本，不把长篇配文烧进 PNG，也不用默认浏览器字体。

## 收录标准

新图收录前必须通过 `references/qa-checklist.md`。多人桌面场景尤其检查：桌面是否是连续前景遮挡平面、躯干是否被桌沿切穿、腿脚是否落在桌下地面层、每个人的动作是否不同且可读。带字图还必须在原尺寸和缩略图下逐字检查。
