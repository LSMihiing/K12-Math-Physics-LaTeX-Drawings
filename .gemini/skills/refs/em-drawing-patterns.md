# 电磁绘图模式参考（TikZ → CeTZ 翻译指南）

## 已完成的 Typst 重构映射

### 磁场（22 tikz）→ `Typst_Project/figures/附录_物理第三册_电磁/磁场/`

| Typst 文件 | LaTeX 源 | 主题 | 关键技术 |
|-----------|----------|------|---------|
| tikz_001.typ | 1.tex:112 | 磁感线环绕导线 | 同心圆弧+箭头 |
| tikz_002.typ | 1.tex:167 | 通电螺线管磁场 | 半弧交替模拟线圈 |
| tikz_003.typ | 1.tex:282 | 磁通量 | 倾斜矩形+法线箭头 |
| tikz_004.typ | 1.tex:310 | 直线电流磁场 | 同心虚线圆 |
| tikz_005.typ | 1.tex:344 | 安培力F方向 | 三维坐标箭头组 |
| tikz_006.typ | 1.tex:396 | 安培力F平行导线 | 双导线+力向量 |
| tikz_007.typ | 1.tex:412 | 安培力矩形线圈 | 矩形+force pair |
| tikz_008.typ | 1.tex:447 | 安培力应用 | 多场景子图 |
| tikz_009.typ | 1.tex:482 | 磁场力受力 | ×磁场+力箭头 |
| tikz_010.typ | 1.tex:497 | 导体棒受力 | 平行板+导体棒 |
| tikz_011.typ | 1.tex:556 | 电流表原理 | 旋转线圈+指针 |
| tikz_012.typ | 1.tex:584 | 电流表侧视图 | ×/·标记+力向量 |
| tikz_013.typ | 1.tex:695 | 洛伦兹力×阵列 | 4×4 foreach |
| tikz_014.typ | 1.tex:705 | 洛伦兹力多场景 | 4面板并排 |
| tikz_015.typ | 1.tex:754 | 圆形轨迹 | circle+tangent |
| tikz_016.typ | 1.tex:878 | 质谱仪D极板 | D形+间隙 |
| tikz_017.typ | 1.tex:912 | 回旋加速器轨迹 | 递增半径半弧 |
| tikz_018.typ | 1.tex:954 | 回旋加速器侧视 | 极板+虚线弧 |
| tikz_019.typ | 1.tex:974 | 回旋加速器反向E | 箭头反向 |
| tikz_020.typ | 1.tex:1084 | 多弧轨迹 | 公共原点O弧线 |
| tikz_021.typ | 1.tex:1101 | 负电荷半圆 | A→B半圆 |
| tikz_022.typ | 1.tex:1147 | 倾斜入射+极板 | bezier轨迹 |

### 电磁感应（5 tikz + 10 circuit）→ `Typst_Project/figures/附录_物理第三册_电磁/电磁感应/`

| Typst 文件 | LaTeX 源 | 主题 | 关键技术 |
|-----------|----------|------|---------|
| tikz_001.typ | 2.tex:86 | 导体板穿过磁感线 | 板+层叠B线 |
| tikz_002.typ | 2.tex:102 | ×磁场中矩形线圈 | 矩形+旋转轴 |
| tikz_003.typ | 2.tex:188 | 涡流环A(交替方向) | 同心环+方向弧 |
| tikz_004.typ | 2.tex:209 | 涡流环B(同向) | 同心环+同向弧 |
| tikz_010.typ | 2.tex:419 | 椭圆线圈+⊙符号 | 椭圆弧+⊙ |
| *circuit_005~015* | 2.tex | 电磁感应电路 | **Phase4已完成（10张）** |

### 交流电（20 tikz + 29 circuit）→ `Typst_Project/figures/附录_物理第三册_电磁/交流电/`

| Typst 文件 | LaTeX 源 | 主题 | 关键技术 |
|-----------|----------|------|---------|
| tikz_001.typ | 3.tex:64 | 旋转线圈(ωt) | 旋转矩形+角度弧 |
| tikz_002.typ | 3.tex:139 | 含初相位φ₀ | 两个旋转位置 |
| tikz_003.typ | 3.tex:189 | φ₀=π/6正弦波 | sine-points工具 |
| tikz_004.typ | 3.tex:261 | 同相不同振幅 | 双波+φ₀标注 |
| tikz_005.typ | 3.tex:279 | 反相正弦波 | amp取负 |
| tikz_006.typ | 3.tex:297 | 不同初相+Δφ | 三层φ标注 |
| tikz_007.typ | 3.tex:326 | 余弦电流波 | cos+时间刻度 |
| tikz_008.typ | 3.tex:346 | 不同频率 | 双波φ₁/φ₂ |
| tikz_010.typ | 3.tex:387 | 纯R电路u/i同相 | 双幅同频 |
| tikz_018.typ | 3.tex:674 | 电感：u超前i | 相位差虚线 |
| tikz_019.typ | 3.tex:699 | 电容：i超前u | 相位差虚线 |
| tikz_025.typ | 3.tex:1207 | 半波整流 | 三组坐标轴 |
| tikz_026.typ | 3.tex:1285 | 全波整流 | 负半周翻转 |
| tikz_028.typ | 3.tex:1378 | 滤波甲乙丙 | 偏移正弦波 |
| tikz_030.typ | 3.tex:1417 | 滤波前后对比 | dashed+折线 |
| tikz_032.typ | 3.tex:1452 | 全波整流+滤波 | abs-sine |
| tikz_036.typ | 3.tex:1541 | 三相发电机截面 | 圆+旋转矩形+N/S |
| tikz_038.typ | 3.tex:1602 | 三相电动势 | 3相sine相位差 |
| tikz_043.typ | 3.tex:1741 | 三相电流ia/ib/ic | 花括号标注 |
| tikz_047.typ | 3.tex:1875 | 感应电动机 | T/3时间标注 |
| *circuit_009~035* | 3.tex | 交流电路(简单) | **Phase4已完成（12张）** |
| *circuit_022~034,037~049* | 3.tex | 变压器/三相(复杂) | **跳过：铁芯/线圈质量不佳** |

### 电磁振荡和电磁波（4 tikz + 5 circuit）→ `Typst_Project/figures/附录_物理第三册_电磁/电磁振荡和电磁波/`

| Typst 文件 | LaTeX 源 | 主题 | 关键技术 |
|-----------|----------|------|---------|
| tikz_002.typ | 4.tex:56 | 无阻尼振荡 | cos(4.5x) |
| tikz_003.typ | 4.tex:63 | 阻尼振荡 | exp(-x)*cos |
| tikz_004.typ | 4.tex:139 | E/B场电容器 | 椭圆+虚线圆 |
| tikz_005.typ | 4.tex:183 | 三时刻E场传播 | 3组轴+λ+方向箭头 |
| *circuit_001,006~009* | 4.tex | 振荡电路 | **待Phase4重构** |

### _sine_utils.typ 正弦波工具（交流电目录下）

```typst
#import "交流电/_sine_utils.typ": sine-points, abs-sine-points
// sine-points(start, end, amp:, freq:, phase:, offset-y:, samples:)
// abs-sine-points(同上) — 全波整流|sin(x)|
```

---

## TikZ → CeTZ 核心映射表

### 线宽映射
| TikZ | 实际宽度 | CeTZ |
|------|---------|------|
| `ultra thin` | 0.1pt | `stroke: 0.1pt + black` |
| `thin` (默认) | 0.4pt | `stroke: 0.4pt + black` |
| `thick` | 0.8pt | `stroke: 0.8pt + black` |
| `very thick` | 1.2pt | `stroke: 1.2pt + black` |
| `ultra thick` | 1.6pt | `stroke: 1.6pt + black` |

### 箭头映射
| TikZ | CeTZ |
|------|------|
| `>=latex` / `>=stealth` | `mark: (end: "stealth", fill: black)` |
| `->` | `mark: (end: "stealth", fill: black)` |
| `<->` | `mark: (start: "stealth", end: "stealth", fill: black)` |

### 虚线映射
| TikZ | CeTZ |
|------|------|
| `dashed` | `stroke: (dash: "dashed")` |
| `dotted` | `stroke: (dash: "dotted")` |

### 缩放映射
| TikZ | CeTZ | 说明 |
|------|------|------|
| `scale=0.7` | `cetz.canvas(length: 0.7cm, ...)` | 均匀缩放 |
| `xscale=1.5` | 手动：所有 x 坐标 ×1.5 | CeTZ 无内置 xscale |
| `rotate=-30` | 手动旋转矩阵计算顶点 | |

### 关键语法差异

#### arc（最易出错！）
```
TikZ:  \draw (x,y) arc (start:end:radius);   → 起点在 (x,y)
CeTZ:  arc((cx,cy), start: ..deg, stop: ..deg, radius: r, anchor: "origin")
       → 必须加 anchor: "origin"！否则位置偏移
```

#### node → content
```
TikZ:  \node at (x,y) {$F$};
CeTZ:  content((x, y), $F$)   // 手动偏移，无自动 [above]
```

#### foreach → for
```
TikZ:  \foreach \x in {1,...,4}
CeTZ:  for x in range(1, 5)   // 左闭右开
```

#### plot → sine-points 点列
```
TikZ:  \draw plot[domain=0:2*pi]{sin(\x r)};
CeTZ:  let pts = sine-points(0, 2*pi, amp: 1)
       line(..pts, stroke: 1.2pt + black)
```

#### fill pattern → 手绘斜线
```
TikZ:  \fill[pattern=north east lines] ...
CeTZ:  for i in range(N) { line((x+i*s, y0), (x+i*s+h, y1), stroke: 0.3pt) }
```

#### ellipse → arc with tuple radius
```
TikZ:  \draw (0,0) ellipse [x radius=2, y radius=0.5];
CeTZ:  arc((0,0), start: 0deg, stop: 360deg, radius: (2, 0.5), anchor: "origin")
```

---

## 电磁特有绘图元素

### 电流方向符号
```typst
// ⊗ 入纸面（×）
circle((x, y), radius: 0.15, fill: white, stroke: 0.8pt + black)
content((x, y), text(size: 8pt)[$times$])

// ⊙ 出纸面（·）
circle((x, y), radius: 0.15, fill: white, stroke: 0.8pt + black)
circle((x, y), radius: 0.04, fill: black, stroke: none)
```

### 磁感线组（平行箭头）
```typst
for y in (0.25, 0.75, -0.25, -0.75) {
  line((-2, y), (2, y), stroke: 0.4pt + black,
    mark: (end: "stealth", fill: black))
}
content((2.5, 0), text(size: 9pt)[$B$])
```

### 正弦波（_sine_utils.typ）
```typst
#import "_sine_utils.typ": sine-points, abs-sine-points
let pts = sine-points(0, 2*pi, amp: 1.5, phase: pi/3, offset-y: -3)
line(..pts, stroke: 1.6pt + black)
```

### 旋转矩形（线圈）
```typst
let angle = -30deg
let c = calc.cos(angle); let s = calc.sin(angle)
let rot(px, py) = (px*c - py*s, px*s + py*c)
let p1 = rot(-1.5, -0.07); let p2 = rot(1.5, -0.07)
let p3 = rot(1.5, 0.07); let p4 = rot(-1.5, 0.07)
line(p1, p2, p3, p4, close: true, stroke: 0.8pt + black)
```

### 三相波形（120°相位差）
```typst
for (phase, label) in ((0, $i_a$), (2*pi/3, $i_b$), (4*pi/3, $i_c$)) {
  let pts = sine-points(0, 2*pi, amp: 1.5, phase: phase)
  line(..pts, stroke: 1.2pt + black)
}
```

---

## 重构流程（每张图）

1. **逐行阅读** LaTeX 源码，记录 scale/xscale/yscale、线宽、箭头
2. **列出所有坐标**，手工应用缩放计算最终值
3. **按映射表翻译**每个 TikZ 命令
4. **单独编译**验证：`typst compile file.typ --root .`
5. **注册到 `_appendix.typ`**，再次编译验证

## 常见 Bug 与修复

| 问题 | 原因 | 修复 |
|------|------|------|
| 坐标变成 4-tuple | `(a,b)+(c,d)` 在 Typst 是拼接不是加法 | 用 `(a+c, b+d)` 显式计算 |
| arc 位置偏移 | 缺少 `anchor: "origin"` | 必须加 `anchor: "origin"` |
| 找不到文件 | 绝对路径 `/figures/...` 在 --root 下不对 | 改用相对路径 `../ ` |
| 正弦波失真 | samples 不够 | sine-points 默认 100 samples 足够 |

---

## 电路图绘制技巧（Phase 4 经验总结）

### _circuit_utils.typ API（v3）

位于 `Typst_Project/figures/附录_物理第三册_电磁/_circuit_utils.typ`

| 函数 | 参数 | 用途 |
|------|------|------|
| `draw-battery(from, to)` | 两端坐标 | 电池(长短线) |
| `draw-switch(from, to)` | 两端坐标 | 开关(圆点+翻转片) |
| `draw-resistor(from, to, label:)` | 两端+可选标签 | 电阻(白底矩形) |
| `draw-inductor(from, to, coils:, mirror:)` | 两端+圈数+镜像 | 电感(波浪线) |
| `draw-lamp(from, to, r:)` | 两端+半径 | 灯泡(白底圆+×) |
| `draw-meter(from, to, label:, r:)` | 两端+标签+半径 | 仪表(白底圆+字母) |
| `draw-capacitor(from, to)` | 两端坐标 | 电容(两平行线) |
| `draw-diode(from, to, sz:)` | 两端+大小 | 二极管(实心▶+bar) |
| `draw-ac-source(x, y-bot, y-top)` | 位置 | AC源(断口+~) |
| `draw-core(x, yb, yt, gap:)` | 铁芯位置 | 铁芯(双竖粗线) |

### ⚠️ 关键绘制规则（易犯错点）

#### 1. 方向感知连接
```
❌ 错误：line(from, (mx-hw, my)) // 不管from在左还是右
✅ 正确：let (ef, et) = _edges(x1, x2, mx, hw)
         line(from, (ef, my))  // ef总是靠近from那侧
```
**原因**：元件函数必须处理 from→to 和 to→from 双向。用 `_edges()`/`_vedges()` 计算方向感知的连接点。

#### 2. 白色填充遮罩
```
❌ 错误：rect(..., stroke: _s)  // 透明背景，背后的线穿透
✅ 正确：rect(..., fill: white, stroke: _s)  // 白底阻挡
```
**所有闭合元件（rect/circle）必须 `fill: white`**，否则之前绘制的导线会穿透元件。

#### 3. 电感白底遮罩
```
// 弧线不闭合，需要额外画白色 rect 遮罩弧线区域
rect((sx-0.03, y1-0.06), (ex+0.03, y1+r+0.06), fill: white, stroke: none)
for i in range(0, coils) {
  arc((...), fill: white, stroke: _s)  // 每个弧线也要白底
}
```

#### 4. 分支接线连续性
```
❌ 错误：line(fork, (1.5, 2.3))  // 到达中间点
         draw-resistor((1, 1.6), ...)  // R从别处开始，中间有空隙！
✅ 正确：line(fork, (1, 1.6))  // 直接画到R的起点
         draw-resistor((1, 1.6), ...)  // 无缝衔接
```
**分叉后必须连续画到下一个元件的起点，不能留空隙。**

#### 5. 二极管实心三角
```
❌ 错误：三条线围成空心三角
✅ 正确：line(bl, tip, br, close: true, fill: black, stroke: _s)
```
**必须 `close: true, fill: black`，用方向向量+垂直向量计算三角顶点。**

#### 6. 变压器线圈相对
```
// 一次线圈bumps朝右（默认）
draw-inductor((2, 0), (2, 2.8), coils: 6)
// 二次线圈bumps朝左（mirror: true）
draw-inductor((1.5, 0), (1.5, 3), coils: 5, mirror: true)
```
**变压器的两个线圈bumps应面向铁芯（相对）。**

#### 7. 铁芯标注避让
**铁芯 `draw-core` 画在线圈 bumps 外侧。n₁/n₂ 标注放在空白区域，不要与铁芯线重叠。**

### ⚠️ 已知局限

| 元件 | 问题 | 状态 |
|------|------|------|
| 铁芯变压器 | 铁芯定位困难，与线圈/标注重叠 | **暂不重构** |
| 三相线圈 | 非轴对齐的电感绘制质量差 | **暂不重构** |
| 滑动变阻器 | 三端接线复杂 | **需手动调整** |
