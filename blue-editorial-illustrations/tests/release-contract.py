#!/usr/bin/env python3
"""Check the portable release without needing an image API or private config."""

import hashlib
import re
import struct
import sys
from pathlib import Path


def check(skill_dir):
    errors = []
    text_suffixes = {".md", ".txt", ".yaml", ".yml", ".sh", ".py"}
    credential_pattern = re.compile(
        r"\b(?:sk-[A-Za-z0-9_-]{20,}|gh[pousr]_[A-Za-z0-9_]{20,})"
        r"|-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----"
    )
    stale_pattern = re.compile(
        r"pending main-agent|not yet synced|待确认", re.IGNORECASE
    )
    for path in sorted(skill_dir.rglob("*")):
        if not path.is_file():
            continue
        relative = path.relative_to(skill_dir)
        if path.name in {".DS_Store", ".env"} or path.suffix in {".key", ".pem"}:
            errors.append(f"Excluded file: {relative}")
        if path.suffix not in text_suffixes:
            continue
        content = path.read_text(encoding="utf-8")
        if credential_pattern.search(content):
            errors.append(f"Credential-like content: {relative}")
        if path.suffix in {".md", ".txt", ".yaml", ".yml"}:
            if "/Users/" in content or "/home/" in content:
                errors.append(f"Private machine path: {relative}")
            if stale_pattern.search(content):
                errors.append(f"Stale approval status: {relative}")

    examples = skill_dir / "assets/examples"
    chinese = sorted(examples.glob("*.png"))
    english = sorted((examples / "english-title").glob("*.png"))
    if len(chinese) != 8:
        errors.append(f"Expected 8 Chinese references, got {len(chinese)}")
    if len(english) != 2:
        errors.append(f"Expected 2 English references, got {len(english)}")

    hashes = set()
    for path in chinese + english:
        relative = path.relative_to(skill_dir)
        data = path.read_bytes()
        if len(data) < 33 or data[:8] != b"\x89PNG\r\n\x1a\n":
            errors.append(f"Invalid PNG: {relative}")
            continue
        width, height, depth, color = struct.unpack(">IIBB", data[16:26])
        if (width, height, depth, color) != (2048, 1152, 8, 2):
            errors.append(f"Unexpected PNG dimensions or RGB mode: {relative}")
        digest = hashlib.sha256(data).hexdigest()
        if digest in hashes:
            errors.append(f"Duplicate reference image: {relative}")
        hashes.add(digest)
        folder = "english-reference" if path in english else "final-reference"
        prompt = skill_dir / "prompts" / folder / f"{path.stem}.txt"
        if not prompt.is_file():
            errors.append(f"Missing prompt for: {relative}")

    return errors


def main():
    skill_dir = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).resolve().parents[1]
    errors = check(skill_dir)
    for error in errors:
        print(f"FAIL: {error}", file=sys.stderr)
    if errors:
        return 1
    print("Release contract passed: portable files, no credential patterns, 8 Chinese + 2 English references.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
