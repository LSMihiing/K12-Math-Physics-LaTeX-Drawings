// ============================================================
// Typst 绘图教程 — 聚合文件
// ============================================================
// 本教程帮助读者从零掌握 Typst 基本语法和 CeTZ 绘图库，
// 并能独立创作 K12 教辅配图。

// 全局样式：内联代码自动加背景色
// 【核心防坑指南：AST 映射与字体级联】
// 1. 保护双向跳转：直接使用 `#it` 输出原始节点，切勿使用 `#raw(it.text)` 重构节点，否则 Tinymist 源码跳转会失效。
// 2. 突破死循环防线：Typst 为防止死循环，不会将外部的 show raw 规则应用到本规则输出的 raw 节点上。
//    如果不在此处局部重申 `#show raw: set text`，新节点会回退到系统默认等宽字体（DejaVu）。
//    在 Windows 缺失该字体时，会继续“裸奔”回退到正文全局衬线体（Times New Roman），导致代码内等号（==）出现多余衬线。
#let _code-font = ("Consolas", "SimSun")
#show raw.where(block: false): it => {
  box(
    fill: luma(240),
    inset: (x: 3pt, y: 2pt),
    radius: 2pt,
    baseline: 2pt,
  )[
    #show raw: set text(font: _code-font)
    #it
  ]
}

= Typst 绘图教程

== Typst 基础语法
#include "ch1_typst_basics.typ"

#pagebreak()

== CeTZ 绘图入门
#include "ch2_cetz_intro.typ"

#pagebreak()

== 常用图形与技巧
#include "ch3_common_shapes.typ"

#pagebreak()

== K12 绘图实战
#include "ch4_k12_practice.typ"

#pagebreak()

== 项目架构与工作流
#include "ch5_project_arch.typ"
