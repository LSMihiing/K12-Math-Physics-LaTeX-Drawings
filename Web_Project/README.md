# K12 教辅绘图前端引擎（Web Canvas Edition）

## 概述

本项目是 K12 教辅绘图体系的**第三条技术路线**，使用 HTML5 Canvas + 原生 JavaScript 绘制数学、物理试题的答案图，作为 LaTeX TikZ 和 Typst CeTZ 方案的前端交互补充。

---

## 技术栈

| 技术 | 版本 / 说明 |
|------|-----------|
| **HTML5** | 语义化结构，SEO 友好 |
| **CSS3** | 原生 CSS，深色主题 + glassmorphism 风格，CSS Custom Properties 设计令牌系统 |
| **JavaScript** | ES Modules（原生 import/export），零框架依赖 |
| **HTML5 Canvas** | 2D 绑图 API，HiDPI (Retina) 自适应 |
| **KaTeX** | v0.16.21（CDN），数学公式渲染（`$...$` 行内 / `$$...$$` 块级） |
| **Google Fonts** | Inter、Noto Sans SC、JetBrains Mono |

> **零依赖**：无需 `npm install`，无构建步骤。浏览器通过 HTTP 服务器直接运行。

---

## 目录结构

```
Web_Project/
├── index.html                          # 主页面（侧边栏 + Canvas + 解答面板）
├── README.md                           # 本文档
├── css/
│   └── styles.css                      # 全局样式 + 设计令牌
├── lib/                                # 公共绘图库
│   ├── grid-utils.js                   # 方格纸绘制
│   ├── transform.js                    # 几何变换（平移、旋转）
│   ├── label.js                        # 点标签 + 文字（LaTeX 数学字体风格）
│   └── draw-helpers.js                 # 通用图元（三角形、虚线箭头等）
└── figures/                            # 题目绘图模块（按分类组织）
    └── 几何作图/
        └── q3-triangle-transform.js    # 第3题 三角形平移旋转
```

---

## 启动方式

由于使用 ES Modules，**必须通过 HTTP 服务器访问**（`file://` 协议不支持模块导入）。

### 方式一：VSCode Live Server（推荐）

1. 安装 VSCode 扩展 `ritwickdey.liveserver`
2. 右键 `index.html` → **Open with Live Server**
3. 浏览器自动打开，支持保存后热重载

### 方式二：Node.js

```bash
npx http-server Web_Project -p 8090
```

### 方式三：Python

```bash
python -m http.server 8090 -d Web_Project
```

---

## 添加新题目

### 1. 创建题目文件

在 `figures/` 对应分类目录下新建 JS 文件，命名格式：`q{序号}-{简述}.js`

```
figures/
├── 几何作图/
│   ├── q3-triangle-transform.js    # 已有
│   └── q4-symmetry.js              # 新增示例
├── 统计图表/
│   └── q1-bar-chart.js             # 新增示例
└── 物理/
    └── q9-circuit.js               # 新增示例
```

### 2. 文件结构模板

每个题目文件需导出以下 4 项：

```javascript
import { drawGrid } from '../../lib/grid-utils.js';
import { drawDotLabel } from '../../lib/label.js';
// ... 按需引入其他公共库

// ① 题目元数据
export const meta = {
  id: 'q4',
  title: '第4题 · 轴对称图形',
  category: '几何作图',
  // 使用 $...$ 包裹 LaTeX 公式，KaTeX 自动渲染
  description: '在方格纸中画出 $\\triangle ABC$ 关于直线 $l$ 的对称图形。',
  subQuestions: [
    "（1）画出 $\\triangle ABC$ 关于 $l$ 的对称三角形 $\\triangle A'B'C'$。",
  ],
};

// ② 解答步骤
export const solutionSteps = [
  {
    title: '（1）轴对称变换',
    content: "找到各顶点关于 $l$ 的对称点：",
    formula: "$(x, y) \\rightarrow (2a - x, y)$",  // 可选
    details: [
      "$A(1,\\, 3) \\rightarrow A'(5,\\, 3)$",
    ],
    summary: "连接 $A'B'C'$ 即得对称三角形。",
  },
];

// ③ 绘制题目原图
export function drawProblem(canvas) {
  const ctx = canvas.getContext('2d');
  // ... 绘图逻辑
}

// ④ 绘制答案图
export function drawAnswer(canvas) {
  const ctx = canvas.getContext('2d');
  // ... 绘图逻辑
}
```

### 3. 注册到主页面

在 `index.html` 中：

**侧边栏** — 在对应分类的 `<ul class="problem-list">` 中添加：

```html
<li class="problem-item" data-id="q4">
  <span class="item-badge">4</span>
  <span>轴对称图形</span>
</li>
```

**脚本** — 在 `<script type="module">` 中导入并注册：

```javascript
import { meta as q4Meta, solutionSteps as q4Steps,
         drawProblem as q4Problem, drawAnswer as q4Answer
} from './figures/几何作图/q4-symmetry.js';
```

---

## 公共绘图库 API

### `grid-utils.js` — 方格纸

```javascript
drawGrid(ctx, {
  originX: 40,      // 起点 X（像素）
  originY: 40,      // 起点 Y（像素）
  cols: 16,          // 列数
  rows: 14,          // 行数
  step: 40,          // 每格像素
  lineColor: '#c8c8c8',
  lineWidth: 0.6,
});
```

### `transform.js` — 几何变换

```javascript
translate([x, y], dx, dy)           // → [x+dx, y+dy]
rotateCW90([x, y], [cx, cy])        // 顺时针 90° 旋转
rotatePoint([x, y], [cx, cy], deg)  // 任意角度旋转（正值=顺时针）
```

### `label.js` — 标签

```javascript
// 绘制顶点圆点 + 文字标签
drawDotLabel(ctx, x, y, 'A', {
  dir: 'ne',             // 标签方向：n/s/e/w/ne/nw/se/sw
  dotRadius: 3,
  dotColor: '#222',
  textColor: '#333',
  offset: 14,            // 文字偏移像素
});

// 绘制较大圆点（旋转中心等）
drawCenterDot(ctx, x, y, 'O', { radius: 5, color: '#DC2626' });
```

### `draw-helpers.js` — 通用图元

```javascript
// 三角形（描边 + 可选填充）
drawTriangle(ctx, [[x1,y1], [x2,y2], [x3,y3]], {
  strokeColor: '#2563EB',
  lineWidth: 1.8,
  fillColor: 'rgba(219, 234, 254, 0.45)',  // null = 不填充
});

// 虚线箭头
drawDashedArrow(ctx, x1, y1, x2, y2, {
  color: '#999',
  lineWidth: 1,
  arrowSize: 8,
  dashPattern: [6, 4],
});
```

---

## 样式注意事项

### 颜色规范

在 `css/styles.css` 中通过 CSS Custom Properties 定义了完整的设计令牌系统：

| 变量 | 值 | 用途 |
|------|-----|------|
| `--bg-primary` | `#0f1117` | 页面背景 |
| `--bg-card` | `#1c1e2e` | 卡片/面板背景 |
| `--bg-canvas` | `#ffffff` | Canvas 画布背景（白色） |
| `--accent-blue` | `#4F8EF7` | 主强调色（按钮、链接） |
| `--accent-red` | `#EF5350` | 红色强调（旋转图形） |
| `--accent-green` | `#66BB6A` | 绿色（状态标识） |
| `--accent-purple` | `#AB47BC` | 紫色（公式块） |

### Canvas 绘图颜色对标

与 Typst 版本保持一致的颜色映射：

| 元素 | Canvas 颜色 | 对标 Typst |
|------|------------|-----------|
| 原图三角形 | `#222` (黑色) | `black` |
| 平移后三角形 | `#2563EB` (蓝色) | `rgb("#2563EB")` |
| 平移填充 | `rgba(219,234,254,0.45)` | `rgb("#DBEAFE").transparentize(50%)` |
| 旋转后三角形 | `#DC2626` (红色) | `rgb("#DC2626")` |
| 旋转填充 | `rgba(254,226,226,0.45)` | `rgb("#FEE2E2").transparentize(50%)` |
| 辅助箭头 | `#999` | `luma(120)` |

### Canvas 标签字体

标签使用 **斜体衬线字体**（模拟 LaTeX 数学排版风格）：

```
italic 14px "Times New Roman", "KaTeX_Math", serif
```

如需修改默认字体，编辑 `lib/label.js` 中的 `font` 参数默认值。

### KaTeX 数学公式

- **行内公式**：使用 `$...$` 包裹，如 `$\\triangle ABC$`
- **块级公式**：使用 `$$...$$` 包裹
- JS 字符串中反斜杠需要转义：`\\triangle` → 运行时 `\triangle`
- KaTeX CDN 版本：0.16.21（通过 `<script defer>` 异步加载）
- 渲染时机：页面 DOM 填充完毕后调用 `renderMathInElement(document.body)`

### 坐标系转换

Canvas 的 Y 轴向下，而数学坐标系 Y 轴向上。使用以下公式转换：

```javascript
// 逻辑坐标 → Canvas 像素坐标
function toCanvas(logicPt, step, padding, gridRows) {
  return [
    padding + logicPt[0] * step,           // X: 直接映射
    padding + (gridRows - logicPt[1]) * step,  // Y: 翻转
  ];
}
```

### HiDPI 适配

Canvas 已内置 HiDPI 支持（`devicePixelRatio`）。绘图函数接收的 `canvas` 对象返回**逻辑尺寸**，无需额外处理。

---

## 与 Typst / LaTeX 项目的关系

本项目与同目录下的 `Typst_Project` 和 `LaTeX_Project` 形成三轨并行体系：

| 维度 | LaTeX TikZ | Typst CeTZ | **Web Canvas** |
|------|-----------|-----------|---------------|
| 输出格式 | PDF | PDF | 浏览器实时渲染 |
| 编译速度 | 慢（XeLaTeX） | 快 | 即时 |
| 交互性 | 无 | 无 | 视图切换、折叠面板 |
| 数学公式 | 原生 TeX | 原生 Typst | KaTeX |
| 适用场景 | 正式印刷出版 | 快速预览迭代 | 在线展示、Web 集成 |

题目文件在三个项目间保持 **坐标和颜色的一一对应**，确保任何修改可以跨项目同步。
