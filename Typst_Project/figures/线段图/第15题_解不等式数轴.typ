// ============================================================
// 第15题 · 解不等式(组)并在数轴上表示
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 公共参数与样式
// ==========================================
#let axis-stroke = 0.8pt + black
#let tick-stroke = 0.8pt + black
#let sol-color = rgb("#0000CD") // 蓝色
#let sol-color-red = rgb("#DC2626") // 红色
#let radius-size = 0.05
#let tick-y = -0.3
#let tick-size = 11pt

#let draw-axis(min-val, max-val) = {
  import cetz.draw: *
  line((min-val - 0.5, 0), (max-val + 0.8, 0), mark: (end: "stealth", fill: black, size: 0.25), stroke: axis-stroke)
  for i in range(int(calc.floor(min-val)), int(calc.ceil(max-val)) + 1) {
    line((i, 0), (i, 0.15), stroke: tick-stroke)
    let label-text = if i < 0 { [$-$#calc.abs(i)] } else { str(i) }
    content((i, tick-y))[#text(size: tick-size)[#label-text]]
  }
}

#let draw-ray(sol-val, sol-type, sol-dir, min-val, max-val, height, ray-color, r: 0.08) = {
  import cetz.draw: *
  let end-x = if sol-dir == "right" { max-val + 0.6 } else { min-val - 0.3 }
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
// 各小题图形定义
// ==========================================

#let figure-1 = cetz.canvas(length: 2.2cm, {
  draw-axis(0, 5)
  import cetz.draw: *
  let sol-val = 22 / 7
  line((sol-val, 0), (sol-val, 0.15), stroke: tick-stroke)
  content((sol-val, tick-y - 0.05))[#text(size: tick-size)[$22/7$]]
  // 长度系数为 2.2cm，设可见圆洞基准 0.08
  draw-ray(sol-val, "open", "left", 0, 5, 0.6, sol-color, r: 0.05)
})

#let figure-2 = cetz.canvas(length: 0.8cm, {
  draw-axis(-6, 7)
  // 长度系数为 0.8cm，为在视觉上保持与图(1)等大，计算为 0.08 * (2.2 / 0.8) = 0.22
  draw-ray(-4, "open", "right", -6, 7, 0.5, sol-color-red, r: 0.1)
  draw-ray(5, "open", "left", -6, 7, 0.9, sol-color, r: 0.1)
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

    #text(weight: "bold")[(1)] 解：去括号，得
    $ 3x - 2 < -4x + 20 $
    移项及合并同类项，得
    $ 7x < 22 $
    系数化为1，得
    $ x < 22/7 $
    该不等式的解集在数轴上表示如图（1）所示。

    #v(0.4em)
    #text(weight: "bold")[(2)] 解：不等式各边同乘 $3$，得
    $ -3 < 2 - x < 6 $
    各边同减去 $2$，得
    $ -5 < -x < 4 $
    各边同除以 $-1$，改变不等号方向，得
    $ 5 > x > -4 $
    即 $ -4 < x < 5 $ 。
    该不等式组的解集在数轴上表示如图（2）所示。
  ]

  v(1em)

  // 图形展示
  align(center)[
    #grid(
      columns: 1,
      row-gutter: 4em,
      align: center,
      [#figure-1 \ #v(0.5em) #text(size: 9pt)[图（1）]],
      [#figure-2 \ #v(0.5em) #text(size: 9pt)[图（2）]],
    )
    #v(0.5em)
    #text(size: 9pt, fill: luma(100))[（第 15 题 不等式解集）]
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

    数轴依据统一风格：正方向朝右（加实心 stealth 箭头），坐标原点标明确，普通数值标记在下方 $-0.4$ 的水平参考线处。

    #v(0.2em)
    #text(weight: "bold")[图（1）：$x < 22/7$]
    - $22/7 approx 3.14$，单独定位于 $3$ 与 $4$ 之间，标记下沉偏移量以保证与临近整数不发生重叠，圆点尺寸调整为 $0.05$。
    - 画空心圆点后引出左指蓝色实心箭头线。

    #v(0.2em)
    #text(weight: "bold")[图（2）：$-4 < x < 5$]
    - 将双边区间按照原题模式转化为两条分离交汇的射线形式展示。
    - 分别于 $-4$ 及 $5$ 画极细空心圆点。
    - 从 $-4$ 引出较低高度的红线向右穿插；从 $5$ 引出较高高度的蓝线向左穿插，均带实心箭头。
  ]
}
