// ============================================================
// main.typ — Typst 绘图项目主入口
// ============================================================
// 编译命令：typst compile main.typ output/main.pdf
// 实时预览：typst watch main.typ output/main.pdf

#import "lib/styles.typ": *

// ============================================================
// 全局样式
// ============================================================
#set page(
  paper: "a4",
  margin: (left: 25mm, right: 25mm, top: 25mm, bottom: 30mm),
)

#set text(
  lang: "zh",
  region: "cn",
  font: ("Times New Roman", "SimSun"),
  size: 10pt,
)
#show heading: set text(font: ("Times New Roman", "SimHei"))
#show raw: set text(font: ("Consolas", "SimSun"))

#set par(
  leading: 0.65em,
  first-line-indent: 2em,
  justify: true,
)

// 首段缩进修复（标题后首段也缩进）
#let fakepar = context {
  let b = par(box())
  b
  v(-measure(b + b).height)
}
#show figure: it => { it; fakepar }

// ========== 深蓝色（目录链接）==========
#let dark-blue = rgb("#3333cc")

// ========== 标题编号（"第X章" 中文方案）==========
#set heading(numbering: (..nums) => {
  let n = nums.pos()
  if n.len() == 1 {
    "第" + numbering("一", n.at(0)) + "部分"
  } else if n.len() == 2 {
    str(n.at(0)) + "." + str(n.at(1))
  } else {
    numbering("1.1", ..n.slice(0))
  }
})

// ========== 标题样式 ==========

// 部（level 1，= 几何作图 / = 附录）：独占一页居中
#show heading.where(level: 1): it => {
  if it.numbering == none {
    pagebreak(weak: true)
    v(50pt)
    align(center, text(size: 22pt, weight: "bold", it.body))
    v(40pt)
    fakepar
    return
  }
  pagebreak(weak: true)
  v(1fr)
  align(center)[
    #set par(first-line-indent: 0pt)
    #text(size: 22pt, weight: "bold")[
      #context counter(heading).display(it.numbering)
    ]
    #v(20pt)
    #text(size: 22pt, weight: "bold")[#it.body]
  ]
  v(1fr)
}

// 章（level 2，== 尺规作图）：新起一页，居中
#show heading.where(level: 2): it => {
  if it.numbering == none { return it }
  pagebreak(weak: true)
  v(50pt)
  align(center)[
    #set par(first-line-indent: 0pt)
    #text(size: 18pt, weight: "bold")[
      #context counter(heading).display(it.numbering)
      #h(0.4em)
      #it.body
    ]
  ]
  v(40pt)
  fakepar
}

// 节（level 3，=== 尺规取等长线段）：居中，大号
#show heading.where(level: 3): it => {
  if it.numbering == none { return it }
  v(1.5em)
  align(center)[
    #set par(first-line-indent: 0pt)
    #text(size: 14pt, weight: "bold")[
      #context counter(heading).display(it.numbering)
      #h(0.4em)
      #it.body
    ]
  ]
  v(1em)
  fakepar
}

// ========== 目录条目样式 ==========

// 部（level 1）：粗体大号，无导引点
#show outline.entry.where(level: 1): it => {
  v(2.25em, weak: true)
  set par(first-line-indent: 0pt)
  set text(weight: "bold", size: 12pt, fill: dark-blue)
  link(it.element.location(), context {
    let p = it.prefix()
    if p != none and measure(p).width > 0pt { p; h(0.5em) }
    it.body()
    h(1fr)
    it.page()
  })
}
// 章（level 2）：粗体，无导引点
#show outline.entry.where(level: 2): it => {
  v(1em, weak: true)
  set par(first-line-indent: 0pt)
  set text(weight: "bold", fill: dark-blue)
  link(it.element.location(), context {
    let p = it.prefix()
    if p != none and measure(p).width > 0pt { p; h(0.5em) }
    it.body()
    h(1fr)
    it.page()
  })
}
// 节（level 3）：1.5em 缩进，导引点
#show outline.entry.where(level: 3): it => {
  set par(first-line-indent: 0pt)
  set text(fill: dark-blue)
  pad(left: 1.5em, link(it.element.location(), {
    let p = it.prefix()
    if p != none { p; h(0.5em) }
    it.body()
    box(width: 1fr, repeat(gap: 4.5pt)[.])
    it.page()
  }))
}

// ========== 超链接颜色 ==========
#show link: set text(fill: dark-blue)
#show ref: set text(fill: dark-blue)

// ============================================================
// 封面（无页码）
// ============================================================
#align(center + horizon)[
  #text(size: 26pt, weight: "bold")[教辅解答绘图集]
  #v(1.5em)
  #text(size: 16pt)[Typst + CeTZ 版]
  #v(1em)
  #text(size: 14pt)[K12 数学 / 物理]
]

// ============================================================
// 目录（罗马数字页码）
// ============================================================
#pagebreak()
#set page(numbering: "i")
#counter(page).update(1)
#outline(title: "目录", indent: 0pt, depth: 3)

// ============================================================
// 正文（阿拉伯数字页码）
// ============================================================
#pagebreak()
#set page(numbering: "1")
#counter(page).update(1)

#include "figures/几何作图/_chapter.typ"
#include "figures/统计图表/_chapter.typ"
#include "figures/线段图/_chapter.typ"
#include "figures/物理/_chapter.typ"

// ============================================================
// 附录
// ============================================================
#set heading(numbering: (..nums) => {
  let n = nums.pos()
  if n.len() == 1 {
    // 附录部分不编号
  } else if n.len() == 2 {
    "附录 " + numbering("A", n.at(1))
  } else {
    numbering("A.1", ..n.slice(1))
  }
})
#include "figures/附录_物理第三册_电磁/_appendix.typ"
