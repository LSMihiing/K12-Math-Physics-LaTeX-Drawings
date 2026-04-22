// 来源：高中物理甲种本·第三册（电磁·光学·近代物理）
// 章节：磁场 / 磁场对运动电荷的作用力
// 原始文件：1.tex，行 705-730
// 类型：tikz   >=stealth   scale=0.5
// 描述：洛伦兹力乙丙丁三场景并排
//   乙：·磁场(出纸面) + +q 水平运动
//   丙：竖直向上磁感线 + +q 水平运动
//   丁：竖直向下磁感线 + +q 水平运动
#import "@preview/cetz:0.4.2"

#let render() = {
  cetz.canvas(length: 0.5cm, {
    import cetz.draw: *

    // ========= 乙：·符号阵列（磁场出纸面） =========
    for x in range(1, 5) {
      for y in range(1, 5) {
        circle((float(x), float(y)), radius: 0.08, fill: black, stroke: none)
      }
    }
    line((-0.5, 2.5), (0.5, 2.5), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((-1.0, 2.5), text(size: 9pt)[$+q$])
    content((0, 2.1), text(size: 9pt)[$v$])
    circle((-0.5, 2.5), radius: 0.12, fill: white, stroke: 0.4pt + black)
    content((2.5, -1), text(size: 9pt)[乙])

    // ========= 丙：竖直向上磁感线 =========
    let ox = 7  // 水平偏移
    for x in range(1, 5) {
      line((float(x) + ox, 0.5), (float(x) + ox, 4), stroke: 0.4pt + black,
        mark: (end: "stealth", fill: black))
    }
    line((-0.5 + ox, 2.5), (0.5 + ox, 2.5), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((-1.0 + ox, 2.5), text(size: 9pt)[$+q$])
    content((ox, 2.1), text(size: 9pt)[$v$])
    circle((-0.5 + ox, 2.5), radius: 0.12, fill: white, stroke: 0.4pt + black)
    content((2.5 + ox, -1), text(size: 9pt)[丙])

    // ========= 丁：竖直向下磁感线 =========
    let ox2 = 14
    for x in range(1, 5) {
      line((float(x) + ox2, 4), (float(x) + ox2, 0.5), stroke: 0.4pt + black,
        mark: (end: "stealth", fill: black))
    }
    line((-0.5 + ox2, 2.5), (0.5 + ox2, 2.5), stroke: 0.4pt + black,
      mark: (end: "stealth", fill: black))
    content((-1.0 + ox2, 2.5), text(size: 9pt)[$+q$])
    content((ox2, 2.1), text(size: 9pt)[$v$])
    circle((-0.5 + ox2, 2.5), radius: 0.12, fill: white, stroke: 0.4pt + black)
    content((2.5 + ox2, -1), text(size: 9pt)[丁])
  })
}
