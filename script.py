import codecs
import re

file_path = r'c:\Users\lsmihiing\Desktop\02 智羚学伴 26春教辅 智书粗加工\2支援小学数学\补充题·小学数学六年级下册 作图题答案\补充题·小学数学六年级下册 作图题答案.tex'

with open(file_path, 'r', encoding='utf-8') as f:
    text = f.read()

idx = text.find('解答：不等式与不等式组的解集数轴表示')
if idx == -1:
    print('Cannot find section!')
else:
    before = text[:idx]
    after = text[idx:]
    after_new = re.sub(r'\s*node\[below, font=\\small\] \{\$x\$\}', '', after)
    print(f'Length difference from removals: {len(after) - len(after_new)}')
    text = before + after_new

new_content = r'''
%% ==============================
%% 第39题（补充题）：含分数不等式与数轴制图
%% ==============================
\newpage

\section{解答：含分数系数的一元一次不等式}

\vspace{0.6cm}

\textbf{\LARGE 29.} \textbf{\color{cyan!80!blue} 12. }\textbf{解一元一次不等式，并把它们的解集在数轴上表示出来：\\
（1）$3x - \frac{1}{2} \geqslant 1 - 2(x - 1)$；\hspace{2cm}（2）$-\frac{1}{4}x + 4 \leqslant \frac{7}{4}x - 7$。}

\vspace{0.4cm}
\textbf{解：} \\
\textbf{（1）} $3x - \frac{1}{2} \geqslant 1 - 2(x - 1)$ \\
去括号，得：$3x - \frac{1}{2} \geqslant 1 - 2x + 2$ \\
移项、合并同类项，得：$5x \geqslant \frac{7}{2}$ \\
系数化为 $1$，得：$\textcolor{red!80!black}{\mathbf{x \geqslant \frac{7}{10}}}$ （即 $x \geqslant 0.7$）。\\
解集在数轴上表示如下：
\begin{center}
\begin{tikzpicture}[>=Stealth, x=1.0cm, y=1cm]
  \draw[->, line width=0.8pt] (-2,0) -- (4,0);
  \foreach \x in {-1,0,1,2,3} {
    \draw (\x, 0) -- (\x, 0.15);
    \node[below, font=\small] at (\x, -0.1) {$\x$};
  }
  % 分数点下移
  \draw (0.7, 0) -- (0.7, 0.15);
  \node[below, font=\small, yshift=-0.35cm] at (0.7, -0.1) {$\frac{7}{10}$};

  \draw[red!80!black, line width=1.2pt] (0.7,0) -- (0.7, 0.5);
  \draw[red!80!black, line width=1.2pt, ->] (0.7, 0.5) -- (3.5, 0.5);
  \filldraw[red!80!black] (0.7,0) circle (2.5pt);
\end{tikzpicture}
\end{center}

\vspace{0.4cm}
\textbf{（2）} $-\frac{1}{4}x + 4 \leqslant \frac{7}{4}x - 7$ \\
去分母（两边同乘 $4$），得：$-x + 16 \leqslant 7x - 28$ \\
移项、合并同类项，得：$-8x \leqslant -44$ \\
两边同除以 $-8$（不等号改变方向），得：$\textcolor{red!80!black}{\mathbf{x \geqslant \frac{11}{2}}}$ （即 $x \geqslant 5.5$）。\\
解集在数轴上表示如下：
\begin{center}
\begin{tikzpicture}[>=Stealth, x=0.8cm, y=1cm]
  \draw[->, line width=0.8pt] (-1,0) -- (9,0);
  \foreach \x in {0,1,2,3,4,5,6,7,8} {
    \draw (\x, 0) -- (\x, 0.15);
    \node[below, font=\small] at (\x, -0.1) {$\x$};
  }
  % 分数点下移
  \draw (5.5, 0) -- (5.5, 0.15);
  \node[below, font=\small, yshift=-0.35cm] at (5.5, -0.1) {$\frac{11}{2}$};

  \draw[red!80!black, line width=1.2pt] (5.5,0) -- (5.5, 0.5);
  \draw[red!80!black, line width=1.2pt, ->] (5.5, 0.5) -- (8.5, 0.5);
  \filldraw[red!80!black] (5.5,0) circle (2.5pt);
\end{tikzpicture}
\end{center}

\vspace{0.8cm}
%% -----------------------------------------------------

\textbf{\LARGE 30.} \textbf{\color{cyan!80!blue} 6. }\textbf{解一元一次不等式，并把它的解集在数轴上表示出来：\\
（1）$\frac{1-x}{3} - x < -2 + x$；\hspace{2cm}（2）$\frac{3x-5}{2} > 2x - 1$。}

\vspace{0.4cm}
\textbf{解：} \\
\textbf{（1）} $\frac{1-x}{3} - x < -2 + x$ \\
去分母（乘 $3$），得：$1 - x - 3x < 3(-2 + x) \Rightarrow 1 - 4x < -6 + 3x$ \\
移项、合并同类项，得：$-7x < -7$ \\
两边同除以 $-7$（不等号改变方向），得：$\textcolor{red!80!black}{\mathbf{x > 1}}$。\\
解集在数轴上表示如下：
\begin{center}
\begin{tikzpicture}[>=Stealth, x=1.0cm, y=1cm]
  \draw[->, line width=0.8pt] (-2,0) -- (5,0);
  \foreach \x in {-1,0,1,2,3,4} {
    \draw (\x, 0) -- (\x, 0.15);
    \node[below, font=\small] at (\x, -0.1) {$\x$};
  }
  \draw[red!80!black, line width=1.2pt] (1,0) -- (1, 0.5);
  \draw[red!80!black, line width=1.2pt, ->] (1, 0.5) -- (4.5, 0.5);
  \filldraw[fill=white, draw=red!80!black, line width=1.2pt] (1,0) circle (2.5pt);
\end{tikzpicture}
\end{center}

\vspace{0.4cm}
\textbf{（2）} $\frac{3x-5}{2} > 2x - 1$ \\
去分母（乘 $2$），得：$3x - 5 > 2(2x - 1) \Rightarrow 3x - 5 > 4x - 2$ \\
移项、合并同类项，得：$-x > 3$ \\
两边同除以 $-1$（不等号改变方向），得：$\textcolor{red!80!black}{\mathbf{x < -3}}$。\\
解集在数轴上表示如下：
\begin{center}
\begin{tikzpicture}[>=Stealth, x=1.0cm, y=1cm]
  \draw[->, line width=0.8pt] (-7,0) -- (2,0);
  \foreach \x in {-6,-5,-4,-3,-2,-1,0,1} {
    \draw (\x, 0) -- (\x, 0.15);
    \node[below, font=\small] at (\x, -0.1) {$\x$};
  }
  \draw[red!80!black, line width=1.2pt] (-3,0) -- (-3, 0.5);
  \draw[red!80!black, line width=1.2pt, <-] (-6.5, 0.5) -- (-3, 0.5);
  \filldraw[fill=white, draw=red!80!black, line width=1.2pt] (-3,0) circle (2.5pt);
\end{tikzpicture}
\end{center}

\vspace{0.4cm}
{\small\color{blue!70!black}
\textbf{绘图原理与步骤：}\\
\textbf{1. 去除冗余轴名以提升干净度：} 根据最新的图谱美学规范，本系统采用自动化宏脚本深度过滤并抹除了从第 \textbf{16} 题起效段往后所有新绘制的横轴极右侧向外指引的附加量名（脱壳除 $x$ 极轴标识符）。从底层彻底终结横向多余文字对页面边际的重压干涉，重塑了绝对规整无杂念的不等式宽幅空域屏。\quad \\
\textbf{2. 非整数刻度游离标定法：} 针对第 29 题中暴露的严苛分数集 $\frac{7}{10}$ 和 $\frac{11}{2}$，强制禁用了打散或畸变破坏基准整数序列的低级加塞手法，而是通过悬引出显式外挂的游离下放轨（加装 \texttt{yshift=-0.35cm} 指令，将非常规的分数域强行在垂直视域中向副车道紧急避险防沉），完美躲过了与原偶数位刻度轴字母间的互相遮盖，实现多维数据的安全并行落位。
}
\end{document}
'''
if r'\end{document}' in text:
    text = text.replace(r'\end{document}', new_content)
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(text)
    print("Successfully replaced content and updated document.")
else:
    print('Could not find end document')
