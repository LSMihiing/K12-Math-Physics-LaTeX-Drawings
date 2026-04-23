// ============================================================
// 第三章 常用图形与技巧
// ============================================================

#import "_example_env.typ": *

=== 几何图形

==== 三角形与多边形

三角形是最基本的几何图形。用 `line(..., close: true)` 绘制：

#example(```
#cetz.canvas(length: 0.8cm, {
  import cetz.draw: *
  let A = (1, 3)
  let B = (-1, 0)
  let C = (3, 0)
  line(A, B, C, close: true, stroke: 0.8pt)
  for (pt, name, anc) in (
    (A, $A$, "south"),
    (B, $B$, "north-east"),
    (C, $C$, "north-west"),
  ) {
    circle(pt, radius: 0.06, fill: black,
           stroke: none)
    content(pt, name, anchor: anc,
            padding: 0.15)
  }
})
```)

==== 直角标记

K12 几何图中，直角标记是必须的。参见 @案例_直角三角形内接正方形 第 84–88 行。

#example(```
#cetz.canvas(length: 1cm, {
  import cetz.draw: *
  let A = (2, 2)
  let B = (0, 0)
  let C = (4, 0)
  line(A, B, C, close: true, stroke: 0.8pt)
  // 直角标记在 B 点
  let sq = 0.3
  line((0, sq), (sq, sq), (sq, 0),
       stroke: 0.5pt)
  content(A, $A$, anchor: "south", padding: 0.12)
  content(B, $B$, anchor: "north-east", padding: 0.12)
  content(C, $C$, anchor: "north-west", padding: 0.12)
})
```)

=== 弧线与扇形

==== 尺规作图中的弧线

尺规作图需要三种弧线样式。参见 @案例_尺规取等长线段 ：

#v(0.5em)
#table(
  columns: (auto, 1fr, 1fr),
  inset: 8pt,
  align: left,
  table.header(
    [*类型*], [*样式*], [*用途*],
  ),
  [蓝色虚线弧], [`(paint: rgb("#2563EB"), thickness: 0.6pt, dash: (2pt, 1.2pt))`], [圆规痕迹],
  [短实线弧], [`1.2pt + 颜色`], [交点处的切痕标记],
  [灰色虚线], [`(paint: luma(140), thickness: 0.5pt, dash: (2pt, 1.2pt))`], [辅助线],
)

#full-example(```
#cetz.canvas(length: 1cm, {
  import cetz.draw: *
  let arc-s = (paint: rgb("#2563EB"), thickness: 0.6pt, dash: (2pt, 1.2pt))
  arc((0, 0), start: 20deg, stop: 160deg, radius: 2, anchor: "origin", stroke: arc-s)
  let ts = (2 * calc.cos(56deg), 2 * calc.sin(56deg))
  arc(ts, start: 56deg, stop: 64deg, radius: 2, stroke: 1.2pt + luma(80))
  circle((0, 0), radius: 0.06, fill: black, stroke: none)
  content((0, -0.5), text(size: 9pt)[圆心])
  content((2.5, 1.5), text(size: 9pt, fill: rgb("#2563EB"))[虚线弧])
  content((1.2, 2.2), text(size: 9pt)[切痕])
})
```)

==== 扇形（统计图用）

`mode: "PIE"` 绘制扇形。参见 @案例_分数涂色与比较大小 。

#full-example(```
#cetz.canvas(length: 0.65cm, {
  import cetz.draw: *
  let colors = (rgb("#42A5F5"), rgb("#EF5350"), rgb("#66BB6A"), rgb("#FFA726"))
  let angles = (0deg, 120deg, 210deg, 300deg, 360deg)
  let labels = ("33%", "25%", "25%", "17%")
  for i in range(4) {
    arc((0, 0), start: angles.at(i), stop: angles.at(i + 1), radius: 2.5,
        anchor: "origin", mode: "PIE", fill: colors.at(i), stroke: 0.8pt + white)
    let mid = (angles.at(i) + angles.at(i + 1)) / 2
    content((1.5 * calc.cos(mid), 1.5 * calc.sin(mid)),
      text(size: 9pt, weight: "bold", fill: white)[#labels.at(i)])
  }
})
```)

=== 网格纸与方格

网格是几何变换题的基础。参见 @案例_格点三角形中心对称 和 `lib/grid-utils.typ`。

#example(```
#cetz.canvas(length: 0.5cm, {
  import cetz.draw: *
  for i in range(0, 6) {
    line((i, 0), (i, 5),
         stroke: 0.3pt + luma(200))
    line((0, i), (5, i),
         stroke: 0.3pt + luma(200))
  }
  rect((0, 0), (5, 5), stroke: 0.8pt)
  // 在格点上画三角形
  line((1, 1), (4, 1), (2, 4),
       close: true, stroke: 1pt + red)
})
```)

=== 箭头与力的标注

物理受力分析图中，箭头至关重要。参见 @案例_受力_斜面物体与绳子 。

#full-example(```
#cetz.canvas(length: 1cm, {
  import cetz.draw: *
  rect((0, 0), (2, 1.5), fill: rgb("#E3F0FD"), stroke: 0.8pt)
  content((1, 0.75), text(size: 10pt)[物体])
  line((1, 0), (1, -1.5), stroke: 1.2pt + red,
       mark: (end: "stealth", fill: red))
  content((1.5, -1.2), text(size: 10pt, fill: red)[$G$])
  line((1, 1.5), (1, 3), stroke: 1.2pt + rgb("#2563EB"),
       mark: (end: "stealth", fill: rgb("#2563EB")))
  content((1.6, 2.7), text(size: 10pt, fill: rgb("#2563EB"))[$N$])
  line((0, 0.75), (-1.5, 0.75), stroke: 1.2pt + rgb("#4CAF50"),
       mark: (end: "stealth", fill: rgb("#4CAF50")))
  content((-1.5, 1.2), text(size: 10pt, fill: rgb("#4CAF50"))[$f$])
})
```)

=== 数轴与坐标轴

数轴是线段图和不等式题的基础。参见 @案例_解不等式_数轴表示_基础 中的 `draw-inequality()` 封装。

#full-example(```
#cetz.canvas(length: 0.65cm, {
  import cetz.draw: *
  // 数轴主线
  line((-6.5, 0), (4.5, 0), stroke: 0.8pt,
       mark: (end: "stealth", fill: black, size: 0.25))
  // 刻度和标签
  for i in range(-6, 4) {
    line((i, 0), (i, 0.15), stroke: 0.8pt)
    let lb = if i < 0 { [$-$#calc.abs(i)] } else { str(i) }
    content((i, -0.4), text(size: 10pt)[#lb])
  }
  // 解集 x > -4（空心圆 + 向右折线箭头）
  let sv = -4
  line((sv, 0.1), (sv, 0.6), (4.2, 0.6),
       stroke: 1.5pt + rgb("#0000CD"),
       mark: (end: "stealth", fill: rgb("#0000CD"), size: 0.25))
  circle((sv, 0), radius: 0.1, fill: white,
         stroke: 1.5pt + rgb("#0000CD"))
})
```)

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  *数轴绘制要点*：
  + 箭头使用 `mark: (end: "stealth", fill: black, size: 0.25)`
  + 负号特殊处理：`if i < 0 { [$-$#calc.abs(i)] }` 避免连字符
  + 空心圆 = 开区间（`fill: white`），实心圆 = 闭区间（`fill: 颜色`）
  + 解集用折线箭头表示方向（向右 = $>$，向左 = $<$）
]
