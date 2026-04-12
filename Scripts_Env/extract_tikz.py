# -*- coding: utf-8 -*-
"""
extract_tikz.py
从 jamesfang8499 的 6 个 LaTeX 教材仓库中提取全部 TikZ/circuitikz 绘图，
按书籍/章节分类整理，生成独立 .tex 文件和 index.tex 索引。
"""

import os
import re
import json
import shutil

# ============================================================
# 配置
# ============================================================
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
REPO_DIR = os.path.join(BASE_DIR, "LaTeX_Project", "参考资料", "jamesfang8499")
OUTPUT_DIR = os.path.join(BASE_DIR, "LaTeX_Project", "附录_参考绘图")

# 仓库 → 中文名称映射
REPO_INFO = {
    "math1": {
        "name": "数学_第一册_代数",
        "title": "中学数学实验教材·第一册（代数）",
        "files": ["1.tex", "2.tex", "3.tex", "4.tex", "5.tex", "6.tex", "7.tex"],
    },
    "math2": {
        "name": "数学_第二册_几何",
        "title": "中学数学实验教材·第二册（几何）",
        "files": ["1.tex", "2.tex", "3.tex", "4.tex", "5.tex", "6.tex"],
    },
    "math3": {
        "name": "数学_第三册_高中数学",
        "title": "中学数学实验教材·第三册（高中数学）",
        "files": ["1.tex", "2.tex", "3.tex", "4.tex", "5.tex", "6.tex", "7.tex"],
    },
    "physics1": {
        "name": "物理_第一册_力学",
        "title": "高中物理甲种本·第一册（力学）",
        "files": ["1.tex", "2.tex", "3.tex", "4.tex", "5.tex", "6.tex", "7.tex", "8.tex", "9.tex", "app1.tex", "app2.tex", "app3.tex"],
    },
    "physics2": {
        "name": "物理_第二册_热学电学",
        "title": "高中物理甲种本·第二册（热学·电学）",
        "files": ["1.tex", "2.tex", "3.tex", "4.tex", "5.tex", "6.tex", "7.tex", "8.tex", "APP1.tex", "APP2.tex", "APP3.tex"],
    },
    "physics3": {
        "name": "物理_第三册_电磁光学",
        "title": "高中物理甲种本·第三册（电磁·光学·近代物理）",
        "files": ["1.tex", "2.tex", "3.tex", "4.tex", "5.tex", "6.tex", "7.tex", "8.tex", "9.tex", "APP1.tex", "APP2.tex"],
    },
}

# ============================================================
# 提取逻辑
# ============================================================

def read_file(path):
    """读取 tex 文件，尝试多种编码"""
    for enc in ("utf-8", "gbk", "latin-1"):
        try:
            with open(path, "r", encoding=enc) as f:
                return f.read()
        except (UnicodeDecodeError, UnicodeError):
            continue
    return ""


def extract_environments(content, env_name):
    """
    从 LaTeX 内容中提取指定环境的全部实例。
    返回 [(start_line, end_line, code_block), ...]
    """
    results = []
    lines = content.split("\n")
    # 使用简单的字符串匹配而非正则，避免转义问题
    begin_str = "\\begin{" + env_name + "}"
    end_str = "\\end{" + env_name + "}"

    i = 0
    while i < len(lines):
        line_stripped = lines[i].strip()
        if begin_str in lines[i]:
            start = i
            depth = lines[i].count(begin_str)
            depth -= lines[i].count(end_str)
            if depth <= 0:
                # 同一行结束
                results.append((start + 1, i + 1, lines[i]))
                i += 1
                continue
            j = i + 1
            while j < len(lines) and depth > 0:
                depth += lines[j].count(begin_str)
                depth -= lines[j].count(end_str)
                j += 1
            block = "\n".join(lines[start:j])
            results.append((start + 1, j, block))
            i = j
        else:
            i += 1
    return results


def find_chapter_context(content, line_num):
    """
    查找给定行号处的 chapter 和 section 上下文。
    返回 (chapter_title, section_title)。
    """
    lines = content.split("\n")
    chapter = "未分类"
    section = ""

    chapter_re = re.compile(r"\\chapter\{(.+?)\}")
    section_re = re.compile(r"\\section\{(.+?)\}")

    for i in range(min(line_num - 1, len(lines) - 1), -1, -1):
        if not section:
            m = section_re.search(lines[i])
            if m:
                section = m.group(1)
        m = chapter_re.search(lines[i])
        if m:
            chapter = m.group(1)
            break

    return chapter, section


def sanitize_dirname(name):
    """将中文名转为安全的目录名"""
    # 移除 LaTeX 命令
    name = re.sub(r"\\[a-zA-Z]+\{.*?\}", "", name)
    name = re.sub(r"\\[a-zA-Z]+", "", name)
    # 移除特殊字符但保留中文、字母、数字
    name = re.sub(r'[\\/:*?"<>|]', "", name)
    name = name.strip()
    # 替换多余空格和波浪线
    name = re.sub(r"\s+", "_", name)
    name = re.sub(r"~+", "", name)
    if not name:
        name = "misc"
    return name


def process_repo(repo_key, repo_info):
    """处理单个仓库，提取 tikzpicture 和 circuitikz 环境"""
    repo_path = os.path.join(REPO_DIR, repo_key)
    out_base = os.path.join(OUTPUT_DIR, repo_info["name"])
    os.makedirs(out_base, exist_ok=True)

    stats = {"repo": repo_key, "title": repo_info["title"], "chapters": {}}
    all_drawings = []  # 收集该仓库所有绘图，用于生成 index.tex

    for tex_file in repo_info["files"]:
        filepath = os.path.join(repo_path, tex_file)
        if not os.path.exists(filepath):
            continue

        content = read_file(filepath)
        if not content:
            continue

        # 提取 tikzpicture
        tikz_envs = extract_environments(content, "tikzpicture")
        # 提取 circuitikz
        circuit_envs = extract_environments(content, "circuitikz")

        all_envs = [(e, "tikz") for e in tikz_envs] + \
                   [(e, "circuit") for e in circuit_envs]

        # 按行号排序
        all_envs.sort(key=lambda x: x[0][0])

        for (start_line, end_line, code_block), env_type in all_envs:
            chapter, section = find_chapter_context(content, start_line)

            # 创建章节目录
            chapter_dir_name = sanitize_dirname(chapter)
            chapter_dir = os.path.join(out_base, chapter_dir_name)
            os.makedirs(chapter_dir, exist_ok=True)

            # 统计
            if chapter not in stats["chapters"]:
                stats["chapters"][chapter] = {
                    "dir_name": chapter_dir_name,
                    "tikz": 0, "circuit": 0, "files": []
                }
            stats["chapters"][chapter][env_type] = \
                stats["chapters"][chapter].get(env_type, 0) + 1

            # 生成文件名
            idx = stats["chapters"][chapter]["tikz"] + \
                  stats["chapters"][chapter]["circuit"]
            prefix = "circuit" if env_type == "circuit" else "tikz"
            filename = f"{prefix}_{idx:03d}.tex"
            out_path = os.path.join(chapter_dir, filename)

            # 写入独立 .tex 文件（带注释头）
            header = (
                f"% 来源：{repo_info['title']}\n"
                f"% 章节：{chapter}"
                + (f" / {section}" if section else "")
                + f"\n% 原始文件：{tex_file}，行 {start_line}-{end_line}\n"
                f"% 类型：{env_type}\n"
                f"% ---\n"
            )
            with open(out_path, "w", encoding="utf-8") as f:
                f.write(header + code_block + "\n")

            stats["chapters"][chapter]["files"].append(filename)
            all_drawings.append({
                "chapter": chapter,
                "chapter_dir": chapter_dir_name,
                "section": section,
                "env_type": env_type,
                "filename": filename,
                "source_file": tex_file,
                "lines": f"{start_line}-{end_line}",
            })

    # 生成 index.tex
    generate_index(out_base, repo_info, stats, all_drawings)

    return stats, all_drawings


def generate_index(out_base, repo_info, stats, all_drawings):
    """为每本书生成 index.tex 汇总文件"""
    index_path = os.path.join(out_base, "index.tex")

    # 按章节分组
    chapters_ordered = []
    seen = set()
    for d in all_drawings:
        ch = d["chapter"]
        if ch not in seen:
            chapters_ordered.append(ch)
            seen.add(ch)

    with open(index_path, "w", encoding="utf-8") as f:
        f.write(f"% 自动生成索引 — {repo_info['title']}\n")
        f.write(f"% 绘图总数：{len(all_drawings)}\n\n")

        for chapter in chapters_ordered:
            ch_info = stats["chapters"][chapter]
            dir_name = ch_info["dir_name"]
            ch_drawings = [d for d in all_drawings if d["chapter"] == chapter]

            # 获取该卷的相对路径前缀
            book_dir = repo_info["name"]

            f.write(f"\\section{{{chapter}}}\n")

            total = len(ch_drawings)
            f.write(f"% 本章共 {total} 个绘图\n\n")

            for d in ch_drawings:
                # 写注释标出来源
                src_info = f"% [{d['env_type']}] 来自 {d['source_file']}:{d['lines']}"
                if d["section"]:
                    src_info += f"  {d['section']}"
                f.write(f"{src_info}\n")
                # 用相对路径 input
                rel_path = f"附录_参考绘图/{book_dir}/{dir_name}/{d['filename']}"
                # 去掉 .tex 后缀
                rel_path_no_ext = rel_path.replace(".tex", "")
                f.write(f"\\input{{{rel_path_no_ext}}}\n")
                f.write("\\vspace{1em}\n\n")

            f.write("\n")


def main():
    print("=" * 60)
    print("TikZ 绘图提取工具")
    print("=" * 60)

    # 清理输出目录
    if os.path.exists(OUTPUT_DIR):
        shutil.rmtree(OUTPUT_DIR)

    os.makedirs(OUTPUT_DIR, exist_ok=True)

    grand_total = {"tikz": 0, "circuit": 0}
    all_stats = []
    all_catalog = []

    for repo_key, repo_info in REPO_INFO.items():
        print(f"\n处理 {repo_key} ({repo_info['title']})...")
        stats, drawings = process_repo(repo_key, repo_info)
        all_stats.append(stats)
        all_catalog.extend(drawings)

        repo_tikz = sum(c.get("tikz", 0) for c in stats["chapters"].values())
        repo_circuit = sum(c.get("circuit", 0) for c in stats["chapters"].values())
        grand_total["tikz"] += repo_tikz
        grand_total["circuit"] += repo_circuit

        print(f"  tikzpicture: {repo_tikz}, circuitikz: {repo_circuit}")
        for ch_name, ch_info in stats["chapters"].items():
            t = ch_info.get("tikz", 0)
            c = ch_info.get("circuit", 0)
            print(f"    {ch_name}: {t + c} ({t} tikz + {c} circuit)")

    # 汇总
    total = grand_total["tikz"] + grand_total["circuit"]
    print(f"\n{'=' * 60}")
    print(f"完成！共提取 {total} 个绘图")
    print(f"  tikzpicture: {grand_total['tikz']}")
    print(f"  circuitikz:  {grand_total['circuit']}")
    print(f"输出目录：{OUTPUT_DIR}")
    print(f"{'=' * 60}")

    # 保存分类目录 JSON
    catalog_path = os.path.join(OUTPUT_DIR, "catalog.json")
    with open(catalog_path, "w", encoding="utf-8") as f:
        json.dump({
            "total": total,
            "tikzpicture": grand_total["tikz"],
            "circuitikz": grand_total["circuit"],
            "repos": all_stats,
            "drawings": all_catalog,
        }, f, ensure_ascii=False, indent=2)
    print(f"分类目录已保存至：{catalog_path}")


if __name__ == "__main__":
    main()
