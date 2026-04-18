// ============================================================
// transform.js — 几何变换工具
// ============================================================

/**
 * 平移变换
 * @param {[number, number]} point - 原始点 [x, y]
 * @param {number} dx - X 方向位移
 * @param {number} dy - Y 方向位移
 * @returns {[number, number]}
 */
export function translate(point, dx, dy) {
  return [point[0] + dx, point[1] + dy];
}

/**
 * 顺时针旋转 90°（绕指定中心）
 * 公式：(x, y) → (cx + (y - cy), cy - (x - cx))
 * @param {[number, number]} point  - 待旋转点 [x, y]
 * @param {[number, number]} center - 旋转中心 [cx, cy]
 * @returns {[number, number]}
 */
export function rotateCW90(point, center) {
  const [x, y] = point;
  const [cx, cy] = center;
  return [cx + (y - cy), cy - (x - cx)];
}

/**
 * 任意角度旋转（顺时针，角度制）
 * @param {[number, number]} point  - 待旋转点 [x, y]
 * @param {[number, number]} center - 旋转中心 [cx, cy]
 * @param {number} angleDeg - 旋转角度（正值 = 顺时针）
 * @returns {[number, number]}
 */
export function rotatePoint(point, center, angleDeg) {
  const [x, y] = point;
  const [cx, cy] = center;
  // 顺时针旋转用负角
  const rad = -angleDeg * Math.PI / 180;
  const cos = Math.cos(rad);
  const sin = Math.sin(rad);
  const dx = x - cx;
  const dy = y - cy;
  return [
    cx + dx * cos - dy * sin,
    cy + dx * sin + dy * cos,
  ];
}
