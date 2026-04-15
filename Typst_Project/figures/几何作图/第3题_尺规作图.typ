// ============================================================
// 第3题 · 尺规作图（保留作图痕迹）
// ============================================================
//
// 题目：尺规作图（不写作法，保留作图痕迹）。
//  (1) 在图①中，作线段 AB 的垂直平分线 MN；
//  (2) 在图②③中，过点 P 作直线 l 的垂线 PH；
//  (3) 在图④中，作 △ABC 的边 BC 上的高 AH，垂足为 H。
//
// 绘图原理与步骤：
// ────────────────
// (1) 垂直平分线 MN：
//     ① 以 A 为圆心、大于 AB/2 的半径画弧，在 AB 两侧各得一个交点区域；
//     ② 以 B 为同样半径画弧，两弧在 AB 上下方各交于一点 M、N；
//     ③ 连接 MN 即为 AB 的垂直平分线。
//     绘图中用虚线弧表示作图痕迹，实线绘制结果线 MN。
//
// (2a) 点在直线上（图②）：P 在 l 上
//     ① 以 P 为圆心、任意半径画弧，交 l 于 C、D 两点；
//     ② 分别以 C、D 为圆心、大于 CD/2 的半径画弧，交于 l 上方一点 H；
//     ③ 连接 PH 即为过 P 的垂线。
//
// (2b) 点在直线外（图③）：P 在 l 外
//     ① 以 P 为圆心、适当半径画弧，交 l 于 C、D 两点；
//     ② 分别以 C、D 为圆心、大于 CD/2 的半径画弧，在 l 另一侧交于一点 E；
//     ③ 连接 PE 交 l 于 H，PH 即为垂线。
//
// (3) 三角形的高 AH：
//     ① 以 A 为圆心、适当半径画弧，交 BC 于 C'、D' 两点；
//     ② 分别以 C'、D' 为圆心、大于 C'D'/2 的半径画弧，在 BC 另一侧交于一点 E；
//     ③ 连接 AE 交 BC 于 H，AH 即为三角形的高，H 为垂足。
// ────────────────

#import "@preview/cetz:0.4.2"
#import "../../lib/grid-utils.typ": dot-label

// ==========================================
// 公共参数
// ==========================================
// 线段/直线的主色
#let main-stroke = 0.8pt + black
// 作图痕迹（弧线）的样式
#let arc-stroke = (paint: rgb("#2563EB"), thickness: 0.6pt, dash: "dashed")
// 答案线（垂直平分线/垂线）的样式
#let answer-stroke = 1pt + rgb("#DC2626")
// 端点圆点
#let dot-radius = 1.8pt
// 垂直标记尺寸
#let sq-size = 0.25

// ==========================================
// 辅助函数：绘制直角标记
// ==========================================
// foot: 垂足坐标, dir1/dir2: 两个方向的单位向量分量
#let draw-right-angle(foot, d1, d2, s: 0.25) = {
  import cetz.draw: *
  let (fx, fy) = foot
  let p1 = (fx + d1.at(0) * s, fy + d1.at(1) * s)
  let p2 = (fx + d1.at(0) * s + d2.at(0) * s, fy + d1.at(1) * s + d2.at(1) * s)
  let p3 = (fx + d2.at(0) * s, fy + d2.at(1) * s)
  line(p1, p2, p3, stroke: 0.5pt + black)
}


// ==========================================
// 图①：线段 AB 的垂直平分线 MN
// ==========================================
#let figure-1 = cetz.canvas(length: 0.6cm, {
  import cetz.draw: *

  // --- 线段 AB ---
  // A = (0, 0), B = (4, 0)，线段长 4 单位
  let A = (0, 0)
  let B = (4, 0)
  // 中点 O = (2, 0)
  let O = (2, 0)

  // 弧的半径 r > AB/2 = 2，取 r = 2.8
  let r = 2.8

  // 两弧交点 M（上）和 N（下）
  // 交点的 x = 2（中点），y = ±sqrt(r² - 2²) = ±sqrt(7.84 - 4) = ±sqrt(3.84) ≈ ±1.96
  let dy = calc.sqrt(r * r - 4)
  let M = (2, dy) // 上交点
  let N = (2, -dy) // 下交点

  // --- 绘制线段 AB（带端点标记） ---
  line(A, B, stroke: main-stroke)
  // 端点加粗点
  circle(A, radius: dot-radius, fill: black, stroke: none)
  circle(B, radius: dot-radius, fill: black, stroke: none)

  // --- 作图痕迹：以 A 为圆心的弧 ---
  // 弧角度范围：从 A 出发，半径 r，与垂直平分线交于 M、N
  // A 到 M 的角度 = atan2(dy, 2) ≈ 44.4°
  // A 到 N 的角度 = atan2(-dy, 2) ≈ -44.4°
  // 画弧范围稍大于交点角度
  let angle-AM = calc.atan2(2, dy) // 注意 atan2(x,y) 在 typst 中
  arc(A, start: -angle-AM - 8deg, stop: angle-AM + 8deg, radius: r, stroke: arc-stroke, anchor: "origin")

  // --- 作图痕迹：以 B 为圆心的弧 ---
  // B 到 M 的角度 = atan2(-2, dy)，即 180° - angle-AM
  let angle-BM = 180deg - angle-AM
  arc(B, start: angle-BM - 8deg, stop: -angle-BM + 8deg + 360deg, radius: r, stroke: arc-stroke, anchor: "origin")

  // --- 垂直平分线 MN（答案线） ---
  // 延伸 M、N 稍长
  let ext = 0.4
  let M-ext = (2, dy + ext)
  let N-ext = (2, -dy - ext)
  line(M-ext, N-ext, stroke: answer-stroke)

  // --- 交点标记 ---
  circle(M, radius: 1.5pt, fill: rgb("#DC2626"), stroke: none)
  circle(N, radius: 1.5pt, fill: rgb("#DC2626"), stroke: none)

  // --- 直角标记 ---
  draw-right-angle(O, (1, 0), (0, 1))

  // --- 标签 ---
  dot-label(A, $A$, dir: "sw", text-size: 9pt)
  dot-label(B, $B$, dir: "se", text-size: 9pt)
  dot-label(M-ext, $M$, dir: "n", text-size: 9pt)
  dot-label(N-ext, $N$, dir: "s", text-size: 9pt)

  // --- 图号 ---
  content((2, -dy - ext - 1.0))[#text(size: 9pt)[①]]
})


// ==========================================
// 图②：P 在直线 l 上，过 P 作垂线 PH
// ==========================================
#let figure-2 = cetz.canvas(length: 0.6cm, {
  import cetz.draw: *

  // --- 直线 l：水平线，P 在线上 ---
  // 直线 l 从 (-0.5, 0) 到 (5.5, 0)
  // P = (2, 0)
  let P = (2, 0)

  // 以 P 为圆心画弧交 l 于 C、D
  let r1 = 1.5
  let C = (P.at(0) - r1, 0) // (0.5, 0)
  let D = (P.at(0) + r1, 0) // (3.5, 0)

  // 以 C、D 为圆心、半径 r2 > CD/2 画弧，交于上方 H
  let r2 = 2.2
  // H 的坐标：x = 2（中点），y = sqrt(r2² - r1²)
  let hy = calc.sqrt(r2 * r2 - r1 * r1)
  let H = (2, hy)

  // --- 绘制直线 l ---
  line((-0.5, 0), (5.5, 0), stroke: main-stroke)
  // 直线末端标记 l
  content((5.8, 0))[#text(size: 9pt)[$l$]]

  // P 端点
  circle(P, radius: dot-radius, fill: black, stroke: none)

  // --- 作图痕迹：以 P 为圆心画弧（交 l 于 C、D） ---
  arc(P, start: -30deg, stop: 30deg + 180deg, radius: r1, stroke: arc-stroke, anchor: "origin")

  // --- 作图痕迹：以 C 为圆心画弧 ---
  // C 到 H 的角度 = atan2(hy, 1.5)
  let angle-CH = calc.atan2(r1, hy)
  arc(C, start: angle-CH - 15deg, stop: angle-CH + 15deg, radius: r2, stroke: arc-stroke, anchor: "origin")

  // --- 作图痕迹：以 D 为圆心画弧 ---
  let angle-DH = 180deg - angle-CH
  arc(D, start: angle-DH - 15deg, stop: angle-DH + 15deg, radius: r2, stroke: arc-stroke, anchor: "origin")

  // --- 垂线 PH（答案线，延伸） ---
  let H-ext = (2, hy + 0.4)
  line(P, H-ext, stroke: answer-stroke)

  // --- 交点 ---
  circle(H, radius: 1.5pt, fill: rgb("#DC2626"), stroke: none)

  // --- 直角标记 ---
  draw-right-angle(P, (1, 0), (0, 1))

  // --- 标签 ---
  dot-label(P, $P$, dir: "sw", text-size: 9pt)
  dot-label(H-ext, $H$, dir: "n", text-size: 9pt)

  // --- 图号 ---
  content((2.5, -1.0))[#text(size: 9pt)[②]]
})


// ==========================================
// 图③：P 在直线 l 外（下方），过 P 作垂线 PH
// ==========================================
#let figure-3 = cetz.canvas(length: 0.6cm, {
  import cetz.draw: *

  // --- 直线 l：水平线在上方，P 在下方 ---
  // 直线 l 位于 y = 2.5 处
  // P = (3, 0)
  let ly = 2.5
  let P = (3, 0)

  // 以 P 为圆心、适当半径画弧交 l 于 C、D
  // r1 需大于 P 到 l 的距离 = 2.5
  let r1 = 3.2
  // C、D 在 l 上：y = ly, 距离 P 为 r1
  // (x - 3)² + (2.5)² = r1² => (x-3)² = r1² - 6.25
  let dx-cd = calc.sqrt(r1 * r1 - ly * ly)
  let C-pt = (P.at(0) - dx-cd, ly)
  let D-pt = (P.at(0) + dx-cd, ly)

  // 以 C、D 为圆心、半径 r2 画弧，在 l 上方交于 E
  let r2 = 2.5
  let r2-real = calc.max(r2, dx-cd + 0.5)
  let ey-offset = calc.sqrt(r2-real * r2-real - dx-cd * dx-cd)
  let E = (3, ly + ey-offset)

  // H = PE 与 l 的交点 = (3, ly)
  let H = (3, ly)

  // --- 绘制直线 l ---
  line((-0.5, ly), (7, ly), stroke: main-stroke)
  content((7.3, ly))[#text(size: 9pt)[$l$]]

  // --- P 端点 ---
  circle(P, radius: dot-radius, fill: black, stroke: none)

  // --- 作图痕迹：以 P 为圆心画弧（交 l 于 C、D） ---
  // 弧的角度范围需要足够大，使弧明显穿过直线 l
  let angle-PC = calc.atan2(-dx-cd, ly)
  let angle-PD = calc.atan2(dx-cd, ly)
  // 扩大弧的范围，使弧在 l 的上下两侧均可见
  arc(P, start: angle-PC + 20deg, stop: angle-PD - 20deg, radius: r1, stroke: arc-stroke, anchor: "origin")

  // --- 作图痕迹：以 C 为圆心画弧 ---
  let angle-CE = calc.atan2(3 - C-pt.at(0), E.at(1) - ly)
  arc(C-pt, start: angle-CE - 15deg, stop: angle-CE + 15deg, radius: r2-real, stroke: arc-stroke, anchor: "origin")

  // --- 作图痕迹：以 D 为圆心画弧 ---
  let angle-DE = 180deg - angle-CE
  arc(D-pt, start: angle-DE - 15deg, stop: angle-DE + 15deg, radius: r2-real, stroke: arc-stroke, anchor: "origin")

  // --- 垂线 PH（答案线，延伸过 l） ---
  line(P, (3, ly + 0.6), stroke: answer-stroke)

  // --- 交点标记 ---
  circle(H, radius: 1.5pt, fill: rgb("#DC2626"), stroke: none)
  circle(E, radius: 1.5pt, fill: rgb("#2563EB"), stroke: none)

  // --- 直角标记 ---
  draw-right-angle(H, (1, 0), (0, -1))

  // --- 标签 ---
  content((P.at(0) + 0.3, P.at(1) - 0.))[#text(size: 9pt)[$P$]]
  dot-label(H, $H$, dir: "sw", text-size: 9pt)

  // --- 图号 ---
  content((3, -0.8))[#text(size: 9pt)[③]]
})


// ==========================================
// 图④：△ABC 中作 BC 上的高 AH
// 作图思路与图③相同：A 为直线 BC 外一点，过 A 作 BC 的垂线
// ==========================================
#let figure-4 = cetz.canvas(length: 0.6cm, {
  import cetz.draw: *

  // --- 三角形 ABC ---
  // 参考原图比例：A 在左下，B 在右下，C 在上方偏右
  let A = (0, 0)
  let B = (4, 0)
  let C = (3, 3.5)

  // ——— 计算垂足 H ———
  // 直线 BC 方向向量 d = C - B = (-1, 3.5)
  let dx-bc = C.at(0) - B.at(0) // -1
  let dy-bc = C.at(1) - B.at(1) // 3.5
  let bc-len2 = dx-bc * dx-bc + dy-bc * dy-bc // 13.25
  let bc-len = calc.sqrt(bc-len2)
  // H = B + t*(C-B)，其中 t = dot(A-B, d) / |d|²
  // A-B = (-4, 0)
  let t-param = (((A.at(0) - B.at(0)) * dx-bc + (A.at(1) - B.at(1)) * dy-bc) / bc-len2)
  let Hx = B.at(0) + t-param * dx-bc
  let Hy = B.at(1) + t-param * dy-bc
  let H = (Hx, Hy)

  // A 到直线 BC 的距离
  let ah-dist = calc.sqrt((A.at(0) - Hx) * (A.at(0) - Hx) + (A.at(1) - Hy) * (A.at(1) - Hy))

  // ——— BC 方向 / 法向量归一化 ———
  let bc-ux = dx-bc / bc-len
  let bc-uy = dy-bc / bc-len
  // 法向量（指向 A 一侧）
  let raw-nx = -bc-uy //  即 -3.5/|BC|
  let raw-ny = bc-ux //  即 -1/|BC|
  // 检查法向量朝向 A
  let check-dot = raw-nx * (A.at(0) - Hx) + raw-ny * (A.at(1) - Hy)
  let (n-ax, n-ay) = if check-dot >= 0 { (raw-nx, raw-ny) } else { (-raw-nx, -raw-ny) }
  // E 侧法向量（与 A 反向）
  let (n-ex, n-ey) = (-n-ax, -n-ay)

  // ——— 绘制三角形 ———
  line(A, B, C, close: true, stroke: main-stroke)
  circle(A, radius: dot-radius, fill: black, stroke: none)
  circle(B, radius: dot-radius, fill: black, stroke: none)
  circle(C, radius: dot-radius, fill: black, stroke: none)

  // ——— CB 延长线（虚线）———
  let ext-len = 2 // 延长 1.8 个单位
  let ext-end = (B.at(0) - bc-ux * ext-len, B.at(1) - bc-uy * ext-len)
  line(B, ext-end, stroke: (paint: luma(140), thickness: 0.5pt, dash: "dashed"))

  // ——— 作图痕迹 ① 以 A 为圆心画弧交直线 BC 于 C'、D' ———
  let r1 = ah-dist + 0.9 // r1 > A 到 BC 的距离
  // 弧与直线 BC 的交点，沿 BC 方向偏移量
  let offset-along = calc.sqrt(r1 * r1 - ah-dist * ah-dist)
  // C' = H + offset_along * bc_unit
  let Cp = (Hx + offset-along * bc-ux, Hy + offset-along * bc-uy)
  // D' = H - offset_along * bc_unit
  let Dp = (Hx - offset-along * bc-ux, Hy - offset-along * bc-uy)

  // 以 A 为圆心画弧（角度范围覆盖 C'、D'，稍扩大使弧穿过 BC）
  let angle-ACp = calc.atan2(Cp.at(0) - A.at(0), Cp.at(1) - A.at(1))
  let angle-ADp = calc.atan2(Dp.at(0) - A.at(0), Dp.at(1) - A.at(1))
  let arc-start-4 = calc.min(angle-ACp, angle-ADp)
  let arc-stop-4 = calc.max(angle-ACp, angle-ADp)
  arc(A, start: arc-start-4 - 10deg, stop: arc-stop-4 + 10deg, radius: r1, stroke: arc-stroke, anchor: "origin")

  // ——— 作图痕迹 ② 以 C'、D' 为圆心画弧交于 E（BC 的另一侧） ———
  let cd-half = offset-along // C'D' 半长
  let r2 = cd-half + 0.5 // r2 > C'D'/2
  let e-offset = calc.sqrt(r2 * r2 - cd-half * cd-half)
  let E-pt = (Hx + n-ex * e-offset, Hy + n-ey * e-offset)

  // 以 C' 为圆心画弧
  let angle-CE = calc.atan2(E-pt.at(0) - Cp.at(0), E-pt.at(1) - Cp.at(1))
  arc(Cp, start: angle-CE - 18deg, stop: angle-CE + 18deg, radius: r2, stroke: arc-stroke, anchor: "origin")

  // 以 D' 为圆心画弧
  let angle-DE = calc.atan2(E-pt.at(0) - Dp.at(0), E-pt.at(1) - Dp.at(1))
  arc(Dp, start: angle-DE - 18deg, stop: angle-DE + 18deg, radius: r2, stroke: arc-stroke, anchor: "origin")

  // ——— 高 AH（红色答案线） ———
  line(A, H, stroke: answer-stroke)

  // ——— 垂足标记 ———
  circle(H, radius: 1.5pt, fill: rgb("#DC2626"), stroke: none)

  // ——— 直角标记（在 H 处） ———
  draw-right-angle(H, (bc-ux, bc-uy), (n-ax, n-ay), s: 0.3)

  // ——— 辅助虚线：从 H 到 E ———
  line(H, E-pt, stroke: (paint: luma(160), thickness: 0.4pt, dash: "dashed"))

  // --- 标签 ---
  dot-label(A, $A$, dir: "sw", text-size: 9pt)
  dot-label(B, $B$, dir: "se", text-size: 9pt)
  dot-label(C, $C$, dir: "n", text-size: 9pt)
  dot-label(H, $H$, dir: "se", text-size: 9pt)

  // --- 图号 ---
  content((2, -1.0))[#text(size: 9pt)[④]]
})


// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[3.]
  text(size: 11pt)[（1）尺规作图（不写作法，保留作图痕迹）。]

  v(0.3em)
  h(2em)
  text[（1）在图①中，作线段 $A B$ 的垂直平分线 $M N$；]

  v(0.2em)
  h(2em)
  text[（2）在图②③中，过点 $P$ 作直线 $l$ 的垂线 $P H$；]

  v(0.2em)
  h(2em)
  text[（3）在图④中，作 $triangle A B C$ 的边 $B C$ 上的高 $A H$，垂足为 $H$。]

  v(1em)

  // --- 四个图排列（两行两列） ---
  align(center)[
    #grid(
      columns: (auto, auto),
      column-gutter: 2em,
      row-gutter: 1.5em,
      figure-1, figure-2,
      figure-3, figure-4,
    )
    #v(0.2em)
    #text(size: 9pt, fill: luma(100))[（第 3 题）]
  ]

  v(1em)

  // --- 解答说明 ---
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
    以 $A$、$B$ 为圆心，以大于 $1/2 A B$ 的长为半径分别画弧，两弧在 $A B$ 两侧各交于一点 $M$、$N$，连接 $M N$ 即为 $A B$ 的垂直平分线。

    #v(0.3em)
    #text(weight: "bold")[(2)]
    *图②*（$P$ 在 $l$ 上）：以 $P$ 为圆心、任意长为半径画弧交 $l$ 于 $C$、$D$ 两点，再分别以 $C$、$D$ 为圆心、大于 $1/2 C D$ 的长为半径画弧，交于一点 $H$，连接 $P H$ 即为过 $P$ 的垂线。

    *图③*（$P$ 在 $l$ 外）：以 $P$ 为圆心、适当长为半径画弧交 $l$ 于 $C$、$D$ 两点，再分别以 $C$、$D$ 为圆心、大于 $1/2 C D$ 的长为半径画弧交于 $l$ 另一侧一点 $E$，连接 $P E$ 交 $l$ 于 $H$，$P H$ 即为垂线。

    #v(0.3em)
    #text(weight: "bold")[(3)]
    以 $A$ 为圆心、适当长为半径画弧交 $B C$ 于 $C'$、$D'$ 两点，再以 $C'$、$D'$ 为圆心、大于 $1/2 C' D'$ 的长为半径画弧交于 $B C$ 另一侧一点 $E$，连接 $A E$ 交 $B C$ 于 $H$，$A H$ 即为 $triangle A B C$ 的高，$H$ 为垂足。
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

    #text(weight: "bold")[图①：垂直平分线 MN]
    #v(0.2em)
    - 坐标：$A = (0,0)$，$B = (4,0)$，中点 $O = (2,0)$。
    - 弧半径 $r = 2.8 > A B\/2 = 2$。
    - 两弧交点 $M$、$N$ 的 $y$ 坐标为 $plus.minus sqrt(r^2 - 2^2) approx plus.minus 1.96$。
    - 以 $A$、$B$ 为圆心分别绘制虚线弧，连接交点得红色实线 $M N$。
    - 在 $O$ 处绘制直角标记。

    #v(0.4em)
    #text(weight: "bold")[图②：P 在 l 上作垂线]
    #v(0.2em)
    - 直线 $l$ 水平，$P = (2, 0)$ 在 $l$ 上。
    - 以 $P$ 为圆心、$r_1 = 1.5$ 画弧交 $l$ 于 $C(0.5, 0)$、$D(3.5, 0)$。
    - 以 $C$、$D$ 为圆心、$r_2 = 2.2$ 画弧交于 $H(2, sqrt(r_2^2 - r_1^2))$。
    - 连接 $P H$ 得垂线，绘制直角标记。

    #v(0.4em)
    #text(weight: "bold")[图③：P 在 l 外作垂线]
    #v(0.2em)
    - 直线 $l$ 位于 $y = 2.5$，$P = (3, 0)$ 在 $l$ 下方。
    - 以 $P$ 为圆心、$r_1 = 3.2$ 画弧交 $l$ 于 $C$、$D$。
    - 以 $C$、$D$ 为圆心画弧，交于 $l$ 上方 $E$。
    - 连接 $P E$ 交 $l$ 于 $H(3, 2.5)$，得垂线 $P H$。

    #v(0.4em)
    #text(weight: "bold")[图④：三角形的高 AH]
    #v(0.2em)
    - $A = (0,0)$，$B = (4,0)$，$C = (3, 3.5)$。
    - $H$ 为 $A$ 在 $B C$ 上的垂足，由 $arrow(A H) perp arrow(B C)$ 解得参数 $t = 4\/13.25$。
    - 以 $A$ 为圆心画弧交 $B C$ 于 $C'$、$D'$，再以 $C'$、$D'$ 为圆心画弧交于 $E$。
    - 连接 $A H$ 得红色高线，$H$ 处绘制直角标记。
  ]
}
