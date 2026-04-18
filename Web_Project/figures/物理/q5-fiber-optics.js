// ============================================================
// q5-fiber-optics.js
// 第5题 · 光纤传输光信号（光路图）
// 全反射原理 — 弯曲光纤，遵循反射定律
// ============================================================

import { drawMidArrowLine, drawDashedLine } from '../../lib/draw-helpers.js';

// ==========================================
// 题目元数据
// ==========================================
export const meta = {
  id: 'q5',
  title: '第5题 · 光纤传输光信号',
  category: '物理',
  categoryIcon: '🔬',
  description: '在光纤的一端放上发光的灯泡，如图(a)所示，在另一端______（选填"有"或"没有"）光射出。请在图(b)中作出光路图，表示光纤传输光信号的原理。',
  subQuestions: [
    '答案：$\\textbf{有}$光射出。',
    '光在光纤内壁发生$\\textbf{全反射}$，光线在弯曲光纤中沿折线路径传播，最终从另一端射出。',
  ],
};

// ==========================================
// 解答步骤
// ==========================================
export const solutionSteps = [
  {
    title: '判断：有光射出',
    content: '光纤利用光的$\\textbf{全反射}$原理传输信号。',
    details: [
      '光纤由高折射率的纤芯和低折射率的包层组成',
      '光从光密介质（纤芯）射向光疏介质（包层），入射角 $\\theta > \\theta_c$ 时发生全反射',
      '即使光纤弯曲，光在内壁反复全反射，仍能传播到另一端',
    ],
    summary: '因此另一端$\\textbf{有}$光射出。',
  },
  {
    title: '作图：光路图',
    content: '在图(b)中画出光在弯曲光纤中的传播路径：',
    formula: '反射定律：$\\theta_i = \\theta_r$，法线与界面切线垂直',
    details: [
      '画出弯曲光纤截面（上下两条弧线）',
      '光线从左端射入，射向外壁（上弧线）',
      '在每个反射点画法线（虚线），法线与该点切线垂直',
      '根据反射定律，入射角 $\\theta_i$ = 反射角 $\\theta_r$',
      '光线在上下壁之间反复全反射，最终从右端射出',
    ],
    summary: '光线遵循反射定律，在弯曲光纤中传播。',
  },
];

// ==========================================
// 弯曲光纤几何参数（二次贝塞尔曲线）
// ==========================================
const UPPER = { p0: [50, 260], cp: [390, 50], p1: [730, 150] };
const LOWER = { p0: [50, 325], cp: [390, 115], p1: [730, 215] };

// ==========================================
// 贝塞尔曲线工具函数
// ==========================================

/** 二次贝塞尔求值 */
function bezPt(curve, t) {
  const u = 1 - t;
  return [
    u * u * curve.p0[0] + 2 * u * t * curve.cp[0] + t * t * curve.p1[0],
    u * u * curve.p0[1] + 2 * u * t * curve.cp[1] + t * t * curve.p1[1],
  ];
}

/** 二次贝塞尔切线 */
function bezTan(curve, t) {
  const u = 1 - t;
  return [
    2 * u * (curve.cp[0] - curve.p0[0]) + 2 * t * (curve.p1[0] - curve.cp[0]),
    2 * u * (curve.cp[1] - curve.p0[1]) + 2 * t * (curve.p1[1] - curve.cp[1]),
  ];
}

/** 单位化 */
function norm(v) {
  const len = Math.hypot(v[0], v[1]);
  return [v[0] / len, v[1] / len];
}

// ==========================================
// 光线-贝塞尔交点计算
// ==========================================

/**
 * 求射线 P + t*D 与二次贝塞尔曲线的交点
 * 返回 { s, t, point } 或 null
 */
function rayBezierHit(P, D, curve, minDist) {
  const ax = curve.p0[0], ay = curve.p0[1];
  const bx = curve.cp[0], by = curve.cp[1];
  const cx = curve.p1[0], cy = curve.p1[1];

  // 贝塞尔展开系数: B(s) = A + Bs*s + Cs*s²
  const Ax = ax, Ay = ay;
  const Bx = 2 * (bx - ax), By = 2 * (by - ay);
  const Cx = ax - 2 * bx + cx, Cy = ay - 2 * by + cy;

  // 联立方程化简为关于 s 的二次方程
  const a2 = Cx * D[1] - Cy * D[0];
  const b2 = Bx * D[1] - By * D[0];
  const c2 = (Ax - P[0]) * D[1] - (Ay - P[1]) * D[0];

  const disc = b2 * b2 - 4 * a2 * c2;
  if (disc < 0) return null;

  const sqrtD = Math.sqrt(disc);
  const s1 = (-b2 + sqrtD) / (2 * a2);
  const s2 = (-b2 - sqrtD) / (2 * a2);

  let bestS = null;
  let bestT = Infinity;

  for (const s of [s1, s2]) {
    if (s < 0.01 || s > 0.99) continue;
    const pt = bezPt(curve, s);
    // 用分量绝对值更大的那个算 t，减少数值误差
    const t = Math.abs(D[0]) > Math.abs(D[1])
      ? (pt[0] - P[0]) / D[0]
      : (pt[1] - P[1]) / D[1];
    if (t > minDist && t < bestT) {
      bestT = t;
      bestS = s;
    }
  }

  if (bestS === null) return null;
  return { s: bestS, t: bestT, point: bezPt(curve, bestS) };
}

// ==========================================
// 光线追踪（遵循反射定律）
// ==========================================

function traceRay(entryPt, entryDir, maxBounces = 6) {
  const path = [entryPt.slice()];
  let P = entryPt.slice();
  let D = norm(entryDir);
  const refData = [];

  for (let i = 0; i < maxBounces; i++) {
    // 检测与两条壁的交点，取最近的
    const hitU = rayBezierHit(P, D, UPPER, 5);
    const hitL = rayBezierHit(P, D, LOWER, 5);

    let hit = null;
    let isUpper = false;

    if (hitU && hitL) {
      if (hitU.t < hitL.t) { hit = hitU; isUpper = true; }
      else { hit = hitL; isUpper = false; }
    } else if (hitU) { hit = hitU; isUpper = true; }
    else if (hitL) { hit = hitL; isUpper = false; }
    else break;

    // 超出右边界则停止
    if (hit.point[0] > 730) break;

    const curve = isUpper ? UPPER : LOWER;
    const T = bezTan(curve, hit.s);
    const tLen = Math.hypot(T[0], T[1]);

    // 内法线（指向光纤内部）
    // 上壁：内法线朝下（canvas y+）；下壁：内法线朝上（canvas y-）
    let N;
    if (isUpper) {
      N = [-T[1] / tLen, T[0] / tLen];
      if (N[1] < 0) { N[0] = -N[0]; N[1] = -N[1]; }
    } else {
      N = [T[1] / tLen, -T[0] / tLen];
      if (N[1] > 0) { N[0] = -N[0]; N[1] = -N[1]; }
    }

    path.push(hit.point);
    refData.push({
      point: hit.point,
      normal: N,
      nAngle: Math.atan2(N[1], N[0]),
    });

    // 反射: r = d - 2(d·n)n
    const dn = D[0] * N[0] + D[1] * N[1];
    D = norm([D[0] - 2 * dn * N[0], D[1] - 2 * dn * N[1]]);
    P = hit.point.slice();
  }

  // 出射延伸
  if (D[0] > 0 && path.length > 1) {
    const exitX = 730;
    const t = (exitX - P[0]) / D[0];
    const exitY = P[1] + t * D[1];
    // 只在合理范围内添加出射点
    if (exitY > 50 && exitY < 450) {
      path.push([exitX, exitY]);
    }
  }

  return { path, refData };
}

// ==========================================
// 绘图：题目原图
// ==========================================
export function drawProblem(canvas) {
  const ctx = canvas.getContext('2d');
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  ctx.save();
  ctx.font = 'italic 16px "Times New Roman", serif';
  ctx.fillStyle = '#666';
  ctx.textAlign = 'center';
  ctx.fillText('(b) \u8BF7\u5728\u6B64\u4F5C\u51FA\u5149\u8DEF\u56FE', canvas.width / 2, 30);
  ctx.restore();

  drawFiber(ctx);
}

// ==========================================
// 绘图：答案图（物理正确的反射光路）
// ==========================================
export function drawAnswer(canvas) {
  const ctx = canvas.getContext('2d');
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  // 标题
  ctx.save();
  ctx.font = 'italic 16px "Times New Roman", serif';
  ctx.fillStyle = '#666';
  ctx.textAlign = 'center';
  ctx.fillText('(b) \u5149\u7EA4\u5168\u53CD\u5C04\u5149\u8DEF\u56FE', canvas.width / 2, 30);
  ctx.restore();

  // 光纤截面
  drawFiber(ctx);

  // 光线追踪
  const entry = [50, 310];
  const dir = [1, -1.6];
  const { path, refData } = traceRay(entry, dir, 8);

  // ---- 绘制光线（带箭头） ----
  for (let i = 0; i < path.length - 1; i++) {
    drawMidArrowLine(ctx, path[i][0], path[i][1], path[i + 1][0], path[i + 1][1], {
      color: '#E65100',
      lineWidth: 2,
      arrowSize: 10,
    });
  }

  // ---- 绘制法线 + 角度标记 ----
  // refData[i] 对应 path[i+1]（path[0] 是入射点）
  for (let i = 0; i < refData.length; i++) {
    const { point, normal, nAngle } = refData[i];
    const [rx, ry] = point;
    const [nx, ny] = normal;
    const pathIdx = i + 1; // 该反射点在 path 中的索引

    // 法线虚线（两侧延伸）
    const nLen = 50;
    drawDashedLine(ctx,
      rx - nx * nLen * 0.3, ry - ny * nLen * 0.3,
      rx + nx * nLen, ry + ny * nLen,
      { color: '#888', lineWidth: 1, dashPattern: [4, 3] },
    );

    // 入射方向（反转 = 从反射点指回光源方向）
    const prevPt = path[pathIdx - 1];
    const incDir = [path[pathIdx][0] - prevPt[0], path[pathIdx][1] - prevPt[1]];
    const revInc = norm([-incDir[0], -incDir[1]]);
    const riAngle = Math.atan2(revInc[1], revInc[0]);

    // 反射方向（从反射点指向下一个点）
    let rfAngle = nAngle;
    if (pathIdx + 1 < path.length) {
      const nextPt = path[pathIdx + 1];
      const refDir = norm([nextPt[0] - rx, nextPt[1] - ry]);
      rfAngle = Math.atan2(refDir[1], refDir[0]);
    }

    // 计算入射角大小，跳过太小的角度
    let diff1 = riAngle - nAngle;
    while (diff1 > Math.PI) diff1 -= 2 * Math.PI;
    while (diff1 < -Math.PI) diff1 += 2 * Math.PI;

    let diff2 = rfAngle - nAngle;
    while (diff2 > Math.PI) diff2 -= 2 * Math.PI;
    while (diff2 < -Math.PI) diff2 += 2 * Math.PI;

    const arcR = 20;
    const minAngle = 0.1; // 最小角度阈值（弧度）

    if (Math.abs(diff1) > minAngle && Math.abs(diff1) < Math.PI - 0.1) {
      drawSmallArc(ctx, rx, ry, arcR, nAngle, riAngle, '#4F8EF7');
    }
    if (Math.abs(diff2) > minAngle && Math.abs(diff2) < Math.PI - 0.1) {
      drawSmallArc(ctx, rx, ry, arcR, nAngle, rfAngle, '#4F8EF7');
    }

    // θ 标签
    const labelR = arcR + 11;
    const mid1 = angleMid(nAngle, riAngle);
    const mid2 = angleMid(nAngle, rfAngle);

    ctx.save();
    ctx.font = 'italic 11px "Times New Roman", "KaTeX_Math", serif';
    ctx.fillStyle = '#4F8EF7';
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    if (Math.abs(diff1) > minAngle && Math.abs(diff1) < Math.PI - 0.1) {
      ctx.fillText('\u03B8', rx + labelR * Math.cos(mid1), ry + labelR * Math.sin(mid1));
    }
    if (Math.abs(diff2) > minAngle && Math.abs(diff2) < Math.PI - 0.1) {
      ctx.fillText('\u03B8', rx + labelR * Math.cos(mid2), ry + labelR * Math.sin(mid2));
    }
    ctx.restore();
  }

  // ---- 入射/出射标签 ----
  ctx.save();
  ctx.font = '13px "Inter", "Noto Sans SC", sans-serif';
  ctx.fillStyle = '#E65100';
  if (path.length > 0) {
    ctx.textAlign = 'left';
    ctx.fillText('\u5165\u5C04\u5149', path[0][0] - 5, path[0][1] + 22);
  }
  if (path.length > 1) {
    ctx.textAlign = 'right';
    const last = path[path.length - 1];
    ctx.fillText('\u51FA\u5C04\u5149', last[0] + 5, last[1] + 22);
  }
  ctx.restore();
}

// ==========================================
// 绘制角度弧线（取较小弧）
// ==========================================
function drawSmallArc(ctx, cx, cy, r, a1, a2, color) {
  let diff = a2 - a1;
  while (diff > Math.PI) diff -= 2 * Math.PI;
  while (diff < -Math.PI) diff += 2 * Math.PI;

  ctx.save();
  ctx.beginPath();
  ctx.arc(cx, cy, r, a1, a1 + diff, diff < 0);
  ctx.strokeStyle = color;
  ctx.lineWidth = 1.2;
  ctx.stroke();
  ctx.restore();
}

/** 两角之间的中间角度 */
function angleMid(a1, a2) {
  let diff = a2 - a1;
  while (diff > Math.PI) diff -= 2 * Math.PI;
  while (diff < -Math.PI) diff += 2 * Math.PI;
  return a1 + diff / 2;
}

// ==========================================
// 绘制弯曲光纤截面
// ==========================================
function drawFiber(ctx) {
  ctx.save();

  // 纤芯填充
  ctx.beginPath();
  ctx.moveTo(UPPER.p0[0], UPPER.p0[1]);
  ctx.quadraticCurveTo(UPPER.cp[0], UPPER.cp[1], UPPER.p1[0], UPPER.p1[1]);
  ctx.lineTo(LOWER.p1[0], LOWER.p1[1]);
  ctx.quadraticCurveTo(LOWER.cp[0], LOWER.cp[1], LOWER.p0[0], LOWER.p0[1]);
  ctx.closePath();
  ctx.fillStyle = 'rgba(200, 230, 255, 0.12)';
  ctx.fill();

  // 上壁弧线
  ctx.beginPath();
  ctx.moveTo(UPPER.p0[0], UPPER.p0[1]);
  ctx.quadraticCurveTo(UPPER.cp[0], UPPER.cp[1], UPPER.p1[0], UPPER.p1[1]);
  ctx.strokeStyle = '#444';
  ctx.lineWidth = 2;
  ctx.stroke();

  // 下壁弧线
  ctx.beginPath();
  ctx.moveTo(LOWER.p0[0], LOWER.p0[1]);
  ctx.quadraticCurveTo(LOWER.cp[0], LOWER.cp[1], LOWER.p1[0], LOWER.p1[1]);
  ctx.strokeStyle = '#444';
  ctx.lineWidth = 2;
  ctx.stroke();

  // 左端面
  ctx.beginPath();
  ctx.moveTo(UPPER.p0[0], UPPER.p0[1]);
  ctx.lineTo(LOWER.p0[0], LOWER.p0[1]);
  ctx.strokeStyle = '#888';
  ctx.lineWidth = 1;
  ctx.stroke();

  // 右端面
  ctx.beginPath();
  ctx.moveTo(UPPER.p1[0], UPPER.p1[1]);
  ctx.lineTo(LOWER.p1[0], LOWER.p1[1]);
  ctx.strokeStyle = '#888';
  ctx.lineWidth = 1;
  ctx.stroke();

  ctx.restore();
}
