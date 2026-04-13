# K12 教辅绘图项目（Typst + CeTZ）

## 项目概述

使用 **Typst** + **CeTZ** 绘制 K12 教辅题目的配图与解答。与同级的 `LaTeX_Project/` 互补，提供更现代化的排版体验。

## 目录结构

```
Typst_Project/
├── main.typ                    # 主编译入口
├── lib/                        # 公共库
│   ├── styles.typ              # 全局样式（字体、页面、题目/解答格式）
│   ├── grid-utils.typ          # 方格纸 & 坐标系工具函数
│   └── geo-utils.typ           # 几何图形工具（三角形、标注等）
├── figures/                    # 绘图+解答源文件（按类型分目录）
│   ├── 几何作图/               # 几何变换、尺规作图等
│   ├── 统计图表/               # 条形图、折线图、扇形图
│   ├── 数据表格/               # 填表题
│   ├── 线段图/                 # 行程 / 分数应用题
│   └── 物理/                   # 受力分析、电路图
├── output/                     # PDF 输出（git 忽略）
├── .gitignore
└── README.md
```

## 技术栈

| 组件 | 版本 | 用途 |
|------|------|------|
| Typst | 0.14.2 | 排版引擎 |
| CeTZ | 0.4.2 | 矢量绘图（类 TikZ） |

## 编译方法

```bash
cd Typst_Project

# 一次性编译
typst compile main.typ output/main.pdf

# 实时预览（文件修改后自动重新编译）
typst watch main.typ output/main.pdf
```

## 添加新题目

1. 在 `figures/` 对应类型子目录下新建 `.typ` 文件
2. 文件中定义 `render()` 函数，包含绘图和解答
3. 在 `main.typ` 中 `#import` 并调用 `render()`

### 文件模板

```typst
#import "@preview/cetz:0.4.2"
#import "../../lib/grid-utils.typ": draw-grid, dot-label
#import "../../lib/geo-utils.typ": draw-triangle, mark-center

#let render() = {
  // 题目文字 ...
  // CeTZ 绘图 ...
  // 解答文字 ...
}
```

## 与 LaTeX 项目的关系

| | LaTeX_Project | Typst_Project |
|---|---|---|
| 引擎 | XeLaTeX | Typst |
| 绘图库 | TikZ / PGF | CeTZ |
| 现有规模 | 315 tikzpicture + 1155 参考图 | 测试中 |
| 适用场景 | 大规模存量图迁移 | 新题绘制 |
