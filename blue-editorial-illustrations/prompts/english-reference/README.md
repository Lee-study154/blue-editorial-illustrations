# English-title reference edits

Status: visually reviewed and confirmed by the owner; included in the published and installed skill.

## Inputs

- Owner-selected original: `01-manuscript-to-presentation.png` (original composition, not the newer Chinese scene).
- Owner-selected original: `01-positioning.png`.

These source edits used the owner's original files, which are not redistributed as separate unlettered assets. The approved results are in `assets/examples/english-title/` relative to the skill root.

Each input was sent separately as the single edit target to ZenMux. No style-reference image or API credential was sent or stored in this folder.

## Model and command

- Provider base URL: `https://zenmux.ai/api/v1`
- Model: `gpt-image-2`
- Operation: `edit`
- Quality: `high`
- Size: `2048x1152`
- Output: RGB PNG
- Prompt augmentation: disabled (`--no-augment`)

The bundled CLI was used:

```bash
python3 "$IMAGEGEN_CLI" edit \
  --model gpt-image-2 \
  --image <input-image> \
  --prompt-file <prompt-file> \
  --quality high \
  --size 2048x1152 \
  --output-format png \
  --out <output-image> \
  --no-augment
```

`IMAGEGEN_CLI` is the runtime-provided imagegen CLI path. Credential injection is intentionally omitted; private configuration and logs are not bundled.

## Deliverables and exact text

- `assets/examples/english-title/01-manuscript-to-presentation.png`: `LOOSE PAGES`, `DRAFT`, `SORT`, `DELIVER`
- `assets/examples/english-title/01-positioning.png`: `NOISE`, `INPUT`, `SORT`, `IN ORDER`

Prompts and shot lists are kept in `prompts/english-reference/`; approved output images are kept in `assets/examples/english-title/`. Both paths are relative to the skill root. The annotations are intentionally short, object-adjacent, and subordinate to the original composition; they are not HTML title text.

## Validation

Both outputs were checked as `2048 x 1152`, RGB, non-interlaced PNG files. The main agent reviewed the composition and exact English strings, and the owner confirmed both for inclusion as English-title references. These are object-adjacent annotations, not HTML slide headlines.
