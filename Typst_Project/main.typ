// ============================================================
// main.typ — Typst 绘图项目主入口
// ============================================================
// 编译命令：typst compile main.typ output/main.pdf
// 实时预览：typst watch main.typ output/main.pdf

#import "lib/styles.typ": center-figure, page-setup, problem-title, solution
#import "figures/几何作图/第7题_三角形变换.typ" as q7
#import "figures/统计图表/第2题_复式折线统计图.typ" as q2
#import "figures/物理/第11题_受力示意图.typ" as q11
#import "figures/物理/第10_11题_受力示意图.typ" as q10_11
#import "figures/物理/第7_8题_受力示意图.typ" as q7_8

// --- 全局样式 ---
#show: doc => {
  page-setup()
  doc
}

// --- 封面标题 ---
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

// --- 章节 ---
#set heading(numbering: "1.")
= 几何作图

== 图形变换

#q7.render()

#pagebreak()

= 统计图表

== 复式折线统计图

#q2.render()

#pagebreak()

= 物理

== 力的受力示意图

#q11.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q10_11.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q7_8.render()
