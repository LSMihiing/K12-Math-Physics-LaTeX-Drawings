// ============================================================
// 合唱团年龄统计（频数与频率）
// 绘图 + 解答合并
// ============================================================

#import "@preview/cetz:0.4.2"

// 辅助：在行内运行 cetz
#let inline-cetz(content) = {
  box(baseline: 10%, content)
}

// ==========================================
// 自定义“正”字划记函数
// ==========================================
#let zheng-tally(count) = {
  let full-zheng = int(count / 5)
  let remainder = calc.rem(count, 5)
  
  let draw-single(n, size: 1.1em) = {
    inline-cetz(cetz.canvas({
      import cetz.draw: *
      set-style(stroke: (thickness: 1pt, cap: "round"))
      
      // 参考 LaTeX TikZ 坐标逻辑重构 (x=1em, y=1em)
      if n >= 1 { line((0.15, 0.8), (0.85, 0.8)) } // 1. 一 (上横)
      if n >= 2 { line((0.5, 0.8), (0.5, 0.1)) }   // 2. 丨 (中竖)
      if n >= 3 { line((0.5, 0.45), (0.8, 0.45)) } // 3. 一 (中右横)
      if n >= 4 { line((0.25, 0.45), (0.25, 0.1)) }// 4. 丨 (左下竖)
      if n >= 5 { line((0.05, 0.1), (0.95, 0.1)) } // 5. 一 (底横)
    }, length: size))
  }

  h(2pt)
  for i in range(full-zheng) {
    draw-single(5)
    h(4pt)
  }
  if remainder > 0 {
    draw-single(remainder)
  }
  h(2pt)
}

// ==========================================
// 输出：题目 + 解答
// ==========================================
#let render() = {
  // --- 题目 ---
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[2. ]
  text(size: 11pt)[音乐老师统计了合唱团 40 名学生的年龄, 数据如下 (单位: 岁):]
  
  v(0.5em)
  align(center)[
    #block(width: 90%)[
      #set text(size: 10pt)
      #grid(
        columns: (1fr,) * 10,
        row-gutter: 0.6em,
        [14], [13], [13], [15], [16], [12], [14], [16], [17], [13],
        [14], [15], [12], [12], [13], [14], [15], [16], [15], [14],
        [13], [12], [15], [14], [17], [16], [16], [13], [12], [14],
        [14], [15], [13], [16], [15], [16], [17], [14], [14], [13]
      )
    ]
  ]

  v(0.8em)
  text(size: 11pt)[（1）填写表格：]
  v(0.5em)

  // --- 统计表 ---
  align(center)[
    #table(
      columns: (2.5cm, 1.2fr, 1.2fr, 1.2fr, 1.2fr, 1.2fr, 1.2fr),
      align: center + horizon,
      stroke: 0.5pt + black,
      inset: 8pt,
      fill: (x, y) => if x == 0 { rgb(240, 240, 240) } else { none },
      [*年龄/岁*], [12], [13], [14], [15], [16], [17],
      [*划记*], [ #zheng-tally(5) ], [ #zheng-tally(8) ], [ #zheng-tally(10) ], [ #zheng-tally(7) ], [ #zheng-tally(7) ], [ #zheng-tally(3) ],
      [*频数*], [5], [8], [10], [7], [7], [3],
      [*频率*], [$1/8$], [$1/5$], [$1/4$], [$7/40$], [$7/40$], [$3/40$],
    )
  ]

  v(1em)
  
  // --- 后续问题 ---
  let answer-style(body) = text(fill: blue.darken(20%), weight: "bold", body)
  
  text(size: 11pt)[
    （2）在这个统计表中, 学生年龄为 13 岁的频数是 #answer-style[8] , 频率是 #answer-style[$1/5$] .\
    （3）学生年龄为 #answer-style[14] 岁的频率最大, 是 #answer-style[$1/4$] .\
    （4）若老师随机问 1 名学生的年龄, 最可能听到的回答是几岁? \
    答：最可能听到的回答是 #answer-style[14] 岁。
  ]

  v(1.5em)

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

    + *数据处理*：遍历 40 个原始数据，统计出各年龄段（12-17岁）出现的次数（频数），并除以总数 40 得到频率（化为最简分数）。
    + *自定义“正”字*：使用 CeTZ 绘制函数 `zheng-tally(count)`。通过 `line` 分步绘制“一、丨、一、丨、一”五笔，根据 `remainder` 决定显示的笔画数，实现自定义划记效果。
    + *表格构建*：使用 Typst 的 `table` 容器。设置首列灰色背景，行列对齐方式为居中。将 `zheng-tally` 渲染结果嵌入划记行。
    + *文本解答*：根据统计结果填写填空题，突出显示答案颜色（深蓝色）。
  ]
}
