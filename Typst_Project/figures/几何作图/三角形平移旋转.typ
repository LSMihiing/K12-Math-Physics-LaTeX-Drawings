// ============================================================
// 三角形平移与旋转（方格纸）
// 绘图 + 解答合并
// ============================================================
//
// 题目：如图，方格纸中每个小正方形的边长都是 1 个单位长度。
//       已知 △ABC 的三个顶点都在格点上，请按要求画出三角形。
//  (1) 将 △ABC 先向上平移 1 个单位长度再向右平移 2 个单位长度，得到 △A′B′C′；
//  (2) 将 △A′B′C′ 绕格点 O 按顺时针方向旋转 90°，得到 △A″B″C″。
//
// 绘图原理与步骤：
// ────────────────
// 网格：16 列 × 14 行
// 原三角形 △ABC：A(1,5), B(5,5), C(6,10)
// 旋转中心 O(8,3)
//
// (1) 平移变换（向上 1，向右 2）：
//     每个顶点 (x,y) → (x+2, y+1)
//     A(1,5) → A′(3,6)
//     B(5,5) → B′(7,6)
//     C(6,10) → C′(8,11)
//
// (2) 顺时针旋转 90°（绕 O(8,3)）：
//     公式：(x,y) → (cx + (y-cy), cy - (x-cx))
//     A′(3,6) → A″(8+(6-3), 3-(3-8)) = A″(11,8)
//     B′(7,6) → B″(8+(6-3), 3-(7-8)) = B″(11,4)
//     C′(8,11) → C″(8+(11-3), 3-(8-8)) = C″(16,3)
// ────────────────

#import "@preview/cetz:0.4.2"
#import "../../lib/grid-utils.typ": dot-label, draw-grid

// ==========================================
// 坐标定义（每小格 = 1 单位）
// ==========================================

// 原三角形 △ABC
#let ptA = (1, 5)
#let ptB = (5, 5)
#let ptC = (6, 10)

// 旋转中心 O
#let ptO = (8, 3)

// (1) 平移后 △A′B′C′：向上 1，向右 2
#let ptA1 = (ptA.at(0) + 2, ptA.at(1) + 1)  // (3, 6)
#let ptB1 = (ptB.at(0) + 2, ptB.at(1) + 1)  // (7, 6)
#let ptC1 = (ptC.at(0) + 2, ptC.at(1) + 1)  // (8, 11)

// (2) 顺时针旋转 90°（绕 O）
// 公式：x′ = cx + (y - cy),  y′ = cy - (x - cx)
#let rotate-cw90(pt, center) = {
  let cx = center.at(0)
  let cy = center.at(1)
  (cx + (pt.at(1) - cy), cy - (pt.at(0) - cx))
}
#let ptA2 = rotate-cw90(ptA1, ptO)  // (11, 8)
#let ptB2 = rotate-cw90(ptB1, ptO)  // (11, 4)
#let ptC2 = rotate-cw90(ptC1, ptO)  // (16, 3)


// ==========================================
// 绘图：题目原图（仅含 △ABC 和 O）
// ==========================================

#let problem-figure = cetz.canvas(length: 0.5cm, {
  import cetz.draw: *

  // --- 方格纸 16×14 ---
  draw-grid(origin: (0, 0), cols: 16, rows: 14, step: 1, line-color: luma(190), line-width: 0.3pt)

  // --- △ABC（黑色，原图） ---
  line(ptA, ptB, ptC, close: true, stroke: 0.8pt + black)
  dot-label(ptA, $A$, dir: "sw", text-size: 8pt)
  dot-label(ptB, $B$, dir: "se", text-size: 8pt)
  dot-label(ptC, $C$, dir: "n", text-size: 8pt)

  // --- O 点 ---
  circle(ptO, radius: 2pt, fill: black, stroke: none)
  dot-label(ptO, $O$, dir: "se", text-size: 8pt)

  // 顶点小圆点
  for pt in (ptA, ptB, ptC) {
    circle(pt, radius: 1.5pt, fill: black, stroke: none)
  }
})


// ==========================================
// 绘图：答案图（含 △ABC、△A′B′C′、△A″B″C″）
// ==========================================

#let answer-figure = cetz.canvas(length: 0.5cm, {
  import cetz.draw: *

  // --- 方格纸 16×14 ---
  draw-grid(origin: (0, 0), cols: 16, rows: 14, step: 1, line-color: luma(190), line-width: 0.3pt)

  // --- △ABC（黑色，原三角形） ---
  line(ptA, ptB, ptC, close: true, stroke: 0.8pt + black)
  dot-label(ptA, $A$, dir: "sw", text-size: 8pt)
  dot-label(ptB, $B$, dir: "s", text-size: 8pt)
  dot-label(ptC, $C$, dir: "nw", text-size: 8pt)
  for pt in (ptA, ptB, ptC) {
    circle(pt, radius: 1.5pt, fill: black, stroke: none)
  }

  // --- △A′B′C′（蓝色，平移后） ---
  line(ptA1, ptB1, ptC1, close: true, stroke: 1pt + rgb("#2563EB"), fill: rgb("#DBEAFE").transparentize(50%))
  dot-label(ptA1, $A'$, dir: "se", text-size: 8pt)
  dot-label(ptB1, $B'$, dir: "se", text-size: 8pt)
  dot-label(ptC1, $C'$, dir: "n", text-size: 8pt)
  for pt in (ptA1, ptB1, ptC1) {
    circle(pt, radius: 1.5pt, fill: rgb("#2563EB"), stroke: none)
  }

  // --- △A″B″C″（红色，旋转后） ---
  line(ptA2, ptB2, ptC2, close: true, stroke: 1pt + rgb("#DC2626"), fill: rgb("#FEE2E2").transparentize(50%))
  dot-label(ptA2, $A''$, dir: "n", text-size: 8pt)
  dot-label(ptB2, $B''$, dir: "sw", text-size: 8pt)
  dot-label(ptC2, $C''$, dir: "se", text-size: 8pt)
  for pt in (ptA2, ptB2, ptC2) {
    circle(pt, radius: 1.5pt, fill: rgb("#DC2626"), stroke: none)
  }

  // --- O 点（旋转中心） ---
  circle(ptO, radius: 2.5pt, fill: rgb("#DC2626"), stroke: none)
  dot-label(ptO, $O$, dir: "s", text-size: 8pt)

  // --- 平移辅助箭头（虚线，A→A′方向） ---
  line(ptA, ptA1, stroke: (paint: luma(120), thickness: 0.5pt, dash: "dashed"), mark: (end: "stealth", fill: luma(120)))
  line(ptB, ptB1, stroke: (paint: luma(120), thickness: 0.5pt, dash: "dashed"), mark: (end: "stealth", fill: luma(120)))
  line(ptC, ptC1, stroke: (paint: luma(120), thickness: 0.5pt, dash: "dashed"), mark: (end: "stealth", fill: luma(120)))
})


// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[3.]
  text(
    size: 11pt,
  )[如图，方格纸中每个小正方形的边长都是 1 个单位长度。已知 $triangle A B C$ 的三个顶点都在格点上，请按要求画出三角形。]

  v(0.3em)
  h(2em)
  text[（1）将 $triangle A B C$ 先向上平移 1 个单位长度再向右平移 2 个单位长度，得到 $triangle A' B' C'$；]

  v(0.2em)
  h(2em)
  text[（2）将 $triangle A' B' C'$ 绕格点 $O$ 按顺时针方向旋转 $90°$，得到 $triangle A'' B'' C''$。]

  v(0.6em)
  align(center)[
    #problem-figure
    #v(0.2em)
    #text(size: 9pt, fill: luma(100))[（第 3 题）]
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
    将 $triangle A B C$ 各顶点向上平移 1 格、向右平移 2 格：

    #v(0.2em)
    - $A(1, 5) arrow A'(3, 6)$
    - $B(5, 5) arrow B'(7, 6)$
    - $C(6, 10) arrow C'(8, 11)$

    #v(0.2em)
    连接 $A' B' C'$ 即得 $triangle A' B' C'$（图中蓝色三角形）。

    #v(0.5em)
    #text(weight: "bold")[(2)]
    将 $triangle A' B' C'$ 绕 $O(8, 3)$ 顺时针旋转 $90°$。

    顺时针 $90°$ 旋转公式：$(x, y) arrow (c_x + (y - c_y), space c_y - (x - c_x))$

    #v(0.2em)
    - $A'(3, 6) arrow A''(11, 8)$
    - $B'(7, 6) arrow B''(11, 4)$
    - $C'(8, 11) arrow C''(16, 3)$

    #v(0.2em)
    连接 $A'' B'' C''$ 即得 $triangle A'' B'' C''$（图中红色三角形）。
  ]

  v(0.8em)
  align(center)[
    #answer-figure
    #v(0.2em)
    #text(size: 9pt, fill: luma(100))[答案图（蓝色为平移后，红色为旋转后）]
  ]

  v(1em)

  // --- 绘图原理与步骤 ---
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2.5pt + luma(140)),
    fill: luma(248),
    radius: 2pt,
  )[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", fill: luma(80), size: 11pt)[绘图原理与步骤]
    #v(0.4em)

    #text(weight: "bold")[网格与坐标]
    #v(0.2em)
    - 网格 16 列 × 14 行，每格 1 个单位，canvas 单位 0.5cm。
    - 原三角形 $triangle A B C$：$A(1,5)$、$B(5,5)$、$C(6,10)$。
    - 旋转中心 $O(8,3)$。

    #v(0.4em)
    #text(weight: "bold")[平移变换]
    #v(0.2em)
    - 每个顶点 $(x, y) arrow (x+2, y+1)$。
    - 结果：$A'(3,6)$、$B'(7,6)$、$C'(8,11)$。
    - 蓝色三角形，半透明填充 `#DBEAFE`。

    #v(0.4em)
    #text(weight: "bold")[旋转变换]
    #v(0.2em)
    - 绕 $O(8,3)$ 顺时针 $90°$：$(x,y) arrow (8+(y-3), 3-(x-8))$。
    - 结果：$A''(11,8)$、$B''(11,4)$、$C''(16,3)$。
    - 红色三角形，半透明填充 `#FEE2E2`。
    - $O$ 用红色实心圆标记。

    #v(0.4em)
    #text(weight: "bold")[辅助元素]
    #v(0.2em)
    - 灰色虚线箭头连接平移前后的对应顶点（$A arrow A'$、$B arrow B'$、$C arrow C'$）。
    - 顶点用 1.5pt 实心圆标记，标签通过 `dot-label` 放置。
  ]
}
