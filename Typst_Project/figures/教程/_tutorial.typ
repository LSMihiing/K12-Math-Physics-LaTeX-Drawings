// ============================================================
// Typst 绘图教程 — 聚合文件
// ============================================================
// 本教程帮助读者从零掌握 Typst 基本语法和 CeTZ 绘图库，
// 并能独立创作 K12 教辅配图。

// 全局样式：内联代码自动加背景色 + Typst 语法高亮
// 注意：必须在 box 内部使用 show raw: set text，否则被创建的 raw
//       不会继承外部 show 规则，而是回退到默认的 DejaVu 导致衬线问题
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
