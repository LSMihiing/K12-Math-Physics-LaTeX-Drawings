// ============================================================
// main.typ — Typst 绘图项目主入口
// ============================================================
// 编译命令：typst compile main.typ output/main.pdf
// 实时预览：typst watch main.typ output/main.pdf

#import "lib/styles.typ": center-figure, page-setup, problem-title, solution

// ============================================================
// 全局样式
// ============================================================
#show: doc => {
  page-setup()
  doc
}

// ============================================================
// 封面
// ============================================================
#align(center)[
  #v(2cm)
  #text(size: 24pt, weight: "bold")[教辅解答绘图集]
  #v(0.5em)
  #text(size: 14pt, fill: luma(80))[Typst + CeTZ 版]
  #v(0.3em)
  #line(length: 60%, stroke: 0.5pt + luma(180))
  #v(0.3em)
  #text(size: 11pt, fill: luma(100))[K12 数学 / 物理]
  #v(3cm)
]

// ============================================================
// 目录（深度 3，展示到每个绘图）
// ============================================================
#outline(title: "目录", depth: 3)

#pagebreak()

// ============================================================
// 正文 — 各章节由 _chapter.typ 聚合文件管理
// ============================================================
// 添加新绘图时，只需编辑对应目录下的 _chapter.typ，
// 无需修改本文件。
// ============================================================
#set heading(numbering: "1.")

#include "figures/几何作图/_chapter.typ"
#include "figures/统计图表/_chapter.typ"
#include "figures/线段图/_chapter.typ"
#include "figures/物理/_chapter.typ"
