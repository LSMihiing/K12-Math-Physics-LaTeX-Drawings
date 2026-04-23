// ============================================================
// 教程示例环境 — 代码 + 渲染结果并排展示
// ============================================================
// 灵感来源：lshort-zh-cn 的 example 环境
// 实现原理：利用 Typst 的 eval() 函数，同一份代码字符串
//           左侧用 raw() 显示为代码块，右侧用 eval() 执行渲染。

#import "@preview/cetz:0.4.2"

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
        #raw(code, lang: "typst", block: true)
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
