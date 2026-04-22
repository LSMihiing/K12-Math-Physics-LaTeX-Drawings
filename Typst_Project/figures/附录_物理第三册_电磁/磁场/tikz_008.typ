// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 磁场对电流的作用力
// 原始文件：1.tex，行 447-467
// 类型：tikz   >=latex   scale=0.8
// 描述：安培力多场景（3组子图）：磁感线+力+电流方向×/·
#import "@preview/cetz:0.4.2"

#let render() = {
  // scale=0.8
  cetz.canvas(length: 0.8cm, {
    import cetz.draw: *

    // ---- 场景1（左）：水平磁感线 + 电流·出纸面 + F向上 ----
    // 原始: \foreach \x in {1,2,3,4} { \draw[->](0,\x)--(4,\x); }
    for y in range(1, 5) {
      line((0, float(y)), (4, float(y)), stroke: 0.4pt + black,
        mark: (end: "stealth", fill: black))
    }
    // F箭头
    // 原始: \draw[->](2,2.5)--(2,3.5)node[right]{$F$}
    line((2, 2.5), (2, 3.5), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((2.3, 3.5), text(size: 9pt)[$F$])
    // B标签
    content((4.5, 2.5), text(size: 9pt)[$B$])
    // 电流·出纸面（白色圆+·）
    circle((2, 2.5), radius: 0.18, fill: white, stroke: 0.4pt + black)

    // ---- 场景2（中）：电流×入纸面 + I和F箭头 ----
    // 原始: \draw[->](6.5,2.5)node[left]{$I$}--(7.5,2.5)node[above]{$F$}
    line((6.5, 2.5), (7.5, 2.5), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((6.1, 2.5), text(size: 9pt)[$I$])
    content((7.5, 2.8), text(size: 9pt)[$F$])
    // 电流×入纸面
    circle((6.5, 2.5), radius: 0.18, fill: white, stroke: 0.4pt + black)
    content((6.5, 2.5), text(size: 8pt)[$times$])

    // ---- 场景3（右）：水平磁感线 + 电流×入纸面 ----
    // 原始: \foreach \y in {1,2,3,4} { \draw[->](9.5,\y)--(13.5,\y); }
    for y in range(1, 5) {
      line((9.5, float(y)), (13.5, float(y)), stroke: 0.4pt + black,
        mark: (end: "stealth", fill: black))
    }
    circle((11.5, 2.5), radius: 0.18, fill: white, stroke: 0.4pt + black)
    content((11.5, 2.5), text(size: 8pt)[$times$])
    content((14, 2.5), text(size: 9pt)[$B$])
    content((11.1, 2.5), text(size: 9pt)[$I$])
  })
}
