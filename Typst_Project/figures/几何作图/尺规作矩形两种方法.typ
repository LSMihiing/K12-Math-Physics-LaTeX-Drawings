// ============================================================
// 尺规作矩形两种方法
// ============================================================
#import "@preview/cetz:0.4.2": canvas, draw, vector
#import "../../lib/geo-utils.typ": *

// 辅助函数：根据圆心、半径、起始和结束角度画以中心为基准的弧
#let arc-by-center(c-pt, r, a-start, a-stop, stroke: 0.5pt) = {
  let cx = c-pt.at(0)
  let cy = c-pt.at(1)
  let sx = cx + r * calc.cos(a-start)
  let sy = cy + r * calc.sin(a-start)
  draw.arc((sx, sy), start: a-start, stop: a-stop, radius: r, stroke: stroke)
}

// 方法一：交轨法
#let rect-construction-method-1() = canvas({
  import draw: *

  let B = (0.0, 0.0)
  let A = (0.0, 1.5)
  let C = (3.0, 0.0)
  let D = (3.0, 1.5)

  line(A, B, stroke: 1pt)
  line(B, C, stroke: 1pt)
  line((0.15, 0), (0.15, 0.15), (0, 0.15), stroke: 0.5pt)

  let rA = 3.0
  let rC = 1.5

  arc-by-center(A, rA, -15deg, 15deg, stroke: 0.5pt)
  arc-by-center(C, rC, 75deg, 105deg, stroke: 0.5pt)

  line(A, D, stroke: 1pt)
  line(C, D, stroke: 1pt)

  content(A, [A], anchor: "south-east", padding: 0.1)
  content(B, [B], anchor: "north-east", padding: 0.1)
  content(C, [C], anchor: "north-west", padding: 0.1)
  content(D, [D], anchor: "south-west", padding: 0.1)
})

// 方法二：对角线中点中心对称法
#let rect-construction-method-2() = canvas({
  import draw: *

  let B = (0.0, 0.0)
  let A = (0.0, 1.5)
  let C = (3.0, 0.0)
  let D = (3.0, 1.5)
  let O = (1.5, 0.75)

  line(A, B, stroke: 1pt)
  line(B, C, stroke: 1pt)
  line((0.15, 0), (0.15, 0.15), (0, 0.15), stroke: 0.5pt)

  line(A, C, stroke: 0.5pt)

  let r_mid = 2.0
  arc-by-center(A, r_mid, 0deg, 15deg, stroke: 0.5pt)
  arc-by-center(C, r_mid, 110deg, 130deg, stroke: 0.5pt)
  arc-by-center(A, r_mid, -70deg, -50deg, stroke: 0.5pt)
  arc-by-center(C, r_mid, 175deg, 195deg, stroke: 0.5pt)

  line((2.15, 2.05), (0.85, -0.55), stroke: 0.5pt)
  line(B, (3.3, 1.65), stroke: 0.5pt)
  arc-by-center(O, 1.677, 15deg, 40deg, stroke: 0.5pt)

  line(A, D, stroke: 1pt)
  line(C, D, stroke: 1pt)

  content(A, [A], anchor: "south-east", padding: 0.1)
  content(B, [B], anchor: "north-east", padding: 0.1)
  content(C, [C], anchor: "north-west", padding: 0.1)
  content(D, [D], anchor: "south-west", padding: 0.1)
  content(O, [O], anchor: "north", padding: 0.15)
})

#let render() = {
  align(center)[
    #grid(
      columns: 2,
      column-gutter: 2em,
      row-gutter: 0.5em,
      align: center + bottom,
      rect-construction-method-1(),
      rect-construction-method-2(),
      [*(作法一)*],
      [*(作法二)*],
    )
  ]

  v(1.2em)

  block(width: 100%, inset: (x: 1em, y: 0.8em), stroke: (left: 2pt + luma(180)), fill: luma(248), radius: 2pt)[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", size: 10pt)[绘图原理与步骤]
    #v(0.3em)
    #set text(size: 9pt)

    *作法一（交轨法）*：分别以 A、C 为圆心，以邻边长为半径画弧，交点即为 D。

    *作法二（对角线中点法）*：连 AC 并作垂直平分线找到中点 O，再以 O 为圆心、OB 为半径截取 BO 延长线得 D。
  ]
}
