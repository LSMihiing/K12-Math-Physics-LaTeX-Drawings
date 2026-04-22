// 来源：1.tex:1084-1096  回旋加速器 — 不同半径弧线轨迹
// scale=0.8
#import "@preview/cetz:0.4.2"
#let render() = {
  cetz.canvas(length: 0.8cm, {
    import cetz.draw: *
    // 5条不同半径的弧线从原点出发
    // TikZ: arc 起点在(0,0)
    // a: arc(0:-120:1) → 圆心在(0, -1)，起角0°，终角-120°
    // 注意TikZ中arc起点是弧上的点，不是圆心
    // arc (start_angle:end_angle:radius) 从start到end

    // a: (0,0) arc(0:-120:1) — 圆心=(0-cos(0)*1, 0-sin(0)*1)=(−1,0)
    // 不对。TikZ arc: 起点在(0,0)，起始角0°，圆心在(0-r*cos(0), 0-r*sin(0))=(−1,0)
    // 终角-120°

    // thick 弧线 a（小半径）
    arc((-1, 0), start: 0deg, stop: -120deg, radius: 1,
      anchor: "origin", stroke: 0.8pt + black)
    content((-1 + calc.cos(-120deg), calc.sin(-120deg)), text(size: 9pt)[$a$],
      anchor: "east")

    // b: arc(0:-45:5)  圆心=(0-5,0)=(-5,0)
    arc((-5, 0), start: 0deg, stop: -45deg, radius: 5,
      anchor: "origin", stroke: 0.8pt + black)
    let bx = -5 + 5*calc.cos(-45deg)
    let by = 5*calc.sin(-45deg)
    content((bx - 0.3, by), text(size: 9pt)[$b$])

    // c: arc(0:-20:15) 圆心=(-15,0)
    arc((-15, 0), start: 0deg, stop: -20deg, radius: 15,
      anchor: "origin", stroke: 0.8pt + black)
    let cx = -15 + 15*calc.cos(-20deg)
    let cy = 15*calc.sin(-20deg)
    content((cx - 0.3, cy), text(size: 9pt)[$c$])

    // d: arc(180:200:13) 从(0,0)，起角180°，圆心=(0-13*cos(180),0-13*sin(180))=(13,0)
    arc((13, 0), start: 180deg, stop: 200deg, radius: 13,
      anchor: "origin", stroke: 0.8pt + black)
    let dx = 13 + 13*calc.cos(200deg)
    let dy = 13*calc.sin(200deg)
    content((dx + 0.3, dy), text(size: 9pt)[$d$])

    // e: arc(180:230:4) 圆心=(4,0)
    arc((4, 0), start: 180deg, stop: 230deg, radius: 4,
      anchor: "origin", stroke: 0.8pt + black)
    let ex = 4 + 4*calc.cos(230deg)
    let ey = 4*calc.sin(230deg)
    content((ex + 0.3, ey), text(size: 9pt)[$e$])

    // B标记 ×
    circle((1, -0.5), radius: 0.15, fill: white, stroke: 0.4pt + black)
    content((1, -0.5), text(size: 8pt)[$times$])
    content((1.4, -0.5), text(size: 9pt)[$B$])

    // O 原点
    content((0, 0.5), text(size: 9pt)[$O$])
    circle((0, 0), radius: 0.05, fill: black, stroke: none)
  })
}
