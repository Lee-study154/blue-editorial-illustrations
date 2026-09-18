#!/bin/sh
set -eu

skill_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

require_file() {
  [ -f "$skill_dir/$1" ] || fail "missing $1"
}

require_text() {
  file=$1
  pattern=$2
  rg -q -- "$pattern" "$skill_dir/$file" || fail "$file lacks required contract: $pattern"
}

reject_text() {
  file=$1
  pattern=$2
  if rg -q -- "$pattern" "$skill_dir/$file"; then
    fail "$file contains obsolete contract: $pattern"
  fi
}

for file in \
  SKILL.md \
  THIRD_PARTY_NOTICES.md \
  agents/openai.yaml \
  references/style-dna.md \
  references/ip-spec.md \
  references/composition-patterns.md \
  references/prompt-template.md \
  references/qa-checklist.md \
  references/reference-pack.md \
  prompts/README.md \
  assets/ip-reference.jpeg \
  assets/examples/01-manuscript-to-presentation.png \
  assets/examples/01-repairing-link-close.png \
  assets/examples/02-shared-load.png \
  assets/examples/02-sorting-storm.png \
  assets/examples/03-workshop-team.png \
  assets/examples/06-delivery.png \
  assets/examples/06-reasoning.png \
  assets/examples/07-conclusion.png \
  assets/examples/english-title/01-manuscript-to-presentation.png \
  assets/examples/english-title/01-positioning.png \
  assets/validation/text-annotations-v1.png \
  prompts/final-reference/01-manuscript-to-presentation.txt \
  prompts/final-reference/01-repairing-link-close.txt \
  prompts/final-reference/02-shared-load.txt \
  prompts/final-reference/02-sorting-storm.txt \
  prompts/final-reference/03-workshop-team.txt \
  prompts/final-reference/06-delivery.txt \
  prompts/final-reference/06-reasoning.txt \
  prompts/final-reference/07-conclusion.txt \
  prompts/final-reference/README.md \
  prompts/english-reference/01-manuscript-to-presentation.txt \
  prompts/english-reference/01-positioning.txt \
  prompts/english-reference/01-manuscript-to-presentation-shot-list.md \
  prompts/english-reference/01-positioning-shot-list.md \
  prompts/english-reference/README.md \
  prompts/validation/text-annotations-v1.txt \
  prompts/validation/text-annotations-v1-shot-list.md \
  prompts/validation/text-annotations-v1-execution.md
do
  require_file "$file"
done

example_count=$(find "$skill_dir/assets/examples" -maxdepth 1 -type f -name '*.png' | wc -l | tr -d ' ')
[ "$example_count" -eq 8 ] || fail "assets/examples must contain exactly 8 final PNG references, found $example_count"

require_text SKILL.md '^name: blue-editorial-illustrations$'
require_text SKILL.md 'HTML'
require_text SKILL.md 'references/style-dna.md'
require_text SKILL.md 'references/ip-spec.md'
require_text SKILL.md 'references/composition-patterns.md'
require_text SKILL.md 'references/prompt-template.md'
require_text SKILL.md 'references/qa-checklist.md'
require_text SKILL.md '4-8'
require_text SKILL.md '每张.*单独生成'
require_text SKILL.md '只做配图规划'
require_text SKILL.md '直接生成'
require_text SKILL.md '单个概念'
require_text SKILL.md '局部改图'
require_text SKILL.md 'assets/<article-slug>-illustrations/'
require_text SKILL.md '图内短标注'
require_text references/composition-patterns.md '图内标注'
require_text references/prompt-template.md 'Text \(verbatim\)'
require_text references/qa-checklist.md '错字'
require_text prompts/README.md '图内短标注'
reject_text SKILL.md '图片保持无文字'
reject_text references/prompt-template.md 'No readable text inside the image'

require_text references/style-dna.md '#002FA7'
require_text references/style-dna.md '硬边'
require_text references/ip-spec.md '每只眼睛.*一个.*瞳孔'
require_text references/ip-spec.md '扁平.*尖鞋'
require_text references/composition-patterns.md '安全留白'
require_text references/composition-patterns.md '多人'
require_text references/composition-patterns.md 'Workflow'
require_text references/composition-patterns.md '系统局部'
require_text references/composition-patterns.md '角色状态'
require_text references/composition-patterns.md '方法分层'
require_text references/composition-patterns.md '地图路线'
require_text references/composition-patterns.md '小漫画分镜'
require_text references/prompt-template.md 'Input Image 1'
require_text references/prompt-template.md 'HTML'
require_text references/qa-checklist.md '重复瞳孔'
require_text references/qa-checklist.md '纯色块'
require_text references/qa-checklist.md '三角支架'
require_text references/qa-checklist.md '桌面.*前景遮挡'
require_text references/reference-pack.md '默认中文'
require_text references/reference-pack.md '03-workshop-team.png'
require_text references/reference-pack.md '8 张最终 Reference Pack'
require_text references/reference-pack.md 'text-annotations-v1.png'
require_text references/reference-pack.md '英文标题 reference'
require_text prompts/README.md 'english-reference'
require_text SKILL.md '英文标题 reference'
require_text prompts/README.md 'single-concept.txt'
require_text prompts/README.md 'multi-person-workbench.txt'
require_text THIRD_PARTY_NOTICES.md 'MIT License'
require_text THIRD_PARTY_NOTICES.md '未包含.*示例图片'

if rg -q -- '彩色 偏向漫画|黑白线稿|ian-xiaohei|helloianneo' \
  "$skill_dir/SKILL.md" "$skill_dir/agents" "$skill_dir/references"; then
  fail "published skill contains source-reference names or copied-repo identifiers"
fi

if find "$skill_dir" -name '.env' -o -name '*.key' | grep -q .; then
  fail "secret-bearing file found"
fi

echo "Skill contract passed."
