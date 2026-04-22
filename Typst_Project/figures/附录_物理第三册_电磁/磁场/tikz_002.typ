// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 磁现象的电本质~~磁性材料
// 原始文件：1.tex，行 167-183
// 类型：tikz   >=latex   scale=0.6
// 描述：磁针在均匀磁场中偏转（N红/S蓝菱形磁针 + 平行磁感线）
#import "@preview/cetz:0.4.2"

#let render() = {
  // scale=0.6 → canvas length: 0.6cm
  cetz.canvas(length: 0.6cm, {
    import cetz.draw: *

    // --- 磁感线组 ---
    // 原始: \foreach \x in {-.5,.5,...,4.5} { \draw[->](-2,\x)--(5,\x); }
    // -.5, .5, 1.5, 2.5, 3.5, 4.5
    for x-val in (-0.5, 0.5, 1.5, 2.5, 3.5, 4.5) {
      line((-2, x-val), (5, x-val), stroke: 0.4pt + black,
        mark: (end: "stealth", fill: black))
    }

    // --- 磁针（菱形，rotate=60°）---
    // 原始: \draw[rotate=60, fill=red](2.5,-.4)--(2.5,.4)--(5,0)
    // 原始: \draw[rotate=60, fill=blue](2.5,-.4)--(2.5,.4)--(0,0)
    // 旋转 60° 的变换：x' = x*cos60 - y*sin60, y' = x*sin60 + y*cos60
    let c60 = calc.cos(60deg)
    let s60 = calc.sin(60deg)
    let rot(px, py) = (px * c60 - py * s60, px * s60 + py * c60)

    // N极（红色）: (2.5,-0.4) → (2.5,0.4) → (5,0)
    let n1 = rot(2.5, -0.4)
    let n2 = rot(2.5, 0.4)
    let n3 = rot(5, 0)
    line(n1, n2, n3, close: true, fill: red, stroke: 0.4pt + black)

    // S极（蓝色）: (2.5,-0.4) → (2.5,0.4) → (0,0)
    let s1 = rot(2.5, -0.4)
    let s2 = rot(2.5, 0.4)
    let s3 = rot(0, 0)
    line(s1, s2, s3, close: true, fill: blue, stroke: 0.4pt + black)

    // 菱形轮廓和中线
    // 原始: \draw[rotate=60](0,0)--(2.5,-.4)--(5,0)--(2.5,.4)--(0,0)
    line(s3, n1, n3, n2, s3, stroke: 0.4pt + black)
    // 原始: \draw[rotate=60](2.5,-.4)--(2.5,.4)
    line(n1, n2, stroke: 0.4pt + black)

    // --- 标签 ---
    // 原始: \node at (0,-.3){$S$}
    content((0, -0.3), text(size: 9pt)[$S$])
    // 原始: \node at (2.8,4){$N$}
    content((2.8, 4), text(size: 9pt)[$N$])
    // 原始: \node at (5.5,2.2){$B$}
    content((5.5, 2.2), text(size: 9pt)[$B$])
  })
}
