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
        
        # In the previous script I replaced \mathord{\text{▱}} with 平行四边形.
        # But this left $平行四边形 ABDC$ which causes missing characters.
        # So we fix it:
        content = content.replace('$平行四边形', '$\\text{平行四边形}')
        
        # Sometimes it's \textbf{①} inside math mode? Or just \textbf{①} without xeCJK bold map?
        # Actually xeCJK supports bold. Why lmroman12-bold? 
        # Only if \textbf{①} is inside $ $. Let's wrap inner with text: \textbf{\text{①}} 
        # Wait, \text is inside \textbf, so it works. Or just wrap the whole thing.
        # Let's fix lists separated by `、` inside math mode.
        # $A、B$ -> $A$、$B$
        content = re.sub(r'\$([^$]*[A-Za-z0-9])、([A-Za-z0-9][^$]*)\$', r'$\1$、$\2$', content)
        content = re.sub(r'、([A-Za-z0-9][^$]*)\$', r'$、$\1$', content)
        # Any remaining `、` in math mode is hard to catch perfectly.
        # Let's catch `_{①}` and `^{①}`
        content = re.sub(r'_\{([①②③④⑤⑥])\}', r'_{\\text{\1}}', content)
        content = re.sub(r'\^\{([①②③④⑤⑥])\}', r'^{\\text{\1}}', content)
        
        if content != orig_content:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"Fixed: {os.path.basename(file_path)}")
            
    except Exception as e:
        pass

print("Done phase 3.")
