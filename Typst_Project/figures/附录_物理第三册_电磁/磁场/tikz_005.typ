// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 磁场对电流的作用力
// 原始文件：1.tex，行 344-362
// 类型：tikz   >=latex   无缩放
// 描述：电流导线在倾斜磁场中受力 + 磁场分解矢量三角形
#import "@preview/cetz:0.4.2"

#let render() = {
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // --- 竖直导线 ---
    // 原始: \draw (0,6)--(0,0); \draw (.2,6)--(.2,0)
    line((0, 6), (0, 0), stroke: 0.4pt + black)
    line((0.2, 6), (0.2, 0), stroke: 0.4pt + black)
    // 电流方向
    // 原始: \draw[->](.5,5.5)--(.5,5)node[right]{$I$}
    line((0.5, 5.5), (0.5, 5), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((0.7, 5), text(size: 9pt)[$I$])

    // --- 倾斜磁感线组 ---
    // 原始: \foreach \x in {0,1,...,4} { \draw[->](-4,6-\x*.7)--(1,3-\x*.7); }
    for x in range(0, 5) {
      let y0 = 6 - float(x) * 0.7
      let y1 = 3 - float(x) * 0.7
      line((-4, y0), (1, y1), stroke: 0.4pt + black,
        mark: (end: "stealth", fill: black))
    }
    content((1.5, 2), text(size: 9pt)[$B$])

    // --- 角度弧 θ ---
    // 原始: \draw (0,2.9-.5) arc (-90:-30:.5)node[below]{$\theta$}
    // 弧心在 (0, 2.4)，起始角 -90°，结束角 -30°，半径 0.5
    arc((0, 2.4), start: -90deg, stop: -30deg, radius: 0.5,
      anchor: "origin", stroke: 0.4pt + black)
    content((0.5, 2.2), text(size: 8pt)[$theta$])

    // --- 磁场分解矢量三角形 ---
    // 位置在左上角 (-3, 4.7)
    // 原始计算: 5.3-0.6=4.7 基点在 (-3, 4.7)
    let bx = -3
    let by = 4.7

    // B2 水平分量
    // 原始: \draw[->, very thick](-3,4.7)--(-2,4.7)node[right]{$B_2$}
    line((bx, by), (bx + 1, by), stroke: 1.2pt + black,
      mark: (end: "stealth", fill: black))
    content((bx + 1.3, by), text(size: 9pt)[$B_2$])

    // B1 竖直分量
    // 原始: \draw[->, very thick](-3,4.7)--(-3,4.1)node[below]{$B_1$}
    line((bx, by), (bx, by - 0.6), stroke: 1.2pt + black,
      mark: (end: "stealth", fill: black))
    content((bx, by - 0.85), text(size: 9pt)[$B_1$])

    // B 合成
    // 原始: \draw[->, very thick](-3,4.7)--(-2,4.1)node[right]{$B$}
    line((bx, by), (bx + 1, by - 0.6), stroke: 1.2pt + black,
      mark: (end: "stealth", fill: black))
    content((bx + 1.3, by - 0.6), text(size: 9pt)[$B$])

    // 虚线完成平行四边形
    line((bx, by - 0.6), (bx + 1, by - 0.6),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    line((bx + 1, by), (bx + 1, by - 0.6),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))

    // 小角度弧
    arc((bx, by - 0.2), start: -90deg, stop: -30deg, radius: 0.2,
      anchor: "origin", stroke: 0.4pt + black)
    content((bx + 0.25, by - 0.35), text(size: 7pt)[$theta$])
  })
}
