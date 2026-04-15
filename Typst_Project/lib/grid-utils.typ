// ============================================================
// grid-utils.typ — 方格纸 & 坐标系绘图工具
// ============================================================

#import "@preview/cetz:0.4.2"

// 绘制方格纸
#let draw-grid(
  origin: (0, 0),
  cols: 10,
  rows: 10,
  step: 1,
  line-color: luma(200),
  line-width: 0.4pt,
) = {
  import cetz.draw: *

  let (ox, oy) = origin
  let w = cols * step
  let h = rows * step

  for i in range(cols + 1) {
    let x = ox + i * step
    line((x, oy), (x, oy + h), stroke: line-width + line-color)
  }
  for j in range(rows + 1) {
    let y = oy + j * step
    line((ox, y), (ox + w, y), stroke: line-width + line-color)
  }
}

// 在指定位置放置文字标签
// dir: 标签相对于点的方向偏移 ("n", "s", "e", "w", "ne", "nw", "se", "sw")
#let dot-label(
  pos,
  label,
  dir: "ne",
  text-size: 9pt,
) = {
  import cetz.draw: *
  let (px, py) = pos
  let d = 0.5
  let (dx, dy) = if dir == "n" { (0, d) }
    else if dir == "s" { (0, -d) }
    else if dir == "e" { (d, 0) }
    else if dir == "w" { (-d, 0) }
    else if dir == "ne" { (d*0.7, d*0.7) }
    else if dir == "nw" { (-d*0.7, d*0.7) }
    else if dir == "se" { (d*0.7, -d*0.7) }
    else if dir == "sw" { (-d*0.7, -d*0.7) }
    else { (d, d) }
  content((px + dx, py + dy))[#text(size: text-size)[#label]]
}
