# 提示词与生成执行

## 执行边界

- 本项目使用用户已选择的 CLI + `gpt-image-2` 外部 Image2 后端。不自动换成 Codex 内置生图服务。
- 复用已有的 provider 和凭证配置。不把 API key 写入命令日志、提示词、skill 或 `.env`。
- 新图默认 `2048x1152`、`quality=high`、PNG。如果只是快速构图草案，可用 `quality=low`。
- 使用 `imagegen` 的 CLI 语义和已有脚本，不新写一次性 SDK runner，不修改系统 CLI。
- 存在子 agent 时，执行者负责读取本文件并调用生图；主 agent 负责最终 QA。

## 新图模板

新生成时只上传 bundled IP。`Input Image 1` 是身份参考，不是构图参考。用英文编译提示词，将花括号替换为当前 shot list 内容；图内标注的实际文字必须保留用户所选语言，逐字输入。

```text
Use case: illustration-story
Asset type: standalone 16:9 editorial illustration for an HTML presentation

Primary request:
Create one original illustration that visualizes {core idea}. Show a concrete scene rather than a formal diagram.

Input images:
Input Image 1 is the ONLY identity reference for the recurring character. Preserve the character identity but invent a fresh pose, action, props, and composition for this manuscript. Do not copy the reference image's arrangement.

Scene/backdrop:
Clean white or near-white canvas. {environment}. Keep props sparse and narratively necessary.

Subject and action:
{number of characters}. The recurring glasses character is {physical action}. {supporting interaction or result}. The character performs the conceptual action and is not a decorative mascot.

Character invariants:
Side-parted black hair; two large round glasses; two separate white oval eyes; exactly one solid black oval pupil inside each eye; both pupils look in the same {gaze direction}. Small rounded face with restrained cool-gray jaw plane. Klein-blue collared top with hard-edged cool-gray fold planes. Very wide black trousers with 15-30% cool-gray folded facets. Flat small pointed shoes extending naturally sideways beneath the trouser hems.

Style/medium:
Hand-painted editorial comic illustration. Expressive black ink contours with visible line-weight variation, slightly imperfect turns, occasional restrained redraw marks, matte flat brush fills, and sparse dry-brush edges. Sophisticated and work-focused, not childish.

Composition/framing:
2048x1152, 16:9. Place the visual action in {illustration zone}. Preserve {safe-zone percentage} of calm white negative space on the {safe-zone side} for HTML title and body copy. Keep hands, face, the core prop, and all in-image lettering outside the HTML text safe zone.

Spatial layering:
For desk or workbench scenes, place all characters behind one continuous tabletop. The tabletop is a foreground occlusion plane that hides waists naturally; legs and flat shoes remain on the floor layer below it. Arms and hands may rest over the tabletop, but no torso, leg, or shoe may pass through the tabletop or merge with table legs.

Color palette:
Klein blue #002FA7 is the only saturated hue. Everything else is black, white, cool light gray, or cool mid gray. Minor antialias shades are acceptable; no second hue.

Lighting and modeling:
Use only hard-edged flat gray structural planes on sleeve undersides, side seams, folds, jaw, hands, and trouser facets. No gradients, soft shadows, realistic lighting, rim lights, airbrush, or 3D rendering.

Text (verbatim):
Draw only these {1-4} short handwritten annotations as part of the illustration, each beside or following the contour of its named visible action, object, or result. Render the exact characters in the requested language; do not translate or paraphrase them:
{annotation 1: "exact text" -> visible anchor and placement}
{annotation 2: "exact text" -> visible anchor and placement}
{optional annotation 3-4}
Use expressive black ink lettering with restrained Klein-blue accents and varied hand-drawn strokes; Chinese has humanistic brush-like contrast, English has informal editorial display-serif character. Keep every label legible at slide size. No label boxes, slide headline, explanatory paragraph, or unrelated words. HTML slide title and body will be rendered separately as real text.

Constraints:
One image communicates one core idea. Preserve generous negative space. Use 3-7 supporting objects at most. No watermark, logo, decorative frame, card container, slide title, dense arrows, formal flowchart, app UI, generic corporate vector illustration, or repeated composition from prior examples. No duplicate pupils, double irises, extra eyes, triangular support-like feet, thick soles, or anatomical toes.
```

## 已有成图的定向修正

修图时，`Input Image 1` 是编辑目标，`Input Image 2` 是 IP 身份参考。每次只改一类问题。

```text
Use case: precise-object-edit
Asset type: locked revision of an approved HTML-presentation illustration

Input images:
Input Image 1 is the EDIT TARGET. Input Image 2 is the ONLY character identity reference.

Primary request:
Change only {specific faulty region or property}. {positive description of corrected result}.

Locked invariants:
Preserve the canvas size, composition, character pose and identity, face outline, hair, glasses, clothing, gray structural planes, feet, props, background, Klein-blue elements, approved in-image labels, and HTML text safe zone. Do not add objects or redesign the scene unless the target is one specific label.

Avoid:
{failure-specific negatives}. No extra words, watermark, new hue, gradient, soft shadow, or style drift.
```

图内标注拼写错误时，只编辑错字及紧邻笔画；提示词写出原字和目标字的逐字替换，锁定人物、道具及其他正确标注。如果整张图的文字均不稳定，减少标注数量后重新生成。

### 眼部专修语句

```text
Inside each round lens, draw one separate white oval eye and exactly one solid black small oval pupil. Keep both pupils aligned toward the same gaze direction. Remove duplicate pupils, concentric irises, accidental extra eye marks, and pupil-like highlights. Preserve the round frames, eyebrows, nose, mouth, face shading, and every pixel outside the face region as closely as possible.
```

## 生成分工

交给子 agent 时，任务必须包含：

- 本 skill 绝对路径。
- 当前文稿或 shot list 项。
- IP 绝对路径及其“身份参考”角色。
- 只允许的图像输入清单。
- 准确输出路径、尺寸、编号和不覆盖要求。
- 需要锁定的不变项和本次唯一修改目标。
- 不上传风格示例，除非用户为当前调用明确要求。
