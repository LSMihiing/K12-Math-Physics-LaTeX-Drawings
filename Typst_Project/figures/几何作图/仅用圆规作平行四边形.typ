// ============================================================
// 仅用圆规作平行四边形
// ============================================================
// 题目：A 是直线 l 外一点。仅用圆规作点 B、C、D，
//       其中两点在 l 上，使 A、B、D、C 是平行四边形顶点。
// 作法：以 A 为圆心画弧交 l 于 B、C；
//       以 C 为圆心、AB 为半径画弧；以 B 为圆心、AC 为半径画弧；
//       两弧交于 D。四边形 ABDC 为平行四边形。
// ============================================================

#import "@preview/cetz:0.4.2"

#let arc-stroke = (paint: rgb("#2563EB"), thickness: 0.6pt, dash: "dashed")
#let answer-stroke = 1pt + rgb("#DC2626")
#let ans-color = rgb("#DC2626")

#let render() = {
  set par(first-line-indent: 0em)
  text(size: 11pt)[如图，$A$ 是直线 $l$ 外一点。求作点 $B$、$C$、$D$，其中有两点在直线 $l$ 上，且使得点 $A$、$B$、$C$、$D$ 是一个平行四边形的四个顶点。（要求：仅用圆规作图，保留作图痕迹）]
  v(1.5em)

  align(center)[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *

      // === 基础参数 ===
      let A = (3, 2.5)
      let r = 3.2 // 以 A 为圆心的弧半径（> A 到 l 的距离 2.5）
      let l-left = (-0.5, 0)
      let l-right = (6.5, 0)

      // B、C：弧与 l (y=0) 的交点
      let dx = calc.sqrt(r * r - A.at(1) * A.at(1)) // ≈ 1.997
      let B = (A.at(0) - dx, 0) // 左交点
      let C = (A.at(0) + dx, 0) // 右交点

      // D：平行四边形第四顶点 = B + C - A
      let D = (B.at(0) + C.at(0) - A.at(0), -A.at(1)) // (3, -2.5)

      // === 原图 ===
      // 直线 l
      line(l-left, l-right, stroke: 1pt)
      content(l-right, text(size: 11pt)[$l$], anchor: "north-west", padding: 0.15)
      // 点 A
      circle(A, radius: 1.5pt, fill: black, stroke: none)
      content(A, text(size: 11pt)[$A$], anchor: "south-west", padding: 0.15)

      // === 作图痕迹 ===
      // 弧①：以 A 为圆心，半径 r，交 l 于 B、C
      let angle-AB = calc.atan2(B.at(0) - A.at(0), B.at(1) - A.at(1))
      let angle-AC = calc.atan2(C.at(0) - A.at(0), C.at(1) - A.at(1))
      // 从 angle-AC (≈-51°) 逆时针扫到 angle-AB (≈-129°)
      // 等价于从 309° 扫到 231°，要经过 270°，所以用 231°-10° 到 309°+10°
      arc(A, start: angle-AB - 10deg, stop: angle-AC + 10deg,
          radius: r, stroke: arc-stroke, anchor: "origin")

      // 弧②：以 C 为圆心，半径 |AB| = r，在 l 下方扫过 D
      let angle-CD = calc.atan2(D.at(0) - C.at(0), D.at(1) - C.at(1))
      arc(C, start: angle-CD - 18deg, stop: angle-CD + 18deg,
          radius: r, stroke: arc-stroke, anchor: "origin")

      // 弧③：以 B 为圆心，半径 |AC| = r，在 l 下方扫过 D
      let angle-BD = calc.atan2(D.at(0) - B.at(0), D.at(1) - B.at(1))
      arc(B, start: angle-BD - 18deg, stop: angle-BD + 18deg,
          radius: r, stroke: arc-stroke, anchor: "origin")

      // === 答案 ===
      // 标记 B、C、D
      circle(B, radius: 1.5pt, fill: ans-color, stroke: none)
      content(B, text(size: 11pt, fill: ans-color)[$B$], anchor: "north-east", padding: 0.15)
      circle(C, radius: 1.5pt, fill: ans-color, stroke: none)
      content(C, text(size: 11pt, fill: ans-color)[$C$], anchor: "north-west", padding: 0.15)
      circle(D, radius: 1.5pt, fill: ans-color, stroke: none)
      content(D, text(size: 11pt, fill: ans-color)[$D$], anchor: "north", padding: 0.15)

      // 平行四边形 ABDC（红色实线）
      line(A, B, stroke: answer-stroke)
      line(B, D, stroke: answer-stroke)
      line(D, C, stroke: answer-stroke)
      line(C, A, stroke: answer-stroke)
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
    + 以 $A$ 为圆心，以大于 $A$ 到直线 $l$ 距离的长为半径画弧，交直线 $l$ 于点 $B$、$C$；
    + 以 $C$ 为圆心，$A B$ 长为半径画弧；
    + 以 $B$ 为圆心，$A C$ 长为半径画弧；
    + 两弧交于点 $D$，从而四边形 $A B D C$ 为平行四边形。

    *作图道理：*

    由作法知 $|A B| = |C D|$（弧②的半径等于 $|A B|$），$|A C| = |B D|$（弧③的半径等于 $|A C|$）。

    因为两组对边分别相等，所以四边形 $A B D C$ 是平行四边形。

    注：因为 $B$、$C$ 均在以 $A$ 为圆心的同一圆弧上，所以 $|A B| = |A C|$，因此该平行四边形实际上是菱形。
  ]
  v(1.2em)

  // --- 绘图原理与步骤 ---
  block(width: 100%, inset: (x: 1em, y: 0.8em), stroke: (left: 2pt + luma(180)), fill: luma(248), radius: 2pt)[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", size: 10pt)[绘图原理与步骤]
    #v(0.3em)
    #set text(size: 9pt)

    + *弧①*：以 $A = (3, 2.5)$ 为圆心、$r = 3.2$ 为半径画弧（`anchor: "origin"`），弧扫过直线 $l$ ($y = 0$) 的区域，交 $l$ 于 $B$、$C$。
    + *弧②*：以 $C$ 为圆心、$r$ 为半径画弧，在 $l$ 下方扫过 $D$ 点附近 $plus.minus 18 degree$。
    + *弧③*：以 $B$ 为圆心、$r$ 为半径画弧，同样在 $l$ 下方扫过 $D$ 点附近。两弧交点即为 $D = (3, -2.5)$。
    + *平行四边形*：用蓝色虚线连接 $A$-$B$-$D$-$C$-$A$ 展示结果。
  ]
}
