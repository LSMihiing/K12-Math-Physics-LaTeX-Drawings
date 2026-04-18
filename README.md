# K12 教辅绘图项目（LaTeX TikZ + Typst CeTZ + Web Canvas 三引擎）

## 项目概述

本项目使用 LaTeX TikZ 绘制 K12 教辅（数学、物理）题目的配图与答案，涵盖小学三年级至初中八年级。所有绘图按 **绘图类型** 进行功能性分类，便于检索与维护，定位类似一本 *K12 数理习题答案绘制手册*。另外，本项目在附录中全量整合了来自 jamesfang8499 的外部教材库，引入了高达 **1155 个** 高质量参阅资料绘图，形成了丰沛的 LaTeX 绘图大全体系。

本项目现已形成 **三轨并行** 的绘图技术体系：**LaTeX TikZ**（传统排版）、**Typst CeTZ**（现代排版）、**Web Canvas**（前端交互）。

**统计：** 基础教辅部分包含 47 个子文件，共 **315 个 tikzpicture** 环境、**81 个 tabular** 表格；附录参考绘图库新增 **1155 个** 独立图形素材文件。

---

## 目录结构

```
项目根目录/
│
├── README.md
├── .gitignore
│
├── LaTeX_Project/                # LaTeX 主项目
│   ├── main.tex                  # 主编译入口
│   ├── preamble.tex              # 公共导言区（宏包、样式）
│   ├── 数学/                     # 数学部分（5 个分类目录，42 个子文件）
│   │   ├── 几何作图/             # 18 个子文件
│   │   ├── 统计图表/             # 12 个子文件
│   │   ├── 数据表格/             # 6 个子文件
│   │   ├── 连线题/               # 1 个子文件
│   │   └── 线段图/               # 5 个子文件
│   ├── 物理/                     # 物理部分（2 个分类目录，5 个子文件）
│   │   ├── 力学作图/             # 4 个子文件
│   │   └── 坐标图像/             # 1 个子文件
│   ├── 附录_参考绘图/            # 从外部教材库提取集的宏大绘图集（按学科/教材分册整理）
│   ├── 参考资料/                 # 外部引用或需要阅读的参考书籍与 PDF 文档
│   ├── 原始文件/                 # 原始未拆分的教辅源文件（存档）
│   └── _backup_before_restructure/  # 重构前按年级分类的备份
│
├── Scripts_Env/                  # Python 脚本与工具
│   ├── .venv/                    # uv 管理的 Python 虚拟环境
│   ├── pyproject.toml
│   ├── inventory_tikz.py         # 绘图/表格统计脚本
│   ├── inventory_result.json     # 统计结果（所有绘图的完整清单）
│   ├── restructure.py            # 自动化重构脚本
│   ├── implementation_plan.md    # 重构实施计划
│   ├── extract_tikz.py           # 从大段 tex 中抽取 TikZ环境生成独立子文件脚本
│   ├── fix_tikz_errors.py        # 批量预处理、修正抽出图片的常见语法错误的工具
│   ├── generate_index_table.py   # 生成用于查看和对照所有 1155 张外部绘图的长表格脚本
│   └── add_tex_root.py           # 批量补充魔法注释工具
│
├── Temp_Work/                    # 临时 LaTeX 工作区
│   └── temp_answer.tex           # 独立可编译的草稿/测试文件
│
├── Typst_Project/                # Typst 现代绘图项目（双轨并行）
│   ├── main.typ                  # Typst 编译主入口
│   ├── lib/                      # 公共样式库
│   └── figures/                  # Typst 教辅绘图目录（数学、物理等）
│
└── Web_Project/                  # 前端 Canvas 绘图引擎（三轨并行）
    ├── index.html                # 首页：题目列表 + Canvas 渲染 + 解答面板
    ├── css/
    │   └── styles.css            # 全局样式（深色主题、glassmorphism）
    ├── lib/                      # 公共绘图库（对标 Typst lib/）
    │   ├── grid-utils.js         # 方格纸绘制
    │   ├── transform.js          # 几何变换（平移、旋转）
    │   ├── label.js              # 点标签与文字
    │   └── draw-helpers.js       # 三角形、虚线箭头等通用图元
    └── figures/                  # 题目绘图模块（按分类组织）
        └── 几何作图/
            └── q3-triangle-transform.js  # 第3题 三角形平移旋转
```

---

## LaTeX 主项目（LaTeX_Project/）

### 章节层级

| 层级 | LaTeX 命令 | 用途 | 示例 |
|------|-----------|------|------|
| 部 | `\part{}` | 学科划分 | 数学、物理 |
| 章 | `\chapter{}` | 绘图大类 | 几何作图、统计图表 |
| 节 | `\section{}` | 绘图小类 | 画角与量角、条形统计图（单式） |
| 小节 | `\subsection{}` | 具体题目 | 解答：以下面的射线为一条边，画出各个角 |

### 数学部分

#### 第 1 章 · 几何作图（18 节）

| 节 | 文件名 | 说明 |
|----|--------|------|
| §1.1 | 画角与量角.tex | 量角器画角、角度测量 |
| §1.2 | 画线段与尺规作图.tex | 线段画法、圆规尺规综合 |
| §1.3 | 垂线与平行线.tex | 过点画垂线/平行线、最短距离 |
| §1.4 | 三角形画高.tex | 三角形、平行四边形、梯形画高 |
| §1.5 | 标准几何图形绘制.tex | 长方形、正方形、规则图形 |
| §1.6 | 梯形与平行四边形.tex | 梯形周长、平行四边形性质 |
| §1.7 | 三角形分割与拼组.tex | 三角尺拼图、分割、三边关系 |
| §1.8 | 图形变换\_平移.tex | 图形平移、平移组合图案 |
| §1.9 | 图形变换\_旋转.tex | 网格旋转、绕点旋转作图 |
| §1.10 | 图形变换\_对称.tex | 轴对称图形、对称轴绘制 |
| §1.11 | 图形变换\_中心对称与复合.tex | 中心对称、复合变换 |
| §1.12 | 图形放大与缩小.tex | 按比例放大缩小 |
| §1.13 | 最短路径与几何模型.tex | 饮马模型、几何概型 |
| §1.14 | 分数涂色与等值分数.tex | 涂色表示分数、等值分数 |
| §1.15 | 小数涂色与描点.tex | 十分格/百分格涂色、直线描点 |
| §1.16 | 比例尺方位与坐标.tex | 比例尺作图、数对表示位置 |
| §1.17 | 点子图与观察物体.tex | 点子图画等面积图形、视图 |
| §1.18 | 图形规律与序列.tex | 图形接龙、周期规律 |

#### 第 2 章 · 统计图表（12 节）

| 节 | 文件名 | 说明 |
|----|--------|------|
| §2.1 | 条形统计图\_单式.tex | 单式条形图绘制 |
| §2.2 | 条形统计图补全.tex | 不完整条形图补全 |
| §2.3 | 复式条形统计图.tex | 双组对比条形图 |
| §2.4 | 折线统计图\_单式.tex | 单式折线图 |
| §2.5 | 复式折线统计图.tex | 双线对比折线图 |
| §2.6 | 扇形统计图.tex | 扇形图绘制与计算 |
| §2.7 | 条形图与扇形图综合.tex | 双图综合分析 |
| §2.8 | 频数直方图.tex | 频数分布与直方图 |
| §2.9 | 概率频率折线图.tex | 概率试验折线图 |
| §2.10 | 正比例图像.tex | 正比例关系图像 |
| §2.11 | 统计方案与图表选择.tex | 方案设计与图表类型选择 |
| §2.12 | 转盘涂色.tex | 概率转盘涂色 |

#### 第 3 章 · 数据表格（6 节）

| 节 | 文件名 | 说明 |
|----|--------|------|
| §3.1 | 填表题\_正反比例.tex | 正比例、反比例填表 |
| §3.2 | 互化表.tex | 分数/小数/百分数互化 |
| §3.3 | 数位顺序表.tex | 整数数位顺序表 |
| §3.4 | 购买与运算表格.tex | 应用题运算表格 |
| §3.5 | 代数运算填表.tex | 整式运算法则填表 |
| §3.6 | 频数统计表.tex | 频数分布统计表 |

#### 第 4 章 · 连线题（1 节）

| 节 | 文件名 | 说明 |
|----|--------|------|
| §4.1 | 连线题.tex | 连线匹配题 |

#### 第 5 章 · 线段图（5 节）

| 节 | 文件名 | 说明 |
|----|--------|------|
| §5.1 | 行程问题线段图.tex | 行程问题图解 |
| §5.2 | 和差问题线段图.tex | 和差倍问题图解 |
| §5.3 | 分数应用题线段图.tex | 分数应用题图解 |
| §5.4 | 数轴与不等式.tex | 不等式解集数轴表示 |
| §5.5 | 日历与其他.tex | 日历、杂项图解 |

### 物理部分

#### 第 6 章 · 力学作图（4 节）

| 节 | 文件名 | 说明 |
|----|--------|------|
| §6.1 | 重力示意图.tex | 物体重力方向标注 |
| §6.2 | 浮力示意图.tex | 浮力受力分析 |
| §6.3 | 综合受力分析.tex | 多力施力示意图 |
| §6.4 | 弹簧测力计.tex | 测力计原理作图 |

#### 第 7 章 · 坐标图像（1 节）

| 节 | 文件名 | 说明 |
|----|--------|------|
| §7.1 | G-m与m-V关系图像.tex | 重力-质量、质量-体积关系图 |

---

## Typst 绘图项目（Typst_Project/）

为提升渲染速度与实时预览体验（借助 VSCode TinyTypst 等扩展），本项目同时引入了 **Typst + CeTZ** 绘图方案，逐步形成双轨并行教辅绘图体系。

- **`main.typ`**：集合所有章节作图解答的主文件，整体排版导出为 `main.pdf`。
- **`figures/`**：目录下按学科核心分类（如：物理、几何作图、统计图表等），单题单文件组织，利于分别维护并由主入口统一索引。
- 采用 Typst 提供了更为现代化的开发流程，无论是几何作图还是受力分析都能更方便快速地实现局部和组件化复用。

---

## 前端绘图引擎（Web_Project/）

作为第三条技术路线，本项目新增了基于 **HTML5 Canvas** 的前端绘图引擎，使用纯原生 JavaScript（ES Modules）实现，无框架依赖，即开即用。

### 技术特点

- **零依赖**：纯 HTML + CSS + JavaScript，无需 npm install，浏览器直接运行。
- **模块化架构**：公共绘图库（`lib/`）与题目文件（`figures/`）分离，1:1 对标 Typst 项目结构。
- **高保真复刻**：坐标、颜色、透明度、标签方向完全对标 Typst 版本。
- **HiDPI 支持**：自动适配高分辨率屏幕（Retina 等），确保绘图清晰锐利。
- **深色主题 UI**：glassmorphism 风格、渐变背景、微动画，提供现代化交互体验。

### 公共绘图库（`lib/`）

| 文件 | 对标 Typst | 功能 |
|------|-----------|------|
| `grid-utils.js` | `grid-utils.typ` | 方格纸绘制（可配置行列、步长、线色） |
| `transform.js` | — | 几何变换：平移、顺时针旋转 90°、任意角度旋转 |
| `label.js` | `dot-label` 函数 | 8 方向点标签绘制（圆点 + 文字偏移） |
| `draw-helpers.js` | — | 通用图元：三角形填充描边、虚线箭头 |

### 已实现题目

| 题号 | 文件 | 内容 |
|------|------|------|
| 第3题 | `figures/几何作图/q3-triangle-transform.js` | 三角形平移与旋转（方格纸） |

### 启动方式

使用 VSCode Live Server 或任意静态服务器：

```bash
# 方式一：VSCode Live Server（推荐）
# 右键 Web_Project/index.html → Open with Live Server

# 方式二：Node.js http-server
npx http-server Web_Project -p 8090

# 方式三：Python
python -m http.server 8090 -d Web_Project
```

> 必须通过 HTTP 服务器访问（ES Modules 不支持 `file://` 协议）。

### 添加新题目

1. 在 `figures/` 对应分类目录下新建 JS 文件（如 `q4-xxx.js`）
2. 导出 `meta`（题目元数据）、`solutionSteps`（解答步骤）、`drawProblem` / `drawAnswer`（绘图函数）
3. 在 `index.html` 的侧边栏和 script 中注册该题目

---

## 编译方法

```bash
cd LaTeX_Project

# 需要 TeX Live 或 MiKTeX，使用 XeLaTeX 编译（运行两次以生成正确目录）
xelatex main.tex
xelatex main.tex
```

> 编译主文件 `main.tex` 即可生成包含全部绘图的完整 PDF。子文件均通过 `\input` 引入，不可单独编译。

---

## 脚本与工具（Scripts_Env/）

Python 环境使用 `uv` 管理，虚拟环境位于 `Scripts_Env/.venv`。

| 文件 | 用途 |
|------|------|
| `inventory_tikz.py` | 遍历所有 .tex 文件，统计 tikzpicture / tabular 数量，按标题分组输出 |
| `inventory_result.json` | 统计结果的 JSON 格式存档，记录每个小节的绘图/表格数量与位置 |
| `restructure.py` | 自动化重构脚本：将按年级组织的 .tex 文件拆分为按绘图类型组织的新文件 |
| `extract_tikz.py` | 针对外部项目设计的抽取器，自动截取包含 `tikzpicture`/`circuitikz` 的环境内容并存储至独立文件 |
| `fix_tikz_errors.py` | 一键扫描附录文件夹，自动修正和过滤外部提取途中带来的错误符号、缺失包、路径依赖 |
| `generate_index_table.py` | 根据解析到的 1155 个文件字典，自动生成附录用于导引和快速检索查阅的长索引表代码 |
| `implementation_plan.md` | 重构实施计划与工作状态跟踪 |
| `extract_principles.py` | 提取绘图原理说明文本 |
| `sanitize.js` | 文本清洗工具 |

### 运行脚本

```bash
cd Scripts_Env

# 激活环境
.venv\Scripts\activate    # Windows
# source .venv/bin/activate  # macOS/Linux

# 统计绘图数量
python inventory_tikz.py

# 执行重构（支持 --dry 模拟运行）
python restructure.py --dry   # 预览，不实际写入
python restructure.py          # 正式执行
```

---

## 临时工作区（Temp_Work/）

`Temp_Work/temp_answer.tex` 是一个独立可编译的 LaTeX 文件，用于：

- 新绘图的草稿编写与调试
- 编译验证后再合并入主项目

该文件包含独立的 `\documentclass` 和 `\begin{document}` 环境，可直接用 `xelatex` 编译。不被主文件 `main.tex` 引用。

---

## TikZ 依赖库

| 库名或宏包名 | 用途 |
|------|------|
| `angles`, `quotes` | 画角、直角标记与附着文字标签 |
| `arrows.meta` | Stealth 箭头等定制端点 |
| `calc` | 坐标数学计算扩展 |
| `decorations.pathreplacing` | 大括号等替换式装饰 |
| `decorations.markings` | 允许在线段特定处补充标记（附录作图依赖） |
| `decorations.pathmorphing` | 呈现波浪、弹簧状的不规则曲面路径变换（附录依赖） |
| `patterns`, `positioning` | 阴影网格纹填充图案、节点之间相对方位指令 |
| `tkz-euclide` | 提供了更高层高度封装的欧几里得几何计算命令集 |
| `circuitikz` | 标准的物理电路回路和元件作图专用包 |
| `wasysym`, `marvosym` | 绘制 \Sun 等非标准的天体或特殊字体符号大全 |

## 全局自定义样式

在 `preamble.tex` 中定义了以下可复用样式：

- `ray` — 带箭头的射线（蓝青色，1.2pt）
- `given ray` — 不带箭头的已知线段
- `angle arc` — 角弧（红黑色，0.8pt）
- `angle label` — 角度文字标签
- `vertex dot` — 顶点圆点

自定义宏：`\zhengI` ~ `\zhengV` — 正字计数法符号。

---

## 添加新绘图

1. 确定绘图类型，找到对应子文件（如 `数学/几何作图/垂线与平行线.tex`）
2. 在文件末尾添加 `\subsection{解答：...}` 和 TikZ 代码
3. 编译 `LaTeX_Project/main.tex` 验证
4. 如需新增分类节，在 `main.tex` 中添加 `\section{...}` 和 `\input{...}`
