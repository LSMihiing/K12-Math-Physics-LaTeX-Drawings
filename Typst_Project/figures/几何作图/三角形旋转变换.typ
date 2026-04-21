// ============================================================
// 三角形变换（方格纸）
// 绘图 + 解答合并
// ============================================================
//
// 题目：在方格纸中，△A₁B₁C₁ 和 △A₂B₂C₂ 是两个形状、大小都一样的三角形。
//  (1) △A₁B₁C₁ 经过怎样的平移、旋转变换后，可以与 △A₂B₂C₂ 重合？
//  (2) △A₁B₁C₁ 经过怎样的变换后，可以与 △A₂B₂C₂ 成中心对称？
//      画出变换后的三角形，并标出对称中心。

#import "@preview/cetz:0.4.2"
#import "../../lib/grid-utils.typ": dot-label, draw-grid

// ==========================================
// 根据题图分析坐标（每小格 = 1 单位）
// ==========================================
// △A₁B₁C₁（左下，等腰三角形，顶点朝上）
//   B₁ = (4, 1),  C₁ = (6, 1),  A₁ = (5, 4)
//
// △A₂B₂C₂（右上，等腰三角形，顶点朝右）
//   B₂ = (9, 7),  C₂ = (9, 5),  A₂ = (12, 6)

// --- 坐标定义 ---
#let A1 = (5, 4)
#let B1 = (4, 1)
#let C1 = (6, 1)

#let A2 = (12, 6)
#let B2 = (9, 7)
#let C2 = (9, 5)

// (2) 中心对称
// 选 O = (10, 5) 作为对称中心:
// A₃ = (2*10 - 12, 2*5 - 6) = (8, 4)
// B₃ = (2*10 - 9, 2*5 - 7) = (11, 3)
// C₃ = (2*10 - 9, 2*5 - 5) = (11, 5)

#let O-sym = (10, 5)
#let A3 = (2 * O-sym.at(0) - A2.at(0), 2 * O-sym.at(1) - A2.at(1))
#let B3 = (2 * O-sym.at(0) - B2.at(0), 2 * O-sym.at(1) - B2.at(1))
#let C3 = (2 * O-sym.at(0) - C2.at(0), 2 * O-sym.at(1) - C2.at(1))

// ==========================================
// 绘图：题目原图
// ==========================================

#let problem-figure = cetz.canvas(length: 0.55cm, {
  import cetz.draw: *

  // --- 方格纸 ---
  draw-grid(origin: (0, 0), cols: 14, rows: 9, step: 1, line-color: luma(190), line-width: 0.3pt)

  // --- △A₁B₁C₁（蓝色） ---
  line(A1, B1, C1, close: true, stroke: 1pt + rgb("#2563EB"), fill: rgb("#DBEAFE"))
  dot-label(A1, $A_1$, dir: "n", text-size: 8pt)
  dot-label(B1, $B_1$, dir: "sw", text-size: 8pt)
  dot-label(C1, $C_1$, dir: "se", text-size: 8pt)

  // --- △A₂B₂C₂（绿色） ---
  line(A2, B2, C2, close: true, stroke: 1pt + rgb("#16A34A"), fill: rgb("#DCFCE7"))
  dot-label(A2, $A_2$, dir: "e", text-size: 8pt)
  dot-label(B2, $B_2$, dir: "n", text-size: 8pt)
  dot-label(C2, $C_2$, dir: "s", text-size: 8pt)

  // 顶点小圆点
  for pt in (A1, B1, C1, A2, B2, C2) {
    circle(pt, radius: 1.5pt, fill: black, stroke: none)
  }
})


// ==========================================
// 绘图：第(2)问 — 中心对称变换
// ==========================================

#let symmetry-figure = cetz.canvas(length: 0.55cm, {
  import cetz.draw: *

  // --- 方格纸 ---
  draw-grid(origin: (0, 0), cols: 14, rows: 9, step: 1, line-color: luma(190), line-width: 0.3pt)

  // --- △A₂B₂C₂（绿色，原三角形） ---
  line(A2, B2, C2, close: true, stroke: 1pt + rgb("#16A34A"), fill: rgb("#DCFCE7"))
  dot-label(A2, $A_2$, dir: "e", text-size: 8pt)
  dot-label(B2, $B_2$, dir: "n", text-size: 8pt)
  dot-label(C2, $C_2$, dir: "s", text-size: 8pt)

  // --- △A₃B₃C₃（红色，中心对称后的三角形） ---
  line(A3, B3, C3, close: true, stroke: 1pt + rgb("#DC2626"), fill: rgb("#FEE2E2"))
  dot-label(A3, $A_3$, dir: "w", text-size: 8pt)
  dot-label(B3, $B_3$, dir: "s", text-size: 8pt)
  dot-label(C3, $C_3$, dir: "n", text-size: 8pt)

  // --- 对称中心 O ---
  circle(O-sym, radius: 2.5pt, fill: red, stroke: none)
  content((O-sym.at(0) + 0.3, O-sym.at(1) + 0.3))[#text(size: 9pt, fill: red, weight: "bold")[$O$]]

  // --- 对应点虚线连接 ---
  line(A2, A3, stroke: (paint: luma(140), thickness: 0.5pt, dash: "dashed"))
  line(B2, B3, stroke: (paint: luma(140), thickness: 0.5pt, dash: "dashed"))
  line(C2, C3, stroke: (paint: luma(140), thickness: 0.5pt, dash: "dashed"))

  // 顶点小圆点
  for pt in (A2, B2, C2, A3, B3, C3) {
    circle(pt, radius: 1.5pt, fill: black, stroke: none)
  }
})


// ==========================================
// 输出：题目 + 解答
// ==========================================

#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[7.]
  text(size: 11pt)[如图，在方格纸中，$triangle A_1 B_1 C_1$ 和 $triangle A_2 B_2 C_2$ 是两个形状、大小都一样的三角形。]

  v(0.3em)
  h(2em)
  text[（1）$triangle A_1 B_1 C_1$ 经过怎样的平移、旋转变换后，可以与 $triangle A_2 B_2 C_2$ 重合？]

  v(0.2em)
  h(2em)
  text[（2）$triangle A_1 B_1 C_1$ 经过怎样的变换后，可以与 $triangle A_2 B_2 C_2$ 成中心对称？画出变换后的三角形，并标出对称中心。]

  v(0.6em)
  align(center)[
    #problem-figure
    #v(0.2em)
    #text(size: 9pt, fill: luma(100))[（第 7 题）]
  ]

  v(1em)

  // --- 解答 ---
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2.5pt + rgb("#4A90D9")),
    fill: rgb("#F0F6FF"),
    radius: 2pt,
  )[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", fill: rgb("#4A90D9"), size: 11pt)[解答]
    #v(0.4em)

    #text(weight: "bold")[(1)]
    $triangle A_1 B_1 C_1$ 先绕点 $A_1$ *顺时针旋转 $90°$*，使得顶点 $A_1$ 朝上的三角形变为顶点朝右的方向；再向右平移 $7$ 格、向上平移 $2$ 格，即可与 $triangle A_2 B_2 C_2$ 完全重合。

    #v(0.3em)
    即变换过程为：*旋转（绕 $A_1$ 顺时针 $90°$）#sym.arrow 平移（右 $7$ 格，上 $2$ 格）*。

    #v(0.6em)
    #text(weight: "bold")[(2)]
    以点 $O(10, 5)$ 为对称中心，对 $triangle A_2 B_2 C_2$ 作中心对称，得到 $triangle A_3 B_3 C_3$。

    #v(0.2em)
    各对应点坐标：
    - $A_3 = (2 times 10 - 12, space 2 times 5 - 6) = (8, 4)$
    - $B_3 = (2 times 10 - 9, space 2 times 5 - 7) = (11, 3)$
    - $C_3 = (2 times 10 - 9, space 2 times 5 - 5) = (11, 5)$


    #v(0.5em)
    #align(center)[
      #symmetry-figure
      #v(0.2em)
      #text(size: 9pt, fill: luma(100))[中心对称变换图（红色为变换后的三角形，$O$ 为对称中心）]
    ]
  ]
}
