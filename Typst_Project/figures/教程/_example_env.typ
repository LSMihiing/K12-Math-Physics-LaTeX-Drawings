// ============================================================
// 教程示例环境 — 代码 + 渲染结果并排展示
// ============================================================
// 灵感来源：lshort-zh-cn 的 example 环境
// 实现原理：利用 Typst 的 eval() 函数，同一份代码字符串
//           左侧用 raw() 显示为代码块，右侧用 eval() 执行渲染。

#import "@preview/cetz:0.4.2"

// --- 内联代码片段（用于表格等场景，带语法高亮+背景）---
#let code(src) = {
  box(
    fill: luma(240),
    inset: (x: 3pt, y: 2pt),
    radius: 2pt,
    baseline: 2pt,
  )[
    #show raw: set text(font: ("Consolas", "SimSun"))
    #raw(src, lang: "typst")
  ]
}

// --- 并排示例（左代码 / 右渲染）---
// code-block: 传入 raw 块（用反引号包裹的代码）
#let example(code-block) = {
  let code = code-block.text
  block(
    width: 100%,
    inset: 0pt,
    above: 0.8em,
    below: 0.8em,
    grid(
      columns: (1fr, auto),
      gutter: 10pt,
      // 左：代码
      block(
        width: 100%,
        fill: luma(245),
        inset: 10pt,
        radius: 3pt,
      )[
        #set par(first-line-indent: 0em)
        #set text(size: 8pt)
        #show raw: set text(font: ("Consolas", "SimSun"))
        #code-block
      ],
      // 右：渲染结果
      block(
        width: auto,
        stroke: 0.5pt + luma(200),
        inset: 10pt,
        radius: 3pt,
      )[
        #set par(first-line-indent: 0em)
        #eval(code, mode: "markup", scope: (cetz: cetz))
      ],
    ),
  )
}

// --- 宽版示例（上代码 / 下渲染）---
// 适用于宽度较大的图形
#let full-example(code-block) = {
  let code = code-block.text
  block(
    width: 100%,
    inset: 0pt,
    above: 0.8em,
    below: 0.8em,
  )[
    #block(
      width: 100%,
      fill: luma(245),
      inset: 10pt,
      radius: (top: 3pt),
    )[
      #set par(first-line-indent: 0em)
      #set text(size: 8pt)
      #raw(code, lang: "typst", block: true)
    ]
    #block(
      width: 100%,
      stroke: 0.5pt + luma(200),
      inset: 12pt,
      radius: (bottom: 3pt),
    )[
      #set par(first-line-indent: 0em)
      #align(center)[
        #eval(code, mode: "markup", scope: (cetz: cetz))
      ]
    ]
  ]
}

// --- 标记模式示例（左代码 / 右渲染）---
// 用于 Typst 基础语法演示（文字样式、列表等），不需要 CeTZ
// 内部重置 heading show 规则，避免 main.typ 的样式泄入
#let markup-example(code-block) = {
  let code = code-block.text
  block(
    width: 100%,
    inset: 0pt,
    above: 0.8em,
    below: 0.8em,
    grid(
      columns: (1fr, 1fr),
      gutter: 10pt,
      // 左：代码
      block(
        width: 100%,
        fill: luma(245),
        inset: 10pt,
        radius: 3pt,
      )[
        #set par(first-line-indent: 0em)
        #set text(size: 8pt)
        #show raw: set text(font: ("Consolas", "SimSun"))
        #code-block
      ],
      // 右：渲染结果（重置标题样式）
      block(
        width: 100%,
        stroke: 0.5pt + luma(200),
        inset: 10pt,
        radius: 3pt,
      )[
        #set par(first-line-indent: 0em)
        #set text(size: 9pt)
        #set heading(outlined: false, bookmarked: false, numbering: none)
        #show heading: it => {
          let sz = if it.level == 1 { 14pt } else if it.level == 2 { 12pt } else { 10pt }
          block(above: 0.4em, below: 0.3em, text(size: sz, weight: "bold")[#it.body])
        }
        #eval(code, mode: "markup")
      ],
    ),
  )
}
