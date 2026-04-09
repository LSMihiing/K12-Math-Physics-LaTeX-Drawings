import os
import glob
import re

workspace = r"c:\Users\lsmihiing\Desktop\02 智羚学伴 26春教辅 智书粗加工\2支援小学数学"
tex_files = glob.glob(os.path.join(workspace, "**", "*.tex"), recursive=True)

for file_path in tex_files:
    if '原始文件' in file_path:
        continue
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        orig_content = content
        
        # Simple replacements
        replaces = {
            r'$\textcircled{1}$': '①',
            r'$\textcircled{2}$': '②',
            r'$\textcircled{3}$': '③',
            r'$\textcircled{4}$': '④',
            r'$\textcircled{5}$': '⑤',
            r'$\textcircled{6}$': '⑥',
            r'\textcircled{1}': '①',
            r'\textcircled{2}': '②',
            r'\textcircled{3}': '③',
            r'\textcircled{4}': '④',
            r'\textcircled{5}': '⑤',
            r'\textcircled{6}': '⑥',
            '$①$': '①',
            '$②$': '②',
            '$③$': '③',
            '$④$': '④',
            '$⑤$': '⑤',
            '$⑥$': '⑥',
            
            # For ▱
            r'\mathord{\text{▱}}': '平行四边形',
            r'\mathord{▱}': '平行四边形',
            r'▱': '平行四边形',
            
            # Some other known problematic things
            '$无解$': '无解',
            '\\mathtt{\\textbackslash': '\\texttt{\\textbackslash',
            '一班：&': '\\text{一班：}&',
            '二班：&': '\\text{二班：}&',
            '三班：&': '\\text{三班：}&',
            '⾯': '面'
        }
        
        for k, v in replaces.items():
            content = content.replace(k, v)
            
        # For multiple 、 elements in math mode. 
        # A common mistake is writing $1、2$ instead of $1$、$2$
        # Let's try to fix numbers separated by 、 inside math mode.
        # It's safer to just let the user know, but let's replace `、` with `, ` or `\text{、}`
        # Let's replace `$、$` with `、`
        content = content.replace('$、$', '、')

        # To fix cases like $1、2$, we can do a regex:
        content = re.sub(r'(\d+)、(\d+)', r'\1, \2', content)

        if content != orig_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"Fixed string matches in: {os.path.basename(file_path)}")
    except Exception as e:
        print(f"Failed to process {file_path}: {e}")

print("Done string replace.")
