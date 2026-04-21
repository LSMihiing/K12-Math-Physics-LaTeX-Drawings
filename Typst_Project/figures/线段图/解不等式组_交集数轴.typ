// ============================================================
// 解不等式组并在数轴上表示
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 公共参数与样式
// ==========================================
#let axis-stroke = 0.8pt + black
#let tick-stroke = 0.8pt + black
#let sol-color = rgb("#0000CD") // 蓝色
#let sol-color-red = rgb("#DC2626") // 红色
#let tick-y = -0.3
#let tick-size = 11pt

#let draw-axis(min-val, max-val) = {
  import cetz.draw: *
  line((min-val - 0.5, 0), (max-val + 0.8, 0), mark: (end: "stealth", fill: black, size: 0.25), stroke: axis-stroke)
  for i in range(int(calc.floor(min-val)), int(calc.ceil(max-val)) + 1) {
    line((i, 0), (i, 0.15), stroke: tick-stroke)
    let label-text = if i < 0 { [$-$#calc.abs(i)] } else { str(i) }
    content((i, tick-y))[#text(size: tick-size)[#label-text]]

    // 原图中原点 (0) 有黑色实心小圆点
    if i == 0 {
      circle((0, 0), radius: 0.05, fill: black, stroke: none)
    }
  }
}

#let draw-ray(sol-val, sol-type, sol-dir, min-val, max-val, height, ray-color, r: 0.08) = {
  import cetz.draw: *
  let end-x = if sol-dir == "right" { max-val + 0.8 } else { min-val - 0.3 }
  let ray-stroke = 1.5pt + ray-color
  line(
    (sol-val, r),
    (sol-val, height),
    (end-x, height),
    mark: (end: "stealth", fill: ray-color, size: 0.25),
    stroke: ray-stroke,
  )
  if sol-type == "open" {
    circle((sol-val, 0), radius: r, fill: white, stroke: ray-stroke)
  } else {
    circle((sol-val, 0), radius: r, fill: ray-color, stroke: none)
  }
}

// ==========================================
// 题图定义
// ==========================================
#let figure-1 = cetz.canvas(length: 0.6cm, {
  draw-axis(-6, 6)

  // (1) 1/2(x-4)+3 > 0 => x > -2
  // 向右，开区间，处于下方
  draw-ray(-2, "open", "right", -6, 6, 0.5, sol-color-red, r: 0.12)

  // (2) x-6 <= 0 => x <= 6
  // 向左，闭区间，处于上方
  draw-ray(6, "closed", "left", -6, 6, 0.9, sol-color, r: 0.12)
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

    解不等式（1）：$x - 6 <= 0$，得：
    $ x <= 6 $

    解不等式（2）：$1/2 (x - 4) + 3 > 0$，去括号得：
    $ 1/2 x - 2 + 3 > 0 $
    $ 1/2 x + 1 > 0 $
    移项并系数化为1，得：
    $ x > -2 $

    所以，该不等式组的解集为：
    $ -2 < x <= 6 $

    该不等式组的解集在数轴上表示如图所示。

    由不等式组的解集可知，所有的整数解为：
    $ -1, 0, 1, 2, 3, 4, 5, 6 $。
  ]

  v(1em)

  // 图形展示
  align(center)[
    #figure-1
    #v(0.5em)
    #text(size: 9pt, fill: luma(100))[（第 16 题 不等式组解集）]
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

    - 还原数轴样式：复现了跨度 $[-6, 6]$ 的向右标准数轴。特别地，在原点 $0$ 刻度正位还原了题目图中的实心黑点，与整数刻度对齐保持等距。
    - $x > -2$ 的图解表示：不包含等号，因此在 $-2$ 的位置落笔空心圆圈标记，引出一条较低高度（0.5）的红色射线向右平穿，并带实心箭头。
    - $x <= 6$ 的图解表示：包含等号，在 $6$ 的位置落笔实心圆点标记，引出一条较高高度（0.9）的蓝色射线向左贯穿，末端带实心箭头。
    - 画板基础单位 `length` 设定为 `0.6cm`，同时传入自动成比例配置的圆点半径 `r: 0.12`，在不重叠的基础上使空/实心圆与前几题等比例一般明显可见。
  ]
}
