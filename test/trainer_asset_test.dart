import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final trainerHtml = File('assets/trainer/index.html').readAsStringSync();

  test('embedded trainer renders a cubie-based physical cube', () {
    expect(trainerHtml, contains('class="cube" id="cube"'));
    expect(trainerHtml, contains('const renderCubies = (state, rotatingMove = null)'));
    expect(trainerHtml, contains('class="cubie"'));
    expect(trainerHtml, contains('class="sticker-face'));
    expect(trainerHtml, contains('--cubie-x'));
    expect(trainerHtml, contains('--cubie-y'));
    expect(trainerHtml, contains('--cubie-z'));
  });

  test('embedded trainer exposes visible step and playback state', () {
    expect(trainerHtml, contains('id="stepCounter"'));
    expect(trainerHtml, contains('id="playState"'));
    expect(trainerHtml, contains('renderCube(item, activeStepIndex)'));
  });

  test('embedded trainer wires cubing.js twisty-player for real alg playback', () {
    expect(trainerHtml, contains('https://cdn.cubing.net/v0/js/cubing/twisty'));
    expect(trainerHtml, contains('<twisty-player'));
    expect(trainerHtml, contains('id="twistyPlayer"'));
    expect(trainerHtml, contains('experimental-setup-alg'));
    expect(trainerHtml, contains('updateTwistyPlayer(item, activeMoveIndex)'));
    expect(trainerHtml, contains('twistyPlayer.play()'));
  });

  test('embedded trainer controls advance one move at a time', () {
    expect(trainerHtml, contains('let activeMoveIndex = 0'));
    expect(trainerHtml, contains('const moveTimeline = (item)'));
    expect(trainerHtml, contains('const goToMove = (nextMoveIndex)'));
    expect(trainerHtml, contains('activeMoveIndex + 1'));
    expect(trainerHtml, contains('move current'));
    expect(trainerHtml, contains(r'Move ${Math.min(activeMoveIndex + 1, timeline.length)} / ${timeline.length}'));
    expect(trainerHtml, contains('goToMove(moveTimeline(activeCase()).length)'));
    expect(trainerHtml, contains('const playNextMove = ()'));
    expect(trainerHtml, contains('setTimeout(playNextMove, playbackDelayMs)'));
  });

  test('embedded trainer renders cube state from executed moves', () {
    expect(trainerHtml, contains('const cubeStateAfterMoves = (moves)'));
    expect(trainerHtml, contains('const applyMove = (state, move)'));
    expect(trainerHtml, contains('const renderCubies = (state, rotatingMove = null)'));
    expect(trainerHtml, contains('const normalizeAxis = (value)'));
    expect(trainerHtml, contains('Object.is(rounded, -0) ? 0 : rounded'));
    expect(trainerHtml, contains('tokenizeAlg(item.scramble)'));
    expect(trainerHtml, contains('moveTimeline(item).slice(0, activeMoveIndex)'));
  });

  test('embedded trainer animates the moved layer before committing state', () {
    expect(trainerHtml, contains('const animateMove = (direction)'));
    expect(trainerHtml, contains('const layerTransform = (parsedMove)'));
    expect(trainerHtml, contains('class="cubie moving-layer"'));
    expect(trainerHtml, contains('isAnimatingMove'));
    expect(trainerHtml, contains('requestAnimationFrame(() => {'));
    expect(trainerHtml, contains('setTimeout(() => {'));
    expect(trainerHtml, contains('activeMoveIndex = targetMoveIndex'));
    expect(trainerHtml, contains('const focusFace = parsed ? moveFaceName(rotatingMove?.move ?? "") : ""'));
    expect(trainerHtml, contains('focusFace && sticker.faceName !== focusFace ? "dim" : ""'));
  });
}
