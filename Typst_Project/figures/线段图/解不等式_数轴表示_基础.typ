// ============================================================
// 解不等式并在数轴上表示
// ============================================================
//
// 题目：解下列不等式，并把解集在数轴上表示出来：
// (1) 7 + x > 3;
// (2) -1/2 x < 1;
// (3) 4 + 3x > 6 - 2x;
// (4) 3(1 - x) >= 2(x + 9).
//
// 绘图原理与步骤：
// ────────────────
// (1) 解不等式 7 + x > 3 得 x > -4。数轴上，在 -4 处画空心圆圈，向右画带有箭头的折现。
// (2) 解不等式 -1/2 x < 1 得 x > -2。数轴上，在 -2 处画空心圆圈，向右画带有箭头的折现。
// (3) 解不等式 4 + 3x > 6 - 2x 得 x > 2/5。数轴上，0 与 1 之间找到 2/5 的位置画空心圆圈，并标记其数值，向右画带有箭头的折线。
// (4) 解不等式 3(1 - x) >= 2(x + 9) 展开得 3 - 3x >= 2x + 18，即 -5x >= 15，解得 x <= -3。数轴上，在 -3 处画实心圆点，向左画带有箭头的折线。
// ────────────────

#import "@preview/cetz:0.4.2"

// ==========================================
// 公共参数与样式
// ==========================================
#let axis-stroke = 0.8pt + black
#let tick-stroke = 0.8pt + black
#let sol-stroke = 1.5pt + rgb("#0000CD") // 蓝色
#let radius-size = 0.08
#let tick-y = -0.3
#let tick-size = 11pt

// 辅助函数：绘制单条数轴及解集
#let draw-inequality(min-val, max-val, sol-val, sol-type, sol-dir, label-val: none) = {
  import cetz.draw: *

  // 1. 画数轴主线
  line((min-val - 0.5, 0), (max-val + 0.8, 0), mark: (end: "stealth", fill: black, size: 0.25), stroke: axis-stroke)

  // 2. 画刻度及数字
  for i in range(int(calc.floor(min-val)), int(calc.ceil(max-val)) + 1) {
    line((i, 0), (i, 0.15), stroke: tick-stroke)
    // - 号特殊处理，否则可能会变连字符
    let label-text = if i < 0 { [$-$#calc.abs(i)] } else { str(i) }
    content((i, tick-y))[#text(size: tick-size)[#label-text]]
  }

  // 3. 画特殊数值的标记（如分数 2/5）
  if label-val != none {
    // 画一个短刻度
    line((sol-val, 0), (sol-val, 0.15), stroke: tick-stroke)
    content((sol-val, tick-y - 0.35))[#text(size: tick-size)[#label-val]]
  }

  // 4. 画解集表现线
  let start-y = 0.6 // 垂直高度
  let end-x = if sol-dir == "right" { max-val + 0.6 } else { min-val - 0.3 }
  line((sol-val, radius-size), (sol-val, start-y), (end-x, start-y), mark: (end: "stealth", fill: rgb("#0000CD"), size: 0.25), stroke: sol-stroke)

  // 5. 画空心/实心圆圈（盖在底端线段上）
  if sol-type == "open" {
    circle((sol-val, 0), radius: radius-size, fill: white, stroke: sol-stroke)
  } else {
    circle((sol-val, 0), radius: radius-size, fill: rgb("#0000CD"), stroke: none)
  }
}

// ==========================================
// 各小题图形定义
// ==========================================

#let figure-1 = cetz.canvas(length: 0.8cm, {
  // (1) x > -4
  draw-inequality(-6, 2, -4, "open", "right")
})

#let figure-2 = cetz.canvas(length: 0.8cm, {
  // (2) x > -2
  draw-inequality(-4, 3, -2, "open", "right")
})

#let figure-3 = cetz.canvas(length: 1.4cm, {
  // (3) x > 2/5
  draw-inequality(-1, 2, 0.4, "open", "right", label-val: $2/5$)
})

#let figure-4 = cetz.canvas(length: 0.8cm, {
  // (4) x <= -3
  draw-inequality(-6, 1, -3, "closed", "left")
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

    #text(weight: "bold")[(1)] 解：移项及合并同类项，得
    $ x > 3 - 7 $
    $ x > -4 $
    该不等式的解集在数轴上表示如图（1）所示。

    #v(0.4em)
    #text(weight: "bold")[(2)] 解：不等式两边同乘 $-2$，得
    $ x > -2 $
    该不等式的解集在数轴上表示如图（2）所示。

    #v(0.4em)
    #text(weight: "bold")[(3)] 解：去括号及移项、合并同类项，得
    $ 3x + 2x > 6 - 4 $
    $ 5x > 2 $
    $ x > 2/5 $
    该不等式的解集在数轴上表示如图（3）所示。

    #v(0.4em)
    #text(weight: "bold")[(4)] 解：去括号，得
    $ 3 - 3x >= 2x + 18 $
    移项及合并同类项，得
    $ -5x >= 15 $
    系数化为1，改变不等号方向，得
    $ x <= -3 $
    该不等式的解集在数轴上表示如图（4）所示。
  ]

  v(1em)

  // 图形展示
  align(center)[
    #grid(
      columns: (1fr, 1fr),
      row-gutter: 2.5em,
      align: center,
      [#figure-1 \ #v(0.5em) #text(size: 9pt)[图（1）]], [#figure-2 \ #v(0.5em) #text(size: 9pt)[图（2）]],
      [#figure-3 \ #v(0.5em) #text(size: 9pt)[图（3）]], [#figure-4 \ #v(0.5em) #text(size: 9pt)[图（4）]],
    )
    #v(0.5em)
    #text(size: 9pt, fill: luma(100))[（第 3 题 不等式解集）]
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

    数轴的绘制满足统一标准要求：正方向朝右，单位长度均匀，标出整数刻度值。

    #v(0.2em)
    #text(weight: "bold")[图（1）：$x > -4$]
    - $x > -4$，解集不包含 $-4$，故在 $-4$ 位置画蓝色空心圆圈。
    - 大于某个数方向向右，绘制从圆点处竖直向上，而后水平向右的蓝色带箭头的折线。

    #v(0.2em)
    #text(weight: "bold")[图（2）：$x > -2$]
    - 等同原理，于 $-2$ 处画空心圆圈，折线向右指并附加箭头。

    #v(0.2em)
    #text(weight: "bold")[图（3）：$x > 2/5$]
    - 刻度以整数为主。在 $0$ 和 $1$ 之间定位 $x = 0.4$ 的位置。
    - 垂直标出专属小刻度，并于下方标记分数 $2/5$ 以辅助定位。
    - 于 $0.4$ 处画蓝色空心圆圈，折线向右指并附加箭头。

    #v(0.2em)
    #text(weight: "bold")[图（4）：$x <= -3$]
    - 解集包含等于情况，于 $-3$ 处绘制蓝色实心圆点。
    - 小于某个数方向向左，画从圆点立起后水平向左的蓝色折线，端点带箭头。
  ]
}
