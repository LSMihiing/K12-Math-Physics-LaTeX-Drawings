// ============================================================
// 第五章 项目架构与工作流
// ============================================================

=== 项目结构解读

本项目采用三层架构，实现内容与样式分离：

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  fill: luma(245),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #set text(size: 9pt)
  ```
  Typst_Project/
  ├── main.typ                      ← 主入口：全局样式 + #include 各部分
  ├── lib/
  │   ├── styles.typ                ← 公共工具函数（solution、problem-title）
  │   ├── grid-utils.typ            ← 网格绘制工具
  │   └── geo-utils.typ             ← 几何图形工具
  └── figures/
      ├── 教程/_tutorial.typ         ← 本教程
      ├── 几何作图/
      │   ├── _chapter.typ           ← 章节聚合（import + heading + render）
      │   ├── 尺规取等长线段.typ     ← 具体绘图模块
      │   └── ...
      ├── 统计图表/_chapter.typ + ...
      ├── 线段图/_chapter.typ + ...
      ├── 物理/_chapter.typ + ...
      └── 附录_物理第三册_电磁/_appendix.typ + ...
  ```
]

==== 数据流

#v(0.5em)
#table(
  columns: (auto, auto, 1fr),
  inset: 8pt,
  align: left,
  table.header(
    [*文件*], [*关键字*], [*作用*],
  ),
  [`main.typ`], [`#include`], [引入 `_chapter.typ`，不导入具体函数],
  [`_chapter.typ`], [`#import ... as _xx`], [导入绘图模块 + 安排标题层级 + 调用 `render()`],
  [`*.typ`], [`#let render() = {...}`], [导出唯一函数，包含题目+绘图+解答],
)

=== 样式系统

本项目的排版风格模仿 `ctexbook` 中文排版方案。

==== 标题编号

#v(0.5em)
#table(
  columns: (auto, auto, 1fr),
  inset: 8pt,
  align: left,
  table.header(
    [*层级*], [*编号格式*], [*样式*],
  ),
  [`=` (level 1)], [第一部分、第二部分...], [独占一页居中，22pt 粗体],
  [`==` (level 2)], [1.1、1.2...], [新起一页居中，18pt 粗体],
  [`===` (level 3)], [1.1.1、1.1.2...], [居中，14pt 粗体],
)

==== 页码方案

#v(0.5em)
#table(
  columns: (auto, 1fr),
  inset: 8pt,
  align: left,
  table.header(
    [*区域*], [*页码格式*],
  ),
  [封面], [无页码],
  [目录], [罗马数字 i, ii, iii...],
  [正文], [阿拉伯数字 1, 2, 3...],
)

==== 目录样式

- Level 1/2：粗体，无导引点
- Level 3：带导引点的深蓝色链接

参见 `main.typ` 第 106–163 行的目录条目样式定义。

// 参考：https://typst.app/docs/reference/model/outline

=== 添加新绘图

完整流程（详见 `CONTRIBUTING.md`）：

#block(
  width: 100%,
  inset: (x: 1em, y: 0.6em),
  stroke: (left: 2pt + rgb("#4A90D9")),
  fill: rgb("#F0F6FF"),
  radius: 2pt,
)[
  #set par(first-line-indent: 0em)
  #text(weight: "bold", fill: rgb("#4A90D9"))[新增绘图 4 步]
  #v(0.3em)
  #set text(size: 9.5pt)

  *第 1 步*：创建绘图文件 `figures/{分类}/{描述性名称}.typ`
  ```typst
  #import "@preview/cetz:0.4.2"
  #let render() = {
    // 题目 + 绘图 + 解答
  }
  ```

  *第 2 步*：在 `_chapter.typ` 中注册
  ```typst
  #import "新绘图.typ" as _新绘图    // 顶部追加
  === 新绘图标题                      // 对应位置追加
  #_新绘图.render()
  ```

  *第 3 步*：编译验证
  ```
  typst compile main.typ output/main.pdf --root .
  ```

  *第 4 步*：提交
  ```
  git add -A && git commit -m "feat: 新增XXX绘图"
  ```
]

=== LaTeX 参考资源

本项目有两类 LaTeX 参考：

==== 自有案例（315 tikz）

`LaTeX_Project/数学/` 和 `LaTeX_Project/物理/` 中的 315 个成熟 TikZ 案例。

#v(0.5em)
#table(
  columns: (auto, auto, 1fr),
  inset: 8pt,
  align: left,
  table.header(
    [*分类*], [*tikz 数*], [*高频文件*],
  ),
  [几何作图], [\~135], [分数涂色(32)、标准几何(21)、垂线平行(12)],
  [统计图表], [\~76], [条形统计图(15)、频数直方图(12)],
  [线段图], [\~74], [数轴与不等式(62)],
  [物理], [\~18], [综合受力分析(7)],
)

==== 外部教材参考（1155 张）

`LaTeX_Project/附录_参考绘图/` 中 6 本教材的 TikZ/circuitikz 绘图。

*使用方式*：
+ 按题型在索引中查找最接近的分类
+ 打开对应 `.tex` 文件阅读 TikZ 源码
+ 参考绘图原理（坐标布局、元素分层），翻译为 CeTZ 代码
