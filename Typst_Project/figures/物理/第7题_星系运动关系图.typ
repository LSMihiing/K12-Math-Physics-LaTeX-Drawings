// ============================================================
// 第7题 · 星系运动关系图像（哈勃定律演示）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 数据定义
// ==========================================
#let data = (
  (name: "室女座", d: 80, v: 1.2),
  (name: "大熊座", d: 980, v: 15.0),
  (name: "牧夫座", d: 2540, v: 39.0),
  (name: "长蛇座", d: 3980, v: 61.0),
)

// ==========================================
// 图表参数
// ==========================================
// X轴：距离 d / 10^4 l.y.  范围 0~4500, 步长 500
// Y轴：速度 v / km·s^-1    范围 0~70,   步长 10
#let sx = 0.8  // 每 500 单位对应的横向厘米数
#let sy = 0.8  // 每 10 单位对应的纵向厘米数
#let x_max = 4500
#let y_max = 70
#let nx = 9    // X轴格数
#let ny = 7    // Y轴格数

// ==========================================
// 绘图函数
// ==========================================
#let hubble-plot = cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let w = nx * sx
  let h = ny * sy

  // ---- 1. 背景网格 ----
  for i in range(nx + 1) {
    line((i * sx, 0), (i * sx, h), stroke: 0.3pt + luma(200))
  }
  for j in range(ny + 1) {
    line((0, j * sy), (w, j * sy), stroke: 0.3pt + luma(200))
  }

  // ---- 2. 坐标轴 ----
  line((0, 0), (w + 0.5, 0), mark: (end: "stealth", fill: black), stroke: 1pt + black)
  line((0, 0), (0, h + 0.5), mark: (end: "stealth", fill: black), stroke: 1pt + black)

  // ---- 3. 刻度标注 ----
  // X 轴
  for i in range(nx + 1) {
    let val = i * 500
    if val != 0 {
      content((i * sx, -0.15), text(size: 8pt)[#val], anchor: "north")
    }
  }
  content((w + 0.2, -0.6), text(size: 9pt)[距离 / $10^4 upright("l.y.")$], anchor: "north")
  content((-0.15, -0.15), text(size: 8pt)[0], anchor: "north-east")

  // Y 轴
  for j in range(ny + 1) {
    let val = j * 10
    if val != 0 {
      content((-0.15, j * sy), text(size: 8pt)[#val], anchor: "east")
    }
  }
  content((0, h + 0.5), text(size: 9pt)[速度 / $(upright("km") dot upright("s")^(-1))$], anchor: "south")

  // ---- 4. 绘制数据点与趋势线 ----
  let points = data.map(p => (p.d / 500 * sx, p.v / 10 * sy))

  // 趋势线 (过原点)
  line((0, 0), (4500 / 500 * sx, 4500 * 0.0153 / 10 * sy), stroke: (
    paint: red.darken(10%),
    thickness: 0.8pt,
    dash: "dashed",
  ))

  // 数据点
  for p in points {
    circle(p, radius: 2.5pt, fill: black, stroke: none)
  }

  // 标注点名称 (可选)
  for i in range(data.len()) {
    let p = points.at(i)
    let n = data.at(i).name
    content((p.at(0), p.at(1) + 0.35), text(size: 7pt, fill: luma(50))[#n])
  }
})

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[7.]
  text(size: 11pt)[用下表中关于星系运动的数据，回答下列问题：]

  v(0.8em)

  // --- 数据表 ---
  align(center)[
    #table(
      columns: (1.2fr, 1.5fr, 1.2fr),
      align: center + horizon,
      stroke: 0.5pt + black,
      fill: (x, y) => if y == 0 { rgb(230, 245, 255) } else { none },
      inset: 7pt,
      [*星系团名称*], [*离银河系的距离/$10^4$ l.y.*], [*速度/(km · $s^{-1}$)*],
      [室女座], [80], [1.2],
      [大熊座], [980], [15.0],
      [牧夫座], [2540], [39.0],
      [长蛇座], [3980], [61.0],
    )
  ]

  v(1.2em)

  // --- 问题 (1) 图像 ---
  text(size: 11pt)[(1) 画出每个星系团离银河系的距离与它运动速度之间的关系图像。]
  v(0.6em)
  align(center)[#hubble-plot]

  v(1.5em)

  // --- 问题 (2)(3) 解答 ---
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2pt + rgb(31, 120, 180)),
    fill: rgb(245, 250, 255),
    radius: 2pt,
  )[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", fill: rgb(31, 120, 180), size: 10pt)[【解答】]
    #v(0.3em)
    #set text(size: 10pt)

    *(2) 星系的距离和运动速度有怎样的关系？*\
    答：星系团离银河系的距离越远，其退行速度越快。从图像上看，星系的退行速度与其距离成*正比*关系（即哈勃定律：$v = H_0 d$）。

    *(3) 该图像显示宇宙在膨胀、在收缩，还是保持着原有的体积？请作出解释。*\
    答：该图像显示宇宙正在*膨胀*。因为所有被观测的远方星系都在远离我们，且距离越远的星系远离的速度越快，这表明宇宙中的空间本身正在均匀膨胀，导致星系间的距离不断增大。
  ]

  v(1.2em)

  // --- 绘图原理与步骤 ---
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2pt + luma(180)),
    fill: luma(248),
    radius: 2pt,
  )[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", size: 10pt)[绘图原理与步骤]
    #v(0.3em)
    #set text(size: 9pt)

    + *坐标系建立*：横轴表示距离 $d$（单位 $10^4$ l.y.），量程 $0 tilde 4500$；纵轴表示速度 $v$（单位 km/s），量程 $0 tilde 70$。
    + *比例映射*：横轴每 500 单位对应 `0.8cm`；纵轴每 10 单位对应 `0.8cm`。
    + *网格与刻度*：绘制 $9 times 7$ 的辅助细网格线。在坐标轴上标注主刻度数值。
    + *描点绘图*：根据表中四组数据 $(80, 1.2), (980, 15.0), (2540, 39.0), (3980, 61.0)$，在坐标系中确定点位并绘制实心圆点。
    + *趋势线*：绘制一条通过原点且经过数据点分布区域的红色虚线，以揭示其线性比例关系。
  ]
}
