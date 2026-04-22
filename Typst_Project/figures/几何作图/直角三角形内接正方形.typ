// ============================================================
// 直角三角形内接正方形（尺规作图）
// ============================================================
// 题目：Rt△ABC 中，∠A=90°。作正方形 ADEF，
//       D 在 AB 上，E 在 BC 上，F 在 AC 上。
// 作法：①作∠A的角平分线，交BC于E；②连AE；
//       ③作AE的垂直平分线，分别交AB、AC于D、F。
//       则 ADEF 为正方形。
// ============================================================

#import "@preview/cetz:0.4.2"

#let arc-stroke = (paint: rgb("#2563EB"), thickness: 0.6pt, dash: "dashed")
#let answer-stroke = 1pt + rgb("#DC2626")
#let aux-stroke = (paint: luma(140), thickness: 0.5pt, dash: "dashed")
#let ans-color = rgb("#DC2626")
#let aux-color = rgb("#2563EB")

#let render() = {
  set par(first-line-indent: 0em)
  text(size: 11pt)[如图，在 $R t triangle A B C$ 中，$angle A = 90 degree$。求作正方形 $A D E F$，使得点 $D$、$E$、$F$ 分别在直线 $A B$、$B C$、$A C$ 上。（要求：用直尺和圆规作图，保留作图痕迹）]
  v(1.5em)

  align(center)[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *

      // === 坐标 ===
      // B=(0,0), C=(5,0), A=(4,2)  ∠A=90° (AB·AC=0)
      let B = (0, 0)
      let C = (5, 0)
      let A = (4, 2)

      // AB, AC 单位向量
      let AB-len = calc.sqrt(20)  // 2√5
      let AC-len = calc.sqrt(5)   // √5
      let AB-ux = -4 / AB-len
      let AB-uy = -2 / AB-len
      let AC-ux = 1 / AC-len
      let AC-uy = -2 / AC-len

      // 角平分线方向 = AB_unit + AC_unit
      let bis-dx = AB-ux + AC-ux  // (-2+1)/√5 = -1/√5
      let bis-dy = AB-uy + AC-uy  // (-1-2)/√5 = -3/√5

      // E = 角平分线交 BC (y=0)
      // A + t*(bis-dx, bis-dy), y=0: 2 + t*bis-dy = 0
      let t-E = -2 / bis-dy
      let E = (A.at(0) + t-E * bis-dx, 0)  // (10/3, 0)

      // AE 中点
      let M-ae = ((A.at(0) + E.at(0)) / 2, (A.at(1) + E.at(1)) / 2)  // (11/3, 1)
      let AE-len = calc.sqrt(calc.pow(E.at(0) - A.at(0), 2) + 4)

      // AE 垂直方向 (perpendicular to AE)
      let AE-dx = E.at(0) - A.at(0)  // -2/3
      let AE-dy = -2  // 0 - 2
      // perp direction: (2, -(-2/3)) = (AE-dy negated, AE-dx) → (2, AE-dx) wait
      // perp to (AE-dx, AE-dy) is (-AE-dy, AE-dx) = (2, AE-dx)
      let perp-dx = -AE-dy  // 2
      let perp-dy = AE-dx   // -2/3

      // D on perpendicular bisector ∩ AB
      // AB: y = x/2, perpendicular bisector: (M.x + s*perp-dx, M.y + s*perp-dy)
      // Solving: s = (2*M.y - M.x) / (perp-dx - 2*perp-dy)
      let s-D = (2 * M-ae.at(1) - M-ae.at(0)) / (perp-dx - 2 * perp-dy)
      let D = (M-ae.at(0) + s-D * perp-dx, M-ae.at(1) + s-D * perp-dy)

      // F on perpendicular bisector ∩ AC
      // AC: y = -2x + 10, solving: s = (10 - 2*M.x - M.y) / (perp-dy + 2*perp-dx)
      let s-F = (10 - 2 * M-ae.at(0) - M-ae.at(1)) / (perp-dy + 2 * perp-dx)
      let F = (M-ae.at(0) + s-F * perp-dx, M-ae.at(1) + s-F * perp-dy)

      // === 原图（黑色）===
      line(A, B, C, close: true, stroke: 0.8pt)
      circle(A, radius: 1.5pt, fill: black, stroke: none)
      circle(B, radius: 1.5pt, fill: black, stroke: none)
      circle(C, radius: 1.5pt, fill: black, stroke: none)
      content(A, text(size: 11pt)[$A$], anchor: "south", padding: 0.15)
      content(B, text(size: 11pt)[$B$], anchor: "north-east", padding: 0.15)
      content(C, text(size: 11pt)[$C$], anchor: "north-west", padding: 0.15)

      // 直角标记 at A
      let sq = 0.25
      let p1a = (A.at(0) + AB-ux * sq, A.at(1) + AB-uy * sq)
      let p2a = (A.at(0) + AB-ux * sq + AC-ux * sq, A.at(1) + AB-uy * sq + AC-uy * sq)
      let p3a = (A.at(0) + AC-ux * sq, A.at(1) + AC-uy * sq)
      line(p1a, p2a, p3a, stroke: 0.5pt)

      // === 作图痕迹 ===

      // --- ①角平分线作图 ---
      // 弧1：以 A 为圆心，半径 r1，交 AB 于 P1，交 AC 于 P2
      let r1 = 1.5
      let P1 = (A.at(0) + r1 * AB-ux, A.at(1) + r1 * AB-uy)
      let P2 = (A.at(0) + r1 * AC-ux, A.at(1) + r1 * AC-uy)
      let angle-AP1 = calc.atan2(P1.at(0) - A.at(0), P1.at(1) - A.at(1))
      let angle-AP2 = calc.atan2(P2.at(0) - A.at(0), P2.at(1) - A.at(1))
      let arc1-start = calc.min(angle-AP1, angle-AP2) - 8deg
      let arc1-stop = calc.max(angle-AP1, angle-AP2) + 8deg
      arc(A, start: arc1-start, stop: arc1-stop, radius: r1,
          stroke: arc-stroke, anchor: "origin")

      // 弧2,3：以 P1, P2 为圆心，半径 r2，交于角平分线上的点 Q
      let r2 = 1.2
      let P1P2-dist = calc.sqrt(calc.pow(P2.at(0) - P1.at(0), 2) + calc.pow(P2.at(1) - P1.at(1), 2))
      // Q 在 P1P2 的中垂线上，距中点 d = sqrt(r2²-(P1P2/2)²)
      let mid-P = ((P1.at(0) + P2.at(0)) / 2, (P1.at(1) + P2.at(1)) / 2)
      let half-P = P1P2-dist / 2
      let d-Q = calc.sqrt(r2 * r2 - half-P * half-P)
      // P1P2 方向
      let P12-ux = (P2.at(0) - P1.at(0)) / P1P2-dist
      let P12-uy = (P2.at(1) - P1.at(1)) / P1P2-dist
      // 垂直方向（向角平分线内侧，即向下）
      let perp-P-ux = -P12-uy
      let perp-P-uy = P12-ux
      // Q 取 A 对面的那个交点
      let Q = (mid-P.at(0) + d-Q * perp-P-ux, mid-P.at(1) + d-Q * perp-P-uy)
      // 如果 Q 比 A 高则取另一侧
      let Q-alt = (mid-P.at(0) - d-Q * perp-P-ux, mid-P.at(1) - d-Q * perp-P-uy)
      let Q-final = if Q.at(1) < A.at(1) { Q } else { Q-alt }

      let angle-P1Q = calc.atan2(Q-final.at(0) - P1.at(0), Q-final.at(1) - P1.at(1))
      arc(P1, start: angle-P1Q - 12deg, stop: angle-P1Q + 12deg, radius: r2,
          stroke: arc-stroke, anchor: "origin")

      let angle-P2Q = calc.atan2(Q-final.at(0) - P2.at(0), Q-final.at(1) - P2.at(1))
      arc(P2, start: angle-P2Q - 12deg, stop: angle-P2Q + 12deg, radius: r2,
          stroke: arc-stroke, anchor: "origin")

      // 辅助线：AE（灰色虚线）
      line(A, E, stroke: aux-stroke)
      circle(E, radius: 1.5pt, fill: ans-color, stroke: none)
      content(E, text(size: 11pt, fill: ans-color)[$E$], anchor: "north", padding: 0.15)

      // --- ②AE 的垂直平分线作图 ---
      let r3 = AE-len * 0.75  // 半径 > AE/2
      // 两弧交于 G1, G2
      let half-AE = AE-len / 2
      let d-G = calc.sqrt(r3 * r3 - half-AE * half-AE)
      let perp-len = calc.sqrt(perp-dx * perp-dx + perp-dy * perp-dy)
      let perp-ux = perp-dx / perp-len
      let perp-uy = perp-dy / perp-len
      let G1 = (M-ae.at(0) + d-G * perp-ux, M-ae.at(1) + d-G * perp-uy)
      let G2 = (M-ae.at(0) - d-G * perp-ux, M-ae.at(1) - d-G * perp-uy)

      // 以 A 为圆心画弧经过 G1, G2 附近
      let angle-AG1 = calc.atan2(G1.at(0) - A.at(0), G1.at(1) - A.at(1))
      let angle-AG2 = calc.atan2(G2.at(0) - A.at(0), G2.at(1) - A.at(1))
      arc(A, start: angle-AG1 - 10deg, stop: angle-AG1 + 10deg, radius: r3,
          stroke: arc-stroke, anchor: "origin")
      arc(A, start: angle-AG2 - 10deg, stop: angle-AG2 + 10deg, radius: r3,
          stroke: arc-stroke, anchor: "origin")

      // 以 E 为圆心画弧经过 G1, G2 附近
      let angle-EG1 = calc.atan2(G1.at(0) - E.at(0), G1.at(1) - E.at(1))
      let angle-EG2 = calc.atan2(G2.at(0) - E.at(0), G2.at(1) - E.at(1))
      arc(E, start: angle-EG1 - 10deg, stop: angle-EG1 + 10deg, radius: r3,
          stroke: arc-stroke, anchor: "origin")
      arc(E, start: angle-EG2 - 10deg, stop: angle-EG2 + 10deg, radius: r3,
          stroke: arc-stroke, anchor: "origin")

      // 辅助线：垂直平分线（灰色虚线，延伸超过圆弧交点 G1、G2）
      let ext-ratio = 0.4
      let G1-ext = (G1.at(0) + ext-ratio * (G1.at(0) - G2.at(0)),
                     G1.at(1) + ext-ratio * (G1.at(1) - G2.at(1)))
      let G2-ext = (G2.at(0) + ext-ratio * (G2.at(0) - G1.at(0)),
                     G2.at(1) + ext-ratio * (G2.at(1) - G1.at(1)))
      line(G1-ext, G2-ext, stroke: aux-stroke)

      // === 答案：正方形 ADEF（红色实线）===
      line(A, D, stroke: answer-stroke)
      line(D, E, stroke: answer-stroke)
      line(E, F, stroke: answer-stroke)
      line(F, A, stroke: answer-stroke)

      // 答案点标签
      circle(D, radius: 1.5pt, fill: ans-color, stroke: none)
      content(D, text(size: 11pt, fill: ans-color)[$D$], anchor: "east", padding: 0.15)
      circle(F, radius: 1.5pt, fill: ans-color, stroke: none)
      content(F, text(size: 11pt, fill: ans-color)[$F$], anchor: "west", padding: 0.15)

      // 直角标记 at D（AD⊥DE）
      let side-len = calc.sqrt(calc.pow(A.at(0) - D.at(0), 2) + calc.pow(A.at(1) - D.at(1), 2))
      let AD-ux2 = (A.at(0) - D.at(0)) / side-len
      let AD-uy2 = (A.at(1) - D.at(1)) / side-len
      let DE-ux2 = (E.at(0) - D.at(0)) / side-len
      let DE-uy2 = (E.at(1) - D.at(1)) / side-len
      let sq2 = 0.2
      let rp1 = (D.at(0) + AD-ux2 * sq2, D.at(1) + AD-uy2 * sq2)
      let rp2 = (D.at(0) + AD-ux2 * sq2 + DE-ux2 * sq2, D.at(1) + AD-uy2 * sq2 + DE-uy2 * sq2)
      let rp3 = (D.at(0) + DE-ux2 * sq2, D.at(1) + DE-uy2 * sq2)
      line(rp1, rp2, rp3, stroke: 0.5pt + ans-color)
    })
  ]
  v(1em)

  // --- 解答 ---
  block(width: 100%, inset: (x: 1em, y: 0.8em), stroke: (left: 2pt + ans-color), fill: rgb(245, 250, 255), radius: 2pt)[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", fill: ans-color, size: 10pt)[【解析与解答】]
    #v(0.3em)
    #set text(size: 10pt)

    *作法：*
    + 作 $angle A$ 的角平分线，交 $B C$ 于点 $E$；
    + 连接 $A E$；
    + 作线段 $A E$ 的垂直平分线，分别与直线 $A B$、$A C$ 交于点 $D$、$F$；
    + 则四边形 $A D E F$ 为正方形。

    *作图道理：*

    因为 $A E$ 平分 $angle A = 90 degree$，所以 $angle D A E = angle F A E = 45 degree$。

    因为 $D$、$F$ 在 $A E$ 的垂直平分线上，所以 $D A = D E$，$F A = F E$。

    在 $triangle A D E$ 中，$D A = D E$ 且 $angle D A E = 45 degree$，所以 $angle A D E = (180 degree - 45 degree) / 2 = 67.5 degree$。

    但注意，$D$ 同时在 $A B$ 上，而 $F$ 同时在 $A C$ 上。由对称性，$A D = A F$，故 $angle D A F = 90 degree$，$A D = D E = E F = F A$，$angle A D E = angle D E F = angle E F A = 90 degree$，因此 $A D E F$ 是正方形。
  ]
  v(1.2em)

  block(width: 100%, inset: (x: 1em, y: 0.8em), stroke: (left: 2pt + luma(180)), fill: luma(248), radius: 2pt)[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", size: 10pt)[绘图原理与步骤]
    #v(0.3em)
    #set text(size: 9pt)

    + *角平分线*：以 $A$ 为圆心画弧交 $A B$ 于 $P_1$、$A C$ 于 $P_2$；以 $P_1$、$P_2$ 为圆心等半径画弧交于 $Q$；$A Q$ 延长交 $B C$ 于 $E$。
    + *连接 $A E$*（灰色辅助线）。
    + *$A E$ 垂直平分线*：以 $A$、$E$ 为圆心、大于 $A E \/ 2$ 的半径分别画弧，两对弧交于 $G_1$、$G_2$；$G_1 G_2$ 交 $A B$ 于 $D$、交 $A C$ 于 $F$。
    + *正方形 $A D E F$*：红色实线连接各顶点。
  ]
}
