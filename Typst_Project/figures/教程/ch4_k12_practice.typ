// ============================================================
// 第四章 K12 绘图实战
// ============================================================

#import "_example_env.typ": *

// 导入实际绘图模块，用于在教程中直接展示渲染效果
#import "../几何作图/尺规取等长线段.typ" as _尺规取等长线段
#import "../几何作图/三角形旋转变换.typ" as _三角形旋转变换
#import "../统计图表/成绩频数分布直方图.typ" as _频数直方图
#import "../统计图表/课外活动扇形统计图.typ" as _扇形统计图
#import "../物理/受力_斜面物体与绳子.typ" as _受力_斜面绳

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

==== 完整示例：尺规取等长线段

以 @案例_尺规取等长线段 为例，下图为实际渲染效果：

#align(center)[
  #block(
    stroke: 0.5pt + luma(200),
    inset: 12pt,
    radius: 3pt,
  )[
    #import "@preview/cetz:0.4.2"
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *
      let main-color = rgb("#00AEEF")
      let mark-color = rgb("#7A7D81")
      let c = (0, 0)
      let b = (-2, 0)
      let a = (-4.5, 0)
      let r = 2.0
      let angle-l = 65deg
      let l-end = (3.5 * calc.cos(angle-l), 3.5 * calc.sin(angle-l))
      let d = (r * calc.cos(angle-l), r * calc.sin(angle-l))
      line(a, c, stroke: 1.2pt + main-color)
      line(c, l-end, stroke: 1.2pt + main-color)
      let l-label-pos = (3.0 * calc.cos(angle-l) - 0.25, 3.0 * calc.sin(angle-l) + 0.2)
      content(l-label-pos, text(fill: black, size: 13pt, style: "italic")[$l$])
      let arc-main-start = (c.at(0) + r * calc.cos(55deg), c.at(1) + r * calc.sin(55deg))
      arc(arc-main-start, start: 55deg, stop: 180deg, radius: r, stroke: (paint: mark-color, thickness: 0.8pt, dash: (2pt, 1.2pt)))
      let arc-tick-start = (c.at(0) + r * calc.cos(61deg), c.at(1) + r * calc.sin(61deg))
      arc(arc-tick-start, start: 61deg, stop: 69deg, radius: r, stroke: 1.2pt + mark-color)
      let pt-radius = 0.07
      for pt in (a, b, c, d) {
        circle(pt, radius: pt-radius, fill: main-color, stroke: none)
      }
      content(a, text(size: 12pt)[$A$], anchor: "south", padding: 0.15)
      content(b, text(size: 12pt)[$B$], anchor: "south", padding: 0.15)
      content(c, text(size: 12pt)[$C$], anchor: "north-west", padding: 0.1)
      content(d, text(size: 12pt)[$D$], anchor: "south-west", padding: 0.1)
    })
  ]
]

核心步骤拆解：

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
  let D = (r * calc.cos(angle-l), r * calc.sin(angle-l))  // 交点
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

==== 旋转变换示例

以 @案例_三角形旋转变换 为例，下图为实际渲染效果：

#align(center)[
  #_三角形旋转变换.render()
]

关键公式：

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  *平移*：
  ```typst
  let A1 = (A.at(0) + dx, A.at(1) + dy)
  // 对应点用灰色虚线箭头连接
  line(A, A1,
    stroke: (paint: luma(120), thickness: 0.5pt, dash: (2pt, 1.2pt)),
    mark: (end: "stealth", fill: luma(120)))
  ```

  *旋转*（绕 O 点逆时针旋转 θ）：
  ```typst
  let P1 = (O.at(0) + dx * calc.cos(theta) - dy * calc.sin(theta),
             O.at(1) + dx * calc.sin(theta) + dy * calc.cos(theta))
  // 网格上 90° 简化：(x,y) → (O.x-(y-O.y), O.y+(x-O.x))
  ```

  *轴对称*（参见 @案例_轴对称补全图形）：
  ```typst
  // 关于 x = k 对称
  let P1 = (2 * k - P.at(0), P.at(1))
  // 关于 y = k 对称
  let P1 = (P.at(0), 2 * k - P.at(1))
  ```
]

=== 实战三：统计图表

==== 频数分布直方图

以 @案例_成绩频数分布直方图 为例，下图为实际渲染效果：

#align(center)[
  #_频数直方图.render()
]

核心绘图代码：

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  *关键技巧*：
  + *坐标轴断裂号*：X 轴 0→50 区间用折线模拟"心电图"断裂号，表示刻度不连续
  + *参考虚线*：`for` 循环绘制水平虚线作为背景网格
  + *柱体区分*：补全部分用蓝色边框+浅色填充高亮，已知部分用灰色

  ```typst
  let data = (
    (50, 2, luma(220), black),
    (70, 10, blue.lighten(80%), blue),  // 补全部分
    (80, 14, luma(220), black),
  )
  for (i, entry) in data.enumerate() {
    let (score, count, fill_clr, stroke_clr) = entry
    rect((x_start, 0), (x_start + sx, count * sy),
         fill: fill_clr, stroke: 1pt + stroke_clr)
  }
  ```
]

==== 扇形统计图

以 @案例_课外活动扇形统计图 为例，下图为实际渲染效果：

#align(center)[
  #_扇形统计图.render()
]

核心绘图代码：

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  *关键技巧*：
  + *十二等分圆*：`for i in range(12)` + 30° 步长放置等分点
  + *极坐标扇形*：用角度累加 + `line` 从圆心到圆周画分割线
  + *文字标注*：在扇形角度中线的 0.6R 处居中放置标注

  ```typst
  let current-angle = 90deg  // 从正上方开始
  for item in angles {
    let angle-span = item.count * 30deg
    line((0,0), (r * calc.cos(current-angle),
                 r * calc.sin(current-angle)),
         stroke: 0.8pt + rgb(31, 120, 180))
    let mid-angle = current-angle - angle-span / 2
    content((r * 0.6 * calc.cos(mid-angle),
             r * 0.6 * calc.sin(mid-angle)), ...)
    current-angle = current-angle - angle-span
  }
  ```
]

=== 实战四：受力分析

物理受力分析的核心模式。以 @案例_受力_斜面物体与绳子 为例，下图为实际渲染效果：

#align(center)[
  #_受力_斜面绳.render()
]

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
