// ============================================================
// 第2题 · 复式折线统计图（北京、南京一周最高气温）
// 绘图 + 解答合并
// ============================================================
//
// 题目：下表是强强摘录的北京和南京两地一周内每天的最高气温。
//       根据表中的数据，完成下面的折线统计图。
//
// 数据：
//   北京：15, 15, 13, 10,  5,  6,  7
//   南京：25, 21, 22, 23, 25, 26, 14

#import "@preview/cetz:0.4.2"

// ==========================================
// 数据定义
// ==========================================
#let days = ("2日", "3日", "4日", "5日", "6日", "7日", "8日")
#let beijing = (15, 15, 13, 10, 5, 6, 7)
#let nanjing = (25, 21, 22, 23, 25, 26, 14)

// ==========================================
// 图表参数
// ==========================================
// 方格网：7 列（7天）× 6 行（0~30℃，步长 5℃）
// 列宽 sx = 1.2 单位，行高 sy = 1.0 单位
// 坐标映射：
//   X(第 i 天, i=0..6) = i × sx + sx/2   （列中心）
//   Y(温度 T)          = T / 5 × sy
#let sx = 1.2
#let sy = 1.0
#let ncols = 7
#let nrows = 6

// ==========================================
// 绘图：已完成的折线统计图
// ==========================================
#let answer-chart = cetz.canvas(length: 0.7cm, {
  import cetz.draw: *

  let w = ncols * sx  // = 8.4
  let ht = nrows * sy  // = 6.0

  // ---- 1. 方格网 ----
  // 水平线（7 条：y=0,1,2,3,4,5,6 对应 0℃,5℃,...,30℃）
  for j in range(nrows + 1) {
    let stk = if j == 0 or j == nrows { 0.7pt + black } else { 0.3pt + black }
    line((0, j * sy), (w, j * sy), stroke: stk)
  }
  // 竖直线（8 条：i=0..7，左右边框较粗）
  for i in range(ncols + 1) {
    let stk = if i == 0 or i == ncols { 0.7pt + black } else { 0.3pt + black }
    line((i * sx, 0), (i * sx, ht), stroke: stk)
  }

  // ---- 2. Y 轴刻度标注（0, 10, 20, 30）----
  content((-0.5, 0))[#text(size: 9pt)[0]]
  content((-0.6, 2))[#text(size: 9pt)[10]]
  content((-0.6, 4))[#text(size: 9pt)[20]]
  content((-0.6, ht))[#text(size: 9pt)[30]]
  // Y 轴标题
  content((0.8, ht + 0.7))[#text(size: 8pt)[最高气温/℃]]

  // ---- 3. X 轴日期标注 ----
  for i in range(ncols) {
    content((i * sx + sx / 2, -0.5))[#text(size: 8pt)[#days.at(i)]]
  }
  content((w + 0.6, -0.5))[#text(size: 8pt)[日期]]

  // ---- 4. 图例与 "年 月" ----
  // 实线 + "北京"
  line((3.0, ht + 0.7), (3.8, ht + 0.7), stroke: 0.8pt + black)
  content((4.3, ht + 0.7))[#text(size: 8pt)[北京]]
  // 虚线 + "南京"
  line((5.0, ht + 0.7), (5.8, ht + 0.7),
    stroke: (paint: black, thickness: 0.8pt, dash: "dashed"))
  content((6.3, ht + 0.7))[#text(size: 8pt)[南京]]
  // "年 月"
  content((w - 0.2, ht + 0.7))[#text(size: 8pt)[年#h(1em)月]]

  // ---- 5. 北京折线（实线 + 实心圆点）----
  // 依次连接 7 个数据点
  for i in range(ncols - 1) {
    let x1 = i * sx + sx / 2
    let y1 = beijing.at(i) / 5
    let x2 = (i + 1) * sx + sx / 2
    let y2 = beijing.at(i + 1) / 5
    line((x1, y1), (x2, y2), stroke: 0.8pt + black)
  }
  // 数据点标记
  for i in range(ncols) {
    let x = i * sx + sx / 2
    let y = beijing.at(i) / 5
    circle((x, y), radius: 2pt, fill: black, stroke: none)
  }

  // ---- 6. 南京折线（虚线 + 空心圆点）----
  for i in range(ncols - 1) {
    let x1 = i * sx + sx / 2
    let y1 = nanjing.at(i) / 5
    let x2 = (i + 1) * sx + sx / 2
    let y2 = nanjing.at(i + 1) / 5
    line((x1, y1), (x2, y2),
      stroke: (paint: black, thickness: 0.8pt, dash: "dashed"))
  }
  // 数据点标记
  for i in range(ncols) {
    let x = i * sx + sx / 2
    let y = nanjing.at(i) / 5
    circle((x, y), radius: 2.5pt, fill: white, stroke: 0.8pt + black)
  }

  // ---- 7. 数据值标注 ----
  // 北京：标在数据点下方
  for i in range(ncols) {
    let x = i * sx + sx / 2
    let y = beijing.at(i) / 5
    content((x, y - 0.4))[#text(size: 6.5pt)[#beijing.at(i)]]
  }
  // 南京：标在数据点上方
  for i in range(ncols) {
    let x = i * sx + sx / 2
    let y = nanjing.at(i) / 5
    content((x, y + 0.4))[#text(size: 6.5pt)[#nanjing.at(i)]]
  }
})


// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[2. ]
  text(size: 11pt)[下表是强强摘录的北京和南京两地一周内每天的最高气温。根据表中的数据，完成下面的折线统计图。]

  v(0.5em)

  // --- 数据表 ---
  align(center)[
    #table(
      columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      align: center + horizon,
      stroke: 0.5pt + black,
      inset: 6pt,
      // 表头行 1
      table.cell(rowspan: 2)[城 市],
      table.cell(colspan: 7)[最高气温/℃],
      // 表头行 2（日期）
      [2日], [3日], [4日], [5日], [6日], [7日], [8日],
      // 数据行
      [北 京], [15], [15], [13], [10], [5], [6], [7],
      [南 京], [25], [21], [22], [23], [25], [26], [14],
    )
  ]

  v(0.8em)

  // --- 折线统计图标题 ---
  align(center)[
    #text(weight: "bold", size: 11pt)[北京、南京一周内每天最高气温统计图]
  ]
  v(0.4em)

  // --- 已完成的折线统计图 ---
  align(center)[#answer-chart]

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

    + *方格网参数*：$7 times 6$ 格，列宽 `sx=1.2`，行高 `sy=1.0`（=5℃）。外框 0.7pt 黑色实线，内部网格 0.3pt 黑色实线。
    + *X 轴映射*：第 $i$ 天（$i = 0 tilde 6$）→ $x = i times 1.2 + 0.6$（列中心）。
    + *Y 轴映射*：温度 $T$ → $y = T \/ 5$。量程 0~30℃，每单位高度 = 5℃。
    + *北京折线*：0.8pt 黑色实线连接相邻点，2pt 实心黑圆标记。
    + *南京折线*：0.8pt 黑色虚线连接相邻点，2.5pt 空心圆（白底黑框）标记。
    + *标注*：Y 轴仅标注 0/10/20/30 四个刻度值；X 轴标注 2日~8日；图例区分实线/虚线位于图上方；数据值北京标于点下方、南京标于点上方。
  ]
}
