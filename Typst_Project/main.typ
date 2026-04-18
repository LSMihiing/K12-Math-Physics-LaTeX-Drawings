// ============================================================
// main.typ — Typst 绘图项目主入口
// ============================================================
// 编译命令：typst compile main.typ output/main.pdf
// 实时预览：typst watch main.typ output/main.pdf

#import "lib/styles.typ": center-figure, page-setup, problem-title, solution
#import "figures/几何作图/第7题_三角形变换.typ" as q7
#import "figures/统计图表/第2题_复式折线统计图.typ" as q2
#import "figures/统计图表/第2题_合唱团年龄统计.typ" as q2_choir
#import "figures/统计图表/第2题_课后延时服务统计.typ" as q2_service
#import "figures/统计图表/第3题_成绩频数分布直方图.typ" as q3_histogram
#import "figures/统计图表/第4题_品种成活率统计.typ" as q4_survival
#import "figures/物理/第11题_受力示意图.typ" as q11
#import "figures/物理/第10_11题_受力示意图.typ" as q10_11
#import "figures/物理/第7_8题_受力示意图.typ" as q7_8
#import "figures/物理/第5题_压力示意图.typ" as q5
#import "figures/物理/第4题_受力示意图.typ" as q4
#import "figures/物理/第2题_受力示意图.typ" as q2_physics
#import "figures/物理/第12题_通电螺线管与条形磁体.typ" as q12
#import "figures/物理/第12题_压力示意图.typ" as q12_p
#import "figures/物理/第13题_压力示意图.typ" as q13_p
#import "figures/物理/第24题_重力示意图.typ" as q24
#import "figures/物理/第25题_压力示意图.typ" as q25
#import "figures/物理/第20题_受力示意图.typ" as q20_force
#import "figures/物理/第7题_星系运动关系图.typ" as q7_hubble
#import "figures/物理/第14题_磁场作图.typ" as q14
#import "figures/物理/第19题_受力示意图.typ" as q19
#import "figures/物理/第20题_家庭电路.typ" as q20
#import "figures/几何作图/第3题_尺规作图.typ" as q3
#import "figures/几何作图/第3题_三角形平移旋转.typ" as q3_transform
#import "figures/几何作图/第3题_长方形拼图.typ" as q3_puzzle
#import "figures/几何作图/第2题_尺规取等长线段.typ" as q2_compass
#import "figures/几何作图/第7题_正方形与长方形.typ" as q7_rect
#import "figures/几何作图/第3题_分数涂色比较.typ" as q3_fraction
#import "figures/几何作图/第2题_蔬菜种植面积.typ" as q2_veggies
#import "figures/几何作图/第5题_画长方形.typ" as q5_grid
#import "figures/几何作图/第3题_根据分数推导图形.typ" as q3_fraction_deduce
#import "figures/几何作图/第1题_分数涂色与比较大小.typ" as q1_fraction_compare
#import "figures/几何作图/第2题_九宫格涂色.typ" as q2_grid_color
#import "figures/几何作图/第8题_补充图形.typ" as q8_complete
#import "figures/物理/第9题_电路图.typ" as q9
#import "figures/物理/第19题_大气压估测表格.typ" as q19_table
#import "figures/线段图/第3题_解不等式数轴.typ" as q3_ineq
#import "figures/线段图/第15题_解不等式数轴.typ" as q15_ineq
#import "figures/线段图/第16题_解不等式组.typ" as q16_ineq

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

== 尺规作图

#q2_compass.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q3.render()



== 图形变换

#q3_transform.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q7.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

== 图形拼接

#q3_puzzle.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q7_rect.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

== 网格纸作图

#q5_grid.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

== 几何图形与分数

#q1_fraction_compare.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q2_grid_color.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q2_veggies.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q8_complete.render()
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q3_fraction.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q3_fraction_deduce.render()

#pagebreak()

= 统计图表

== 复式折线统计图

#q2.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q2_choir.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q4_survival.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q2_service.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q3_histogram.render()

#pagebreak()

= 数轴与线段

== 解不等式与数轴表示

#q3_ineq.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q15_ineq.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q16_ineq.render()

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

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q4.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q5.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q12_p.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q13_p.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q24.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q25.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q20_force.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q7_hubble.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q2_physics.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q12.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q14.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q19.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q20.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q9.render()

#v(2em)
#line(length: 100%, stroke: 0.5pt + luma(200))
#v(2em)

#q19_table.render()
