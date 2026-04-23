// ============================================================
// 第四章 K12 绘图实战
// ============================================================

#import "_example_env.typ": *

=== 实战一：尺规作图

尺规作图是几何绘图中最常见的题型。参见 @案例_尺规取等长线段 和 @案例_直角三角形内接正方形 。

==== 作图规范

#v(0.5em)
#table(
  columns: (auto, auto, 1fr),
  inset: 8pt,
  align: left,
  table.header(
    [*元素*], [*颜色*], [*说明*],
  ),
  [原图], [黑色 `0.8pt`], [题目已知的线段、顶点],
  [圆弧痕迹], [蓝色虚线], [`(paint: rgb("#2563EB"), thickness: 0.6pt, dash: (2pt, 1.2pt))`],
  [答案线], [红色实线 `1pt`], [`1pt + rgb("#DC2626")`],
  [辅助线], [灰色虚线], [`(paint: luma(140), thickness: 0.5pt, dash: (2pt, 1.2pt))`],
  [交点切痕], [深色短弧实线], [小角度范围（约 ±4°\~8°）的实线弧],
)

==== 完整示例

以「尺规取等长线段」（@案例_尺规取等长线段）为例，核心步骤：

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  *第 1 步*：定义坐标和常量
  ```typst
  let C = (0, 0)         // 圆心
  let B = (-2, 0)         // 已知线段端点
  let r = 2.0             // 半径 = |BC|
  ```

  *第 2 步*：画原图（实线）→ *第 3 步*：画弧线痕迹（虚线）
  ```typst
  arc(start-pt, start: 55deg, stop: 180deg, radius: r,
      stroke: (paint: mark-color, thickness: 0.8pt, dash: (2pt, 1.2pt)))
  ```

  *第 4 步*：画切痕（短实线弧）→ *第 5 步*：标注顶点
  ```typst
  arc(tick-pt, start: 61deg, stop: 69deg, radius: r,
      stroke: 1.2pt + mark-color)
  content(D, $D$, anchor: "south-west", padding: 0.1)
  ```
]

=== 实战二：图形变换

图形变换（平移、旋转、对称）的核心是坐标运算。参见 @案例_三角形平移旋转 和 @案例_三角形旋转变换 。

==== 平移

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  // 向右平移 dx，向上平移 dy
  let A1 = (A.at(0) + dx, A.at(1) + dy)
  // 对应点用灰色虚线箭头连接
  line(A, A1,
    stroke: (paint: luma(120), thickness: 0.5pt, dash: (2pt, 1.2pt)),
    mark: (end: "stealth", fill: luma(120)))
  ```
]

==== 旋转

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  // 绕 O 点逆时针旋转 θ
  let cos-t = calc.cos(theta)
  let sin-t = calc.sin(theta)
  let dx = P.at(0) - O.at(0)
  let dy = P.at(1) - O.at(1)
  let P1 = (O.at(0) + dx * cos-t - dy * sin-t,
             O.at(1) + dx * sin-t + dy * cos-t)

  // 网格上 90° 简化公式
  // 逆时针 90°: (x,y) → (-y, x)（相对于旋转中心）
  let P1 = (O.at(0) - (P.at(1) - O.at(1)),
             O.at(1) + (P.at(0) - O.at(0)))
  ```
]

==== 轴对称

参见 @案例_轴对称补全图形 。

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```typst
  // 关于竖直线 x = k 对称
  let P1 = (2 * k - P.at(0), P.at(1))

  // 关于水平线 y = k 对称
  let P1 = (P.at(0), 2 * k - P.at(1))
  ```
]

=== 实战三：统计图表

==== 柱状图

参见 @案例_果树品种成活率_饼图柱状图 。

#full-example(```
#cetz.canvas(length: 0.5cm, {
  import cetz.draw: *
  let data = (8, 12, 6, 15, 10)
  let labels = ("一", "二", "三", "四", "五")
  let bw = 1.2
  let gap = 0.6
  for j in range(0, 16, step: 5) {
    line((0, j), (10.5, j), stroke: 0.3pt + luma(210))
    content((-0.8, j), text(size: 8pt)[#str(j)])
  }
  line((0, 0), (0, 16), stroke: 0.6pt)
  line((0, 0), (10.5, 0), stroke: 0.6pt)
  for i in range(5) {
    let x = 0.5 + i * (bw + gap)
    rect((x, 0), (x + bw, data.at(i)),
         fill: rgb("#42A5F5"), stroke: 0.5pt + white)
    content((x + bw / 2, data.at(i) + 0.8),
            text(size: 8pt)[#str(data.at(i))])
    content((x + bw / 2, -1.2),
            text(size: 8pt)[#labels.at(i)月])
  }
})
```)

==== 折线图

参见 @案例_北京南京气温_复式折线统计图 。

#full-example(```
#cetz.canvas(length: 0.5cm, {
  import cetz.draw: *
  let data = ((1, 3), (2, 5), (3, 4), (4, 8), (5, 6), (6, 9))
  for j in range(0, 11, step: 2) {
    line((0, j), (7.5, j), stroke: 0.3pt + luma(210))
    content((-0.8, j), text(size: 8pt)[#str(j)])
  }
  line((0, 0), (0, 11), stroke: 0.6pt)
  line((0, 0), (7.5, 0), stroke: 0.6pt)
  for i in range(data.len() - 1) {
    line(data.at(i), data.at(i + 1), stroke: 1pt + rgb("#1976D2"))
  }
  for pt in data {
    circle(pt, radius: 0.15, fill: rgb("#1976D2"), stroke: 0.8pt + white)
    content((pt.at(0), pt.at(1) + 0.8), text(size: 8pt)[#str(pt.at(1))])
  }
})
```)

=== 实战四：受力分析

物理受力分析的核心模式。参见 @案例_受力_斜面物体与绳子 。

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  *标准流程*：
  + 画物体轮廓（rect / circle / 多边形）
  + 确定力的作用点（重心、接触点等）
  + 计算力的方向（单位向量 × 力长）
  + 画力箭头：`line(起点, 终点, mark: (end: "stealth", fill: 颜色), stroke: 1.2pt + 颜色)`
  + 标注力的符号：`content(偏移位置, $G$)`
  + 画支撑面阴影线：用循环 `line` 绘制

  *多场景子图*：用 `group()` 隔离每个场景，避免坐标冲突。
]
