// 电路元件辅助函数 v3 — 修复方向、白色填充、连接断点
#import "@preview/cetz:0.4.2"
#let _s = 0.7pt + black

// 内部：计算元件两侧连接点（处理正/反方向）
#let _edges(x1, x2, mx, half) = {
  if x1 <= x2 { (mx - half, mx + half) } else { (mx + half, mx - half) }
}
#let _vedges(y1, y2, my, half) = {
  if y1 <= y2 { (my - half, my + half) } else { (my + half, my - half) }
}

// ─── 电池 battery2 ───
#let draw-battery(from, to) = {
  import cetz.draw: *
  let (x1, y1) = from; let (x2, y2) = to
  let mx = (x1 + x2) / 2.0; let my = (y1 + y2) / 2.0
  if calc.abs(y2 - y1) < 0.01 {
    let (ef, et) = _edges(x1, x2, mx, 0.12)
    line(from, (ef, my), stroke: _s)
    rect((calc.min(ef, et) - 0.02, my - 0.32), (calc.max(ef, et) + 0.02, my + 0.32), fill: white, stroke: none)
    line((ef, my - 0.28), (ef, my + 0.28), stroke: 0.6pt + black)
    line((et, my - 0.14), (et, my + 0.14), stroke: 1.4pt + black)
    line((et, my), to, stroke: _s)
  } else {
    let (ef, et) = _vedges(y1, y2, my, 0.12)
    line(from, (mx, ef), stroke: _s)
    rect((mx - 0.32, calc.min(ef, et) - 0.02), (mx + 0.32, calc.max(ef, et) + 0.02), fill: white, stroke: none)
    line((mx - 0.28, ef), (mx + 0.28, ef), stroke: 0.6pt + black)
    line((mx - 0.14, et), (mx + 0.14, et), stroke: 1.4pt + black)
    line((mx, et), to, stroke: _s)
  }
}

// ─── 开关 cute open switch ───
#let draw-switch(from, to) = {
  import cetz.draw: *
  let (x1, y1) = from; let (x2, y2) = to
  if calc.abs(y2 - y1) < 0.01 {
    let px = x1 + (x2 - x1) * 0.35
    let cx = x1 + (x2 - x1) * 0.65
    line(from, (px, y1), stroke: _s)
    circle((px, y1), radius: 0.04, fill: black, stroke: none)
    line((px, y1), (cx, y1 + 0.35), stroke: _s)
    circle((cx, y1), radius: 0.04, fill: black, stroke: none)
    line((cx, y1), to, stroke: _s)
  } else {
    let py = y1 + (y2 - y1) * 0.35
    let cy = y1 + (y2 - y1) * 0.65
    line(from, (x1, py), stroke: _s)
    circle((x1, py), radius: 0.04, fill: black, stroke: none)
    line((x1, py), (x1 + 0.35, cy), stroke: _s)
    circle((x1, cy), radius: 0.04, fill: black, stroke: none)
    line((x1, cy), to, stroke: _s)
  }
}

// ─── 仪表 rmeter ───
#let draw-meter(from, to, label: $G$, r: 0.32) = {
  import cetz.draw: *
  let mx = (from.at(0) + to.at(0)) / 2.0
  let my = (from.at(1) + to.at(1)) / 2.0
  if calc.abs(to.at(1) - from.at(1)) < 0.01 {
    let (ef, et) = _edges(from.at(0), to.at(0), mx, r)
    line(from, (ef, my), stroke: _s)
    circle((mx, my), radius: r, fill: white, stroke: _s)
    content((mx, my), text(size: 8pt)[#label])
    line((et, my), to, stroke: _s)
  } else {
    let (ef, et) = _vedges(from.at(1), to.at(1), my, r)
    line(from, (mx, ef), stroke: _s)
    circle((mx, my), radius: r, fill: white, stroke: _s)
    content((mx, my), text(size: 8pt)[#label])
    line((mx, et), to, stroke: _s)
  }
}

// ─── 电阻 R（矩形，白色填充）───
#let draw-resistor(from, to, label: none) = {
  import cetz.draw: *
  let mx = (from.at(0) + to.at(0)) / 2.0
  let my = (from.at(1) + to.at(1)) / 2.0
  if calc.abs(to.at(1) - from.at(1)) < 0.01 {
    let hw = 0.35; let hh = 0.13
    let (ef, et) = _edges(from.at(0), to.at(0), mx, hw)
    line(from, (ef, my), stroke: _s)
    rect((mx - hw, my - hh), (mx + hw, my + hh), fill: white, stroke: _s)
    line((et, my), to, stroke: _s)
    if label != none { content((mx, my + hh + 0.22), text(size: 7pt)[#label]) }
  } else {
    let hw = 0.13; let hh = 0.35
    let (ef, et) = _vedges(from.at(1), to.at(1), my, hh)
    line(from, (mx, ef), stroke: _s)
    rect((mx - hw, my - hh), (mx + hw, my + hh), fill: white, stroke: _s)
    line((mx, et), to, stroke: _s)
    if label != none { content((mx + hw + 0.28, my), text(size: 7pt)[#label]) }
  }
}

// ─── 电感 L（波浪线样式）───
// mirror: 竖向电感波浪朝左(true)还是朝右(false，默认)
//         横向电感波浪朝下(true)还是朝上(false，默认)
#let draw-inductor(from, to, coils: 4, mirror: false) = {
  import cetz.draw: *
  let (x1, y1) = from; let (x2, y2) = to
  if calc.abs(y2 - y1) < 0.01 {
    let lx = calc.min(x1, x2); let rx = calc.max(x1, x2)
    let total = rx - lx
    let cw = total * 0.75 / float(coils)
    let r = cw / 2.0
    let sx = (lx + rx) / 2.0 - float(coils) * cw / 2.0
    let ex = sx + float(coils) * cw
    if mirror {
      rect((sx - 0.03, y1 - r - 0.06), (ex + 0.03, y1 + 0.06), fill: white, stroke: none)
    } else {
      rect((sx - 0.03, y1 - 0.06), (ex + 0.03, y1 + r + 0.06), fill: white, stroke: none)
    }
    line((lx, y1), (sx, y1), stroke: _s)
    for i in range(0, coils) {
      let cx = sx + float(i) * cw + r
      if mirror {
        arc((cx, y1), start: 0deg, stop: -180deg, radius: r,
          anchor: "origin", fill: white, stroke: _s)
      } else {
        arc((cx, y1), start: 180deg, stop: 0deg, radius: r,
          anchor: "origin", fill: white, stroke: _s)
      }
    }
    line((ex, y1), (rx, y1), stroke: _s)
  } else {
    let by = calc.min(y1, y2); let ty = calc.max(y1, y2)
    let total = ty - by
    let cw = total * 0.75 / float(coils)
    let r = cw / 2.0
    let sy = (by + ty) / 2.0 - float(coils) * cw / 2.0
    let ey = sy + float(coils) * cw
    if mirror {
      rect((x1 - r - 0.06, sy - 0.03), (x1 + 0.06, ey + 0.03), fill: white, stroke: none)
    } else {
      rect((x1 - 0.06, sy - 0.03), (x1 + r + 0.06, ey + 0.03), fill: white, stroke: none)
    }
    line((x1, by), (x1, sy), stroke: _s)
    for i in range(0, coils) {
      let cy = sy + float(i) * cw + r
      if mirror {
        arc((x1, cy), start: 90deg, stop: -90deg, radius: r,
          anchor: "origin", fill: white, stroke: _s)
      } else {
        arc((x1, cy), start: -90deg, stop: 90deg, radius: r,
          anchor: "origin", fill: white, stroke: _s)
      }
    }
    line((x1, ey), (x1, ty), stroke: _s)
  }
}

// ─── 灯泡 lamp（circle + ×，白色填充）───
#let draw-lamp(from, to, r: 0.2) = {
  import cetz.draw: *
  let mx = (from.at(0) + to.at(0)) / 2.0
  let my = (from.at(1) + to.at(1)) / 2.0
  if calc.abs(to.at(1) - from.at(1)) < 0.01 {
    let (ef, et) = _edges(from.at(0), to.at(0), mx, r)
    line(from, (ef, my), stroke: _s)
    circle((mx, my), radius: r, fill: white, stroke: _s)
    let d = r * 0.55
    line((mx - d, my - d), (mx + d, my + d), stroke: 0.5pt + black)
    line((mx - d, my + d), (mx + d, my - d), stroke: 0.5pt + black)
    line((et, my), to, stroke: _s)
  } else {
    let (ef, et) = _vedges(from.at(1), to.at(1), my, r)
    line(from, (mx, ef), stroke: _s)
    circle((mx, my), radius: r, fill: white, stroke: _s)
    let d = r * 0.55
    line((mx - d, my - d), (mx + d, my + d), stroke: 0.5pt + black)
    line((mx - d, my + d), (mx + d, my - d), stroke: 0.5pt + black)
    line((mx, et), to, stroke: _s)
  }
}

// ─── 变压器铁芯 ───
#let draw-core(x, yb, yt, gap: 0.1) = {
  import cetz.draw: *
  line((x - gap, yb), (x - gap, yt), stroke: 1.2pt + black)
  line((x + gap, yb), (x + gap, yt), stroke: 1.2pt + black)
}

// ─── 电容 C（两条平行线）───
#let draw-capacitor(from, to) = {
  import cetz.draw: *
  let mx = (from.at(0) + to.at(0)) / 2.0
  let my = (from.at(1) + to.at(1)) / 2.0
  let g = 0.08
  if calc.abs(to.at(1) - from.at(1)) < 0.01 {
    let (ef, et) = _edges(from.at(0), to.at(0), mx, g)
    line(from, (ef, my), stroke: _s)
    rect((calc.min(ef, et) - 0.01, my - 0.3), (calc.max(ef, et) + 0.01, my + 0.3), fill: white, stroke: none)
    line((ef, my - 0.25), (ef, my + 0.25), stroke: 0.8pt + black)
    line((et, my - 0.25), (et, my + 0.25), stroke: 0.8pt + black)
    line((et, my), to, stroke: _s)
  } else {
    let (ef, et) = _vedges(from.at(1), to.at(1), my, g)
    line(from, (mx, ef), stroke: _s)
    rect((mx - 0.3, calc.min(ef, et) - 0.01), (mx + 0.3, calc.max(ef, et) + 0.01), fill: white, stroke: none)
    line((mx - 0.25, ef), (mx + 0.25, ef), stroke: 0.8pt + black)
    line((mx - 0.25, et), (mx + 0.25, et), stroke: 0.8pt + black)
    line((mx, et), to, stroke: _s)
  }
}

// ─── 二极管 diode（实心三角形 + 阴极竖线）───
// circuitikz full diode 样式：实心三角指向 to 方向 + 阴极bar
#let draw-diode(from, to, sz: 0.15) = {
  import cetz.draw: *
  let (x1, y1) = from; let (x2, y2) = to
  let dx = x2 - x1; let dy = y2 - y1
  let len = calc.sqrt(dx * dx + dy * dy)
  let nx = dx / len; let ny = dy / len  // 方向单位向量
  let px = -ny; let py = nx              // 垂直单位向量
  let mx = (x1 + x2) / 2.0; let my = (y1 + y2) / 2.0
  // 三角形顶点
  let base-c = (mx - nx * sz, my - ny * sz)  // 底边中心
  let tip = (mx + nx * sz, my + ny * sz)      // 尖端(朝to)
  let bl = (base-c.at(0) + px * sz * 0.7, base-c.at(1) + py * sz * 0.7)
  let br = (base-c.at(0) - px * sz * 0.7, base-c.at(1) - py * sz * 0.7)
  // 导线 → 底边中心
  line(from, base-c, stroke: _s)
  // 实心三角形
  line(bl, tip, br, close: true, fill: black, stroke: _s)
  // 阴极竖线（在尖端处垂直于方向）
  line((tip.at(0) + px * sz * 0.7, tip.at(1) + py * sz * 0.7),
       (tip.at(0) - px * sz * 0.7, tip.at(1) - py * sz * 0.7),
       stroke: 0.8pt + black)
  // 尖端 → 导线
  line(tip, to, stroke: _s)
}

// ─── AC源（竖线断口+~符号，绘制在指定位置）───
#let draw-ac-source(x, y-bot, y-top) = {
  import cetz.draw: *
  let gap = 0.2
  let my = (y-bot + y-top) / 2.0
  line((x, y-bot), (x, my - gap), stroke: _s)
  line((x, my + gap), (x, y-top), stroke: _s)
  circle((x, my - gap), radius: 0.04, fill: white, stroke: 0.5pt + black)
  circle((x, my + gap), radius: 0.04, fill: white, stroke: 0.5pt + black)
  content((x, my), text(size: 8pt)[~])
}

#let w = _s
