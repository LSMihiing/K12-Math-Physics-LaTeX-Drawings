// ============================================================
// 第一章 Typst 基础语法
// ============================================================
// 参考：https://typst.app/docs/tutorial
// 参考：https://typst.app/docs/reference/scripting

=== Typst 是什么

*Typst* 是一个现代排版系统，用于替代 LaTeX 和 Word。它的核心优势：

- *编译极快*：毫秒级增量编译，支持实时预览
- *语法简洁*：比 LaTeX 更易学，比 Word 更精确
- *可编程*：内置脚本语言，可以用变量、循环、函数控制排版

#v(0.5em)
#block(
  width: 100%,
  inset: (x: 1em, y: 0.8em),
  stroke: (left: 2pt + rgb("#4A90D9")),
  fill: rgb("#F0F6FF"),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #text(weight: "bold", fill: rgb("#4A90D9"))[安装与编译]
  #v(0.3em)
  #set text(size: 9pt)
  ```
  安装：winget install Typst.Typst
  编译：typst compile main.typ output/main.pdf --root .
  实时预览：typst watch main.typ output/main.pdf --root .
  ```
  VS Code 推荐安装 *tinymist* 扩展，可在编辑器内实时预览。
]

=== 三种模式

Typst 有三种书写模式，可以随时切换：

#v(0.5em)
#table(
  columns: (1fr, 1fr, 1fr),
  inset: 8pt,
  align: left,
  table.header([*模式*], [*用途*], [*示例*]),
  [标记模式（Markup）], [正常写文字], [`= 标题`、`*加粗*`、`- 列表`],
  [脚本模式（Scripting）], [逻辑控制], [`#let x = 42`、`#if`、`#for`],
  [数学模式（Math）], [公式排版], [`$a^2 + b^2 = c^2$`],
)

*切换规则*：
- 标记模式中，用 `#` 进入脚本模式（如 `#text(size: 12pt)[...]`）
- 脚本模式中，用 `[...]` 回到标记模式
- 任何地方用 `$...$` 进入数学模式

#import "_example_env.typ": markup-example

=== 基本文本与排版

==== 标题

用 `=` 的数量表示标题层级（类似 Markdown 的 `#`）：

#markup-example(```
= 一级标题
== 二级标题
=== 三级标题
```)

本项目中，`=` 用于"部分"（如几何作图），`==` 用于"章"，`===` 用于"节"。
参见本书 `main.typ` 第 44–101 行的标题编号和样式定义。

==== 段落与间距

#markup-example(```
首段文字。

空行分段。#v(1em)
插入垂直间距后的段落。

水平留白：前#h(3em)后
```)

// 参考：https://typst.app/docs/reference/layout/v

==== 文字样式

#markup-example(```
*加粗文字*

_斜体文字_

#text(fill: red, size: 14pt)[红色大字]

#text(weight: "bold")[程序化加粗]
```)

=== 函数与变量

Typst 的强大之处在于它是可编程的。用 `#let` 定义变量和函数：

==== 变量

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  #let main-color = rgb("#2563EB")    // 颜色变量
  #let stroke-width = 0.8pt           // 尺寸变量
  #let title = "K12 绘图教程"          // 字符串变量
  ```
]

==== 函数定义

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  // 定义一个"解答块"函数（摘自本项目 lib/styles.typ）
  #let solution(body) = {
    block(
      width: 100%,
      inset: (x: 1em, y: 0.8em),
      stroke: (left: 2.5pt + rgb("#4A90D9")),
      fill: rgb("#F0F6FF"),
      radius: 2pt,
    )[
      #text(weight: "bold", fill: rgb("#4A90D9"))[解答]
      #v(0.3em)
      #body
    ]
  }

  // 调用
  #solution[这里是解答内容。]
  ```
  参见本书 `lib/styles.typ` 的 `solution()`、`problem-title()` 函数。
]

==== set 与 show 规则

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  // set：设定默认值（影响后续所有同类元素）
  #set text(size: 10pt, lang: "zh")
  #set par(first-line-indent: 2em)

  // show：自定义元素的渲染方式
  #show heading.where(level: 2): it => {
    pagebreak(weak: true)
    align(center, text(size: 18pt, weight: "bold")[#it.body])
  }
  ```
  // 参考：https://typst.app/docs/reference/scripting/#blocks
]

=== 模块系统

本项目使用模块化架构，理解 `#import` 和 `#include` 是关键。

==== import（导入函数/变量）

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  // 导入外部包
  #import "@preview/cetz:0.4.2"

  // 导入本地文件的所有导出
  #import "lib/styles.typ": *

  // 导入本地文件作为模块
  #import "尺规取等长线段.typ" as _尺规
  #_尺规.render()   // 调用模块中的函数
  ```
]

==== include（嵌入整个文件内容）

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  // 将另一个文件的全部内容插入此处
  #include "figures/几何作图/_chapter.typ"
  ```
  `main.typ` 用 `#include` 引入各章节聚合文件，每个聚合文件内部用 `#import` 引入各绘图模块。
]

==== 本项目的三层架构

#v(0.5em)
#table(
  columns: (auto, 1fr, 1fr),
  inset: 8pt,
  align: left,
  table.header([*层级*], [*文件*], [*职责*]),
  [第一层], [`main.typ`], [全局样式 + `#include` 各部分],
  [第二层], [`_chapter.typ`], [`#import` 各绘图文件 + 编排标题层级],
  [第三层], [`*.typ` 绘图文件], [导出 `render()` 函数，包含题目和图形],
)

// 参考：https://typst.app/docs/reference/scripting/#modules
