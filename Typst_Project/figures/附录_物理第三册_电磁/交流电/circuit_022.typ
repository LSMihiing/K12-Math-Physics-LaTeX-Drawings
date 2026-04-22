// 3.tex:906-920 变压器：一次/二次线圈+铁芯
// 一次线圈bumps朝右(默认), 铁芯在右侧, 标注在线圈外侧
#import "@preview/cetz:0.4.2"
#import "../_circuit_utils.typ": *
#let render() = {
  cetz.canvas(length: 0.6cm, {
    import cetz.draw: *
    // 一次线圈（左侧，bumps朝右→铁芯侧）
    line((0, 0), (2, 0), stroke: w)
    draw-inductor((2, 0), (2, 2.8), coils: 6)
    line((2, 2.8), (0, 2.8), stroke: w)
    // 铁芯（在一次线圈bumps右侧）
    draw-core(2.55, 0.1, 2.7)
    // n₁（铁芯左侧，粗竖线）
    line((2.35, 0.1), (2.35, 2.7), stroke: 1.4pt + black)
    content((2.1, 1.4), text(size: 6pt)[$n_1$])
    // 二次线圈接线端（右侧，短）
    line((2.55, 0), (4, 0), stroke: w)
    line((4, 1.4), (2.55, 1.4), stroke: w)
    // n₂
    content((2.8, 0.7), text(size: 6pt)[$n_2$])
    // U₁ 双箭头
    line((0, 0.1), (0, 2.7), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    rect((-0.3, 1.1), (0.3, 1.7), fill: white, stroke: none)
    content((0, 1.4), text(size: 7pt)[$U_1$])
    // U₂ 双箭头
    line((4, 0.1), (4, 1.3), stroke: 0.4pt + black,
      mark: (start: "stealth", end: "stealth", fill: black))
    rect((3.7, 0.4), (4.3, 1.0), fill: white, stroke: none)
    content((4, 0.7), text(size: 7pt)[$U_2$])
    // 端子
    circle((0, 0), radius: 0.04, fill: white, stroke: 0.5pt + black)
    circle((0, 2.8), radius: 0.04, fill: white, stroke: 0.5pt + black)
    circle((4, 0), radius: 0.04, fill: white, stroke: 0.5pt + black)
    circle((4, 1.4), radius: 0.04, fill: white, stroke: 0.5pt + black)
  })
}
