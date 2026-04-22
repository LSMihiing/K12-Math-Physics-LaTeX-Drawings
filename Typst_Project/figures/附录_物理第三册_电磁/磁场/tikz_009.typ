// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 磁场对电流的作用力
// 原始文件：1.tex，行 482-492
// 类型：tikz   >=latex   scale=0.7
// 描述：倾斜矩形线圈在均匀磁场中（旋转60°） + 角度标注
#import "@preview/cetz:0.4.2"

#let render() = {
  // scale=0.7
  cetz.canvas(length: 0.7cm, {
    import cetz.draw: *

    // --- 磁感线组 ---
    // 原始: \foreach \x in {-.5,.5,...,4.5} { \draw[->](-2,\x)--(5,\x); }
    for x-val in (-0.5, 0.5, 1.5, 2.5, 3.5, 4.5) {
      line((-2, x-val), (5, x-val), stroke: 0.4pt + black,
        mark: (end: "stealth", fill: black))
    }

    // --- 倾斜矩形线圈 rotate=60° thick ---
    // 原始: \draw[rotate=60, thick](0,0)node[left]{$a$} rectangle (4.5,.2)node[above]{$b$}
    // 旋转变换：x'=x*cos60-y*sin60, y'=x*sin60+y*cos60
    let c60 = calc.cos(60deg)
    let s60 = calc.sin(60deg)
    let rot(px, py) = (px * c60 - py * s60, px * s60 + py * c60)

    let p1 = rot(0, 0)
    let p2 = rot(4.5, 0)
    let p3 = rot(4.5, 0.2)
    let p4 = rot(0, 0.2)
    line(p1, p2, p3, p4, close: true, stroke: 0.8pt + black)

    // 标签 a 在原点左侧，b 在 (4.5, 0.2) 上方
    content((p1.at(0) - 0.3, p1.at(1)), text(size: 9pt)[$a$])
    content((p3.at(0) + 0.1, p3.at(1) + 0.2), text(size: 9pt)[$b$])

    // B标签
    content((5.5, 2.2), text(size: 9pt)[$B$])

    // --- 角度弧 60° ---
    // 原始: \draw (.8,.5) arc (0:60:.5) node[right]{$60°$}
    // 弧起点在 (.8, .5)，TikZ arc(0:60:.5) 从 0° 到 60°，半径 0.5
    // 在 TikZ 中，arc 起点是弧的起点，圆心在 (.8-.5, .5) = (.3, .5)
    arc((0.3, 0.5), start: 0deg, stop: 60deg, radius: 0.5,
      anchor: "origin", stroke: 0.4pt + black)
    content((0.9, 1.05), text(size: 8pt)[$60°$])
  })
}
