// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 电流表的工作原理
// 原始文件：1.tex，行 556-579
// 类型：tikz   >=latex   yscale=1.3
// 描述：矩形线圈abcd在磁场中的受力分析（电流表原理甲）
//       使用 tkzDefPoints 定义点，需手动计算等效坐标
#import "@preview/cetz:0.4.2"

#let render() = {
  // yscale=1.3 → y坐标乘1.3
  let ys = 1.3
  cetz.canvas(length: 1cm, {
    import cetz.draw: *

    // --- 磁感线组 ---
    // 原始: \foreach \x in {-1,-.5,...,1.5} → -1, -0.5, 0, 0.5, 1, 1.5
    for x-val in (-1, -0.5, 0, 0.5, 1, 1.5) {
      line((-2, x-val * ys), (2, x-val * ys), stroke: 0.4pt + black,
        mark: (end: "stealth", fill: black))
    }

    // --- 旋转轴虚线 ---
    line((0, -1.5 * ys), (0, 2 * ys),
      stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
    content((0, -1.7 * ys), text(size: 9pt)[$O'$])
    content((0, 2.2 * ys), text(size: 9pt)[$O$])

    // --- 线圈 abcd ---
    // tkzDefPoints: a=(-1, 0.8*1.3), d=(1, 1.8*1.3), b=(-1, -1.2*1.3)
    // c = b + (d - a) = (-1+2, -1.2*1.3+1.0*1.3) = (1, -0.2*1.3)
    let a = (-1, 0.8 * ys)
    let b = (-1, -1.2 * ys)
    let d = (1, 1.8 * ys)
    let c = (b.at(0) + d.at(0) - a.at(0), b.at(1) + d.at(1) - a.at(1))
    // c = (1, (-1.2+1.8-0.8)*1.3) = (1, -0.2*1.3)

    // very thick 边: a-b, b-c, c-d
    line(a, b, stroke: 1.2pt + black)
    line(b, c, stroke: 1.2pt + black)
    line(c, d, stroke: 1.2pt + black)

    // ad 边断开：a→a'（40%处）和 d→d'（60%处）
    let a-prime = (a.at(0) + 0.4 * (d.at(0) - a.at(0)),
                   a.at(1) + 0.4 * (d.at(1) - a.at(1)))
    let d-prime = (a.at(0) + 0.6 * (d.at(0) - a.at(0)),
                   a.at(1) + 0.6 * (d.at(1) - a.at(1)))

    line(a, a-prime, stroke: 1.2pt + black)
    line(d, d-prime, stroke: 1.2pt + black)

    // 断口处竖线（引线标记）
    line((a-prime.at(0), a-prime.at(1)), (a-prime.at(0), a-prime.at(1) + 0.25),
      stroke: 1.2pt + black)
    line((d-prime.at(0), d-prime.at(1)), (d-prime.at(0), d-prime.at(1) + 0.25),
      stroke: 1.2pt + black)

    // --- 标签 ---
    content((a.at(0) - 0.3, a.at(1)), text(size: 9pt)[$a$])
    content((b.at(0) - 0.3, b.at(1)), text(size: 9pt)[$b$])
    content((c.at(0) + 0.3, c.at(1)), text(size: 9pt)[$c$])
    content((d.at(0) + 0.3, d.at(1)), text(size: 9pt)[$d$])

    // --- 力箭头 ---
    // F_ad: 从 d' 处向右上
    line((d-prime.at(0), d-prime.at(1)),
      (d-prime.at(0) + 0.2, d-prime.at(1) + 0.7),
      stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((d-prime.at(0) + 0.3, d-prime.at(1) + 0.9), text(size: 8pt)[$F_(a d)$])

    // F_cd
    line((1, 0.5 * ys), (1.3, 0.5 * ys + 0.6),
      stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((1.5, 0.5 * ys + 0.7), text(size: 8pt)[$F_(c d)$])

    // F_ab
    line((-1, 0), (-1.3, -0.6),
      stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((-1.5, -0.8), text(size: 8pt)[$F_(a b)$])

    // F_bc
    line((0, -0.7 * ys), (-0.2, -0.7 * ys - 0.7),
      stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    content((-0.4, -0.7 * ys - 0.9), text(size: 8pt)[$F_(b c)$])

    // θ标签
    content((0.25, 1.3 * ys), text(size: 9pt)[$theta$])
  })
}
