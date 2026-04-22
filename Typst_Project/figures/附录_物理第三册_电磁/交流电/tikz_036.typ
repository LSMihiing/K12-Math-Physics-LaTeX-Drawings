// 3.tex:1541-1577  三相交流电发电机横截面
#import "@preview/cetz:0.4.2"
#let render() = {
  cetz.canvas(length: 1cm, {
    import cetz.draw: *
    circle((0, 0), radius: 1.3, stroke: 0.4pt + black)
    // 旋转虚线矩形 30°,90°,150°
    for angle in (30, 90, 150) {
      let c = calc.cos(float(angle) * calc.pi / 180)
      let s = calc.sin(float(angle) * calc.pi / 180)
      let rot(px, py) = (px * c - py * s, px * s + py * c)
      let p1 = rot(-1.6, -0.08); let p2 = rot(1.6, -0.08)
      let p3 = rot(1.6, 0.08); let p4 = rot(-1.6, 0.08)
      line(p1, p2, p3, p4, close: true,
        stroke: (paint: black, thickness: 0.4pt, dash: "dashed"))
      // 端点圆
      let ep1 = rot(1.6, 0); let ep2 = rot(-1.6, 0)
      circle(ep1, radius: 0.12, fill: white, stroke: 0.4pt + black)
      circle(ep2, radius: 0.12, fill: white, stroke: 0.4pt + black)
    }
    // ×/· 符号
    for (a, sym) in ((30, "×"), (-30, "×"), (150, "·"), (-150, "·")) {
      let r = 1.6
      let x = r * calc.cos(float(a) * calc.pi / 180)
      let y = r * calc.sin(float(a) * calc.pi / 180)
      if sym == "×" { content((x, y), text(size: 8pt)[$times$]) }
      else { circle((x, y), radius: 0.03, fill: black, stroke: none) }
    }
    // 旋转方向弧
    arc((0, 0), start: 0deg, stop: 20deg, radius: 1,
      anchor: "origin", stroke: 0.4pt + black, mark: (end: "stealth", fill: black))
    // 标签
    content((1.85, 1.1), text(size: 8pt)[$Z$])
    content((1.85, -0.65), text(size: 8pt)[$B$])
    content((-1.7, 1.2), text(size: 8pt)[$Y$])
    content((-1.85, -0.8), text(size: 8pt)[$C$])
    content((0, 1.9), text(size: 8pt)[$A$])
    content((0, -1.9), text(size: 8pt)[$X$])
    // N/S 极
    line((3, 1.5), (1.25, 1.5), stroke: 0.4pt + black)
    line((3, -1.5), (1.25, -1.5), stroke: 0.4pt + black)
    bezier((1.25, 1.5), (1.25, -1.5), (0.4, 0), stroke: 0.4pt + black)
    line((3, 1.5), (3, -1.5), stroke: 0.4pt + black)
    line((-3, 1.5), (-3, -1.5), stroke: 0.4pt + black)
    line((-3, 1.5), (-1.25, 1.5), stroke: 0.4pt + black)
    line((-3, -1.5), (-1.25, -1.5), stroke: 0.4pt + black)
    bezier((-1.25, 1.5), (-1.25, -1.5), (-0.4, 0), stroke: 0.4pt + black)
    content((-2.5, 0), text(size: 9pt)[$N$])
    content((2.5, 0), text(size: 9pt)[$S$])
  })
}
