// ============================================================
// 仅用圆规作矩形
// ============================================================
// 题目：A 是直线 l 外一点。仅用圆规作点 B、C、D，
//       其中两点在 l 上，使 A、B、C、D 是矩形的顶点。
// 作法（答案不唯一）：
//   1. 在直线 l 上取一点 O，以 O 为圆心、OA 为半径画弧，交 l 于 B、C；
//   2. 以 C 为圆心、AB 长为半径画弧，与圆交于点 D（在 l 下方）；
//   3. 则四边形 ABDC 为矩形。
// 道理：BC 是圆的直径 ⇒ ∠BAC = ∠BDC = 90°（半圆上的圆周角）
//       O 是 BC 和 AD 的公共中点 ⇒ ABDC 是平行四边形
//       平行四边形 + 直角 = 矩形
// ============================================================

#import "@preview/cetz:0.4.2"

#let arc-stroke = (paint: rgb("#2563EB"), thickness: 0.6pt, dash: (2pt, 1.2pt))
#let answer-stroke = 1pt + rgb("#DC2626")
#let ans-color = rgb("#DC2626")
#let aux-color = rgb("#2563EB")

#let render() = {
  set par(first-line-indent: 0em)
  text(
    size: 11pt,
  )[如图，$A$ 是直线 $l$ 外一点。求作点 $B$、$C$、$D$，其中有两点在直线 $l$ 上，且使得点 $A$、$B$、$C$、$D$ 是一个矩形的四个顶点。（要求：仅用圆规作图，保留作图痕迹）]
  v(1.5em)

  align(center)[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *

      // === 基础参数 ===
      let A = (2, 2.5)
      let O-pt = (3.5, 0) // 在 l 上取的点 O
      let r = calc.sqrt(calc.pow(A.at(0) - O-pt.at(0), 2) + calc.pow(A.at(1), 2))
      // r = sqrt(2.25 + 6.25) = sqrt(8.5) ≈ 2.915

      let l-left = (-0.5, 0)
      let l-right = (7.5, 0)

      // B、C：圆与 l 的交点
      let B = (O-pt.at(0) - r, 0)
      let C = (O-pt.at(0) + r, 0)

      // D：A 关于 O 的对称点（圆上的对径点）
      let D = (2 * O-pt.at(0) - A.at(0), -A.at(1))

      // |AB|：用于弧②的半径
      let AB-len = calc.sqrt(calc.pow(A.at(0) - B.at(0), 2) + calc.pow(A.at(1), 2))

      // === 原图 ===
      line(l-left, l-right, stroke: 1pt)
      content(l-right, text(size: 11pt)[$l$], anchor: "north-west", padding: 0.15)
      circle(A, radius: 1.5pt, fill: black, stroke: none)
      content(A, text(size: 11pt)[$A$], anchor: "south-west", padding: 0.15)

      // === 作图痕迹 ===

      // 弧①：以 O 为圆心、OA 为半径画圆（交 l 于 B、C，经过 A 和 D）
      // 画大弧覆盖 A、B、C、D 四点
      let angle-OA = calc.atan2(A.at(0) - O-pt.at(0), A.at(1))
      let angle-OD = calc.atan2(D.at(0) - O-pt.at(0), D.at(1))
      // 画一个完整的圆
      arc(O-pt, start: 0deg, stop: 365deg, radius: r, stroke: arc-stroke, anchor: "origin")

      // 标记 O 点（辅助点，蓝色）
      circle(O-pt, radius: 1.2pt, fill: aux-color, stroke: none)
      content(O-pt, text(size: 10pt, fill: aux-color)[$O$], anchor: "north-west", padding: 0.15)

      // 弧②：以 C 为圆心、|AB| 为半径画弧，交圆于 D
      let angle-CD = calc.atan2(D.at(0) - C.at(0), D.at(1) - C.at(1))
      arc(C, start: angle-CD - 18deg, stop: angle-CD + 18deg, radius: AB-len, stroke: arc-stroke, anchor: "origin")

      // === 答案 ===
      circle(B, radius: 1.5pt, fill: ans-color, stroke: none)
      content(B, text(size: 11pt, fill: ans-color)[$B$], anchor: "north-east", padding: 0.15)
      circle(C, radius: 1.5pt, fill: ans-color, stroke: none)
      content(C, text(size: 11pt, fill: ans-color)[$C$], anchor: "north-west", padding: 0.15)
      circle(D, radius: 1.5pt, fill: ans-color, stroke: none)
      content(D, text(size: 11pt, fill: ans-color)[$D$], anchor: "north", padding: 0.15)

      // 矩形 ABDC（红色实线）
      line(A, B, stroke: answer-stroke)
      line(B, D, stroke: answer-stroke)
      line(D, C, stroke: answer-stroke)
      line(C, A, stroke: answer-stroke)

      // 直角标记（在 A 处和 D 处）
      let sq = 0.25
      // A 处直角：AB 方向与 AC 方向
      let AB-ux = (B.at(0) - A.at(0)) / AB-len
      let AB-uy = (B.at(1) - A.at(1)) / AB-len
      let AC-len = calc.sqrt(calc.pow(C.at(0) - A.at(0), 2) + calc.pow(A.at(1), 2))
      let AC-ux = (C.at(0) - A.at(0)) / AC-len
      let AC-uy = (C.at(1) - A.at(1)) / AC-len
      let p1-A = (A.at(0) + AB-ux * sq, A.at(1) + AB-uy * sq)
      let p2-A = (A.at(0) + AB-ux * sq + AC-ux * sq, A.at(1) + AB-uy * sq + AC-uy * sq)
      let p3-A = (A.at(0) + AC-ux * sq, A.at(1) + AC-uy * sq)
      line(p1-A, p2-A, p3-A, stroke: 0.5pt + ans-color)
    })
  ]
  v(1em)

  // --- 解答部分 ---
  block(width: 100%, inset: (x: 1em, y: 0.8em), stroke: (left: 2pt + ans-color), fill: rgb(245, 250, 255), radius: 2pt)[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", fill: ans-color, size: 10pt)[【解析与解答】]
    #v(0.3em)
    #set text(size: 10pt)

    （答案不唯一）

    *作法：*
    + 在直线 $l$ 上取一点 $O$，以 $O$ 为圆心、$O A$ 长为半径画弧，交直线 $l$ 于点 $B$、$C$；
    + 以 $C$ 为圆心、$A B$ 长为半径画弧，与圆交于点 $D$（在 $l$ 下方）；
    + 则四边形 $A B D C$ 为矩形。

    *作图道理：*

    因为 $B$、$C$ 在以 $O$ 为圆心的圆上且在直线 $l$ 上，所以 $B C$ 是该圆的直径。

    $A$、$D$ 均在圆上，$B C$ 为直径，由圆周角定理知 $angle B A C = angle B D C = 90 degree$。

    又 $O$ 是 $B C$ 的中点，$D$ 是 $A$ 关于 $O$ 的对称点，因此 $O$ 也是 $A D$ 的中点，即对角线互相平分，故四边形 $A B D C$ 是平行四边形。

    平行四边形中有一个直角 ($angle B A C = 90 degree$)，所以 $A B D C$ 是矩形。
  ]
  v(1.2em)

  // --- 绘图原理与步骤 ---
  block(width: 100%, inset: (x: 1em, y: 0.8em), stroke: (left: 2pt + luma(180)), fill: luma(248), radius: 2pt)[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", size: 10pt)[绘图原理与步骤]
    #v(0.3em)
    #set text(size: 9pt)

    + *取点 O*：在 $l$ 上取 $O = (3.5, 0)$，计算 $r = |O A| approx 2.915$。
    + *弧①*：以 $O$ 为圆心画近完整圆弧（`anchor: "origin"`），交 $l$ 于 $B$、$C$，同时经过 $A$ 和 $D$。
    + *弧②*：计算 $|A B|$，以 $C$ 为圆心、$|A B|$ 为半径画弧，扫过 $D$ 附近区域，与弧①交于 $D = (5, -2.5)$。
    + *矩形*：用蓝色虚线连接 $A$-$B$-$D$-$C$-$A$，并在 $A$ 处标注直角符号。
  ]
}
