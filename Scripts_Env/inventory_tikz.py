#!/usr/bin/env python3
"""
inventory_tikz.py — 扫描 LaTeX 项目中所有 .tex 子文件，
统计每个逻辑小节（section 或 bfseries 标题）下的 tikzpicture 和 tabular 数量，
并提取标题，用于重构章节划分。

修复：同时检测 \section{} 和 {\large\bfseries 解答：...} 两种标题格式
修复：tikzpicture 正则匹配带参数的情况
"""
import re, os, sys, json
from pathlib import Path

PROJECT = Path(r"c:\Users\lsmihiing\Desktop\02 智羚学伴 26春教辅 智书粗加工\2支援小学数学")
LATEX_DIR = PROJECT / "LaTeX_Project"
TEMP_DIR  = PROJECT / "Temp_Work"

# 匹配 \begin{tikzpicture} 或 \begin{tikzpicture}[...]
TIKZ_RE = re.compile(r'\\begin\{tikzpicture\}')
# 匹配 \begin{tabular}{...}
TAB_RE  = re.compile(r'\\begin\{tabular\}')

# 匹配两种标题格式:
# 1. \section{解答：...} 或 \section*{...}
# 2. {\large\bfseries 解答：...}
HEADER_RE = re.compile(
    r'\\section\*?\{(.+?)\}'
    r'|'
    r'\\bfseries\s+(解答[：:].+?)\}'
)

def scan_file(filepath):
    """扫描单个 tex 文件，返回结构化的 section 列表"""
    with open(filepath, encoding="utf-8") as f:
        text = f.read()
    
    # 找到所有标题位置
    header_matches = list(HEADER_RE.finditer(text))
    
    results = []
    
    for idx, m in enumerate(header_matches):
        start = m.start()
        end = header_matches[idx+1].start() if idx+1 < len(header_matches) else len(text)
        chunk = text[start:end]
        
        tikz_count = len(TIKZ_RE.findall(chunk))
        tabular_count = len(TAB_RE.findall(chunk))
        
        # 提取标题（group(1) 来自 \section, group(2) 来自 \bfseries）
        title = m.group(1) if m.group(1) else m.group(2)
        title = title.strip()
        
        results.append({
            "title": title,
            "tikz": tikz_count,
            "tabular": tabular_count,
        })
    
    # 也统计标题之前的内容
    if header_matches:
        pre_text = text[:header_matches[0].start()]
        pre_tikz = len(TIKZ_RE.findall(pre_text))
        pre_tab = len(TAB_RE.findall(pre_text))
        if pre_tikz > 0 or pre_tab > 0:
            results.insert(0, {"title": "[文件头部无标题]", "tikz": pre_tikz, "tabular": pre_tab})
    elif text.strip():
        # 整个文件没有标题
        tikz_count = len(TIKZ_RE.findall(text))
        tabular_count = len(TAB_RE.findall(text))
        if tikz_count > 0 or tabular_count > 0:
            results.append({"title": "[无标题内容]", "tikz": tikz_count, "tabular": tabular_count})
    
    total_tikz = sum(s["tikz"] for s in results)
    total_tab = sum(s["tabular"] for s in results)
    
    return {
        "file": str(filepath.relative_to(PROJECT)),
        "sections": results,
        "total_tikz": total_tikz,
        "total_tabular": total_tab,
        "total_sections": len(results),
    }

def main():
    all_results = []
    
    # 扫描主项目
    for subdir in ["数学", "物理"]:
        base = LATEX_DIR / subdir
        if not base.exists():
            continue
        for tex in sorted(base.rglob("*.tex")):
            r = scan_file(tex)
            all_results.append(r)
    
    # 扫描临时工作区
    for tex in sorted(TEMP_DIR.glob("temp_answer.tex")):
        r = scan_file(tex)
        all_results.append(r)
    
    # 输出汇总
    grand_tikz = 0
    grand_tab = 0
    grand_sec = 0
    
    print("=" * 80)
    print("LaTeX 项目绘图/表格完整清单")
    print("=" * 80)
    
    for r in all_results:
        print(f"\n📁 {r['file']}")
        print(f"   标题数: {r['total_sections']}  |  tikzpicture: {r['total_tikz']}  |  tabular: {r['total_tabular']}")
        for s in r["sections"]:
            tag = []
            if s["tikz"]: tag.append(f"{s['tikz']}tikz")
            if s["tabular"]: tag.append(f"{s['tabular']}tab")
            marker = " [" + ", ".join(tag) + "]" if tag else " [无图表]"
            print(f"   ├─ {s['title']}{marker}")
        grand_tikz += r["total_tikz"]
        grand_tab  += r["total_tabular"]
        grand_sec  += r["total_sections"]
    
    print("\n" + "=" * 80)
    print(f"总计: {len(all_results)} 个文件, {grand_sec} 个逻辑小节")
    print(f"      {grand_tikz} 个 tikzpicture, {grand_tab} 个 tabular")
    print("=" * 80)
    
    # 输出JSON供后续使用
    json_path = PROJECT / "Scripts_Env" / "inventory_result.json"
    with open(json_path, "w", encoding="utf-8") as f:
        json.dump(all_results, f, ensure_ascii=False, indent=2)
    print(f"\n详细JSON已保存至: {json_path}")

if __name__ == "__main__":
    main()
