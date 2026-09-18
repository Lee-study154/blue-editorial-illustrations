# CLI 生图运行环境

## 发布包与本机配置的边界

Skill 提供风格、转译规则、IP 和参考图，不包含独立 API 客户端或私人配置。默认是外部 `gpt-image-2` CLI 路径，不切换到 Codex 内置 image generation。本项目已验证的 provider 是 ZenMux：`https://zenmux.ai/api/v1`。

本机已有安全配置时直接复用。换到新电脑时，不假定旧凭证、Keychain 服务名或绝对路径存在；先检查运行时的 `imagegen` skill 是否提供 `scripts/image_gen.py`、Python 是否具备 `openai` 依赖，以及所选 provider 是否支持 `/images/edits` 和 `gpt-image-2`。

缺少 CLI 时说明依赖缺口并请求用户安装对应运行时能力，不自动换后端或另写 SDK runner。缺少凭证时让用户通过环境变量或安全存储完成一次配置，不在聊天中索取完整 key，不写入仓库或 `.env`。

## 首次启动

在当前运行时发现 CLI 后，把实际路径赋给 `IMAGEGEN_CLI`；把 skill 根目录赋给 `ILLUSTRATION_SKILL_DIR`。不要沿用其他用户的绝对路径。Provider 通过 `OPENAI_BASE_URL` 指定，凭证由 `OPENAI_API_KEY` 或现有安全注入机制提供；这两个值不会随发布包传递。

先运行不联网、不收费的检查：

```bash
python3 "$IMAGEGEN_CLI" --help
python3 "$IMAGEGEN_CLI" edit \
  --model gpt-image-2 \
  --image "$ILLUSTRATION_SKILL_DIR/assets/ip-reference.jpeg" \
  --prompt-file '<compiled-shot-prompt.txt>' \
  --quality high \
  --size 2048x1152 \
  --output-format png \
  --out '<new-output-image.png>' \
  --no-augment \
  --dry-run
```

`compiled-shot-prompt.txt` 必须来自当前文稿的 shot list，不默认重跑 bundled reference。Dry run 只能验证参数与本地输入，不能证明凭证、余额、provider 能力或远端生图成功。

用户已要求生成且图像输入与外部传输授权明确后，移除 `--dry-run`，每张单独执行。新图默认只传 bundled IP；编辑时第一张是编辑目标，第二张自动附加 bundled IP 作为身份参考，与 prompt template 保持一致。输入清单必须在调用前明确，不能把自动附加当成额外上传授权；用户限定单张编辑目标时，只传该目标并同步改写提示词中的输入角色。英文 reference 默认不作为远端输入。

## 失败处理

记录无密钥错误摘要。401/403、余额不足、CLI 或模型不兼容时停止该请求，不盲目重复付费调用，不改后端或降低模型。局部视觉/文字错误按 QA 锁定其余区域修图；超出用户授权的调用数量或费用范围时，先展示现状再确认。交付保留实际 prompt、输入角色和输出路径，不声称像素级无损编辑。
