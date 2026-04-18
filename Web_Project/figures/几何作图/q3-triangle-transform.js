// ============================================================
// q3-triangle-transform.js
// 第3题 · 三角形平移与旋转（方格纸）
// 完全对标 Typst 版本
// ============================================================

import { drawGrid } from '../../lib/grid-utils.js';
import { translate, rotateCW90 } from '../../lib/transform.js';
import { drawDotLabel, drawCenterDot } from '../../lib/label.js';
import { drawTriangle, drawDashedArrow } from '../../lib/draw-helpers.js';

// ==========================================
// 题目元数据
// ==========================================
export const meta = {
  id: 'q3',
  title: '第3题 · 三角形平移与旋转',
  category: '几何作图',
  description: '如图，方格纸中每个小正方形的边长都是 $1$ 个单位长度。已知 $\\triangle ABC$ 的三个顶点都在格点上，请按要求画出三角形。',
  subQuestions: [
    "（1）将 $\\triangle ABC$ 先向上平移 $1$ 个单位长度再向右平移 $2$ 个单位长度，得到 $\\triangle A'B'C'$；",
    "（2）将 $\\triangle A'B'C'$ 绕格点 $O$ 按顺时针方向旋转 $90\\degree$，得到 $\\triangle A''B''C''$。",
  ],
};

// ==========================================
// 坐标定义（逻辑坐标，每格 = 1 单位）
// ==========================================
const ptA = [1, 5];
const ptB = [5, 5];
const ptC = [6, 10];
const ptO = [8, 3];

// (1) 平移后 △A′B′C′：向上 1，向右 2
const ptA1 = translate(ptA, 2, 1);  // [3, 6]
const ptB1 = translate(ptB, 2, 1);  // [7, 6]
const ptC1 = translate(ptC, 2, 1);  // [8, 11]

// (2) 顺时针旋转 90°（绕 O）
const ptA2 = rotateCW90(ptA1, ptO); // [11, 8]
const ptB2 = rotateCW90(ptB1, ptO); // [11, 4]
const ptC2 = rotateCW90(ptC1, ptO); // [16, 3]

// ==========================================
// 解答步骤数据
// ==========================================
export const solutionSteps = [
  {
    title: '（1）平移变换',
    content: "将 $\\triangle ABC$ 各顶点向上平移 $1$ 格、向右平移 $2$ 格：",
    details: [
      `$A(${ptA[0]},\\, ${ptA[1]}) \\rightarrow A'(${ptA1[0]},\\, ${ptA1[1]})$`,
      `$B(${ptB[0]},\\, ${ptB[1]}) \\rightarrow B'(${ptB1[0]},\\, ${ptB1[1]})$`,
      `$C(${ptC[0]},\\, ${ptC[1]}) \\rightarrow C'(${ptC1[0]},\\, ${ptC1[1]})$`,
    ],
    summary: "连接 $A'B'C'$ 即得 $\\triangle A'B'C'$（蓝色三角形）。",
  },
  {
    title: "（2）顺时针旋转 $90\\degree$",
    content: `将 $\\triangle A'B'C'$ 绕 $O(${ptO[0]},\\, ${ptO[1]})$ 顺时针旋转 $90\\degree$。`,
    formula: "$(x,\\, y) \\rightarrow (c_x + (y - c_y),\\; c_y - (x - c_x))$",
    details: [
      `$A'(${ptA1[0]},\\, ${ptA1[1]}) \\rightarrow A''(${ptA2[0]},\\, ${ptA2[1]})$`,
      `$B'(${ptB1[0]},\\, ${ptB1[1]}) \\rightarrow B''(${ptB2[0]},\\, ${ptB2[1]})$`,
      `$C'(${ptC1[0]},\\, ${ptC1[1]}) \\rightarrow C''(${ptC2[0]},\\, ${ptC2[1]})$`,
    ],
    summary: "连接 $A''B''C''$ 即得 $\\triangle A''B''C''$（红色三角形）。",
  },
];

// ==========================================
// 网格参数
// ==========================================
const GRID_COLS = 16;
const GRID_ROWS = 14;

// ==========================================
// 坐标转换：逻辑坐标 → Canvas 像素坐标
// Canvas Y 轴向下，逻辑 Y 轴向上，需翻转
// ==========================================
function toCanvas(logicPt, step, padding, gridRows) {
  return [
    padding + logicPt[0] * step,
    padding + (gridRows - logicPt[1]) * step,
  ];
}

// ==========================================
// 绘制题目原图（仅 △ABC 和 O）
// ==========================================
export function drawProblem(canvas) {
  const ctx = canvas.getContext('2d');
  const step = Math.min(
    (canvas.width - 80) / GRID_COLS,
    (canvas.height - 80) / GRID_ROWS,
  );
  const padding = 40;

  // 调整 canvas 实际使用大小
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  const toC = (pt) => toCanvas(pt, step, padding, GRID_ROWS);

  // 方格纸
  drawGrid(ctx, {
    originX: padding,
    originY: padding,
    cols: GRID_COLS,
    rows: GRID_ROWS,
    step,
    lineColor: '#c8c8c8',
    lineWidth: 0.6,
  });

  // △ABC（黑色）
  const cA = toC(ptA), cB = toC(ptB), cC = toC(ptC);
  drawTriangle(ctx, [cA, cB, cC], {
    strokeColor: '#222',
    lineWidth: 1.5,
  });

  drawDotLabel(ctx, cA[0], cA[1], 'A', { dir: 'sw', dotColor: '#222' });
  drawDotLabel(ctx, cB[0], cB[1], 'B', { dir: 'se', dotColor: '#222' });
  drawDotLabel(ctx, cC[0], cC[1], 'C', { dir: 'n', dotColor: '#222' });

  // O 点
  const cO = toC(ptO);
  drawCenterDot(ctx, cO[0], cO[1], 'O', {
    radius: 4,
    color: '#222',
    dir: 'se',
  });
}

// ==========================================
// 绘制答案图（含 △ABC、△A′B′C′、△A″B″C″）
// ==========================================
export function drawAnswer(canvas) {
  const ctx = canvas.getContext('2d');
  const step = Math.min(
    (canvas.width - 80) / GRID_COLS,
    (canvas.height - 80) / GRID_ROWS,
  );
  const padding = 40;

  ctx.clearRect(0, 0, canvas.width, canvas.height);

  const toC = (pt) => toCanvas(pt, step, padding, GRID_ROWS);

  // 方格纸
  drawGrid(ctx, {
    originX: padding,
    originY: padding,
    cols: GRID_COLS,
    rows: GRID_ROWS,
    step,
    lineColor: '#c8c8c8',
    lineWidth: 0.6,
  });

  // --- △ABC（黑色，原三角形） ---
  const cA = toC(ptA), cB = toC(ptB), cC = toC(ptC);
  drawTriangle(ctx, [cA, cB, cC], {
    strokeColor: '#222',
    lineWidth: 1.5,
  });
  drawDotLabel(ctx, cA[0], cA[1], 'A', { dir: 'sw', dotColor: '#222' });
  drawDotLabel(ctx, cB[0], cB[1], 'B', { dir: 's', dotColor: '#222' });
  drawDotLabel(ctx, cC[0], cC[1], 'C', { dir: 'nw', dotColor: '#222' });

  // --- △A′B′C′（蓝色，平移后） ---
  const cA1 = toC(ptA1), cB1 = toC(ptB1), cC1 = toC(ptC1);
  drawTriangle(ctx, [cA1, cB1, cC1], {
    strokeColor: '#2563EB',
    lineWidth: 1.8,
    fillColor: 'rgba(219, 234, 254, 0.45)',  // #DBEAFE 半透明
  });
  drawDotLabel(ctx, cA1[0], cA1[1], "A'", { dir: 'se', dotColor: '#2563EB', textColor: '#2563EB' });
  drawDotLabel(ctx, cB1[0], cB1[1], "B'", { dir: 'se', dotColor: '#2563EB', textColor: '#2563EB' });
  drawDotLabel(ctx, cC1[0], cC1[1], "C'", { dir: 'n', dotColor: '#2563EB', textColor: '#2563EB' });

  // --- △A″B″C″（红色，旋转后） ---
  const cA2 = toC(ptA2), cB2 = toC(ptB2), cC2 = toC(ptC2);
  drawTriangle(ctx, [cA2, cB2, cC2], {
    strokeColor: '#DC2626',
    lineWidth: 1.8,
    fillColor: 'rgba(254, 226, 226, 0.45)',  // #FEE2E2 半透明
  });
  drawDotLabel(ctx, cA2[0], cA2[1], 'A″', { dir: 'n', dotColor: '#DC2626', textColor: '#DC2626' });
  drawDotLabel(ctx, cB2[0], cB2[1], 'B″', { dir: 'sw', dotColor: '#DC2626', textColor: '#DC2626' });
  drawDotLabel(ctx, cC2[0], cC2[1], 'C″', { dir: 'se', dotColor: '#DC2626', textColor: '#DC2626' });

  // --- O 点（旋转中心） ---
  const cO = toC(ptO);
  drawCenterDot(ctx, cO[0], cO[1], 'O', {
    radius: 5,
    color: '#DC2626',
    dir: 's',
  });

  // --- 平移辅助箭头（虚线） ---
  drawDashedArrow(ctx, cA[0], cA[1], cA1[0], cA1[1], { color: '#999' });
  drawDashedArrow(ctx, cB[0], cB[1], cB1[0], cB1[1], { color: '#999' });
  drawDashedArrow(ctx, cC[0], cC[1], cC1[0], cC1[1], { color: '#999' });
}
