// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 磁场对电流的作用力
// 原始文件：1.tex，行 412-423
// 类型：tikz   >=latex   无缩放
// 描述：两根平行载流导线（ab）+ 椭圆虚线环 + 安培力F2（反向）
#import "@preview/cetz:0.4.2"

#let render() = {
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // --- 两根平行导线 ---
    for x in (0, 0.2, 1, 1.2) {
      line((x, 0), (x, 4), stroke: 0.4pt + black)
    }

    // --- 椭圆虚线环（注意圆心在0.1处） ---
    // 原始: \draw[dashed](.1,2) ellipse [x radius=1, y radius=.5]
    arc((0.1, 2), start: 0deg, stop: 360deg,
      radius: (1, 0.5), anchor: "origin",
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))

    // --- 标签 ---
    content((0, -0.5), text(size: 9pt)[$b$])
    content((1, -0.5), text(size: 9pt)[$a$])

    // --- 电流方向 ---
    line((-0.25, 3), (-0.25, 3.5), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((-0.25, 3.75), text(size: 9pt)[$I$])
    line((0.75, 3), (0.75, 3.5), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((0.75, 3.75), text(size: 9pt)[$I$])

    // --- 安培力箭头（反向，从右到左） ---
    // 原始: \draw[->,thick](1.1,2)--(.4,2)node[above]{$F_2$}
    line((1.1, 2), (0.4, 2), stroke: 0.8pt + black,
      mark: (end: "stealth", fill: black))
    content((0.4, 2.25), text(size: 9pt)[$F_2$])
  })
}
