# K12 教辅绘图项目（Typst CeTZ + LaTeX TikZ + Web Canvas 三引擎）

## 项目概述

本项目使用多种绘图引擎为 K12 教辅（数学、物理）绘制配图与解答，涵盖小学三年级至初中八年级。所有绘图按 **绘图类型** 进行功能性分类，便于检索与维护。

本项目现已形成 **三轨并行** 的绘图技术体系：
- **Typst CeTZ**（主力） — 新题绘制的首选方案，实时预览、模块化架构
- **LaTeX TikZ**（存量） — 315 个 tikzpicture + 1155 参考图的存量体系
- **Web Canvas**（交互） — 前端交互式绘图引擎

> **新成员？** 请阅读 [CONTRIBUTING.md](CONTRIBUTING.md) 了解环境搭建、分支规范和绘图流程。

---

## 目录结构

```
项目根目录/
│
├── README.md
├── .gitignore
│
├── Typst_Project/                # ★ Typst 主力绘图项目
│   ├── main.typ                  # 主入口（封面 + 目录 + #include 各章节 + 附录）
│   ├── lib/                      # 公共库
│   │   ├── styles.typ            # 全局样式（字体、页面、题目/解答格式）
│   │   ├── grid-utils.typ        # 方格纸 & 坐标系工具函数
│   │   └── geo-utils.typ         # 几何图形工具（三角形、标注等）
│   ├── figures/                  # 绘图源文件（按类型分目录，各目录含 _chapter.typ）
│   │   ├── 教程/                 # ⛔ 只读！Typst+CeTZ 绘图教程（5章），禁止在此创建新绘图
│   │   ├── 几何作图/   (15 个)    # 尺规、变换、拼接、分数涂色
│   │   ├── 统计图表/   (6 个)     # 折线、柱状、饼图、直方图
│   │   ├── 线段图/     (3 个)     # 数轴、不等式
│   │   ├── 物理/       (20 个)    # 受力、压力、电磁、电路
│   │   └── 附录_物理第三册_电磁/ # LaTeX→Typst 重构（51 tikz + 22 circuit）
│   ├── output/                   # PDF 输出（git 忽略）
│   └── typst绘图AI提示词.md      # AI 绘图交互提示词
│
├── LaTeX_Project/                # LaTeX 存量项目
│   ├── main.tex                  # 主编译入口
│   ├── preamble.tex              # 公共导言区
│   ├── 数学/                     # 42 个子文件（5 个分类目录）
│   ├── 物理/                     # 5 个子文件（2 个分类目录）
│   ├── 附录_参考绘图/            # 1155 个外部教材绘图素材
│   ├── 参考资料/                 # 参考书籍与 PDF
│   └── Temp_Work/                # LaTeX 临时工作区
│
├── Scripts_Env/                  # Python 脚本与工具
│   ├── inventory_tikz.py         # 绘图/表格统计
│   ├── restructure.py            # 自动化重构
│   └── ...                       # 其他工具脚本
│
└── Web_Project/                  # 前端 Canvas 绘图引擎
    ├── index.html
    ├── css/ & lib/ & figures/
    └── ...
```

---

## Typst 主力项目（Typst_Project/）

### 技术栈

| 组件 | 版本 | 用途 |
|------|------|------|
| Typst | 0.14.2 | 排版引擎 |
| CeTZ | 0.4.2 | 矢量绘图（类 TikZ） |

### 模块化架构

采用 **`_chapter.typ` 聚合模式**，main.typ 管理全局样式 + 页码 + 附录：

```
main.typ                              ← 全局样式 + 封面 + 目录 + #include 章节 + 附录
  ├─ #include "figures/几何作图/_chapter.typ"
  ├─ #include "figures/统计图表/_chapter.typ"
  ├─ #include "figures/线段图/_chapter.typ"
  ├─ #include "figures/物理/_chapter.typ"
  └─ #include "figures/附录_物理第三册_电磁/_appendix.typ"

_chapter.typ                           ← 每个分类目录的聚合文件
  ├─ #import "绘图A.typ" as _A         ← 本地 import
  ├─ #import "绘图B.typ" as _B
  ├─ = 一级标题（学科/大类，独占一页居中）
  ├─ == 二级标题（绘图分类，新页居中）
  └─ === 三级标题（具体绘图，居中大号）
```

**优势**：添加新绘图只需编辑对应目录的 `_chapter.typ`，无需修改 `main.typ`。

### 排版样式（模仿 ctexbook 中文方案）

| 特性 | 说明 |
|------|------|
| 封面 | 居中垂直布局，无页码 |
| 目录 | 罗马数字页码（i, ii, ...），深蓝色链接，导引点 |
| 正文 | 阿拉伯数字页码（1, 2, ...），首行缩进 2em |
| L1 标题 | `= 几何作图`，独占一页居中，"第X部分" 编号 |
| L2 标题 | `== 尺规作图`，新页居中，"X.Y" 编号 |
| L3 标题 | `=== 具体绘图`，居中 14pt，"X.Y.Z" 编号 |
| 附录 | "附录 A" 编号方案，无部分编号 |

### 三级目录索引

PDF 编译后自动生成三级目录，每个绘图都有独立条目可直接跳转：

```
第一部分 几何作图           ← 一级（学科/大类）
  1.1 尺规作图              ← 二级（绘图分类）
    1.1.1 尺规取等长线段 ........... 1  ← 三级（具体绘图，导引点+页码）
    1.1.2 尺规作图·角平分线与垂线
```

### 编译方法

```bash
cd Typst_Project

# 一次性编译
typst compile main.typ output/main.pdf

# 实时预览
typst watch main.typ output/main.pdf
```

### 添加新绘图

1. 在 `figures/` 对应类型子目录下新建 `.typ` 文件
2. **文件名为纯描述性**，不使用题号（如 `尺规取等长线段.typ`）
3. 文件中定义 `render()` 函数，包含绘图和解答
4. 在同目录的 `_chapter.typ` 中注册（添加 import + `===` 标题 + render 调用）

#### 文件模板

```typst
// ============================================================
// {描述性名称}
// ============================================================
#import "@preview/cetz:0.4.2"
#import "../../lib/grid-utils.typ": draw-grid, dot-label

#let render() = {
  // 题目文字 → CeTZ 绘图 → 解答文字
}
```

#### 命名规范

| 分类 | 命名示例 |
|------|---------|
| 几何作图 | `尺规取等长线段.typ`、`三角形平移旋转.typ` |
| 统计图表 | `北京南京气温_复式折线统计图.typ` |
| 物理受力 | `受力_斜面物体与绳子.typ` |
| 物理压力 | `压力_水平竖直斜面.typ` |
| 物理电路 | `电路图_电动机滑动变阻器.typ` |

### 文件统计

**42 个课程绘图文件**：几何作图 15 | 统计图表 6 | 线段图 3 | 物理 18
**Typst+CeTZ 绘图教程**：5 章（基础语法、CeTZ 入门、常用图形、K12 实战、项目架构）
**51 个电磁 tikz 重构图**：磁场 22 | 电磁感应 5 | 交流电 20 | 电磁振荡和电磁波 4
**22 个电路图（circuit）**：电磁感应 10 | 交流电 12

### 电磁重构附录

从 LaTeX TikZ/circuitikz 精细重构为 Typst CeTZ 的物理第三册电磁图形：

#### tikz 矢量图（51 张 ✅）

| 章节 | 图数 | 状态 | 关键技术 |
|------|------|------|----------|
| 磁场 | 22 | ✅ | 同心弧、旋转矩阵、负电荷轨迹、回旋加速器 |
| 电磁感应 | 5 | ✅ | 层叠遮罩、涡流环、椎圆弧 |
| 交流电 | 20 | ✅ | 正弦波工具(_sine_utils.typ)、三相波形、整流滤波 |
| 电磁振荡和电磁波 | 4 | ✅ | 阻尼振荡exp(-x)、电磁场分布 |

#### 电路图 circuit（22 张 ✅ / 22 张跳过）

| 章节 | 完成 | 跳过 | 说明 |
|------|------|------|------|
| 电磁感应 | 10 | 0 | 电池+开关+电阻+灯泡+仪表+电感 |
| 交流电（简单） | 12 | 0 | AC源+R/L/C+滤波+功率+信号检波 |
| 交流电（复杂） | 0 | 22 | 变压器铁芯/三相线圈 — 绘制质量不佳 |

#### 电路工具库 `_circuit_utils.typ`（v3）

集中管理 10 种电路元件的绘制函数：电池、开关、电阻、电感（含 mirror 参数）、灯泡、仪表、电容、二极管、AC源、铁芯。

编译入口：`figures/附录_物理第三册_电磁/_appendix.typ`
正弦波工具：`figures/附录_物理第三册_电磁/交流电/_sine_utils.typ`
电路工具库：`figures/附录_物理第三册_电磁/_circuit_utils.typ`

---

## LaTeX 存量项目（LaTeX_Project/）

### 编译方法

```bash
cd LaTeX_Project
xelatex main.tex
xelatex main.tex   # 运行两次以生成正确目录
```

### 章节概览

| 部分 | 章节 | 子文件数 |
|------|------|---------|
| 数学 | 几何作图（18节）、统计图表（12节）、数据表格（6节）、连线题（1节）、线段图（5节） | 42 |
| 物理 | 力学作图（4节）、坐标图像（1节） | 5 |
| 附录 | 外部教材参考绘图库 | 1155 |

**统计**：315 个 tikzpicture 环境、81 个 tabular 表格

### TikZ 依赖库

| 库名 | 用途 |
|------|------|
| `angles`, `quotes` | 画角、直角标记 |
| `arrows.meta` | Stealth 箭头 |
| `calc` | 坐标计算 |
| `tkz-euclide` | 欧几里得几何 |
| `circuitikz` | 电路图 |

---

## 前端绘图引擎（Web_Project/）

基于 **HTML5 Canvas** 的前端绘图引擎，纯原生 JavaScript（ES Modules），零依赖。

- 模块化架构，1:1 对标 Typst 项目结构
- HiDPI 适配，深色主题 glassmorphism UI
- 启动：`npx http-server Web_Project -p 8090`

---

## 脚本与工具（Scripts_Env/）

Python 环境使用 `uv` 管理。

| 脚本 | 用途 |
|------|------|
| `inventory_tikz.py` | 统计 tikzpicture / tabular 数量 |
| `restructure.py` | 按绘图类型自动重构 .tex 文件 |
| `extract_tikz.py` | 从 tex 中抽取 TikZ 环境生成独立文件 |
| `fix_tikz_errors.py` | 批量修正语法错误 |
| `generate_index_table.py` | 生成 1155 个外部绘图的索引表 |
| `extract_principles.py` | 提取绘图原理文本 |
| `add_tex_root.py` | 添加 TeX 根文件标记 |

---

## 三引擎对比

| | Typst（主力） | LaTeX（存量） | Web（交互） |
|---|---|---|---|
| 引擎 | Typst 0.14.2 | XeLaTeX | HTML5 Canvas |
| 绘图库 | CeTZ 0.4.2 | TikZ / PGF | 原生 JS |
| 现有规模 | 42 绘图 + 51 电磁tikz + 22 电路图 | 315 tikzpicture + 1155 参考图 | 1 个题目 |
| 实时预览 | ✅ 毫秒级 | ❌ 需编译 | ✅ 浏览器 |
| 适用场景 | **新题绘制（首选）** | 存量维护 | 交互演示 |
