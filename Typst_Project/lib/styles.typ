// ============================================================
// styles.typ — 公共工具函数（题目/解答/图片容器）
// ============================================================

// --- 题目标题 ---
#let problem-title(number, content) = {
  v(0.8em)
  set par(first-line-indent: 0em)
  text(weight: "bold", size: 12pt)[#number. #content]
  v(0.4em)
}

// --- 小问编号 ---
#let sub-question(number, content) = {
  set par(first-line-indent: 0em)
  h(2em)
  text[（#number）#content]
}

// --- 解答块 ---
#let solution(body) = {
  v(0.5em)
  set par(first-line-indent: 0em)
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 2.5pt + rgb("#4A90D9")),
    fill: rgb("#F0F6FF"),
    radius: 2pt,
  )[
    #text(weight: "bold", fill: rgb("#4A90D9"))[解答]
    #v(0.3em)
    #body
  ]
}

// --- 图片居中容器 ---
#let center-figure(body, caption: none) = {
  v(0.3em)
  align(center, body)
  if caption != none {
    align(center, text(size: 9pt, fill: luma(100))[#caption])
  }
  v(0.3em)
}
