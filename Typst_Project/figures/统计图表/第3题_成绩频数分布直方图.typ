// ============================================================
// 第3题 · 测试成绩频数分布直方图
// 绘图 + 补全缺失数据 (70-80 分段)
// ============================================================

#import "@preview/cetz:0.4.2"

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目描述 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[3.]
  text(
    size: 11pt,
  )[某班学生进行了一次数学测试，根据测试成绩绘制了如下频数分布直方图（部分信息缺失）。已知 70-80 分这一小组的频数为 10，请补全该统计图。]

  v(1.5em)

  // --- 绘图区域 ---
  align(center)[
    #cetz.canvas(length: 1cm, {
      import cetz.draw: *

      let w = 7.0
      let h = 5.5
      let sx = 0.7 // 减小宽度使柱子更细长
      let sy = h / 18 // 纵轴比例
      let ex = 0.2 // 心跳符号左移
      let bar-start-x = 0.6 // 柱子起始位置跟随左移

      // 1. 绘制横向参考虚线 (延长至从 Y 轴开始)
      for y in (2, 4, 6, 8, 10, 12, 14, 16) {
        let yp = y * sy
        line((0, yp), (bar-start-x + 5 * sx + 0.5, yp), stroke: (paint: luma(150), dash: "dashed", thickness: 0.5pt))
      }

      // 2. 坐标轴
      // Y 轴 (与 0 刻度对齐)
      line((0, 0), (0, h + 0.5), mark: (end: "stealth", fill: black))
      content((-0.4, h + 0.5), text(size: 10pt, weight: "bold")[频数])
      content((-0.3, -0.3), text(size: 9pt)[0])

      // X 轴起始段
      line((0, 0), (ex, 0))

      // 心电图样式断裂号 (0-50 刻度表示)
      line(
        (ex, 0),
        (ex + 0.05, 0),
        (ex + 0.1, 0.3),
        (ex + 0.2, -0.3),
        (ex + 0.25, 0),
        (ex + 0.3, 0),
        stroke: 0.8pt + black,
      )

      // X 轴后续段
      line((ex + 0.3, 0), (w - 1.5, 0), mark: (end: "stealth", fill: black))
      content((w - 1, -0.6), text(size: 10pt, weight: "bold")[测试成绩/分])

      // 3. 绘制矩形条 (50-60, 60-70, 70-80, 80-90, 90-100)
      // 数据: 2, 6, 10(补全), 14, 8
      let data = (
        (50, 2, luma(220), black),
        (60, 6, luma(220), black),
        (70, 10, blue.lighten(80%), blue), // 补全部分
        (80, 14, luma(220), black),
        (90, 8, luma(220), black),
      )

      for (i, entry) in data.enumerate() {
        let (score, count, fill_clr, stroke_clr) = entry
        let x_start = bar-start-x + i * sx
        let x_end = x_start + sx
        let y_h = count * sy

        // 矩形条
        rect((x_start, 0), (x_end, y_h), fill: fill_clr, stroke: 1pt + stroke_clr)

        // 标注分数刻度 (50, 60, ...)
        content((x_start, -0.4), text(size: 9pt)[#score])
        if i == 4 {
          content((x_end, -0.4), text(size: 9pt)[100])
        }

        // 在补全的柱子上方显示数值 10
        if score == 70 {
          content(((x_start + x_end) / 2, y_h + 0.3), text(fill: blue, weight: "bold")[10])
        }
      }

      // 补充 Y 轴刻度 (移至 x=0 处)
      for y in (2, 4, 6, 8, 10, 12, 14, 16) {
        let yp = y * sy
        content((-0.4, yp), text(size: 9pt)[#y])
        line((0, yp), (0.1, yp)) // 小刻度线
      }
    })
  ]

  v(2.5em)

  // --- 解答部分 ---
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2pt + rgb(31, 120, 180)),
    fill: rgb(245, 250, 255),
    radius: 2pt,
  )[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", fill: rgb(31, 120, 180), size: 10pt)[【解析与解答】]
    #v(0.3em)
    #set text(size: 10pt)

    *解析*：
    根据题意，70-80 分段的频数为 10。在直方图中，这意味着在横轴 70 到 80 的区间内，矩形的高度应对应纵轴的刻度 10。

    *解答*：
    补全后的统计图中，70-80 分的分段柱体高度为 10（见图中蓝色加亮部分）。
  ]

  v(1.2em)

  // --- 绘图原理与步骤 ---
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2pt + luma(180)),
    fill: luma(248),
    radius: 2pt,
  )[
    #set par(first-line-indent: 0em)
    #text(weight: "bold", size: 10pt)[绘图原理与步骤]
    #v(0.3em)
    #set text(size: 9pt)

    + *坐标系构建*：设置 X 轴表示成绩，Y 轴表示频数。在 X 轴 0 到 50 之间绘制“折断线”以表示省略不连续的刻度。
    + *参考线绘制*：按纵轴 2 为步长绘制水平虚线作为背景网格，辅助精准定位柱体高度。
    + *柱体绘制*：使用 `rect` 函数绘制各组数据的矩形。宽度固定为 10 分（单位长度），高度根据频数按比例缩放。
    *补全策略*：将缺失的 70-80 分段频数设定为 10，并使用蓝色边框和浅色填充进行区分显示，以体现“补全”这一动作。
  ]
}
