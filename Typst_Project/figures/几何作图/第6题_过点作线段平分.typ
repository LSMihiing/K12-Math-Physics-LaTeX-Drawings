// ============================================================
// 第6题 · 尺规作图：过角内一点作线段使 PM = PN
// ============================================================
//
// 题目：P 是 ∠AOB 内的一点，过点 P 作直线 l 交 OA、OB
//       于点 M、N，使得 PM = PN。(尺规作图，保留作图痕迹)
//
// 作法（参考答案）：
//   1. 连接 OP，并延长至点 C，使得 PC = PO；
//   2. 通过画一个角等于已知角，作射线 CM，
//      使得 ∠MCO = ∠COB，交 OA 于点 M；
//   3. 连接 MP，并延长 MP，交 OB 于点 N。
//
// 作图道理：
//   ∠MCO = ∠COB ⇒ CM ∥ OB（内错角相等）
//   在 △MCP 和 △NOP 中：
//     ∠MCP = ∠NOP（平行线内错角）
//     PC = PO（作图）
//     ∠CPM = ∠OPN（对顶角）
//   ∴ △MCP ≅ △NOP（ASA）⇒ PM = PN
// ============================================================

#import "@preview/cetz:0.4.2"

// 线型规范
#let arc-stroke = (paint: rgb("#2563EB"), thickness: 0.6pt, dash: (2pt, 1.2pt)) // 圆规弧（蓝色虚线）
#let answer-stroke = 1pt + rgb("#DC2626")  // 答案/成品线（红色实线）
#let aux-stroke = (paint: luma(140), thickness: 0.5pt, dash: (2pt, 1.2pt)) // 辅助直线（灰色虚线）
#let ans-color = rgb("#DC2626") // 答案点/标签颜色
#let aux-color = rgb("#2563EB") // 辅助点/标签颜色

#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[6. ]
  text(size: 11pt)[如图，$P$ 是 $angle A O B$ 内的一点，过点 $P$ 作直线 $l$ 交 $O A$、$O B$ 于点 $M$、$N$，使得 $P M = P N$。（要求：用直尺和圆规作图，保留作图痕迹，并说明作图的道理）]
  v(1.5em)

  // --- 绘图区域 ---
  align(center)[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *

      // ============================
      // 基础几何参数
      // ============================
      let angle-OA = 60deg      // OA 与 x 轴的夹角
      let O = (0, 0)
      let ray-len = 6.5
      let A-end = (ray-len * calc.cos(angle-OA), ray-len * calc.sin(angle-OA))
      let B-end = (ray-len, 0)
      let P = (3.2, 1.4)

      // ============================
      // 计算辅助点
      // ============================
      // 角 OP 的方向
      let angle-OP = calc.atan2(P.at(0), P.at(1))  // ≈ 23.63°
      let OP-len = calc.sqrt(P.at(0) * P.at(0) + P.at(1) * P.at(1))

      // C = P 关于 P 延长，PC = PO，即 C = 2P - O = 2P
      let C = (2 * P.at(0), 2 * P.at(1))  // (6.4, 2.8)

      // CM ∥ OB（水平），所以 M 在 OA 上且 y = C.y
      // OA: y = x * tan(60°)
      // M.y = C.y ⇒ M.x = C.y / tan(60°)
      let M-x = C.at(1) / calc.tan(angle-OA)
      let M = (M-x, C.at(1))  // ≈ (1.617, 2.8)

      // N: 直线 MP 延长交 OB (y=0)
      // 方向 MP: P - M = (3.2-1.617, 1.4-2.8) = (1.583, -1.4)
      // 参数化: (M.x + t*dx, M.y + t*dy), 令 y=0: t = -M.y / dy = -2.8/(-1.4) = 2
      let dx-MN = P.at(0) - M.at(0)
      let dy-MN = P.at(1) - M.at(1)
      let t-N = -M.at(1) / dy-MN
      let N = (M.at(0) + t-N * dx-MN, 0)  // ≈ (4.783, 0)

      // ============================
      // 1. 原图基础线条（黑色）
      // ============================
      // 射线 OA
      line(O, A-end, stroke: 1pt)
      // 射线 OB
      line(O, B-end, stroke: 1pt)

      // 端点标签
      content(A-end, text(size: 11pt)[$A$], anchor: "south-west", padding: 0.15)
      content(B-end, text(size: 11pt)[$B$], anchor: "north-west", padding: 0.15)
      content(O, text(size: 11pt)[$O$], anchor: "north-east", padding: 0.15)

      // 点 P
      circle(P, radius: 1.5pt, fill: black, stroke: none)
      content(P, text(size: 11pt)[$P$], anchor: "north-west", padding: 0.15)

      // ============================
      // 2. 作图痕迹（蓝色虚线弧）
      // ============================

      // --- 步骤1：以 P 为圆心，PO 为半径画弧，标记点 C ---
      // 弧应当在 C 附近可见（即在 OP 延长线方向上扫过 C 点）
      // C 相对于 P 的方向 = angle-OP（与 OP 同向）
      arc(P, start: angle-OP - 15deg, stop: angle-OP + 15deg, radius: OP-len,
          stroke: arc-stroke, anchor: "origin")

      // 连接 OP 延长至 C（辅助直线，灰色虚线）
      line(O, C, stroke: aux-stroke)
      circle(C, radius: 1.5pt, fill: aux-color, stroke: none)
      content(C, text(size: 11pt, fill: aux-color)[$C$], anchor: "south-west", padding: 0.15)

      // --- 步骤2：复制角 ∠COB 到点 C ---
      // 步骤2a：以 O 为圆心，任意半径 r 画弧，
      //          交 OB 于 D1，交 OC 于 D2
      let r-copy = 1.8
      // D1 在 OB 上（角度 0°），D2 在 OC 方向上（角度 angle-OP）
      let D1 = (r-copy, 0)
      let D2 = (r-copy * calc.cos(angle-OP), r-copy * calc.sin(angle-OP))

      // 画弧：从 OB 方向到 OC 方向，稍微扩展
      arc(O, start: -5deg, stop: angle-OP + 5deg, radius: r-copy,
          stroke: arc-stroke, anchor: "origin")

      // 步骤2b：以 C 为圆心，同样半径 r 画弧，交 CO 方向于 E1
      // CO 方向 = angle-OP + 180°
      let angle-CO = angle-OP + 180deg
      // E1 = C + r-copy * (cos(angle-CO), sin(angle-CO))
      let E1 = (C.at(0) + r-copy * calc.cos(angle-CO),
                C.at(1) + r-copy * calc.sin(angle-CO))

      // CM ∥ OB，所以 CM 方向 = 180°（从 C 向左水平）
      // E2 = C + r-copy * (cos(180°), sin(180°)) = (C.x - r-copy, C.y)
      let E2 = (C.at(0) - r-copy, C.at(1))

      // 弧的扫描范围应从 angle-CO 方向到 180° 方向
      // angle-CO ≈ 203.63°
      // 注意 CeTZ 的弧从 start 逆时针扫到 stop
      // 从 180° 到 angle-CO(≈203.63°)，扫过约 23.63°
      arc(C, start: 180deg - 5deg, stop: angle-CO + 5deg, radius: r-copy,
          stroke: arc-stroke, anchor: "origin")

      // 步骤2c：量取弦长 |D1D2|，以 E1 为圆心画弧
      let chord-len = calc.sqrt(
        calc.pow(D1.at(0) - D2.at(0), 2) + calc.pow(D1.at(1) - D2.at(1), 2)
      )

      // 以 E1 为圆心，chord-len 为半径画弧，交步骤2b的弧于 E2
      // E2 相对于 E1 的方向
      let angle-E1-E2 = calc.atan2(E2.at(0) - E1.at(0), E2.at(1) - E1.at(1))
      arc(E1, start: angle-E1-E2 - 15deg, stop: angle-E1-E2 + 15deg,
          radius: chord-len, stroke: arc-stroke, anchor: "origin")

      // --- 步骤2d：画射线 CM（辅助直线，灰色虚线），交 OA 于点 M ---
      line(C, M, stroke: aux-stroke)
      circle(M, radius: 1.5pt, fill: ans-color, stroke: none)
      content(M, text(size: 11pt, fill: ans-color)[$M$], anchor: "south-east", padding: 0.15)

      // ============================
      // 3. 答案：直线 l (红色实线)
      // ============================
      let ext = 0.3
      let MN-dx = N.at(0) - M.at(0)
      let MN-dy = N.at(1) - M.at(1)
      let MN-len = calc.sqrt(MN-dx * MN-dx + MN-dy * MN-dy)
      let MN-ux = MN-dx / MN-len
      let MN-uy = MN-dy / MN-len
      let M-ext = (M.at(0) - ext * MN-ux, M.at(1) - ext * MN-uy)
      let N-ext = (N.at(0) + ext * MN-ux, N.at(1) + ext * MN-uy)

      line(M-ext, N-ext, stroke: answer-stroke)

      circle(N, radius: 1.5pt, fill: ans-color, stroke: none)
      content(N, text(size: 11pt, fill: ans-color)[$N$], anchor: "north-west", padding: 0.15)
      content(N-ext, text(size: 11pt, fill: ans-color)[$l$], anchor: "north-west", padding: 0.15)
    })
  ]
  v(1em)

  // --- 解答部分 ---
  block(width: 100%, inset: (x: 1em, y: 0.8em), stroke: (left: 2pt + ans-color), fill: rgb(245, 250, 255), radius: 2pt)[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", fill: ans-color, size: 10pt)[【解析与解答】]
    #v(0.3em)
    #set text(size: 10pt)

    *作法：*
    + 连接 $O P$，并延长至点 $C$，使得 $P C = P O$；
    + 通过画一个角等于已知角，作射线 $C M$，使得 $angle M C O = angle C O B$，交 $O A$ 于点 $M$；
    + 连接 $M P$，并延长 $M P$，交 $O B$ 于点 $N$。直线 $M N$（即直线 $l$）即为所求。

    *作图道理：*

    因为 $angle M C O = angle C O B$，所以 $C M parallel O B$（内错角相等，两直线平行）。

    所以 $angle M C P = angle N O P$（两直线平行，内错角相等）。

    在 $triangle M C P$ 和 $triangle N O P$ 中，
    $
    cases(
      angle M C P = angle N O P quad "(已证)",
      P C = P O quad "(作图已知)",
      angle C P M = angle O P N quad "(对顶角相等)"
    )
    $
    所以 $triangle M C P tilde.eq triangle N O P$（ASA）。

    所以 $P M = P N$（全等三角形的对应边相等）。
  ]
  v(1.2em)

  // --- 绘图原理与步骤 ---
  block(width: 100%, inset: (x: 1em, y: 0.8em), stroke: (left: 2pt + luma(180)), fill: luma(248), radius: 2pt)[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", size: 10pt)[绘图原理与步骤]
    #v(0.3em)
    #set text(size: 9pt)

    + *倍长线段（找 C 点）*：以 $P$ 为圆心、$P O$ 为半径画弧，弧与射线 $O P$ 的延长线交于点 $C$，从而 $P C = P O$。弧线在 $C$ 点附近可见。
    + *等角作图（在 O 处取角）*：以 $O$ 为圆心、任意半径 $r$ 画弧，分别交 $O B$ 于 $D_1$，交 $O C$ 于 $D_2$。
    + *等角作图（在 C 处复制角）*：以 $C$ 为圆心、同样半径 $r$ 画弧，交 $C O$ 于 $E_1$；再以 $E_1$ 为圆心、弦长 $|D_1 D_2|$ 为半径画弧，交前一弧于 $E_2$。射线 $C E_2$ 使 $angle M C O = angle C O B$。
    + *连结交点*：$C E_2$ 方向即为水平方向（$C M parallel O B$），交 $O A$ 于 $M$。连接 $M P$ 并延长得直线 $l$，标出与 $O B$ 的交点 $N$。
  ]
}
