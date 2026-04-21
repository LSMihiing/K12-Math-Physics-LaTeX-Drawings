// ============================================================
// 用小长方形拼接大长方形
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 题图定义
// ==========================================

#let figure-1 = cetz.canvas(length: 0.6cm, {
  import cetz.draw: *

  // 原题网格颜色（浅青色）
  let grid-color = rgb("#4FC3F7")
  let grid-stroke = 0.6pt + grid-color
  let grid-stroke-dashed = (paint: grid-color, thickness: 0.6pt, dash: "dashed")
  
  // 拼图方块颜色（深蓝色）
  let block-stroke = 1.5pt + rgb("#005DB9")

  // 1. 绘制 14 × 8 的背景方格网
  // 内部虚线网格
  grid((0, 0), (14, 8), step: 1, stroke: grid-stroke-dashed)
  // 外部实线边框
  rect((0, 0), (14, 8), stroke: grid-stroke)
  
  // 2. 绘制拼接的长方形拼法
  // 左侧留空 2 格，上方留空 1 格开始绘制
  let start-x = 2
  let start-y = 7
  
  // 上半部分：2个横放的小长方形 (3 x 2)
  // 第一个：从(2, 7)向右3，向下2 -> 到(5, 5)
  rect((start-x, start-y), (start-x + 3, start-y - 2), stroke: block-stroke)
  // 第二个：从(5, 7)向右3，向下2 -> 到(8, 5)
  rect((start-x + 3, start-y), (start-x + 6, start-y - 2), stroke: block-stroke)
  
  // 下半部分：3个竖放的小长方形 (2 x 3)
  let y-mid = start-y - 2 // 也就是 5
  // 第一个：从(2, 5)向右2，向下3 -> 到(4, 2)
  rect((start-x, y-mid), (start-x + 2, y-mid - 3), stroke: block-stroke)
  // 第二个：从(4, 5)向右2，向下3 -> 到(6, 2)
  rect((start-x + 2, y-mid), (start-x + 4, y-mid - 3), stroke: block-stroke)
  // 第三个：从(6, 5)向右2，向下3 -> 到(8, 2)
  rect((start-x + 4, y-mid), (start-x + 6, y-mid - 3), stroke: block-stroke)
})

// ==========================================
// 输出：题目解答与组合图表
// ==========================================
#let render() = {
  set par(first-line-indent: 0em)

  // 解答块
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2.5pt + rgb("#4A90D9")),
    fill: rgb("#F0F6FF"),
    radius: 2pt,
  )[
    #text(weight: "bold", fill: rgb("#4A90D9"), size: 11pt)[解答]
    #v(0.4em)
    
    小长方形的长为 $3$ 厘米，宽为 $2$ 厘米；大长方形的长为 $6$ 厘米，宽为 $5$ 厘米。
    
    我们可以如下拼凑：
    - 因为 $6 = 3 + 3$，所以横列可以放置 $2$ 个横向长方形凑齐 $6$ 厘米长度，此时占据宽度为 $2$ 厘米；
    - 因为 $6 = 2 + 2 + 2$，所以竖列可以放置 $3$ 个纵向长方形凑齐 $6$ 厘米长度，此时占据宽度为 $3$ 厘米；
    - 上下拼合两种放法，大长方形的总宽度恰好为 $2 + 3 = 5$ 厘米。满足了长为 $6$ 厘米，宽为 $5$ 厘米的要求。
    
    拼法如图所示：
  ]

  v(1.5em)

  align(center)[
    #figure-1
    #v(0.5em)
    #text(size: 9pt, fill: luma(100))[（第 3 题 矩形拼接示意图）]
  ]

  v(1em)

  // 绘图原理与步骤
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2.5pt + luma(140)),
    fill: luma(248),
    radius: 2pt,
  )[
    #text(weight: "bold", fill: luma(80), size: 11pt)[绘图原理与步骤]
    #v(0.4em)
    
    - 绘制网格：按照原题样式，绘制长为 14、高为 8 的底面网孔。采用匹配原题干青蓝色（\#4FC3F7）的虚线 `dashed` 作为内网格线，外围实线包边。
    - 坐标计算：以左下角为原点 $(0, 0)$，定义小矩形从网格坐标 $(2, 7)$ 开始画，满足了左错 2 格、上距 1 格的定位条件。
    - 上排渲染：绘制两个长为 $3$ 宽为 $2$ 的蓝色矩形，坐标从 $(2, 7)$ 到 $(5, 5)$ 以及 $(5, 7)$ 到 $(8, 5)$。
    - 下排渲染：绘制三个长为 $2$ 宽为 $3$ 的蓝色矩形，下方高度为 3，坐标直接从上层边界 $(..., 5)$ 对应连接到底座 $y=2$ 分别隔 $2$ 距离排列即可。
  ]
}
