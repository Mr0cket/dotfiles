#!/usr/bin/env python3
import sys
import json

for line in sys.stdin:
    line = line.strip()
    if not line:
        continue
    try:
        obj = json.loads(line)
        print(json.dumps(obj, indent=2, ensure_ascii=False))
    except json.JSONDecodeError as e:
        print(f"[ERROR] Failed to decode JSON: {e}\nLine: {line}", file=sys.stderr) 