# -*- coding: utf-8 -*-
"""
generate_index_table.py
Reads catalog.json and outputs a LaTeX file with a longtable summarizing all TikZ graphics.
"""

import os
import json

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUTPUT_DIR = os.path.join(BASE_DIR, "LaTeX_Project", "附录_参考绘图")
CATALOG_PATH = os.path.join(OUTPUT_DIR, "catalog.json")
INDEX_TABLE_PATH = os.path.join(OUTPUT_DIR, "总索引表.tex")

def generate_table():
    if not os.path.exists(CATALOG_PATH):
        print(f"Catalog not found: {CATALOG_PATH}")
        return

    with open(CATALOG_PATH, "r", encoding="utf-8") as f:
        catalog = json.load(f)

    repos = catalog.get("repos", [])
    
    with open(INDEX_TABLE_PATH, "w", encoding="utf-8") as f:
        f.write("\\chapter*{附录总索引表}\n")
        f.write("\\addcontentsline{toc}{chapter}{附录总索引表}\n\n")
        f.write("此表格汇总了目前提取自 jamesfang8499 GitHub 仓库的教材参考绘图资源。您可以根据册名、章节名快速定位至相应的图形。\n\n")
        f.write("\\begin{center}\n")
        
        # Configure longtable
        f.write("\\begin{longtable}{|p{4.5cm}|p{5cm}|c|c|}\n")
        f.write("\\caption{TikZ/circuitikz 参阅绘图提取目录表} \\label{tab:tikz_index} \\\\\n")
        f.write("\\hline\n")
        f.write("\\textbf{来源分册} & \\textbf{对应章节} & \\textbf{环境类型} & \\textbf{引图数} \\\\\n")
        f.write("\\hline\n")
        f.write("\\endfirsthead\n\n")
        
        f.write("\\multicolumn{4}{c}% \n")
        f.write("{\\tablename\\ \\thetable{} -- 续前页} \\\\\n")
        f.write("\\hline\n")
        f.write("\\textbf{来源分册} & \\textbf{对应章节} & \\textbf{环境类型} & \\textbf{引图数} \\\\\n")
        f.write("\\hline\n")
        f.write("\\endhead\n\n")
        
        f.write("\\hline\n")
        f.write("\\multicolumn{4}{r}{{接下页...}} \\\\\n")
        f.write("\\endfoot\n\n")
        
        f.write("\\hline\n")
        f.write("\\endlastfoot\n\n")
        
        # Table body
        for repo in repos:
            repo_title = repo.get("title", "")
            chapters = repo.get("chapters", {})
            
            # Since some chapters might have both tikz and circuitikz, we handle rows
            rows = []
            for ch_name, ch_data in chapters.items():
                tikz_count = ch_data.get("tikz", 0)
                circuit_count = ch_data.get("circuit", 0)
                if tikz_count > 0:
                    rows.append((ch_name, "tikzpicture", tikz_count))
                if circuit_count > 0:
                    rows.append((ch_name, "circuitikz", circuit_count))
            
            if not rows:
                continue
                
            num_rows = len(rows)
            # Write first row with multirow for the repo title
            first_ch, first_env, first_cnt = rows[0]
            # Replace spaces and common characters if needed, keep title clean
            clean_title = repo_title.replace("中学数学实验教材·", "数学").replace("高中物理甲种本·", "物理")
            f.write(f"\\multirow{{{num_rows}}}{{*}}{{{clean_title}}} & {first_ch} & {first_env} & {first_cnt} \\\\\n")
            
            # Write remaining rows
            for i in range(1, num_rows):
                ch_name, env_name, env_cnt = rows[i]
                # To prevent middle lines breaking the multirow, we use \cline{2-4}
                f.write(f"\\cline{{2-4}}\n")
                f.write(f" & {ch_name} & {env_name} & {env_cnt} \\\\\n")
                
            f.write("\\hline\n")
        
        f.write("\\end{longtable}\n")
        f.write("\\end{center}\n")
        
    print(f"Generated index table at {INDEX_TABLE_PATH}")

if __name__ == "__main__":
    generate_table()
