// ============================================================
// 第三章 常用图形与技巧
// ============================================================

#import "@preview/cetz:0.4.2"

=== 几何图形

==== 三角形与多边形

三角形是最基本的几何图形。用 `line(..., close: true)` 绘制：

#align(center)[
  #cetz.canvas(length: 0.8cm, {
    import cetz.draw: *

    // 三角形
    let A = (0, 3)
    let B = (-2, 0)
    let C = (2, 0)
    line(A, B, C, close: true, stroke: 0.8pt)

    // 顶点标注
    content(A, text(size: 10pt)[$A$], anchor: "south", padding: 0.15)
    content(B, text(size: 10pt)[$B$], anchor: "north-east", padding: 0.15)
    content(C, text(size: 10pt)[$C$], anchor: "north-west", padding: 0.15)

    // 顶点圆点
    for pt in (A, B, C) {
      circle(pt, radius: 0.06, fill: black, stroke: none)
    }
  })
]

==== 直角标记

K12 几何图中，直角标记是必须的：

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  // 在顶点 A 处画直角标记
  // 需要两条边的单位向量 u1、u2
  let sq = 0.25  // 标记大小
  let p1 = (A.at(0) + u1x * sq, A.at(1) + u1y * sq)
  let p2 = (A.at(0) + u1x * sq + u2x * sq, A.at(1) + u1y * sq + u2y * sq)
  let p3 = (A.at(0) + u2x * sq, A.at(1) + u2y * sq)
  line(p1, p2, p3, stroke: 0.5pt)
  ```
  参见「几何作图 → 直角三角形内接正方形」第 84–88 行。
]

#align(center)[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *
    let A = (2, 2)
    let B = (0, 0)
    let C = (4, 0)

    line(A, B, C, close: true, stroke: 0.8pt)
    // 直角在 B 点
    let sq = 0.3
    line((0, sq), (sq, sq), (sq, 0), stroke: 0.5pt)

    content(A, text(size: 10pt)[$A$], anchor: "south", padding: 0.12)
    content(B, text(size: 10pt)[$B$], anchor: "north-east", padding: 0.12)
    content(C, text(size: 10pt)[$C$], anchor: "north-west", padding: 0.12)
  })
]

=== 弧线与扇形

==== 尺规作图中的弧线

尺规作图需要三种弧线样式：

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

#align(center)[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *
    let arc-stroke = (paint: rgb("#2563EB"), thickness: 0.6pt, dash: (2pt, 1.2pt))

    // 虚线大弧
    arc((0, 0), start: 20deg, stop: 160deg, radius: 2,
        anchor: "origin", stroke: arc-stroke)
    // 交点实线切痕
    let tick-start = (2 * calc.cos(56deg), 2 * calc.sin(56deg))
    arc(tick-start, start: 56deg, stop: 64deg, radius: 2, stroke: 1.2pt + luma(80))

    circle((0, 0), radius: 0.06, fill: black, stroke: none)
    content((0, -0.5), text(size: 8pt)[圆心])
    content((2.5, 1.5), text(size: 8pt, fill: rgb("#2563EB"))[虚线弧])
    content((1.2, 2.2), text(size: 8pt)[切痕])
  })
]

==== 扇形（统计图用）

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  // 扇形关键：mode: "PIE" + anchor: "origin"
  arc((0, 0), start: 0deg, stop: 120deg, radius: 2,
      anchor: "origin", mode: "PIE",
      fill: rgb("#42A5F5"), stroke: 0.8pt)
  ```
  参见「几何作图 → 分数涂色与比较大小」的扇形涂色实现。
]

#align(center)[
  #cetz.canvas(length: 0.7cm, {
    import cetz.draw: *
    let colors = (rgb("#42A5F5"), rgb("#EF5350"), rgb("#66BB6A"), rgb("#FFA726"))
    let angles = (0deg, 120deg, 210deg, 300deg, 360deg)
    let labels = ("33%", "25%", "25%", "17%")

    for i in range(4) {
      arc((0, 0), start: angles.at(i), stop: angles.at(i + 1), radius: 2.5,
          anchor: "origin", mode: "PIE",
          fill: colors.at(i), stroke: 0.8pt + white)
      let mid-angle = (angles.at(i) + angles.at(i + 1)) / 2
      let lx = 1.5 * calc.cos(mid-angle)
      let ly = 1.5 * calc.sin(mid-angle)
      content((lx, ly), text(size: 9pt, weight: "bold", fill: white)[#labels.at(i)])
    }
  })
]

=== 网格纸与方格

网格是几何变换题的基础。本项目的 `lib/grid-utils.typ` 提供了 `draw-grid()` 工具函数。

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  // 手动画网格（简单场景）
  for i in range(0, cols + 1) {
    line((i, 0), (i, rows), stroke: 0.3pt + luma(200))
  }
  for j in range(0, rows + 1) {
    line((0, j), (cols, j), stroke: 0.3pt + luma(200))
  }

  // 或使用 CeTZ 内置 grid
  grid((0, 0), (cols, rows), step: 1, stroke: 0.3pt + luma(200))
  ```
  参见「几何作图 → 格点三角形中心对称」和 `lib/grid-utils.typ`。
]

=== 箭头与力的标注

物理受力分析图中，箭头至关重要。

#align(center)[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // 物体
    rect((0, 0), (2, 1.5), fill: rgb("#E3F2FD"), stroke: 0.8pt)
    content((1, 0.75), text(size: 10pt)[物体])

    // 重力 G（向下）
    line((1, 0), (1, -1.5), stroke: 1.2pt + red, mark: (end: "stealth", fill: red))
    content((1.5, -1.2), text(size: 10pt, fill: red)[$G$])

    // 支持力 N（向上）
    line((1, 1.5), (1, 3), stroke: 1.2pt + rgb("#2563EB"), mark: (end: "stealth", fill: rgb("#2563EB")))
    content((1.6, 2.7), text(size: 10pt, fill: rgb("#2563EB"))[$N$])

    // 摩擦力 f（向左）
    line((0, 0.75), (-1.5, 0.75), stroke: 1.2pt + rgb("#4CAF50"), mark: (end: "stealth", fill: rgb("#4CAF50")))
    content((-1.5, 1.2), text(size: 10pt, fill: rgb("#4CAF50"))[$f$])
  })
]

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  // 力箭头的标准画法
  line(起点, 终点,
    stroke: 1.2pt + red,
    mark: (end: "stealth", fill: red))
  content(标注位置, text(fill: red)[$G$])
  ```
  参见「物理 → 受力\_斜面物体与绳子」等受力分析系列。
]

=== 数轴与坐标轴

#align(center)[
  #cetz.canvas(length: 0.6cm, {
    import cetz.draw: *

    // x 轴
    line((-1, 0), (11, 0), stroke: 0.8pt, mark: (end: "stealth", fill: black))

    // 刻度和标签
    for i in range(0, 11) {
      line((i, -0.15), (i, 0.15), stroke: 0.6pt)
      content((i, -0.6), text(size: 8pt)[#str(i)])
    }

    // 区间标记示例：[3, 7]
    line((3, 0.4), (7, 0.4), stroke: 1.2pt + rgb("#2563EB"))
    circle((3, 0.4), radius: 0.12, fill: rgb("#2563EB"), stroke: none)  // 实心 = 闭
    circle((7, 0.4), radius: 0.12, fill: rgb("#2563EB"), stroke: none)
    content((5, 0.9), text(size: 9pt, fill: rgb("#2563EB"))[$[3, 7]$])
  })
]

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  *数轴绘制要点*：
  + 用 `mark: (end: "stealth")` 画箭头
  + 用 `for` 循环画刻度和标签
  + 空心圆 = 开区间（`fill: white`），实心圆 = 闭区间（`fill: 颜色`）

  参见 LaTeX 参考：`LaTeX_Project/数学/线段图/数轴与不等式.tex`（62 个 tikz 案例）。
]
