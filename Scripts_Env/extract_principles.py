import os
import glob
import json
import re
import traceback

try:
    directories = ["../LaTeX_Project/数学/统计图表", "../LaTeX_Project/数学/线段图", "../LaTeX_Project/数学/几何作图", "../LaTeX_Project/数学/数据表格", "../LaTeX_Project/物理/力学作图", "../LaTeX_Project/物理/坐标图像"]
    tex_files = []
    for d in directories:
        tex_files.extend(glob.glob(d + "/*.tex"))

    pattern = re.compile(r'(\\textbf\{绘图原理.*?\}\s*\\\\?\s*\\begin\{enumerate\}.*?\\end\{enumerate\})', re.DOTALL)

    extracted_blocks = []

    for file_path in tex_files:
        try:
            with open(file_path, "r", encoding="utf-8") as f:
                content = f.read()
                
            matches = pattern.finditer(content)
            for idx, match in enumerate(matches):
                block = match.group(1)
                extracted_blocks.append({
                    "file": file_path,
                    "index": idx,
                    "content": block
                })
        except Exception as e:
            with open("python_log.txt", "a", encoding="utf-8") as log:
                log.write(f"Error reading {file_path}: {str(e)}\n")

    with open("extracted_blocks.json", "w", encoding="utf-8") as f:
        json.dump(extracted_blocks, f, ensure_ascii=False, indent=2)

    with open("python_log.txt", "w", encoding="utf-8") as log:
        log.write("Success!\n")
        
except Exception as e:
    with open("python_log.txt", "w", encoding="utf-8") as log:
        log.write("Global Error: " + str(e) + "\n")
        log.write(traceback.format_exc())
