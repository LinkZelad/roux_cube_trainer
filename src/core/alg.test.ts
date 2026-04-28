import { describe, expect, it } from 'vitest';
import { algsMatch, normalizeAlg } from './alg';

describe('normalizeAlg', () => {
  it('collapses repeated whitespace between moves', () => {
    expect(normalizeAlg("U   R    U'")).toBe("U R U'");
  });

  it('normalizes parenthesized spacing for comparison', () => {
    expect(normalizeAlg("( R U R' )   U2")).toBe("(R U R') U2");
  });

  it('returns an empty string for whitespace-only input', () => {
    expect(normalizeAlg('   \n\t   ')).toBe('');
  });
});

describe('algsMatch', () => {
  it('accepts equivalent whitespace', () => {
    expect(algsMatch("U  R U'", " U R   U' ")).toBe(true);
  });

  it('rejects different moves', () => {
    expect(algsMatch("U R U'", "U R2 U'")).toBe(false);
  });
});
