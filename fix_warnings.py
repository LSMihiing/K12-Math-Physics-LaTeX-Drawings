import os
import glob
import re

workspace = r"c:\Users\lsmihiing\Desktop\02 智羚学伴 26春教辅 智书粗加工\2支援小学数学"
tex_files = glob.glob(os.path.join(workspace, "**", "*.tex"), recursive=True)

def fix_content(content):
    # Fix $\textcircled{1}$ etc.
    content = re.sub(r'\$\\textcircled\{1\}\$', '①', content)
    content = re.sub(r'\$\\textcircled\{2\}\$', '②', content)
    content = re.sub(r'\$\\textcircled\{3\}\$', '③', content)
    content = re.sub(r'\$\\textcircled\{4\}\$', '④', content)
    
    # Textcircled command invalid in math mode
    content = re.sub(r'\\textcircled\{1\}', '①', content)
    content = re.sub(r'\\textcircled\{2\}', '②', content)
    content = re.sub(r'\\textcircled\{3\}', '③', content)
    content = re.sub(r'\\textcircled\{4\}', '④', content)
    
    # Fix $①$, $②$, etc.
    content = re.sub(r'\$①\$', '①', content)
    content = re.sub(r'\$②\$', '②', content)
    content = re.sub(r'\$③\$', '③', content)
    content = re.sub(r'\$④\$', '④', content)
    content = re.sub(r'\$、\$', '、', content)
    
    # Wrap elements manually if they are single occurrences
    content = re.sub(r'_①', r'_\\text{①}', content)
    content = re.sub(r'_②', r'_\\text{②}', content)
    content = re.sub(r'_③', r'_\\text{③}', content)
    content = re.sub(r'\^①', r'^\\text{①}', content)
    content = re.sub(r'\^②', r'^\\text{②}', content)
    content = re.sub(r'\^③', r'^\\text{③}', content)
    
    # Special fix for math mode items without text{}
    content = re.sub(r'(?<!\\text\{)▱', r'\\text{▱}', content)
    content = re.sub(r'一班：&', r'\\text{一班：}&', content)
    content = re.sub(r'二班：&', r'\\text{二班：}&', content)
    content = re.sub(r'三班：&', r'\\text{三班：}&', content)
    content = re.sub(r'\$无解\$', '无解', content)
    content = re.sub(r'\\mathtt\{\\textbackslash', r'\\texttt{\\textbackslash', content)
    
    # Fix the Kangxi face radical ⾯ -> 面
    content = content.replace('⾯', '面')

    return content

for file_path in tex_files:
    if '原始文件' in file_path:
        continue
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        new_content = fix_content(content)
        
        if new_content != content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Fixed: {os.path.basename(file_path)}")
    except Exception as e:
        print(f"Failed to process {file_path}: {e}")

print("Done")
