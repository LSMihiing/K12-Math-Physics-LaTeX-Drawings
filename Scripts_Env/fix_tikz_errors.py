# -*- coding: utf-8 -*-
r"""
fix_tikz_errors.py
Fix common errors introduced from extracting tikzpicture:
1. Remove `\caption{...}` appended outside floats.
2. Replace `plot function{...}` (requires gnuplot) with native pgf math `plot(\x, {...})`.
"""
import os, re

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUTPUT_DIR = os.path.join(BASE_DIR, "LaTeX_Project", "附录_参考绘图")

def process_files():
    files_fixed = 0
    caption_fixes = 0
    plot_fixes = 0

    for root, dirs, files in os.walk(OUTPUT_DIR):
        for fname in files:
            if not fname.endswith('.tex'):
                continue
            filepath = os.path.join(root, fname)
            
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
                
            orig_content = content
            
            # 1. Fix \caption inside tikz but without figure.
            # Usually it appears as \end{tikzpicture} \caption{...} 
            # or loosely written \caption{...} inside.
            # We just comment out \caption{...} globally in these extracted files.
            # Wait, regex for \caption{...} handling nested braces is hard, but usually it's just \caption{} or \caption{xxx}
            def caption_repl(m):
                return m.group(0).replace(r'\caption', r'%\caption')
            
            if r'\caption' in content:
                content = re.sub(r'\\caption\s*\{[^}]*\}', caption_repl, content)
                content = content.replace(r'\caption{}', r'%\caption{}') # catch empty ones
            
            # 2. Fix plot function{...}
            # e.g., plot[domain=0:4*3.1416, samples=1000] function{.7*sin(x)+4}
            # -> plot[domain=0:4*3.1416, samples=1000, variable=\x] (\x, {.7*sin(\x r)+4})
            if 'function' in content and 'plot' in content:
                def repl_plot(m):
                    prefix = m.group(1) # e.g. plot[domain=...]
                    # Make sure variable=\x is in there if it has []
                    if '[' in prefix and 'variable=' not in prefix:
                        prefix = prefix.replace(']', ', variable=\\x]')
                    elif '[' not in prefix:
                        prefix = prefix + '[variable=\\x]'
                    
                    func_body = m.group(2)
                    # replace x with \x, and sin(x) with sin(\x r) so tikz evaluates in radians
                    func_body = re.sub(r'\b(sin)\((.*?)\)', r'\1(\2 r)', func_body)
                    func_body = re.sub(r'\b(cos)\((.*?)\)', r'\1(\2 r)', func_body)
                    func_body = re.sub(r'\bx\b', r'\\x', func_body)
                    
                    return f"{prefix} (\\x, {{{func_body}}})"
                    
                # Regex matches: plot... function{...}
                content = re.sub(r'(plot\s*(?:\[[^\]]*\])?)\s*function\s*\{([^\}]+)\}', repl_plot, content)

            if content != orig_content:
                files_fixed += 1
                caption_fixes += (orig_content.count(r'\caption') - content.count(r'\caption')) # rough count
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(content)
                    
    print(f"Fixed {files_fixed} files.")

if __name__ == "__main__":
    process_files()
