// ============================================================
// Typst 绘图教程 — 聚合文件
// ============================================================
// 本教程帮助读者从零掌握 Typst 基本语法和 CeTZ 绘图库，
// 并能独立创作 K12 教辅配图。

// 全局样式：内联代码自动加背景色 + Typst 语法高亮
#show raw.where(block: false): it => {
  if it.lang == none {
    // 无语言标记的内联代码 → 加 typst 高亮 + 背景
    box(
      fill: luma(240),
      inset: (x: 3pt, y: 2pt),
      radius: 2pt,
      baseline: 2pt,
      raw(it.text, lang: "typst"),
    )
  } else {
    // 已有语言标记（含递归产生的 typst）→ 仅加背景
    box(
      fill: luma(240),
      inset: (x: 3pt, y: 2pt),
      radius: 2pt,
      baseline: 2pt,
      it,
    )
  }
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
