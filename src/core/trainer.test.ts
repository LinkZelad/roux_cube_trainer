import { describe, expect, it } from 'vitest';
import { checkAnswer, createSession, getPlaybackAlg, goToStep, nextStep, previousStep } from './trainer';
import type { RouxCase } from './types';

const sampleCase: RouxCase = {
  id: 'fb-sample',
  phase: 'FB',
  title: 'Sample first block',
  goal: 'Build the left 1x2x3 block',
  scramble: "R U R' F2 U",
  solutionAlg: "U R U' R'",
  tags: ['square+pair'],
  source: {
    label: 'Local sample',
    url: 'https://example.com'
  },
  steps: [
    { alg: 'U R', note: 'Set up the square' },
    { alg: "U' R'", note: 'Insert the pair' }
  ]
};

describe('trainer session navigation', () => {
  it('starts on the first step', () => {
    const session = createSession(sampleCase);

    expect(session.activeStepIndex).toBe(0);
    expect(session.caseId).toBe('fb-sample');
  });

  it('clamps next and previous navigation to valid step bounds', () => {
    const session = createSession(sampleCase);

    expect(previousStep(session).activeStepIndex).toBe(0);
    expect(nextStep(session).activeStepIndex).toBe(1);
    expect(nextStep(nextStep(session)).activeStepIndex).toBe(1);
  });

  it('clamps direct step navigation to valid step bounds', () => {
    const session = createSession(sampleCase);

    expect(goToStep(session, -5).activeStepIndex).toBe(0);
    expect(goToStep(session, 99).activeStepIndex).toBe(1);
  });

  it('returns playback alg through the active step', () => {
    const session = goToStep(createSession(sampleCase), 1);

    expect(getPlaybackAlg(sampleCase, session)).toBe("U R U' R'");
  });
});

describe('answer checking', () => {
  it('accepts the exact solution with different whitespace', () => {
    expect(checkAnswer(sampleCase, " U   R U'   R' ").status).toBe('correct');
  });

  it('rejects a different algorithm', () => {
    expect(checkAnswer(sampleCase, "U R2 U' R'").status).toBe('incorrect');
  });

  it('asks for input when the answer is empty', () => {
    expect(checkAnswer(sampleCase, '  ').status).toBe('empty');
  });
});
