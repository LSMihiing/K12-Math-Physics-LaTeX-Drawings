// ============================================================
// 第二章 CeTZ 绘图入门
// ============================================================
// 参考：https://cetz-package.github.io/docs/getting-started
// 参考：https://cetz-package.github.io/docs/basics/canvas
// 参考：https://cetz-package.github.io/docs/basics/coordinate-systems

#import "_example_env.typ": *

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

  // 参考：https://cetz-package.github.io/docs/getting-started
]

==== 第一个示例

#example(```
#cetz.canvas(length: 1cm, {
  import cetz.draw: *
  circle((0, 0), radius: 1, stroke: 0.8pt + black)
  line((-1.5, 0), (1.5, 0), stroke: 0.5pt + luma(150))
  line((0, -1.5), (0, 1.5), stroke: 0.5pt + luma(150))
})
```)

=== 坐标系统

CeTZ 使用笛卡尔坐标系，*y 轴向上为正*（与屏幕坐标相反）。

// 参考：https://cetz-package.github.io/docs/basics/coordinate-systems

==== 笛卡尔坐标（最常用）

#example(```
#cetz.canvas(length: 0.8cm, {
  import cetz.draw: *
  line((0, 0), (3, 2), stroke: 1pt)
  circle((3, 2), radius: 0.08, fill: black, stroke: none)
  content((3.5, 2), text(size: 9pt)[$(3, 2)$])
  circle((0, 0), radius: 0.08, fill: black, stroke: none)
  content((0, -0.5), text(size: 9pt)[$(0, 0)$])
})
```)

==== 坐标运算

绘图中经常需要计算坐标。Typst 内置 `calc` 数学模块：

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
  let d = calc.sqrt(calc.pow(B.at(0) - A.at(0), 2)
                  + calc.pow(B.at(1) - A.at(1), 2))

  // 角度（注意 atan2 参数顺序：x, y）
  let angle = calc.atan2(B.at(0) - A.at(0), B.at(1) - A.at(1))
  ```
  参见 @案例_尺规取等长线段 的坐标运算实例。
]

=== 基本绘图函数

==== line — 线段与折线

#example(```
#cetz.canvas(length: 0.7cm, {
  import cetz.draw: *
  line((0, 0), (3, 0), stroke: 1pt + black)
  line((5, 0), (6, 2), (8, 1), stroke: 1pt + rgb("#2563EB"))
  line((10, 0), (11, 2), (13, 1), close: true,
       stroke: 0.8pt, fill: rgb("#E8F0FE"))
})
```)

==== rect — 矩形

#example(```
#cetz.canvas(length: 0.8cm, {
  import cetz.draw: *
  rect((0, 0), (3, 2), stroke: 0.8pt, fill: rgb("#FFF3E0"))
  rect((5, 0), (8, 2), stroke: (
    paint: rgb("#2563EB"),
    thickness: 1pt,
    dash: (2pt, 1.2pt),
  ))
})
```)

==== circle — 圆

#example(```
#cetz.canvas(length: 0.8cm, {
  import cetz.draw: *
  circle((1, 1), radius: 0.08, fill: black, stroke: none)
  content((1, 0.3), text(size: 8pt)[实心点])
  circle((4, 1), radius: 0.6, stroke: 0.8pt + black)
  content((4, 0.3), text(size: 8pt)[空心圆])
  circle((7, 1), radius: 0.6, stroke: 0.8pt,
         fill: rgb("#BBDEFB"))
  content((7, 0.3), text(size: 8pt)[填充圆])
})
```)

==== arc — 弧线（重要）

弧线是 K12 绘图中最重要的函数（尺规作图、扇形统计图等）。

*⚠️ 关键*：必须加 `anchor: "origin"`，否则第一个坐标不是圆心！

#example(```
#cetz.canvas(length: 0.8cm, {
  import cetz.draw: *
  // 普通弧
  arc((0, 1), start: 30deg, stop: 150deg,
      radius: 1.5, anchor: "origin",
      stroke: 0.8pt + rgb("#2563EB"))
  circle((0, 1), radius: 0.05, fill: black, stroke: none)
  // 扇形
  arc((5, 1), start: -30deg, stop: 90deg,
      radius: 1.5, anchor: "origin",
      mode: "PIE", fill: rgb("#E3F2FD"),
      stroke: 0.8pt)
})
```)

==== content — 文字标注

#example(```
#cetz.canvas(length: 0.8cm, {
  import cetz.draw: *
  circle((2, 1), radius: 0.06, fill: black, stroke: none)
  content((2, 1), $A$, anchor: "south", padding: 0.15)
  circle((5, 1), radius: 0.06, fill: red, stroke: none)
  content((5, 1.6), text(fill: red, size: 10pt)[$F$])
})
```)

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

#example(```
#cetz.canvas(length: 0.8cm, {
  import cetz.draw: *
  line((0, 1), (3, 1),
    mark: (end: "stealth", fill: black),
    stroke: 1pt)
  content((1.5, 0.3), text(size: 8pt)["stealth"])
  line((5, 1), (8, 1),
    mark: (end: ">", fill: black),
    stroke: 1pt)
  content((6.5, 0.3), text(size: 8pt)[">"])
})
```)

// 参考：https://cetz-package.github.io/docs/basics/marks

=== 分组与循环

==== group — 分组隔离

`group()` 将绘图元素封装在一起，避免样式污染。参见 @案例_受力_斜面物体与绳子 的多场景实现。

==== for 循环

#example(```
#cetz.canvas(length: 0.5cm, {
  import cetz.draw: *
  for i in range(0, 6) {
    line((i, 0), (i, 5), stroke: 0.3pt + luma(200))
    line((0, i), (5, i), stroke: 0.3pt + luma(200))
  }
  rect((0, 0), (5, 5), stroke: 0.8pt + black)
})
```)
