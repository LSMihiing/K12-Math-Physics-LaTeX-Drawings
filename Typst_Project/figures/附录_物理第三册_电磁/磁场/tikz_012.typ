// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 电流表的工作原理
// 原始文件：1.tex，行 584-605
// 类型：tikz   >=latex   scale=1
// 描述：线圈侧视图 - 电流方向·/×标注，力矢量，距离d和角θ
#import "@preview/cetz:0.4.2"

#let render() = {
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // --- 磁感线组 ---
    // 原始: \foreach \x in {-1,0,1,2} { \draw[->](-1.5,\x)--(3,\x); }
    for y in (-1, 0, 1, 2) {
      line((-1.5, float(y)), (3, float(y)), stroke: 0.4pt + black,
        mark: (end: "stealth", fill: black))
    }
    content((3.5, 0.5), text(size: 9pt)[$B$])

    // --- 力箭头 F_cd (向上) ---
    line((1.5, 1.5), (1.5, 3), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((1.8, 3), text(size: 9pt)[$F_(c d)$])

    // --- 力箭头 F_ab (向下) ---
    line((-0.5, -0.5), (-0.5, -2), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((-0.2, -2), text(size: 9pt)[$F_(a b)$])

    // --- 虚线 ---
    line((1.5, 1.5), (1.5, -0.7),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))

    // --- 距离标注 d ---
    line((-0.3, -0.5), (1.5, -0.5), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    // 白色背景标签
    rect((0.3, -0.65), (0.9, -0.35), fill: white, stroke: none)
    content((0.6, -0.5), text(size: 9pt)[$d$])

    // --- 电流方向 d点 (·出纸面) ---
    circle((1.5, 1.5), radius: 0.15, fill: white, stroke: 0.4pt + black)
    circle((1.5, 1.5), radius: 0.04, fill: black, stroke: none)

    // --- 电流方向 a点 (×入纸面) ---
    circle((-0.5, -0.5), radius: 0.15, fill: white, stroke: 0.4pt + black)
    content((-0.5, -0.5), text(size: 7pt)[$times$])

    // --- 导线 (两条平行线连接 a-d) ---
    line((1.5 - 0.1, 1.5 + 0.1), (-0.5 - 0.1, -0.5 + 0.1), stroke: 0.4pt + black)
    line((1.5 + 0.1, 1.5 - 0.1), (-0.5 + 0.1, -0.5 - 0.1), stroke: 0.4pt + black)

    // --- 标签 ---
    content((1.7, 1.5), text(size: 9pt)[$d$])
    content((-0.8, -0.5), text(size: 9pt)[$a$])

    // --- O 点 ---
    circle((0.5, 0.5), radius: 0.04, fill: black, stroke: none)
    content((0.7, 0.35), text(size: 9pt)[$O$])

    // --- 角度 θ ---
    arc((-0.3, -0.5), start: 0deg, stop: 45deg, radius: 0.5,
      anchor: "origin", stroke: 0.4pt + black)
    content((0.15, -0.15), text(size: 8pt)[$theta$])
  })
}
