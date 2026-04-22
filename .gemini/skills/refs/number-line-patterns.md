# 数轴与不等式绘图模式参考

## 核心模式：可复用的 `draw-inequality()` 函数

项目中已建立了一个高度可复用的数轴绘制函数。新的数轴题应遵循此模式。

### 公共样式

```typst
#let axis-stroke = 0.8pt + black
#let tick-stroke = 0.8pt + black
#let sol-stroke = 1.5pt + rgb("#0000CD")   // 解集线：蓝色
#let radius-size = 0.08                     // 圆圈大小
#let tick-y = -0.3                          // 刻度标注 y 偏移
#let tick-size = 11pt                       // 刻度文字大小
```

### draw-inequality() 函数

```typst
#let draw-inequality(min-val, max-val, sol-val, sol-type, sol-dir, label-val: none) = {
  import cetz.draw: *

  // 1. 数轴主线（带箭头）
  line((min-val - 0.5, 0), (max-val + 0.8, 0), 
    mark: (end: "stealth", fill: black, size: 0.25), stroke: axis-stroke)

  // 2. 整数刻度 + 数字标注
  for i in range(int(calc.floor(min-val)), int(calc.ceil(max-val)) + 1) {
    line((i, 0), (i, 0.15), stroke: tick-stroke)
    // 负号特殊处理（避免变连字符）
    let label-text = if i < 0 { [$-$#calc.abs(i)] } else { str(i) }
    content((i, tick-y))[#text(size: tick-size)[#label-text]]
  }

  // 3. 特殊数值标记（如分数 2/5）
  if label-val != none {
    line((sol-val, 0), (sol-val, 0.15), stroke: tick-stroke)
    content((sol-val, tick-y - 0.35))[#text(size: tick-size)[#label-val]]
  }

  // 4. 解集折线箭头（先竖直上升，再水平延伸）
  let start-y = 0.6
  let end-x = if sol-dir == "right" { max-val + 0.6 } else { min-val - 0.3 }
  line((sol-val, radius-size), (sol-val, start-y), (end-x, start-y), 
    mark: (end: "stealth", fill: rgb("#0000CD"), size: 0.25), stroke: sol-stroke)

  // 5. 端点标记
  if sol-type == "open" {
    // 开区间：空心圆（不包含端点）
    circle((sol-val, 0), radius: radius-size, fill: white, stroke: sol-stroke)
  } else {
    // 闭区间：实心圆（包含端点）
    circle((sol-val, 0), radius: radius-size, fill: rgb("#0000CD"), stroke: none)
  }
}
```

### 调用示例

```typst
// x > -4（开区间，向右）
#let figure-1 = cetz.canvas(length: 0.8cm, {
  draw-inequality(-6, 2, -4, "open", "right")
})

// x ≤ -3（闭区间，向左）
#let figure-4 = cetz.canvas(length: 0.8cm, {
  draw-inequality(-6, 1, -3, "closed", "left")
})

// x > 2/5（带分数标注）
#let figure-3 = cetz.canvas(length: 1.4cm, {
  draw-inequality(-1, 2, 0.4, "open", "right", label-val: $2/5$)
})
```

---

## 不等式组（交集）

对于不等式组，需要在同一数轴上表示两个不等式的解集，并标出交集。

### 布局模式

```typst
// 三行结构：不等式1的数轴、不等式2的数轴、交集数轴
// 左侧标注不等式表达式，右侧画数轴

// 使用 grid 进行两列排布
grid(
  columns: (1fr, 1fr),
  row-gutter: 2.5em,
  align: center,
  [#figure-1 \ #v(0.5em) #text(size: 9pt)[图（1）]],
  [#figure-2 \ #v(0.5em) #text(size: 9pt)[图（2）]],
)
```

---

## 关键细节

### 负号显示

```typst
// ⚠️ 直接写 -3 可能显示为连字符
// 正确做法：
let label-text = if i < 0 { [$-$#calc.abs(i)] } else { str(i) }
```

### 数轴参数选择

- `min-val` 和 `max-val` 应覆盖解集端点前后至少 2-3 个整数
- `canvas(length: 0.8cm)` 适合整数解；`length: 1.4cm` 适合需要标分数的场景
- 解集折线的高度 `start-y = 0.6` 统一不变

### 开区间 vs 闭区间

| 不等式 | sol-type | 端点样式 |
|--------|----------|----------|
| x > a 或 x < a | `"open"` | 空心圆（白色填充 + 蓝色描边） |
| x ≥ a 或 x ≤ a | `"closed"` | 实心圆（蓝色填充，无描边） |

### 解集方向

| 不等式 | sol-dir | 箭头方向 |
|--------|---------|----------|
| x > a 或 x ≥ a | `"right"` | 向右 |
| x < a 或 x ≤ a | `"left"` | 向左 |
