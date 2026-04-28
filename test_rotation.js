const faceSpecs = {
  front: { normal: { x: 0, y: 0, z: 1 } },
  back: { normal: { x: 0, y: 0, z: -1 } },
  right: { normal: { x: 1, y: 0, z: 0 } },
  left: { normal: { x: -1, y: 0, z: 0 } },
  top: { normal: { x: 0, y: 1, z: 0 } },
  bottom: { normal: { x: 0, y: -1, z: 0 } }
};

const normalizeAxis = (value) => {
  const rounded = Math.round(value);
  return Object.is(rounded, -0) ? 0 : rounded;
};

const rotateVector = (vector, axis, turns) => {
  let result = { ...vector };
  const count = ((turns % 4) + 4) % 4;
  for (let i = 0; i < count; i += 1) {
    if (axis === "x") {
      result = { x: result.x, y: -result.z, z: result.y };
    } else if (axis === "y") {
      result = { x: result.z, y: result.y, z: -result.x };
    } else {
      result = { x: -result.y, y: result.x, z: result.z };
    }
  }
  return {
    x: normalizeAxis(result.x),
    y: normalizeAxis(result.y),
    z: normalizeAxis(result.z)
  };
};

const faceNameForNormal = (normal) =>
  Object.entries(faceSpecs).find(([, spec]) =>
    spec.normal.x === normal.x && spec.normal.y === normal.y && spec.normal.z === normal.z
  )?.[0];

// Test U move (turns: -1 around Y)
let normal = { x: 0, y: 0, z: 1 }; // Front
console.log("Original Front:", normal, faceNameForNormal(normal));
let rotated = rotateVector(normal, "y", -1);
console.log("After U:", rotated, faceNameForNormal(rotated));

// Test M move
let mNormal = { x: 0, y: 1, z: 0 }; // Top
console.log("Original Top:", mNormal, faceNameForNormal(mNormal));
let mRotated = rotateVector(mNormal, "x", -1); // Current M direction
console.log("After M (current):", mRotated, faceNameForNormal(mRotated));
