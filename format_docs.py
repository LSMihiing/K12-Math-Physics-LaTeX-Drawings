import re

file_path = "temp_answer.tex"
with open(file_path, "r", encoding="utf-8") as file:
    content = file.read()

replacements = [
    # Block 1
    (r"\\textbf{绘图原理：}\n\\begin{enumerate}\n    \\item \\textbf{画布参数分配：} 定义了宽为.*?绝不被着色液覆盖，整齐利落。\n\\end{enumerate}",
     r"""\textbf{绘图原理：}
\begin{enumerate}
    \item \textbf{布局参数：} 定义基础矩形宽 \texttt{W=5.0}、高 \texttt{H=1.0}。使用 \texttt{scope} 和 \texttt{shift} 将左右两题、上下两图隔开。
    \item \textbf{等值分数涂色：} 左侧分别按 3 等分和 6 等分计算网格间距，对应涂色 1 格（\texttt{gray!30}）与 2 格（\texttt{green}）。右侧同理按照 4 等分和 8 等分处理，完成 1 格与 2 格图形映射。
    \item \textbf{图层顺序：} 先调用 \texttt{\textbackslash fill} 面填涂色，再使用 \texttt{\textbackslash draw} 覆盖 0.8pt 实线外框与 0.6pt 内部虚线，防止点划线被遮挡。
\end{enumerate}"""),

    # Block 2
    (r"\\textbf{绘图原理：}\n\\begin{enumerate}\n    \\item \\textbf{整体布局计算：} 设置四组图形的中心点横坐标.*?让分式更易读且适配下方图列空白。\n\\end{enumerate}",
     r"""\textbf{绘图原理：}
\begin{enumerate}
    \item \textbf{布局设置：} 设定四组图形中心点横坐标，借助 \texttt{scope} 的 \texttt{shift} 将图形等距平铺。文字公式置于纵坐标 -2.5 处居中对齐。
    \item \textbf{多边形绘制：} 基于极坐标生成正六边形，设起始角度为 $0^\circ$，步长 $60^\circ$ 生成六个顶点确保其平顶平底。
    \item \textbf{虚线划分：} 六边形内部连接对角线实现 6 等分；正方形内部通过横纵各 3 条虚线完成 $4\times 4$ 网格拆分。
    \item \textbf{分块上色：} 左六边形涂满等同 $1/3$ 面积的部分菱形。右正方形设半边长为 \texttt{L=1.15}，填涂顶部 1/4 区间，实现面积等分比照。
\end{enumerate}"""),

    # Block 3
    (r"\\textbf{绘图原理：}\n\\begin{enumerate}\n    \\item \\textbf{图表定义与比例：} 严格按照原图长宽比例 5\.7 : 1\.5 建立外部大矩形.*?运用了中英文标点及并排粗斜调整。\n\\end{enumerate}",
     r"""\textbf{绘图原理：}
\begin{enumerate}
    \item \textbf{矩形比例：} 按 5.7:1.5 构建原辅助矩形框，将其横扫 4 列 \texttt{W/4} 与纵扫 2 行 \texttt{H/2} 生成全局结构。
    \item \textbf{分区着色：} 前 4 等份（整体前 2 列）作 \texttt{\textbackslash fill[red]} 红漆；后续 3 份则被剖分为第 3、4 列上半一块以及第 3 列下侧一块，由 \texttt{\textbackslash fill[cyan]} 完涂。
    \item \textbf{图层管理：} 首先声明块状 \texttt{\textbackslash fill} 涂色图层，随后迭代追加实边框及水平与垂直虚线分栏。
\end{enumerate}"""),

    # Block 4
    (r"\\textbf{绘图原理：}\n\\begin{enumerate}\n    \\item \\textbf{基础结构与预处理：} 根据图示按比例画出长条矩形，设定总宽度.*?确保线迹能清晰凸显于色块之上。\n\\end{enumerate}",
     r"""\textbf{绘图原理：}
\begin{enumerate}
    \item \textbf{参数划定：} 限定原题矩阵总宽 \texttt{W=7.0}，纵向高度 \texttt{H=1.5}，从而设定格宽基础常量为 1.0 的等量。
    \item \textbf{上色控制：} 调用 \texttt{red} 将 $x$ 范围设入 $0 \sim 4\text{cw}$ 作基础色层表示 $4/7$；再以 \texttt{green} 填涂向右并延的 $4\text{cw} \sim 6\text{cw}$ 区块表示 $2/7$；余一格未涂保留空集。
    \item \textbf{网格点缀：} 等同底层铺设原则，以黑色外包框以及内部循环参数 \texttt{1...6} 来生成虚线等距划分标识。
\end{enumerate}"""),

    # Block 5
    (r"\\textbf{绘图原理：}\n\\begin{enumerate}\n    \\item \\textbf{整体布局：} 根据需求.*?完美契合了参考答案中等值分数的数学含义。涂色操作必须在画线操作上方（先声明）才能防止线条被覆盖。\n\\end{enumerate}",
     r"""\textbf{绘图原理：}
\begin{enumerate}
    \item \textbf{段落规划：} 题面字汇转移至主体正文排版规制，用普通字块进行填字框植入，以防止内置的图表节点排位错乱。
    \item \textbf{网格构筑：} 以边长 $1.0$ 的格子作为元素单元，构筑宽 6 纵 2 比例的长外边界实框；中央穿入纵单条与横多条短划线作等宽隔断。
    \item \textbf{色域换算：} 左方两列以 \texttt{red} 平铺涵盖，以表现视觉体量 $2\times 2 = 4$ 格红格。此覆盖同样满足长方形总体积 $2/6$ 及水平轴系 $1/3$ 的占位比例计算法则。
\end{enumerate}"""),

    # Block 6
    (r"\\textbf{绘图原理：}\n\\begin{enumerate}\n    \\item \\textbf{整体布局计算：} 定义宽为 \\texttt{W=2\.5}.*?让最后的公式既保留了印刷原貌，又极大地整齐了逻辑方程“因为\\dots 所以\\dots ”。\n\\end{enumerate}",
     r"""\textbf{绘图原理：}
\begin{enumerate}
    \item \textbf{整体坐标预设：} 定义长方形基座边长 \texttt{W=2.5} 且 \texttt{H=2.0}，对应使得五或四等分的格形内部间隙统一成 $0.5$ 正方形矩阵。
    \item \textbf{首行逻辑处理：} 左图划立 4 横等分且在顶区涂灰代表 $1/4$；次图对应拓展 20 并块方网格系统并将相应占有顶界涂布淡蓝。
    \item \textbf{次行逻辑处理：} $Y$ 轴偏转 -2.8 单位量复制全套下推机制。左方单图用纵向 5 截并上灰色标记代表 $1/5$；对应作 20 分解且首列赋涂色。
    \item \textbf{圆环排版：} 自主包裹 \texttt{\textbackslash tikz} 语法定义一个外圈包含填值的标靶组合块，挂载其参数居底平齐，形成完整的比值句型段。
\end{enumerate}"""),

    # Block 7
    (r"\\textbf{绘图原理：}\n\\begin{enumerate}\n    \\item \\textbf{图表结构：} 设置宽为.*?绘制完毕后追加等式即完成。\n\\end{enumerate}",
     r"""\textbf{绘图原理：}
\begin{enumerate}
    \item \textbf{基本堆叠：} 三项长条通过 \texttt{shift} 将每列向上推 \texttt{\textbackslash H + \textbackslash gap} 而完成排列。总结构各宽 $10\text{cm}$、高 $0.8\text{cm}$。
    \item \textbf{基础切分：} 三大矩块的外部沿由原等分的四大虚线预装定式化切割生成。
    \item \textbf{局部重新划分：} 二号图附加绘制每组 $W/5$ 跨距内部的中分线；底座三号条附加描定出每组内部的 $W/15$ 及 $2W/15$ 的两重实线切断口。
    \item \textbf{赋彩比值：} 初版以浅灰色标立首块 $1/5$ 格框；第二、三组别照同面同占原则将开局 $W/5$ 对应空间作满红色处理，彰显直观等倍原理。
\end{enumerate}"""),

    # Block 8
    (r"\\textbf{绘图原理：}\n\\begin{enumerate}\n    \\item \\textbf{图层与基准线：} 首先为了逻辑分离，在总体坐标系中利用.*?忠实、数学上毫无偏差地还原了教科书式的圆规相切截段流程。\n\\end{enumerate}",
     r"""\textbf{绘图原理：}
\begin{enumerate}
    \item \textbf{布局分布：} 使用 \texttt{scope} 分层将参照原线段 $a$ 绘于上侧区域，于底部辅设无限伸张长向浅色直线供切分。
    \item \textbf{公用参量约束：} 利用常量 \texttt{\textbackslash def\textbackslash L\{2.0\}} 将首目标及次目标图形的横测跨线硬性挂钩确保倍参的统一性。
    \item \textbf{目标截分出体：} 在 $x=1.5$ 建置目标端点位 $C$，加宽笔触横扫绘制至 $1.5+3\times L$ 作为长 $3a$ 的粗实线形本体线段。
    \item \textbf{留痕标注重塑：} 分别借用以目标截点为向心利用半径为 $L$ 所构致角度偏斜为 $\pm 8^\circ$ 的微短弧形切面，充作圆规描弧的实态保留。
\end{enumerate}"""),

    # Block 9
    (r"\\textbf{绘图原理：}\n\\begin{enumerate}\n    \\item \\textbf{旋转局部坐标系的巧用：} 在面对倾斜直线的平行/垂直作图问题时，如果依然使用全局.*?没有任何手动三角计算出现。\n\\end{enumerate}",
     r"""\textbf{绘图原理：}
\begin{enumerate}
    \item \textbf{局部偏转基座：} 开启偏置 $15^\circ$ 的域框架体系，使原本附有斜度的考题基板回溯为正交正平轴线系统。
    \item \textbf{线长定义标定：} 将源形原线设在 $y=0$ 沿轴面。设定 $A$ 坐标至于 $(-1,2)$ 的位置，由绝对轴系将原题面所需横空段自然降生成真实相距 $2\text{cm}$。
    \item \textbf{降维实线填平：} 点 $A$ 处的水平正直即为题中的平行线代办段；点 $A$ 向垂线底面的下落即化为纵向截出垂段，其内直角边也一脉随之。
\end{enumerate}"""),

    # Block 10
    (r"\\textbf{绘图原理：}\n\\begin{enumerate}\n    \\item \\textbf{图文混排原生控制：} 为了完美还原.*?利用自带参数化正交逻辑就“切除包围”出了绝不失真的斜向正方体。\n\\end{enumerate}",
     r"""\textbf{绘图原理：}
\begin{enumerate}
    \item \textbf{原生文本集约：} 采用统一大视图承接文字及图稿版块，利用含折行规范的定宽端点标块完成题目文本在画布上的预加载。
    \item \textbf{直面外轮廓$(1)$：} 原稿自带偏置斜角，套取 \texttt{rotate=-15} 将之回摆，通过起始原点的水平和垂直方向推移宽界 $2\text{cm}$ 和长距 $3\text{cm}$ 合成标准外框再由回旋指令统一倾泻歪角。
    \item \textbf{平行推距结构$(2)$：} 调用 \texttt{rotate=30} 建立偏斜，以恒距参数建立相横向为 $2.5\text{cm}$ 的直条平行线面作为辅助切线，择定底部边截作首刀再拉开纵值 $2.5\text{cm}$ 闭合尾方框架以定死方体形状。
\end{enumerate}"""),

    # Block 11
    (r"\\textbf{绘图原理：}\n\\begin{enumerate}\n    \\item \\textbf{尺寸逻辑隐性推理：} 题干明确要求在这组现有的平行线内部作图且完全抵住边界.*?代码可读性亦达到极致。\n\\end{enumerate}",
     r"""\textbf{绘图原理：}
\begin{enumerate}
    \item \textbf{纵向截度锁定：} 判定题型正方形及矩形的限高皆受制边度所局限（即宽维和边界 $3\text{cm}$），进而提前常量赋予参值 \texttt{\textbackslash H=3.0} 以限定底上两平行辅助线框。
    \item \textbf{背景骨架搭建：} 生成在无偏向全画作横流横穿的长辅助导线充分布局纵距隔挡界度。
    \item \textbf{正交封闭边框：} 通过左右横排平移分别安列作画域阵地，借助简单的内置命令配合前置截距宽度和参数值快速嵌满方形厚边线组。
\end{enumerate}"""),

    # Block 12
    (r"\\textbf{绘图原理：}\n\\begin{enumerate}\n    \\item \\textbf{表格无边框设计再现：} 为了高精度重构.*?使得左侧带括号刻度在视觉上达成连强迫症都无可挑剔的绝对中心对齐。\n\\end{enumerate}",
     r"""\textbf{绘图原理：}
\begin{enumerate}
    \item \textbf{三线表格外接：} 在列声控句内抛弃尾端立向隔列 \texttt{|} 框且拉撑原内列横排值空使得左右侧完全通透化呈递。
    \item \textbf{数据折列联并：} 源信息表为二组分列态栏；底方总控纵系转由单一复合项目名为 $90\sim100$ 取代。绘图中须把该格实指高度求和定至 $17$ 级。
    \item \textbf{硬框格段规整处理：} 在全局设立规整为宽 9 落高 6 列底格阵营；利用 1 个间隔的空点柱面令对应单体黑柱完全密拼向格网两点切面内。针对 $Y$ 项括号单数值则预嵌 \texttt{\textbackslash phantom} 技术造设虚占位等量体以居化偏齐偏差。
\end{enumerate}")
]

for pattern, repl in replacements:
    content, count = re.subn(pattern, repl, content, flags=re.DOTALL)
    if count == 0:
        print(f"Failed to match pattern:\n{pattern[:50]}...")

with open(file_path, "w", encoding="utf-8") as file:
    file.write(content)
print("Finished replacements.")
