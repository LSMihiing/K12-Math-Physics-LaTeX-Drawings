// ============================================================
// 第二章 CeTZ 绘图入门
// ============================================================
// 参考：https://cetz-package.github.io/docs/getting-started
// 参考：https://cetz-package.github.io/docs/basics/canvas
// 参考：https://cetz-package.github.io/docs/basics/coordinate-systems

=== 画布与导入

CeTZ（"ein Typst Zeichenpaket"）是 Typst 的矢量绘图库，类似 LaTeX 中的 TikZ。

==== 最小绘图模板

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  #import "@preview/cetz:0.4.2"

  #cetz.canvas(length: 1cm, {
    import cetz.draw: *
    // 在这里写绘图代码
  })
  ```
  - `length: 1cm` 表示坐标系中 1 个单位 = 1cm
  - `import cetz.draw: *` 必须写在 `canvas` 内部（避免与 Typst 的 `line` 等函数冲突）
]

// 参考：https://cetz-package.github.io/docs/getting-started

==== 实际效果

#import "@preview/cetz:0.4.2"

#align(center)[
  #cetz.canvas(length: 1cm, {
    import cetz.draw: *
    circle((0, 0), radius: 1, stroke: 0.8pt + black)
    line((-1.5, 0), (1.5, 0), stroke: 0.5pt + luma(150))
    line((0, -1.5), (0, 1.5), stroke: 0.5pt + luma(150))
    content((0, -2), text(size: 9pt, fill: luma(100))[一个圆和十字辅助线])
  })
]

=== 坐标系统

CeTZ 使用笛卡尔坐标系，*y 轴向上为正*（与屏幕坐标相反）。

// 参考：https://cetz-package.github.io/docs/basics/coordinate-systems

==== 笛卡尔坐标（最常用）

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  line((0, 0), (3, 2))        // 从原点画到 (3, 2)
  circle((2, 1), radius: 0.5) // 圆心在 (2, 1)，半径 0.5
  rect((0, 0), (4, 3))        // 左下角 (0,0)，右上角 (4,3)
  ```
]

==== 坐标运算

绘图中经常需要计算坐标（如中点、交点、旋转）。Typst 内置数学函数：

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  let A = (0, 0)
  let B = (4, 3)

  // 中点
  let M = ((A.at(0) + B.at(0)) / 2, (A.at(1) + B.at(1)) / 2)

  // 距离
  let d = calc.sqrt(calc.pow(B.at(0) - A.at(0), 2) + calc.pow(B.at(1) - A.at(1), 2))

  // 角度（注意 atan2 参数顺序）
  let angle = calc.atan2(B.at(0) - A.at(0), B.at(1) - A.at(1))

  // 旋转 90°
  let dx = B.at(0) - A.at(0)
  let dy = B.at(1) - A.at(1)
  let rotated = (A.at(0) - dy, A.at(1) + dx)  // 逆时针 90°
  ```
  本项目大量使用此类运算，参见「几何作图 → 尺规取等长线段」。
]

=== 基本绘图函数

==== line — 线段与折线

#align(center)[
  #cetz.canvas(length: 0.8cm, {
    import cetz.draw: *
    // 单线段
    line((0, 0), (3, 0), stroke: 1pt + black)
    content((1.5, -0.5), text(size: 8pt)[`line((0,0), (3,0))`])

    // 折线
    line((5, 0), (6, 2), (8, 1), stroke: 1pt + rgb("#2563EB"))
    content((6.5, -0.5), text(size: 8pt)[`line(A, B, C)`])

    // 闭合多边形
    line((10, 0), (11, 2), (13, 1), close: true, stroke: 0.8pt, fill: rgb("#E8F0FE"))
    content((11.5, -0.5), text(size: 8pt)[`close: true`])
  })
]

==== rect — 矩形

#align(center)[
  #cetz.canvas(length: 0.8cm, {
    import cetz.draw: *
    rect((0, 0), (3, 2), stroke: 0.8pt, fill: rgb("#FFF3E0"))
    content((1.5, 1), text(size: 8pt)[`rect`])

    rect((5, 0), (8, 2), stroke: (paint: rgb("#2563EB"), thickness: 1pt, dash: (2pt, 1.2pt)))
    content((6.5, 1), text(size: 8pt)[虚线边框])
  })
]

==== circle — 圆

#align(center)[
  #cetz.canvas(length: 0.8cm, {
    import cetz.draw: *
    // 实心圆点
    circle((0, 1), radius: 0.08, fill: black, stroke: none)
    content((0, 0.3), text(size: 8pt)[实心点])

    // 空心圆
    circle((3, 1), radius: 0.6, stroke: 0.8pt + black)
    content((3, 0.3), text(size: 8pt)[空心圆])

    // 彩色填充
    circle((6, 1), radius: 0.6, stroke: 0.8pt, fill: rgb("#BBDEFB"))
    content((6, 0.3), text(size: 8pt)[填充圆])
  })
]

==== arc — 弧线

弧线是 K12 绘图中最重要的函数之一（尺规作图、扇形统计图等）。

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  // ⚠️ 关键：anchor: "origin" 使第一个参数成为圆心
  arc((cx, cy), start: 30deg, stop: 150deg, radius: 2,
      anchor: "origin", stroke: 0.6pt + blue)

  // 扇形（饼图用）
  arc((0, 0), start: 0deg, stop: 90deg, radius: 2,
      anchor: "origin", mode: "PIE", fill: red)

  // 椭圆弧
  arc((0, 0), start: 0deg, stop: 180deg, radius: (2, 1),
      anchor: "origin")
  ```
  *⚠️ 如果不加 `anchor: "origin"`，第一个坐标将被视为弧线起点而非圆心，导致位置偏移！*

  参见「几何作图 → 尺规取等长线段」中的弧线用法。
]

#align(center)[
  #cetz.canvas(length: 0.8cm, {
    import cetz.draw: *
    // 普通弧
    arc((0, 1), start: 30deg, stop: 150deg, radius: 1.5,
        anchor: "origin", stroke: 0.8pt + rgb("#2563EB"))
    circle((0, 1), radius: 0.05, fill: black, stroke: none)
    content((0, -0.5), text(size: 8pt)[弧线])

    // 扇形
    arc((5, 1), start: -30deg, stop: 90deg, radius: 1.5,
        anchor: "origin", mode: "PIE",
        fill: rgb("#E3F2FD"), stroke: 0.8pt)
    content((5, -0.5), text(size: 8pt)[扇形 `mode: "PIE"`])
  })
]

==== content — 文字标注

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  // 在坐标处放置文字
  content((3, 2), text(size: 10pt)[$A$])

  // 用 anchor 控制对齐
  content((3, 2), text(size: 10pt)[$A$], anchor: "south")  // 文字在点上方

  // 用 padding 调整间距
  content((3, 2), $F$, anchor: "south", padding: 0.15)
  ```
]

=== 样式与描边

==== stroke 详解

#v(0.5em)
#table(
  columns: (1fr, 2fr),
  inset: 8pt,
  align: left,
  table.header(
    [*写法*], [*效果*],
  ),
  [`stroke: 1pt + black`], [简写：1pt 粗黑色实线],
  [`stroke: (paint: blue, thickness: 0.6pt)`], [指定颜色和粗细],
  [`stroke: (..., dash: (2pt, 1.2pt))`], [细密虚线（本项目标准）],
  [`stroke: (..., dash: "dotted")`], [点线],
  [`stroke: none`], [不描边（常用于纯填充圆点）],
)

*⚠️ 本项目规定：禁止使用 `dash: "dashed"`（默认间距过大），统一使用 `dash: (2pt, 1.2pt)`。*

==== 箭头（mark）

#align(center)[
  #cetz.canvas(length: 0.8cm, {
    import cetz.draw: *
    line((0, 0), (3, 0), mark: (end: "stealth", fill: black), stroke: 1pt)
    content((1.5, -0.5), text(size: 8pt)[`"stealth"`])

    line((5, 0), (8, 0), mark: (end: ">", fill: black), stroke: 1pt)
    content((6.5, -0.5), text(size: 8pt)[`">"`])

    line((10, 0), (13, 0), mark: (start: "|", end: ">", fill: black), stroke: 1pt)
    content((11.5, -0.5), text(size: 8pt)[双端])
  })
]

// 参考：https://cetz-package.github.io/docs/basics/marks

==== 颜色

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  rgb("#2563EB")       // 十六进制 RGB（本项目蓝色弧线）
  rgb("#DC2626")       // 红色答案线
  luma(140)            // 灰度值 0~255（辅助线）
  black, white, red    // 内置颜色名
  ```
]

=== 分组与循环

==== group — 分组隔离

`group()` 将绘图元素封装在一起，避免样式污染：

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  // 物理受力分析中常用多个 group 隔离子图
  group(name: "scene1", {
    // 第一个场景的所有绘图
  })
  group(name: "scene2", {
    // 第二个场景
  })
  ```
  参见「物理 → 受力分析」系列的多场景子图实现。
]

==== for 循环

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  // 画网格线
  for i in range(0, 11) {
    line((i, 0), (i, 10), stroke: 0.3pt + luma(200))
    line((0, i), (10, i), stroke: 0.3pt + luma(200))
  }

  // 注意：range(0, 11) 是左闭右开 [0, 11)，即 0~10
  ```
]

#align(center)[
  #cetz.canvas(length: 0.5cm, {
    import cetz.draw: *
    for i in range(0, 6) {
      line((i, 0), (i, 5), stroke: 0.3pt + luma(200))
      line((0, i), (5, i), stroke: 0.3pt + luma(200))
    }
    // 外框
    rect((0, 0), (5, 5), stroke: 0.8pt + black)
    content((2.5, -0.8), text(size: 8pt)[`for` 循环绘制 5×5 网格])
  })
]
