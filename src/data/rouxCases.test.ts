import { describe, expect, it } from 'vitest';
import { rouxCases } from './rouxCases';

describe('rouxCases', () => {
  it('contains both first block and second block examples', () => {
    expect(rouxCases.some((rouxCase) => rouxCase.phase === 'FB')).toBe(true);
    expect(rouxCases.some((rouxCase) => rouxCase.phase === 'SB')).toBe(true);
  });

  it('defines complete solutions and step notes for every case', () => {
    for (const rouxCase of rouxCases) {
      expect(rouxCase.id).not.toBe('');
      expect(rouxCase.title).not.toBe('');
      expect(rouxCase.solutionAlg.trim()).not.toBe('');
      expect(rouxCase.steps.length).toBeGreaterThan(0);

      for (const step of rouxCase.steps) {
        expect(step.alg.trim()).not.toBe('');
        expect(step.note.trim()).not.toBe('');
      }
    }
  });
});
