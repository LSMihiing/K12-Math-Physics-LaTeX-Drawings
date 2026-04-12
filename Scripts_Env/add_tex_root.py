import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUTPUT_DIR = os.path.join(BASE_DIR, "LaTeX_Project", "附录_参考绘图")

# Compute absolute path to main.tex
MAIN_TEX_PATH = os.path.join(BASE_DIR, "LaTeX_Project", "main.tex")
# But usually LaTeX Workshop works best with relative path or a well formed absolute path.
MAIN_TEX_PATH = MAIN_TEX_PATH.replace('\\', '/')

count = 0
for root, dirs, files in os.walk(OUTPUT_DIR):
    for fname in files:
        if fname.endswith('.tex') and fname not in ['index.tex', '总索引表.tex']:
            filepath = os.path.join(root, fname)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            if '!TEX root' not in content:
                # Add magic comment for IDE LaTeX Workshop
                # We can just use absolute path or relative path
                rel_path = os.path.relpath(MAIN_TEX_PATH, start=root)
                rel_path = rel_path.replace('\\', '/')
                
                new_content = f"% !TEX root = {rel_path}\n" + content
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                count += 1

print(f"Added !TEX root to {count} files.")
