# Prompt Presets

这些文件是可复制的任务入口，不替代 `references/prompt-template.md`。生成前仍需按当前 shot list 填入核心命题、动作、环境、图内短标注的逐字文本及物件锚点、HTML 安全留白。

- [`single-concept.txt`](single-concept.txt)：单人或单个抽象概念。
- [`multi-person-workbench.txt`](multi-person-workbench.txt)：3-5 人共享桌面/工作台的多人环境。
- [`final-reference/`](final-reference/)：8 张最终 reference 的原始或可追溯复现提示词；它们是来源记录，不覆盖当前模板。
- [`english-reference/`](english-reference/)：两张已确认的英文标题 reference、对应提示词和 shot list；仅在用户明确要求英文时读取。
- [`validation/`](validation/)：图内短标注实测的提示词、shot list 与无密钥执行摘要。

两种 preset 都默认：只上传 `assets/ip-reference.jpeg` 作为身份参考；图片中直接绘制 1-4 个短手写标注，默认中文、明确要求时英文；HTML 标题和正文仍由 DOM 渲染。使用 `gpt-image-2` CLI 时沿用项目现有 provider 和凭证配置。
