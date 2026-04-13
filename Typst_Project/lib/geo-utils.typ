// ============================================================
// geo-utils.typ — 几何图形绘制工具
// ============================================================

#import "@preview/cetz:0.4.2"

// 绘制三角形
// - a, b, c: 三个顶点坐标
// - stroke-color: 边框颜色
// - fill-color: 填充颜色（none = 不填充）
// - stroke-width: 线宽
// - dash: 虚线样式（none = 实线）
#let draw-triangle(
  a, b, c,
  stroke-color: black,
  fill-color: none,
  stroke-width: 0.8pt,
  dash: none,
) = {
  import cetz.draw: *
  let s = if dash != none {
    stroke-width + stroke-color
  } else {
    stroke-width + stroke-color
  }
  line(a, b, c, close: true, stroke: s, fill: fill-color)
}

// 标注对称中心
// - pos: 坐标
// - label: 标签文本
// - radius: 圆点半径
#let mark-center(
  pos,
  label: "O",
  radius: 3pt,
  color: red,
  text-size: 10pt,
) = {
  import cetz.draw: *
  circle(pos, radius: radius, fill: color, stroke: none)
  content(
    pos,
    anchor: "north-east",
    padding: 3pt,
    text(size: text-size, fill: color, weight: "bold")[#label],
  )
}

// 绘制带箭头的线段（用于标注变换方向）
#let draw-arrow(
  from, to,
  color: rgb("#4A90D9"),
  width: 1pt,
) = {
  import cetz.draw: *
  line(from, to, stroke: width + color, mark: (end: "stealth", fill: color))
}

// 绘制虚线连接（用于标注对应点关系）
#let draw-dashed-line(
  from, to,
  color: luma(120),
  width: 0.5pt,
) = {
  import cetz.draw: *
  line(from, to, stroke: (paint: color, thickness: width, dash: "dashed"))
}
