# Blue Label Trial Execution Summary

- Status: success
- Provider: `https://zenmux.ai/api/v1`
- Model: `gpt-image-2`
- Operation: `edit` with one identity-reference image
- Quality: `high`
- Size: `2048x1152`
- Output format: `png`
- Prompt augmentation: disabled; `prompt.txt` was sent unchanged
- Input image: `assets/ip-reference.jpeg` relative to the skill root
- Prompt: `prompts/validation/text-annotations-v1.txt`
- Shot list: `prompts/validation/text-annotations-v1-shot-list.md`
- Published output: `assets/validation/text-annotations-v1.png`
- API duration reported by CLI: `79.2s`
- Output validation: valid non-interlaced RGB PNG, `2048x1152`, no alpha, `1,276,769` bytes
- SHA-256: `a955a6cf62d7d8482bdf4ee443fe97c715fdd430c7461090664dfda83b54bd0e`

Command summary, with the Keychain credential injection intentionally omitted:

```bash
OPENAI_BASE_URL='https://zenmux.ai/api/v1' \
python3 "$IMAGEGEN_CLI" edit \
  --model 'gpt-image-2' \
  --image 'assets/ip-reference.jpeg' \
  --prompt-file 'prompts/validation/text-annotations-v1.txt' \
  --quality 'high' \
  --size '2048x1152' \
  --output-format 'png' \
  --out '<new-output-image.png>' \
  --no-augment
```

`IMAGEGEN_CLI` is the runtime-provided CLI path. The original API credential was read from a secure store into process memory; it was not printed or saved. The published bundle contains no private runtime configuration.
